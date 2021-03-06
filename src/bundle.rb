require 'squib'
require_relative 'squib_helpers'

# Collect the entire collection of output files
special_faces = Dir['_output/special_??.png'].sort
special_backs = Dir['_output/special_back_??.png'].sort

special_faces += Dir['_output/ladder_??.png'].sort
special_backs += Dir['_output/ladder_back_??.png'].sort

special_pngs = merge_front_back(special_faces, special_backs)

Squib::Deck.new(cards: special_pngs.size, config: 'bundle.yml') do
  background color: :white
  png file: special_pngs
  save_pdf file: 'bundle-specials-k40.pdf', margin: '0.125in', trim: '0.05in'
end

resource_faces = Dir['_output/resource_??.png'].sort
resource_backs = Dir['_output/resource_back_??.png'].sort

resource_pngs = merge_front_back(resource_faces, resource_backs)

Squib::Deck.new(cards: resource_pngs.size, config: 'bundle.yml') do
  background color: :white
  png file: resource_pngs, angle: Math::PI / 2, x: 825
  save_pdf file: 'bundle-resources-k40.pdf', margin: '0.125in', trim: '0.05in'
end

# Printing tip: print two-sided with "flip on long edge"
