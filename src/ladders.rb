require 'squib'

Squib::Deck.new(cards: 2) do
  background color: :white
  build :color do
    png file: 'table.png'
    svg file: 'steno pad.svg'
  end

  svg file: ['point ladder.svg', 'resource ladder.svg']


  save_png prefix: 'ladder_'

  use_layout file: 'layouts/specials.yml'
  rect layout: :cut_line
  save_pdf file: 'ladders.pdf', trim: 37.5
end
