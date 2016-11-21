require 'squib'
require_relative 'squib_helpers'

deck = Squib.xlsx file: 'data/deck.xlsx'

Squib::Deck.new(cards: deck['Title'].size, width: 1125, height: 825)) do
  background color: :background
  use_layout file: 'layouts/backs.yml'

  build :color do
    png file: 'table.png'
    svg file: 'steno pad.svg',
  end

  text str: deck['Type'], layout: :type

  # save_png prefix: 'back_'
  rect layout: :cut_line
  save_pdf file: 'backs.pdf', trim: 37
end
