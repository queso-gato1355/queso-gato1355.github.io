# 개인 블로그 프로젝트 (queso-gato1355.github.io)

이 저장소는 Jekyll과 Minimal Mistakes 테마를 기반으로 구축된 개인 블로그 및 포트폴리오 사이트입니다. 다국어(영어, 한국어) 지원과 커스텀 배포 스크립트를 포함하고 있습니다.

## 프로젝트 특징

- **Jekyll 기반**: 정적 사이트 생성기인 Jekyll을 사용합니다.
- **Minimal Mistakes 테마**: mmistakes/minimal-mistakes 원격 테마를 사용합니다.
- **다국어 지원**: `jekyll-polyglot` 플러그인을 사용하여 영어(기본)와 한국어를 지원합니다.
- **스마트 언어 링크**: 커스텀 플러그인(`_plugins/polyglot_availability_map.rb`)을 통해 실제 번역된 포스트가 존재할 때만 언어 전환 버튼을 표시합니다.
- **포트폴리오 섹션**: 별도의 포트폴리오 컬렉션을 관리합니다.
- **자동화된 배포**: `deploy.sh` 스크립트를 통해 빌드 및 배포 과정을 자동화했습니다.

## 프로젝트 구조

주요 디렉토리 및 파일의 역할은 다음과 같습니다.

- `_config.yml`: 사이트 전역 설정 파일 (테마, 플러그인, 언어 설정 등).
- `_posts/`: 블로그 게시글 마크다운 파일 (en/ko 하위 폴더로 언어 구분).
- `_pages/`: 정적 페이지 파일 (소개, 아카이브 등).
- `_portfolio/`: 포트폴리오 항목 관리.
- `_layouts/`, `_includes/`: 커스텀 레이아웃 및 HTML 조각.
- `_plugins/`: Jekyll 빌드 시 실행되는 커스텀 플러그인 (다국어 가용성 확인 등).
- `deploy.sh`: 사이트 빌드 및 GitHub Pages 배포를 위한 쉘 스크립트.
- `.env`: (사용자 생성 필요) 배포 환경 변수 설정 파일.

## 환경 설정 (.env)

배포 스크립트(`deploy.sh`)는 SSH를 통한 안전한 배포를 위해 `.env` 파일을 참조합니다. 로컬 배포 시 이 파일이 필요합니다.

1. 프로젝트 루트 디렉토리에 `.env` 파일을 생성하십시오.
2. `DEPLOY_KEY_NAME` 변수를 정의하십시오. 이 값은 SSH 설정(`~/.ssh/config`)에 등록된 Host 별칭(Alias)이어야 합니다.

작성 예시:

```text
DEPLOY_KEY_NAME=github-queso-gato
```

위 설정은 `git push git@github-queso-gato:queso-gato1355/queso-gato1355.github.io.git` 명령을 실행하기 위해 사용됩니다.

## 설치 및 실행 방법

### 사전 요구 사항

- Ruby (Jekyll 실행 환경)
- Bundler (`gem install bundler`)
- Git

### 패키지 설치

프로젝트 루트에서 의존성 패키지를 설치합니다.

```bash
bundle install
```

### 로컬 서버 실행

로컬에서 사이트를 미리 확인하려면 다음 명령어를 사용합니다.

```bash
bundle exec jekyll serve
```

## 배포 방법

이 프로젝트는 `deploy` 브랜치를 통해 정적 파일을 배포합니다. `deploy.sh` 스크립트가 빌드부터 푸시까지의 과정을 처리합니다.

**주의**: Windows 환경(Git Bash 등) 또는 Linux/Mac 터미널에서 실행 권장.

1. `.env` 파일이 올바르게 설정되었는지 확인하십시오.
2. 배포 스크립트를 실행합니다.

```bash
./deploy.sh
```

### 배포 스크립트 동작 과정

1. 기존 `_site` 디렉토리(빌드 결과물)를 삭제합니다.
2. `bundle exec jekyll build` 명령으로 사이트를 빌드합니다.
3. `_site` 디렉토리로 이동하여 새로운 git 저장소를 초기화합니다.
4. 빌드된 모든 파일을 스테이징 및 커밋합니다.
5. 설정된 SSH 호스트(`DEPLOY_KEY_NAME`)를 사용하여 원격 저장소의 `deploy` 브랜치에 강제 푸시(`--force`)합니다.

이 방식을 통해 소스 코드(`main` 브랜치)와 빌드 결과물(`deploy` 브랜치)을 분리하여 관리합니다.
