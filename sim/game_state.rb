module VPS
  class GameState
    attr_accessor :starters,
                  :specials,
                  :resources,
                  :engines,
                  :blockers,
                  :discard_r,
                  :discard_s,
                  :p1_tableau,
                  :p2_tableau,
                  :p1_hand,
                  :p2_hand,
                  :avail_purchase,
                  :avail_resources

    def pretty_print
      puts <<-EOS
=== Player 1 ==
  Hand:      #{ @p1_hand.join(', ') }
  Tableau:   #{@p1_tableau.join(', ')}
=== Player 2 ==
  Hand:      #{ @p2_hand.join(', ') }
  Tableau:   #{@p2_tableau.join(', ')}
=== Table ===
  Specials:  #{avail_purchase.join(', ')}
  Resources: #{avail_resources.join(', ')}
      EOS
    end

    def self.from_xlsx(xlsx, prng)
      table  = explode_quantities(Squib.xlsx(file: xlsx))
      gs = GameState.new
      gs.starters   = []
      gs.resources  = []
      gs.specials   = []
      gs.engines    = []
      gs.blockers   = []
      gs.discard_r  = []
      gs.discard_s  = []
      gs.p1_tableau = []
      gs.p2_tableau = []
      gs.p1_hand    = []
      gs.p2_hand    = []
      0.upto(table['Title'].size).each do |i|
        unless table['Title'][i].nil?
          class_name = table['Title'][i].gsub(/[\s\!\-]/,'')
          c = Object.const_get("VPS::#{class_name}").new
          case table['Type'][i]
          when 'Resource'
            gs.resources << c
          when 'Engine'
            gs.engines   << c
          when 'Starter'
            gs.starters  << c
          when 'Special'
            gs.specials  << c
          when 'Blocker'
            gs.blockers  << c
          end
          c.id          = i
          c.title       = table['Title'][i]
          c.description = table['Description'][i]
          c.snark       = table['Snark'][i]
          c.vp          = table['VP'][i]
          c.bonuses ||= []
          c.bonuses    << table['Bonus1'][i]
          c.bonuses    << table['Bonus2'][i]
          c.trashes ||= []
          c.trashes    << table['Trash1'][i]
          c.trashes    << table['Trash2'][i]
          c.requires  ||= []
          c.requires    << table['Requires1'][i]
          c.requires    << table['Requires2'][i]
        end
      end
      num_players = 2
      num_start_resources = 4
      num_start_specials = 4
      num_resources_avail = num_players * 3 - 1
      num_specials_avail = num_players * 3 - 1

      gs.resources.shuffle!(random: prng)
      gs.starters.shuffle!(random: prng)
      gs.specials.shuffle!(random: prng)

      gs.p1_hand = gs.specials.pop(num_start_specials) #start with specials in hand
      gs.p2_hand = gs.specials.pop(num_start_specials) #start with specials in hand
      gs.p1_tableau = gs.resources.pop(num_start_resources) #start with resources
      gs.p2_tableau = gs.resources.pop(num_start_resources) #start with resources

      gs.avail_resources = gs.resources.pop(num_resources_avail)
      gs.avail_purchase  = gs.specials .pop(num_specials_avail)
      return gs
    end
  end
end