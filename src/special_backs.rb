require 'squib'
require_relative 'squib_helpers'

deck = Squib.xlsx file: 'data/deck.xlsx', sheet: 0

Squib::Deck.new(cards: deck['Title'].size) do
  use_layout file: %w(layouts/layout.yml layouts/backs.yml)

  background color: :white
  build :color do
    png file: 'table.png'
    svg file: 'steno pad.svg'
  end

  text str: deck['Type'], layout: :type

  # save_png prefix: 'special_back_' #all
  save_png prefix: 'special_back_', range: [1,20,30,50,60,68]
  # rect layout: :cut_line
  # save_pdf file: 'backs.pdf', trim: 37
end
