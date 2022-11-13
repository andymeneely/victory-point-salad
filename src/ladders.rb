require 'squib'

Squib::Deck.new(cards: 8, config: 'config.yml') do
  background color: :white
  use_layout file: 'layouts/specials.yml'

  data = [
    'The Point Ladder',
    'The Resource Ladder',
    'The Special Ladder',
    'The Army Tracker',
    'The Blue Veep Tracker',
    'The Red Veep Tracker',
    'The Green Veep Tracker',
    'The Purple Veep Tracker'
  ]
  text layout: :title, str: data
  svg file: data.map { |s| "#{s.downcase}.svg" }
  # cut_zone
  # safe_zone
  save_png prefix: 'ladder_'
  save_sheet prefix: 'sheet_ladder_', rows: 3, columns: 3
end

Squib::Deck.new(cards: 3, config: 'config.yml') do
  background color: :white
  use_layout file: 'layouts/backs.yml'
  text str: ['Ladder Card'] * size, layout: :type
  save_png prefix: 'ladder_back_'
  save_sheet prefix: 'sheet_ladder_back_', rows: 3, columns: 3
end
