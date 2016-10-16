require 'squib'

Squib::Deck.new(cards: 2) do
  background color: :white

  svg file: ['point ladder.svg', 'resource ladder.svg']

  save_png prefix: 'ladder_'

  use_layout file: 'layouts/layout.yml'
  rect layout: :cut_line
  save_pdf file: 'ladders.pdf', trim: 37.5
end
