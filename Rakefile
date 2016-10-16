require 'squib'

desc 'Build the main deck by default'
task default: [:deck]

desc 'Build everything'
task all: [:deck, :backs, :marketing, :ladders]

desc 'Build the main deck'
task(:deck)      { load 'src/deck.rb' }

desc 'Build the deck backs'
task(:backs)     { load 'src/backs.rb' }

desc 'Build ladder cards'
task(:ladders)   { load 'src/ladders.rb' }

desc 'Build marketing images'
task(:marketing) { load 'src/marketing.rb' }
