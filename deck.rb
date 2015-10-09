require 'squib'
require_relative 'squib_helpers'

trash_icon = "<span font=\"FontAwesome\">\uF1F8</span> "
requires_icon = "<span font=\"FontAwesome\">\uF023</span> "

data = Squib.xlsx file: 'data/deck.xlsx'
data = explode_quantities(data)

id = data['Title'].each.with_index.inject({}) { | hsh, (name, i)| hsh[name] = i; hsh}

Squib::Deck.new(cards: data['Title'].size, layout: 'layout.yml') do
  background color: :background

  text str: data['Title'], layout: :title
  text str: data['Type'], layout: :type
  svg file: 'vp.svg', layout: :VP_img

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
      widths = bonusbox_width(data[bonus], @layout[bonus]['font_size'])
      rect range: range, layout: "#{bonus}Box", width: widths
  end

  %w(Bonus1 Bonus2 PreReq Description Snark VP).each do |key|
    text str: data[key], layout: key, markup: true
  end

  # png file: 'tgc-proof-overlay.png'
  # save_png #all
  save_png range: id['The Building Building Building']

  rect layout: :cut_line
  # save_sheet prefix: 'sheet_', columns: 8, margin: 75, gap: 5, trim: 37
  # save format: :pdf, file: 'data.pdf', trim: 37
  # showcase file: 'showcase.png', range: [3,15,20, 90], fill_color: :black

  save_json cards: @cards.size, deck: data, file: "data/deck.json"
  puts "Done. #{data['Title'].size} cards"
end
