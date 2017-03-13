#!/usr/bin/env ruby

require 'prime'

def diag_nums(side_length)
  base = (side_length-2)**2
  step = side_length-1
  (0...4).map { |i| base + step*i }
end

def get_ratio(side_length,nprimes)
  nnums = Float(2*side_length-1)
  nprimes/nnums
end

nprimes = 0
for n in 1..Float::INFINITY do
  side_length = n*2+1
  # puts "diag_nums: #{diag_nums(side_length)}"
  nprimes += diag_nums(side_length).select { |x| Prime.prime? x }.count
  ratio = get_ratio(side_length,nprimes)
  # puts "#{n} #{nprimes} #{ratio}"
  if ratio < 0.1
    puts "#{side_length}"
    break
  end
end

exit
puts (2...Float::INFINITY).lazy.reduce([0,1.0]) { |accum,n|
  nprimes,ratio = accum
  puts "#{n} #{nprimes} #{ratio} (#{accum})"
  nprimes += 1
  ratio -= 0.05
  [nprimes,ratio]
}.find { |nprimes, ratio| puts "in find"; ratio < 0.1 }

