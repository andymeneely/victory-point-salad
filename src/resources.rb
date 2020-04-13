require 'squib'
require_relative 'squib_helpers'

trash_icon = "<span font=\"FontAwesome\">\uF1F8</span> "
requires_icon = "<span font=\"FontAwesome\">\uF023</span> "

data = Squib.xlsx file: 'data/deck.xlsx', sheet: 1

Squib::Deck.new(cards: data['Title'].size, width: 1125, height: 825) do
  use_layout file: 'layouts/resources.yml'
  background color: :white

  text str: data['Title'], layout: :title
  text str: data['Type'], layout: :type
  svg file: 'vp.svg', layout: :VP_img

  %w(Resource1 Resource2).each do |bonus|
      svg file: data[bonus].map {|b| b.nil? ? nil : "#{b.downcase}.svg" },
          layout: "#{bonus}Img"
  end

  %w(Resource1 Resource2 Description Snark VP).each do |key|
    text str: data[key], layout: key, markup: true
  end

  # rect layout: 'Description',
  #      range: data['Description'].each.with_index.inject([]) {|rng, (d, i)| rng << i unless d.to_s.strip.empty?; rng}

  # png file: 'tgc-proof-overlay.png', angle: Math::PI/2, x: 1125
  # save_png range: id['The Building Building Building']

  save_png prefix: 'resource_' #all
  save_sheet prefix: '_sheet_resources_', columns: 10, row: 7
  # save format: :pdf, file: 'data.pdf', trim: 37
  # showcase file: 'resource_showcase.png', range: [3, 15, 42], fill_color: :black
  # save_png range: [0,5,7,10,30,33,42], prefix: 'resource_'
  # showcase range: [1,72], fill_color: :black

  build(:pdf) do
    rect layout: :cut_line
    save_pdf trim: 37.5, file: 'resources.pdf'
  end

  build(:figures) do
    save_png range: 36,
             dir: 'docs', prefix: 'rules_resource_figure_',
             trim: 37.5, trim_radius: 37.5
  end

  File.open('data/resources.txt', 'w+') { |f| f.write data.to_pretty_text }

  puts "Done. #{data['Title'].size} cards"
end
