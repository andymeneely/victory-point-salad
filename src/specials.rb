require 'squib'
require_relative 'squib_helpers'

trash_icon = "<span font=\"FontAwesome\">\uF1F8</span> "
requires_icon = "💥 "

data = Squib.xlsx file: 'data/deck.xlsx', sheet: 0

id = data['Title'].each.with_index.inject({}) { | hsh, (name, i)| hsh[name] = i; hsh}

Squib::Deck.new(cards: data['Title'].size) do
  use_layout file: 'layouts/specials.yml'
  background color: :white
  build :color do
    png file: 'table.png'
    svg file: 'steno pad.svg'
  end

  text str: data['Title'], layout: :title
  text str: data['Type'], layout: :type
  svg file: 'vp-drawn.svg', layout: :VP_img

  %w(Trash1 Trash2).each do |bonus|
    data[bonus].map! { |str| str && (trash_icon + str)}
  end

  %w(Requires1 Requires2).each do |bonus|
    data[bonus].map! { |str| str && (requires_icon + str)}
  end

  # Combine Trash & Requires into a single string
  data['PreReq'] = [data['Trash1'], data['Trash2'],
                    data['Requires1'], data['Requires2']]
                    .transpose
                    .map {|req| req.compact.join("\n")}

  %w(Bonus1 Bonus2).each do |bonus|
      range = [] # only put rectangles out in with non-nil texts
      data[bonus].each_with_index { |n, i| range << i unless n.nil? }
      svg range: range, layout: "#{bonus}Box"
      svg file: data[bonus].map {|b| b.nil? ? nil : "#{b.downcase}.svg" },
          layout: "#{bonus}Img"
  end

  %w(Bonus1 Bonus2 PreReq Description Snark VP).each do |key|
    text str: data[key], layout: key, markup: true
  end

  svg file: data['Power'].map { |p| p.nil? ? nil : 'power.svg' }, layout: :Power
  text str: data['Power'], layout: :PowerText

  svg layout: :TypeImg

  save_png prefix: 'special_'
  showcase file: 'special_showcase.png', fill_color: :black,
           range: [3, 15, 20, 69]

  build(:pdf) do
    rect layout: :cut_line
    save_pdf trim: 37.5
  end

  save_json cards: @cards.size, deck: data, file: "data/deck.json"
  puts "Done. #{data['Title'].size} cards"
end
