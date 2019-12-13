require 'squib'
require_relative 'version'

data = Squib.xlsx file: 'data/deck.xlsx', sheet: 0, explode: 'nothing'
out = StringIO.new
out.puts "graph LR"

(0..data.nrows).each do |i|
  row = data.row(i)

  %w(Trash1 Trash2).each do |req|
    unless row[req].to_s.empty?
      a = row[req]
      a_id = a.downcase.gsub(/\s+/,'')
      b = row['Title'].gsub('"', '').gsub("'",'')
      b_id = b.downcase.gsub(/\s+/,'')
      out.puts "    #{a_id}[#{a}] --> #{b_id}[#{b}];"
    end
  end

  %w(Bonus1 Bonus2).each do |bonus|
    unless row[bonus].to_s.empty?
      a = row['Title'].gsub('"', '').gsub("'",'')
      a_id = a.downcase.gsub(/\s+/,'')
      b = row[bonus]
      b_id = b.downcase.gsub(/\s+/,'')
      out.puts "    #{a_id}[#{a}] --> #{b_id}[#{b}];"
    end
  end

  %w(Require1 Require2).each do |req|
    unless row[req].to_s.empty?
      a = row[req]
      a_id = a.downcase.gsub(/\s+/,'')
      b = row['Title'].gsub('"', '').gsub("'",'')
      b_id = b.downcase.gsub(/\s+/,'')
      out.puts "    #{a_id}[#{a}] -.-> #{b_id}[#{b}];"
    end
  end

end


File.open('tree.mm', 'w') { |f| f.write out.string }
puts "Done building Mermaid tree."
