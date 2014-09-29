require 'squib'
require_relative 'squib_helpers'

color_dark = '#1A1917'
color_bg = '#EDEBD8'

deck = Squib.xlsx file: 'data/deck.xlsx'

Squib::Deck.new(cards: deck['Title'].size, layout: 'layout.yml') do
  background color: color_bg

  text str: deck['Title'], layout: :title

  #png file: 'tgc-proof-overlay.png'

  save format: :png
  save_json cards: @cards.size, deck: deck, file: "data/deck.json"
end

