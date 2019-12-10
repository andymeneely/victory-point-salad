---
---
Here's the latest build of Victory Point Salad.

[Specials](#specials)
[Resources](#resources)
[Ladders](#adders)
[Diff](#diff)
{: class="nav-links"}

# Specials

<div class="cards">
{% for myimage in site.static_files %}
  {% if myimage.path contains "/assets/cards/specials/" %}
<a href="{{ site.baseurl }}{{ myimage.path }}">
  <img src="{{ site.baseurl }}{{ myimage.path }}" class="portrait" alt="image" />
</a>
  {% endif %}
{% endfor %}
</div>

# Resources

<div class="cards">
{% for myimage in site.static_files %}
  {% if myimage.path contains "/assets/cards/resources/" %}
<a href="{{ site.baseurl }}{{ myimage.path }}">
  <img src="{{ site.baseurl }}{{ myimage.path }}"
       class="landscape" alt="image" />
</a>
  {% endif %}
{% endfor %}
</div>

# Ladders

# Diff

This is the image difference between this commit and the last commit.

<img src="{{ site.baseurl }}/assets/cards/special_sheet.png" class="fullwidth"/>

<div class="diff">
  <img src="{{ site.baseurl }}/assets/cards/special_sheet.png"/>
  <img src="{{ site.baseurl }}/assets/cards/old_special_sheet.png"/>
</div>