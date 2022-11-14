require 'squib'
require_relative 'squib_helpers'

deck = Squib.xlsx file: 'data/deck.xlsx', sheet: 1

Squib::Deck.new(cards: deck['Title'].size, width: 1125, height: 825) do
  background color: :background
  use_layout file: 'layouts/resource_backs.yml'

  text str: deck['Type'].map {|str| "#{str} Card"}, layout: :type

  save_png prefix: 'resource_back_', count_format: '[%02d]', rotate: :clockwise

  build :pdf do
    # svg file: 'crop_landscape.svg'
    save_pdf file: 'resource_backs.pdf', crop_marks: true
  end
end
