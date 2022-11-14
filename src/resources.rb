require 'squib'
require_relative 'squib_helpers'

data = Squib.xlsx file: 'data/deck.xlsx', sheet: 1
File.open('data/resources.txt', 'w+') { |f| f.write data.to_pretty_text }
File.open('data/resources.json', 'w+') { |f| f.write data.to_pretty_json }

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

  # text str: "#{VictoryPointSalad::VERSION} #{VictoryPointSalad::GIT_HEAD}",
  #      layout: :version

  save_png prefix: 'resource_', rotate: :clockwise #all
  save_sheet prefix: 'sheet_resources_', columns: 5, rows: 5

  build(:pdf) do
    rect layout: :cut_line
    save_pdf trim: 37.5, file: 'resources.pdf'
  end

  save_png range: 36,
            dir: 'docs', prefix: 'rules_resource', count_format: '',
            trim: 37.5, trim_radius: 37.5,
            shadow_radius: 10

end

puts "Done. #{data.nrows} Resource cards"
