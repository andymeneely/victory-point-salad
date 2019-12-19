require 'squib'

Squib::Deck.new(cards: 3, config: 'config.yml') do
  background color: :white
  use_layout file: 'layouts/specials.yml'

  text layout: :title,
       str: ['The Point Ladder', 'The Resource Ladder', 'The Special Ladder']
  svg file: ['point ladder.svg', 'resource ladder.svg', 'special ladder.svg']

  save_png prefix: 'ladder_'

  rect layout: :cut_zone
  rect layout: :safe_zone
  save_png prefix: 'ladder_preview_', trim: 37.5, trim_radius: 37.5
end

Squib::Deck.new(cards: 3, config: 'config.yml') do
  background color: :white
  use_layout file: 'layouts/backs.yml'
  text str: ['Ladder Card'] * size, layout: :type
  save_png prefix: 'ladder_back_'
end
