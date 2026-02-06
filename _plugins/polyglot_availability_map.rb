module Jekyll
  class PolyglotAvailabilityMap < Generator
    safe true
    priority :high

    def generate(site)
      # lang-ref를 키로 하고, 존재하는 언어 코드들의 배열을 값으로 갖는 맵 생성
      availability = {}

      # 모든 게시글(Posts)과 페이지(Pages)를 순회
      # site.posts.docs는 Posts 컬렉션, site.pages는 일반 페이지들
      items = site.posts.docs + site.pages
      
      items.each do |item|
        # lang-ref가 없는 항목은 제외
        next unless item.data['lang-ref']

        ref = item.data['lang-ref']
        # 언어 설정이 없으면 기본 언어로 간주 (설정에 따라 다를 수 있음)
        lang = item.data['lang'] || site.config['default_lang'] || "en"

        availability[ref] ||= []
        # 중복 방지하여 언어 추가
        availability[ref] << lang unless availability[ref].include?(lang)
      end

      # 생성된 맵을 site.data에 주입하여 Liquid에서 사용할 수 있게 함
      site.data['polyglot_availability'] = availability
    end
  end
end
