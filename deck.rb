require 'squib'
require_relative 'squib_helpers'

raw_deck = Squib.xlsx file: 'data/deck.xlsx'
deck = explode_quantities(raw_deck)

Squib::Deck.new(cards: deck['Title'].size, layout: 'layout.yml') do
  background color: :background

  text str: deck['Title'], layout: :title
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

  save format: :png
  save_json cards: @cards.size, deck: deck, file: "data/deck.json"
end

