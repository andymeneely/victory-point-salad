require 'squib'
require_relative 'squib_helpers'

deck = Squib.xlsx file: 'data/deck.xlsx'
deck = explode_quantities(deck)

Squib::Deck.new(cards: deck['Title'].size, layout: 'layout.yml') do
  background color: :background

  text str: deck['Title'], layout: :title
  text str: deck['Type'], layout: :type
  svg file: 'vp.svg', layout: :VP_img

  # Put the text "Requires" when necessary
  range = [] ; deck['Requires1'].each_with_index { |n, i| range << i unless n.nil? }
  text str: 'Requires:', layout: :Requires, range: range
  # Put the text "Trash" when necessary
  range = [] ; deck['Trash1'].each_with_index { |n, i| range << i unless n.nil? }
  text str: 'Trash:', layout: :Trash, range: range

  %w(Bonus1 Bonus2).each do |bonus|
      range = [] # only put rectangles out in with non-nil texts
      deck[bonus].each_with_index { |n, i| range << i unless n.nil? }
      widths = bonusbox_width(deck[bonus], @layout[bonus]['font_size'])
      rect range: range, layout: "#{bonus}Box", width: widths
  end

  %w(Bonus1 Bonus2 Trash1 Trash2 Requires1 Requires2 Description Snark VP).each do |key|
    text str: deck[key], layout: key
  end

  # png file: 'tgc-proof-overlay.png'
  save format: :png
  rect layout: :cut_line
  save format: :pdf, file: 'deck.pdf', trim: 37

  save_json cards: @cards.size, deck: deck, file: "data/deck.json"
  puts "Done. #{deck['Title'].size} cards"
end
