require 'squib'
require_relative 'squib_helpers'

deck = Squib.xlsx file: 'data/deck.xlsx'

def text_box(str, layout, layout_rect)
  exts = text str: str, layout: layout
  rect layout: layout_rect,
       width: 5000,
       height: exts[0][:height] + 10,
       x: 2500 - exts[0][:width]
  text str: str, layout: layout
end

#### TOP ####
Squib::Deck.new(width: 3450, height: 2700,
                layout: %w(layouts/tgc-small-pro-box-top.yml layouts/box.yml),
                config: 'config.yml') do
  background color: :white

  vps = '<span foreground="#000">Victory Point Salad</span>'
  text str: wordwall(deck['Title'],vps, 43), layout: :coverart

  %w(north south).each do |dir|
    text str: 'Victory Point Salad', layout: "flap_#{dir}"
  end

  # png file: 'small-pro-box-top.png', alpha: 0.5
  save format: :png, prefix: 'box_top_'
end

#### BOTTOM ####
Squib::Deck.new(width: 3450, height: 2700,
                layout: %w(tgc-small-pro-box-bottom.yml box.yml),
                config: 'config.yml') do
  background color: :white

  text str: File.open('data/description.txt').read, layout: :desc

  text_box 'Victory Points!', :bullet, :bullet_rect
  text_box 'Stuff!',  :bullet2, :bullet_rect2
  text_box '1-4 players',  :bullet3, :bullet_rect3
  text_box '30 minutes',  :bullet4, :bullet_rect4

  text str: "by Andy Meneely", layout: :signature
  text str: 'Copyright (c) 2014 Andrew Meneely', layout: :copyright

  # png file: 'small-pro-box-bottom.png', alpha: 0.5
  save format: :png, prefix: 'box_bottom_'
end
