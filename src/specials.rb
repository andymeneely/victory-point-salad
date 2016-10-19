require 'squib'
require_relative 'squib_helpers'

trash_icon = "<span font=\"FontAwesome\">\uF1F8</span> "
requires_icon = "<span font=\"FontAwesome\">\uF023</span> "

data = Squib.xlsx file: 'data/deck.xlsx', sheet: 0

id = data['Title'].each.with_index.inject({}) { | hsh, (name, i)| hsh[name] = i; hsh}

Squib::Deck.new(cards: data['Title'].size, layout: 'layouts/layout.yml') do
  background color: :background
  svg file: 'steno pad.svg'

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
      widths = bonusbox_width(data[bonus], @layout[bonus]['font_size'])
      rect range: range, layout: "#{bonus}Box", width: widths
  end

  %w(Bonus1 Bonus2 PreReq Description Snark VP).each do |key|
    text str: data[key], layout: key, markup: true
  end

  # rect layout: 'Description',
  #      range: data['Description'].each.with_index.inject([]) {|rng, (d, i)| rng << i unless d.to_s.strip.empty?; rng}

  # png file: 'tgc-proof-overlay.png'
  # save_png range: id['The Building Building Building']

  # save_png #all
  # save_sheet prefix: 'sheet_', columns: 8, margin: 75, gap: 5, trim: 37
  # save format: :pdf, file: 'data.pdf', trim: 37
  # showcase file: 'showcase.png', range: [3,15,20, 90], fill_color: :black
  save_png range: [1,46]
  # showcase range: [1,72], fill_color: :black
  rect layout: :cut_line

  # build(:pdf) do
    # save_pdf trim: 37.5
  # end


  save_json cards: @cards.size, deck: data, file: "data/deck.json"
  puts "Done. #{data['Title'].size} cards"
end
