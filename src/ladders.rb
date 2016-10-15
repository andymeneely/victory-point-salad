require 'squib'

Squib::Deck.new(cards: 2) do
  background color: :white

  svg file: ['point ladder.svg', 'resource ladder.svg']

  save_png prefix: 'ladder_'
  safe_pdf file: 'ladders.pdf'
end
