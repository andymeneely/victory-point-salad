require 'squib'
require_relative 'squib_helpers'

trash_icon = "<span font=\"FontAwesome\">\uF1F8</span> "
requires_icon = "<span font=\"FontAwesome\">\uF023</span> "

data = Squib.xlsx file: 'data/deck.xlsx', sheet: 1

Squib::Deck.new(cards: data['Title'].size, width: 1125, height: 825) do
  use_layout file: %w(layouts/base.yml layouts/resources.yml)
  background color: :white
  svg file: 'graph paper.svg'

  text str: data['Title'], layout: :title
  text str: data['Type'], layout: :type
  svg file: 'vp-drawn.svg', layout: :VP_img

  %w(Bonus1 Bonus2).each do |bonus|
      range = [] # only put rectangles out in with non-nil texts
      data[bonus].each_with_index { |n, i| range << i unless n.nil? }
      widths = bonusbox_width(data[bonus], @layout[bonus]['font_size'])
      rect range: range, layout: "#{bonus}Box", width: widths
  end

  %w(Bonus1 Bonus2 PreReq Description Snark VP).each do |key|
    text str: data[key], layout: key, markup: true
  end

  # rect layout: 'Description',
  #      range: data['Description'].each.with_index.inject([]) {|rng, (d, i)| rng << i unless d.to_s.strip.empty?; rng}

  png file: 'tgc-proof-overlay.png', angle: Math::PI/2, x: 1125
  # save_png range: id['The Building Building Building']

  # save_png #all
  # save_sheet prefix: 'sheet_', columns: 8, margin: 75, gap: 5, trim: 37
  # save format: :pdf, file: 'data.pdf', trim: 37
  # showcase file: 'showcase.png', range: [3,15,20, 90], fill_color: :black
  save_png range: [0,5,10], prefix: 'resource_'
  # showcase range: [1,72], fill_color: :black
  rect layout: :cut_line

  # build(:pdf) do
    # save_pdf trim: 37.5
  # end


  save_json cards: @cards.size, deck: data, file: "data/deck.json"
  puts "Done. #{data['Title'].size} cards"
end
