require 'squib'
require 'rake/clean'
require 'launchy'
require 'erb'

# Add clean & clobber tasks
CLEAN.include('_output/*').exclude('_output/gitkeep.txt')

desc 'Build the specials deck by default black-and-white'
task default: [:all]

desc 'Build everything black-and-white'
task all: [:specials,
           :special_backs,
           :resources,
           :resource_backs,
           :ladders,
           :tree,
           :tree_cli,
           :bundle,
         ]

desc 'Build default task with color'
task color: [:with_color, :all]

desc 'Build only the faces'
task faces: [:specials, :resources]

desc 'Build the main deck'
task(:specials)       { load 'src/specials.rb' }

desc 'Build the backs for specials'
task(:special_backs)  { load 'src/special_backs.rb' }

desc 'Build resources deck'
task(:resources)      { load 'src/resources.rb' }

desc 'Build the resource backs'
task(:resource_backs) { load 'src/resource_backs.rb' }

desc 'Make a big PDF front-and-back.'
task(:bundle) { load 'src/bundle.rb' }

desc 'Build ladder cards'
task(:ladders)        { load 'src/ladders.rb' }

desc 'Build marketing images'
task(:marketing)      { load 'src/marketing.rb' }

desc 'Build the giant tree'
task(:tree)           { load 'src/tree.rb' }

desc 'Build the giant tree to SVG'
task(tree_cli: :tree) { `./node_modules/.bin/mmdc -i tree.mm -o _output/tree.svg` }

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

desc 'Enable PDF builds'
task :with_pdf do
  Squib.enable_build_globally :pdf
end

desc 'Build the rules sheet'
task :rules do
  load 'src/rules.rb' # convert markdown
  erb = ERB.new(File.read('docs/RULES_TEMPLATE.html.erb'))
  File.open('docs/RULES.html', 'w+') { |html|  html.write(erb.result) }
  puts "Weasyprinting..."
  `python src/weasybuild.py`
  puts "Ghostscripting PDF to PNGs..."
  `gswin64c -dNOPAUSE -dBATCH -sDEVICE=png16m -r600 -dDownScaleFactor=2 -sOutputFile="_output/RULES-%02d.png" _output/RULES.pdf`
  # `gs -dNOPAUSE -dBATCH -sDEVICE=png16m -r600 -dDownScaleFactor=2 -sOutputFile="_output/RULES-[%02d].png" _output/RULES.pdf`
end

desc 'Open up resources after building. Put last, e.g. rake rules launch'
task :launch do
  return unless @launch.respond_to? :each
  @launch.each do |url|
    puts "Launching #{url}"
    Launchy.open url
  end
end

desc 'Enable figure building for future builds'
task :with_figures do
  Squib.enable_build_globally :figures
end
