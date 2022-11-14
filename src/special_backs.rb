require 'squib'
require_relative 'squib_helpers'

deck = Squib.xlsx file: 'data/deck.xlsx', sheet: 0, explode: 'qty'

Squib::Deck.new(cards: deck['Title'].size) do
  use_layout file: 'layouts/backs.yml'
  background color: :white

  type_str = deck['Type'].map { |str| "#{str} Card" }
  text str: type_str, layout: :type

  save_png prefix: 'special[back]_'
  save_sheet prefix: 'sheet_special_back_', columns: 10, rows: 7
  # rect layout: :cut_line
  # save_pdf file: 'special_backs.pdf', trim: 37

end
