require 'squib'
require_relative 'squib_helpers'

trash_icon = "<span font=\"FontAwesome\">\uF1F8</span> "
requires_icon = "<span font=\"FontAwesome\">\uF023</span> "

data = Squib.xlsx file: 'data/deck.xlsx', sheet: 1

Squib::Deck.new(cards: data['Title'].size, width: 1125, height: 825) do
  use_layout file: %w(layouts/base.yml layouts/resources.yml)
  background color: :white
  build :color do
    png file: 'table.png'
    svg file: 'stickie.svg'
  end

  text str: data['Title'], layout: :title
  text str: data['Type'], layout: :type
  svg file: 'vp-drawn.svg', layout: :VP_img

  %w(Resource1 Resource2).each do |bonus|
      range = [] # only put rectangles out in with non-nil texts
      data[bonus].each_with_index { |n, i| range << i unless n.nil? }
      bonus_boxes = data[bonus].map { |b| b.nil? ? nil : 'bonus_box.svg' }
      svg file: bonus_boxes, layout: "#{bonus}Box"
  end
  svg file: data['Resource1'].map {|b| b.nil? ? nil : "#{b.downcase}.svg" },
      layout: "Resource1Img"
  svg file: data['Resource2'].map {|b| b.nil? ? nil : "#{b.downcase}.svg" },
      layout: "Resource2Img"


  %w(Resource1 Resource2 Description Snark VP).each do |key|
    text str: data[key], layout: key, markup: true
  end

  # rect layout: 'Description',
  #      range: data['Description'].each.with_index.inject([]) {|rng, (d, i)| rng << i unless d.to_s.strip.empty?; rng}

  # png file: 'tgc-proof-overlay.png', angle: Math::PI/2, x: 1125
  # save_png range: id['The Building Building Building']

  save_png prefix: 'resource_' #all
  # save_sheet prefix: 'sheet_', columns: 8, margin: 75, gap: 5, trim: 37
  # save format: :pdf, file: 'data.pdf', trim: 37
  showcase file: 'resource_showcase.png', range: [3, 15, 42], fill_color: :black
  # save_png range: [0,5,7,10,30,33,42], prefix: 'resource_'
  # showcase range: [1,72], fill_color: :black
  rect layout: :cut_line

  save_pdf trim: 37.5, file: 'resources.pdf'
  build(:pdf) do
  end

  save_json cards: @cards.size, deck: data, file: "data/resources.json"
  puts "Done. #{data['Title'].size} cards"
end
