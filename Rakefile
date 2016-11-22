require 'squib'
require 'rake/clean'
require 'launchy'

# Add clean & clobber tasks
CLEAN.include('_output/*').exclude('_output/gitkeep.txt')

desc 'Build the specials deck by default black-and-white'
task default: [:specials]

desc 'Build everything black-and-white'
task all: [:specials,
           :special_backs,
           :resources,
           :resource_backs,
           :marketing,
           :ladders]

desc 'Build default task with color'
task color: [:with_color, :all]

desc 'Build the main deck'
task(:specials)       { load 'src/specials.rb' }

desc 'Build the backs for specials'
task(:special_backs)  { load 'src/special_backs.rb' }

desc 'Build resources deck'
task(:resources)      { load 'src/resources.rb' }

desc 'Build the resource backs'
task(:resource_backs) { load 'src/resource_backs.rb' }

desc 'Build ladder cards'
task(:ladders)        { load 'src/ladders.rb' }

desc 'Build marketing images'
task(:marketing)      { load 'src/marketing.rb' }

desc 'Launch the Excel sheet'
task :data do
  url = "file:///#{Dir.pwd}/data/deck.xlsx"
  puts "Launching #{url}"
  Launchy.open url
end

desc 'Enable color for the rest of the builds'
task :with_color do
  ENV['SQUIB_BUILD'] ||= ''
  ENV['SQUIB_BUILD'] += ',color'
end
