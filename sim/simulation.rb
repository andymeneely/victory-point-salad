require 'pp'
require 'squib'
require_relative 'cards'
require_relative 'game_state'
require_relative '../squib_helpers'

prng = Random.new(1234)
gs = VPS::GameState.from_xlsx('data/deck.xlsx', prng)
gs.pretty_print

puts "Done!"