require 'squib'
require_relative 'squib_helpers'

data = Squib.xlsx file: 'data/deck.xlsx', sheet: 0, explode: 'qty'
File.open('data/specials.txt', 'w+') { |f| f.write data.to_pretty_text }
File.open('data/specials.json', 'w+') { |f| f.write data.to_json }

id = data['Title'].each.with_index.inject({}) { | hsh, (name, i)| hsh[name] = i; hsh}

Squib::Deck.new(cards: data['Title'].size) do
  use_layout file: 'layouts/specials.yml'
  background color: :white

  svg file: 'vp.svg', layout: :VP_img
  text str: data['Title'], layout: :title

  %w(Trash1 Trash2).each do |bonus|
    data[bonus].map! { |str| str && (":trash: Trash 1 #{str}")}
  end

  %w(Requires1 Requires2).each do |bonus|
    data[bonus].map! { |str| str && ("◎ Requires #{str}") }
  end

  # Combine Trash & Requires into a single string
  data['PreReq'] = [data['Trash1'], data['Trash2'],
                    data['Requires1'], data['Requires2']]
                    .transpose
                    .map {|req| req.compact.join("\n")}

  # Combine Trash, Requires into a single string
  data['Description'] = data['Description'].zip(data['PreReq']).map do |desc, prereq|
    if prereq.to_s.empty?
      desc
    else
      "<span foreground=\"red\">#{prereq}</span>\n \n#{desc}"
    end
  end

  %w(Bonus1 Bonus2).each do |bonus|
      svg file: data[bonus].map {|b| b.nil? ? nil : "#{b.downcase.strip}.svg" },
          layout: "#{bonus}Img"
  end

  %w(Bonus1 Bonus2 Description Snark VP).each do |key|
    text(str: data[key], layout: key, markup: true) do |embed|
      w = 35 # px
      embed.svg key: ':trash:', file: 'img/trash.svg',
                width: w, height: w * 1.14, dy: 5, dx: 2
    end
  end

  svg file: data['Power'].map { |p| p.nil? ? nil : 'power.svg' },
      layout: :Power
  text str: data['Power'], layout: :PowerText,
       font_size: data['Power'].map { |p| p.to_s.length > 15 ? 10 : 12 }

  text str: "#{VictoryPointSalad::VERSION} #{VictoryPointSalad::GIT_HEAD}",
       layout: :version

  # rect layout: :cut_zone
  # rect layout: :safe_zone
  save_png prefix: 'special_', trim: 37.5, trim_radius: 37.5
  save_sheet prefix: 'special_sheet_', columns: 13

  build(:pdf) do
    save_pdf trim: 37.5, file: 'specials.pdf'
  end

  save_png prefix: 'rules_figure_', range: 35, dir: 'docs', trim_radius: 37.5
  save_sheet prefix: 'sheet_special_', columns: 10, rows: 7

end

puts "Done. #{data['Title'].size} Special cards"
