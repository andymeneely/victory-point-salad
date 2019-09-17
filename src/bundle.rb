require 'squib'
require_relative 'squib_helpers'

# Collect the entire collection of output files
special_faces = Dir['_output/special_??.png'].sort
special_backs = Dir['_output/special_back_??.png'].sort

resource_faces = Dir['_output/resource_??.png'].sort
resource_backs = Dir['_output/resource_back_??.png'].sort

ladder_faces = Dir['_output/ladder_??.png'].sort

n = special_faces.length + resource_faces.length + ladder_faces.length

Squib.configure img_dir: '.'

def merge_front_back(faces, backs, per_sheet = 8)
  z = faces.zip(backs)
  merged = []
  z.each_slice(per_sheet) do |pairs|
    pairs.each { |(face, _back)| merged << face }
    pairs.each { |(_face, back)| merged << back }
  end
  return merged
end

Squib::Deck.new(cards: n) do
  background color: :white
  # puts merge_front_back(special_faces, special_backs)
  png file: merge_front_back(special_faces, special_backs)
  save_pdf file: 'bundle-k40.pdf', margin: '0.125in', trim: '0.05in'
end
