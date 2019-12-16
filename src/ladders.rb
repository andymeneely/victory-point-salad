require 'squib'

Squib::Deck.new(cards: 2, config: 'config.yml') do
  background color: :white
  use_layout file: 'layouts/specials.yml'

  text str: ['The Point Ladder', 'The Resource Ladder'], layout: :title

  svg file: ['point ladder.svg', 'resource ladder.svg']

  save_png prefix: 'ladder_'

  rect layout: :cut_zone
  # rect layout: :safe_zone
  save_png prefix: 'ladder_preview_', trim: 37.5, trim_radius: 37.5
end

Squib::Deck.new(cards: 2, config: 'config.yml') do
  background color: :white
  use_layout file: 'layouts/backs.yml'

  type_str = ["Ladder Card"] * 2
  text str: type_str, layout: :type

  save_png prefix: 'ladder_back_'
end
