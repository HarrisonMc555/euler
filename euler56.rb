#!/usr/bin/env ruby

def digital_sum(x)
  x.to_s.each_char.map(&:to_i).inject(:+)
end

puts (1...100).flat_map { |a| (1...100).map { |b| digital_sum(a**b) } }.max
