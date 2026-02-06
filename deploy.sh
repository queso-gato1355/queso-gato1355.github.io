#!/bin/bash

# 에러 발생 시 스크립트 실행 중단
set -e

echo "Calling .env file to load environment variables..."
# .env 파일에서 환경 변수 로드
if [ -f .env ]; then
  # .env 파일에서 변수 export
  export $(grep -v '^#' .env | xargs)
fi
# 환경 변수 출력 (디버깅용)
echo "Loaded environment variables:"
env | grep DEPLOY_KEY_NAME

if [ -z "$DEPLOY_KEY_NAME" ]; then
  echo "Error: DEPLOY_KEY_NAME is not set in .env file."
  exit 1
fi

echo "Starting deployment..."

# 1. 기존 _site 폴더 삭제 (깨끗한 빌드를 위해)
rm -rf _site

# 2. Jekyll 빌드 실행
echo "Building Jekyll site..."
cmd.exe /c "bundle exec jekyll build"

# 3. _site 폴더로 이동하여 git 초기화
cd _site
git init
git checkout -b deploy

# 4. 모든 빌드 결과물 스테이징 및 커밋
git add .
git commit -m ":rocket: 블로그 내용 게시 $(date '+%Y-%m-%d %H:%M:%S')"

# 5. 원격 저장소 URL 가져오기 (상위 폴더 설정에서 가져옴)
REMOTE_REPO="git@$DEPLOY_KEY_NAME:queso-gato1355/queso-gato1355.github.io.git"

# 6. deploy 브랜치로 강제 푸시 (이전 deploy 내용을 덮어씌움)
echo "Pushing to deploy branch..."
git remote add origin $REMOTE_REPO
git push origin deploy --force

# 7. 원래 폴더로 복귀
cd ..

echo "Deployment finished successfully!"