#!/usr/bin/env ruby

def pentagonal_num? pn
  nf = (1 + Math.sqrt(1.0 + 24*pn))/6.0
  n = nf.to_i
  return n == nf
  # return n*(3*n-1)/2 == pn
end

pc = []

i = 1
while true do
  pc[i] = (i*(3*i-1))/2
  (1...i).each { |j|
    if pentagonal_num? (pc[i] + pc[j]) and pentagonal_num? (pc[i] - pc[j])
      puts "#{pc[i] - pc[j]}"
      exit
    end
  }
  i += 1
end
