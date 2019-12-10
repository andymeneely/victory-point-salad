---
---
Here's the latest build of Victory Point Salad.

[Engines](#engines)
[Specials](#specials)
[Resources](#resources)
[Ladders](#Ladders)
{: class="nav-links"}

# Engines

# Specials

<div class="cards">
{% for myimage in site.static_files %}
  {% if myimage.path contains 'assets/cards/special_' %}
<a href="{{ site.baseurl }}{{ myimage.path }}">
  <img src="{{ site.baseurl }}{{ myimage.path }}" class="card" alt="image" />
</a>
  {% endif %}
{% endfor %}
</div>

# Resources

# Ladders

# Diff
