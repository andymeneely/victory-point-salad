require 'json'

# Generates a JSON output from deck for easy Git tracking.
def save_json(cards: 1, deck: {}, file: 'deck.json')
  h = {}
  (0..cards-1).each do |i|
    h[i] ||= {}
    deck.each_pair do |key, value|
      h[i][key] = value[i]
    end
  end
  File.open(file,"w") do |f|
    f.write(JSON.pretty_generate(h))
  end
end

# Explode quantity field
def explode_quantities(raw_deck)
  qtys = raw_deck['Qty']
  deck = {}
  raw_deck.each do |col, arr|
    deck[col] = []
    qtys.each_with_index do |qty, index|
      qty.to_i.times{ deck[col] << arr[index] }
    end
  end
  return deck
end

# Estimates the width of a given string to scale the bounding box properly
def bonusbox_width(strs, font_size)
  map = Hash.new(1.0)
  %w(f i j l r t !).each{|thin| map[thin] = 0.5}
  %w(o) .each{|med|             map[med] = 1.1}
  %w(m w S G).each{|fat|            map[fat] = 1.5}
  %w(M W C).each{|vfat|           map[vfat] = 1.7}

  margin = 75 # to overlap the left-side of the card
  return strs.inject([]) do |widths, str|
    if str.nil?
      widths << 0
    else 
      width = str.strip.scan(/./).inject(0) do |width, c|
        width + map[c]*font_size
      end
      widths << width + margin
    end
  end
end