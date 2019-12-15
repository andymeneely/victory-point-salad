require 'json'
require 'byebug'
require_relative 'version'

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

def wordwall(arr, title, loc)
  prng = Random.new(1234)
  arr.uniq.shuffle(random: prng).insert(loc, title).join(' ')
end

# Given two parallel arrays of images that correspond to front and back,
# Arrange them such that they will be back-to-back if front-to-back printing
# is enabled. This returns a single array.
# e.g. if 'a' and 'A' are front-back
# 8 cards per sheet
#
# faces: A B C D E F G H I J K
# backs: a b c d e f g h i j k
#
# Would need to be arranged:
#   -----------
#   | A B C D |
#   | E F G H |
#   -----------
#   -----------
#   | d c b a |
#   | h g f e |
#   -----------
#   -----------
#   | I J K   |
#   |         |
#   -----------
#   -----------
#   |   k j i |
#   |         |
#   -----------
#  And then flattened out to a single array:
#  A B C D E F G H d c b a h g f e I J K nil nil nil nil nil k j i nil nil nil nil
def merge_front_back(faces, backs, per_sheet = 8, rows = 2)
  # Pad the arrays to be divisible by 8
  faces += [nil] * (per_sheet - faces.size % per_sheet)
  backs += [nil] * (per_sheet - backs.size % per_sheet)
  # Combine them into pairs
  z = faces.zip(backs)
  row_n = per_sheet / rows
  merged = []
  z.each_slice(per_sheet) do |pairs| # [[A,a],[B,b],[C,c],...]
    pairs.each { |(face, _back)| merged << face } # [A B C D]
    pairs.each { |(_face, back)| merged << back } # [a b c d]
  end

  # We need to reverse the rows of backs so they line up front-to-back
  # Assume 2 rows
  merged2 = []
  row_i = 0
  on_face = true
  merged.each_slice(row_n) do |row|
    if on_face
      merged2 += row # faces we put it as normal
    else
      merged2 += row.reverse # back we need to reverse
    end
    row_i += 1
    if row_i == rows # time for the next page!
      on_face = !on_face
      row_i = 0
    end
  end
  return merged2
end
