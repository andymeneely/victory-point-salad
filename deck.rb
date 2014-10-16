require 'squib'
require_relative 'squib_helpers'

raw_deck = Squib.xlsx file: 'data/deck.xlsx'
deck = explode_quantities(raw_deck)

Squib::Deck.new(cards: deck['Title'].size, layout: 'layout.yml') do
  background color: :background

  text str: deck['Title'], layout: :title
  text str: deck['Type'], layout: :type
  svg file: 'vp.svg', layout: :VP_img

  range = [] ; deck['Requires1'].each_with_index { |n, i| range << i unless n.nil? }
  text str: 'Requires:', layout: :Requires, range: range

  %w(Bonus1 Bonus2).each do |bonus|
      range = [] # only put rectangles out in with non-nil texts
      deck[bonus].each_with_index { |n, i| range << i unless n.nil? }
      rect range: range, layout: "#{bonus}Box"
  end 

  %w(Bonus1 Bonus2 Requires Requires1 Requires2 Requires3 Description Snark VP).each do |key|
    text str: deck[key], layout: key
  end

  #png file: 'tgc-proof-overlay.png'

  # save format: :png
  # save format: :pdf, file: 'deck.pdf', trim: 38
  # save_json cards: @cards.size, deck: deck, file: "data/deck.json"
end

Squib::Deck.new(cards: 1, width: 1600, height: 600) do
  vps = '<span foreground="#888">Victory Points</span>'
  str = deck['Title'].uniq.insert(deck['Title'].uniq.size/2 + 0,vps).join(' ')
  # str = deck['Title'].uniq.join(' ')
  background color: :background
  text str: str, x: -50, y: -50, 
       width: 1800, height: 700, 
       font: 'Sans bold 32', color: '#ccc',
       spacing: -8,
       ellipsize: false, markup: true

  save format: :png, prefix: 'backdrop_'
end

Squib::Deck.new(cards: 1, width: 350, height: 150) do
  # background color: :white
  rect x: -50, y: 45, width: 390, height: 65, fill_color: :foreground, radius: 15
  str = "Victory Point Salad"
  text str: str, font: 'Sans bold 24', color: :background,
       width: 350, height: 150, 
       align: :center, valign: :middle
  save format: :png, prefix: 'logo_'
end
