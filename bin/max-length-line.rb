#!/usr/bin/env ruby

max_length = 0
max_line = ""

while line = STDIN.gets&.chomp
  if line.size > max_length
    max_length = line.size
    max_line = line
  end
end

puts "length: #{max_length}\n"
puts "line:\n#{max_line}\n"
