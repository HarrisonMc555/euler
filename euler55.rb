#!/usr/bin/env ruby

def palindrome?(x)
  x.to_s == x.to_s.reverse
end

def next_lychrel(x)
  x + x.to_s.reverse.to_i
end

def lychrel?(x)
  (1..50).each do |n|
    x = next_lychrel(x)
    return false if palindrome? x
  end
  return true
end

puts (1...10000).count { |x| lychrel?(x) }
