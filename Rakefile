require 'squib'
require 'rake/clean'

CLEAN.include('_output/*').exclude('_output/gitkeep.txt')

desc 'Build the specials deck by default'
task default: [:specials]

desc 'Build everything'
task all: [:specials, :resources, :backs, :marketing, :ladders]

desc 'Build the main deck'
task(:specials)  { load 'src/specials.rb' }

desc 'Build resources deck'
task(:resources) { load 'src/resources.rb' }

desc 'Build the deck backs'
task(:backs)     { load 'src/backs.rb' }

desc 'Build ladder cards'
task(:ladders)   { load 'src/ladders.rb' }

desc 'Build marketing images'
task(:marketing) { load 'src/marketing.rb' }
