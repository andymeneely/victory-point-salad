require 'squib'

deck = Squib.xlsx file: 'data/deck.xlsx'

def wordwall(arr, title)
  loc  = 43  # where to insert the title
  prng = Random.new(1234)
  arr.uniq.shuffle(random: prng).insert(loc, title).join(' ')
end

Squib::Deck.new(width: 3450, height: 2700,
                layout: %w(tgc-small-pro-box-top.yml box.yml),
                config: 'config.yml') do
  background color: :white

  vps = '<span foreground="#000">Victory Point Salad</span>'
  text str: wordwall(deck['Title'],vps), layout: :coverart

  %w(north south).each do |dir|
    text str: 'Victory Point Salad', layout: "flap_#{dir}"
  end

  # png file: 'small-pro-box-top.png', alpha: 0.5
  save format: :png, prefix: 'box_top_'
end