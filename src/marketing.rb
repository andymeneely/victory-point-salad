require 'squib'
require_relative 'squib_helpers'

deck = Squib.xlsx file: 'data/deck.xlsx'

Squib::Deck.new(cards: 1, width: 1600, height: 600) do
  vps = '<span foreground="#aaa">Victory Points</span>'
  str = wordwall(deck['Title'],vps, 23)
  # str = deck['Title'].uniq.join(' ')
  background color: :black
  text str: str, x: -50, y: -50,
       width: 1800, height: 700,
       font: 'Sans bold 10', color: '#222',
       spacing: -5,
       ellipsize: false, markup: true

  save format: :png, prefix: 'backdrop_'
end

Squib::Deck.new(cards: 1, width: 350, height: 150) do
  # background color: :white
  rect x: -50, y: 45, width: 390, height: 65, fill_color: :foreground, radius: 15
  str = "Victory Point Salad"
  text str: str, font: 'Sans bold 8', color: :background,
       width: 350, height: 150,
       align: :center, valign: :middle
  save format: :png, prefix: 'logo_'
end
