---
---
Here's the latest build of Victory Point Salad.

[Specials](#specials)
[Resources](#resources)
[Ladders](#Ladders)
{: class="nav-links"}

# Specials

<div class="cards">
{% for myimage in site.static_files %}
  {% if myimage.path contains 'assets/cards/special_' %}
<a href="">
  <img src="{{ site.baseurl }}{{ myimage.path }}" class="card" alt="image" />
</a>
  {% endif %}
{% endfor %}
</div>

# Resources


# Ladders

# Diff
