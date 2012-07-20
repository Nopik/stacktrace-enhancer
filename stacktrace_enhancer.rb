#!/usr/bin/env ruby

context = 1

until $stdin.eof?
  line = $stdin.gets

  puts line

  line.match(/^    at ([^\/ ]+ \()?(\/[a-zA-Z0-9._\/]+\.coffee):([0-9]+):([0-9]+)\)?$/) do |m|
    filename = m[ 2 ]
    linenum = m[ 3 ].to_i
    column = m[ 4 ].to_i

    begin
      if File.exists?( filename )
        content = `coffee -p -j -c #{filename}`
        content = content.split "\n"

        context.times do |c|
          l = linenum - context + c - 1
          if l > 0
            puts "\x1b[34;1m#{content[ l ]}\x1b[0m"
          end
        end
        if (content.length >= linenum) && (linenum > 0)
          puts "\x1b[31;1m#{content[ linenum-1 ]}\x1b[0m"
          arrow = (" " * (column-1)) + "^"
          puts arrow
        end
        context.times do |c|
          l = linenum + c + 1
          if l < content.length
            puts "\x1b[34;1m#{content[ l ]}\x1b[0m"
          end
        end
      end
    rescue
      puts " Cannot open file: #{filename}"
    end
  end
end

