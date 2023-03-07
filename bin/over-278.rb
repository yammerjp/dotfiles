#!/usr/bin/env ruby

over_278_line_size = 0
while line = STDIN.gets&.chomp
  if line.size > 278
    over_278_line_size += 1
  end
end

puts over_278_line_size

