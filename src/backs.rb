require 'squib'
require_relative 'squib_helpers'

deck = Squib.xlsx file: 'data/deck.xlsx'
deck = explode_quantities(deck)

Squib::Deck.new(cards: deck['Title'].size, width: 1125, height: 825,
                layout: %w(layouts/layout.yml layouts/backs.yml)) do
  background color: :background

  text str: deck['Type'], layout: :type

  # save_png prefix: 'back_'
  rect layout: :cut_line
  save_pdf file: 'backs.pdf', trim: 37
end
