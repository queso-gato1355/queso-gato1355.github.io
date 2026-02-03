---
title: "포스트: 공지"
categories:
  - Blog
tags:
  - Post Formats
  - notice
lang: ko
permalink: /:title/
lang-ref: post-notice
---

공지는 인접한 콘텐츠를 설명하는 정보를 표시합니다. 특정 세부 사항에 주의를 끌기 위해 자주 사용됩니다.

Kramdown을 사용할 때 문장 뒤에 `{: .notice}`를 추가하여 `.notice`를 `<p></p>` 요소에 할당할 수 있습니다.

**서비스 변경:** 고객에게 더 나은 서비스를 제공하기 위해 [개인정보 보호정책](#)을 업데이트했습니다. 변경 사항을 검토하시기 바랍니다.
{: .notice}

**주요 공지:** Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. [Praesent libero](#). Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet.
{: .notice--primary}

**정보 공지:** Lorem ipsum dolor sit amet, [consectetur adipiscing elit](#). Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet.
{: .notice--info}

**경고 공지:** Lorem ipsum dolor sit amet, consectetur adipiscing elit. [Integer nec odio](#). Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet.
{: .notice--warning}

**위험 공지:** Lorem ipsum dolor sit amet, [consectetur adipiscing](#) elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet.
{: .notice--danger}

**성공 공지:** Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at [nibh elementum](#) imperdiet.
{: .notice--success}

여러 단락이나 다른 요소를 공지로 감싸고 싶으신가요? Liquid를 사용하여 콘텐츠를 캡처한 다음 `markdownify`로 필터링하는 것이 좋은 방법입니다.

```html
{% raw %}{% capture notice-2 %}
#### 새로운 사이트 기능

* 이제 블로그 페이지에 커버 이미지를 추가할 수 있습니다
* 작성 중 초안이 자동 저장됩니다
{% endcapture %}{% endraw %}

<div class="notice">{% raw %}{{ notice-2 | markdownify }}{% endraw %}</div>
```

{% capture notice-2 %}
#### 새로운 사이트 기능

* 이제 블로그 페이지에 커버 이미지를 추가할 수 있습니다
* 작성 중 초안이 자동 저장됩니다
{% endcapture %}

<div class="notice">
  {{ notice-2 | markdownify }}
</div>

또는 캡처를 건너뛰고 순수 HTML을 사용할 수 있습니다.

```html
<div class="notice">
  <h4>메시지</h4>
  <p>기본 메시지입니다.</p>
</div>
```

<div class="notice">
  <h4>메시지</h4>
  <p>기본 메시지입니다.</p>
</div>