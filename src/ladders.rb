require 'squib'

data = [
  'The Point Ladder',
  'The Resource Ladder',
  'The Special Ladder',
  'The Army Tracker',
  # 'The Blue Veep Tracker',
  # 'The Red Veep Tracker',
  # 'The Green Veep Tracker',
  # 'The Purple Veep Tracker'
]

Squib::Deck.new(cards: data.length, config: 'config.yml') do
  background color: :white
  use_layout file: 'layouts/specials.yml'

  text layout: :title, str: data
  svg file: data.map { |s| "#{s.downcase}.svg" }
  # cut_zone
  # safe_zone
  save_png prefix: 'ladder_', count_format: '[%02d]'
  save_png range: 0, dir: 'docs', prefix: 'rules_ladder', count_format: ''
  save_sheet prefix: 'sheet_ladder_', rows: 3, columns: 3
end

Squib::Deck.new(cards: data.length, config: 'config.yml') do
  background color: :white
  use_layout file: 'layouts/backs.yml'
  text str: 'Ladder', layout: :type
  save_png prefix: 'ladder_back_', count_format: '[%02d]'
  save_sheet prefix: 'sheet_ladder_back_', rows: 3, columns: 3
end
