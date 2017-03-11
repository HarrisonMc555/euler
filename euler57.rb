#!/usr/bin/env ruby

def next_sqrt_iter(frac)
  # puts "next_sqrt_iter"
  # puts "\tfrac: #{frac}"
  # puts "\t(Rational(2) + frac): #{(Rational(2) + frac)}"
  Rational(1,(Rational(2) + frac))
end

# p next_sqrt_iter(Rational(0))
# p next_sqrt_iter(Rational(1,2))

def sqrt_iter(n)
  1 + (0...n).inject(Rational(0)) { |frac,n|
    next_sqrt_iter(frac) # don't need n value
  }
end

# (1..5).each do |n|
#   puts "#{n}: #{sqrt_iter(n)}"
# end

cnt = 0
frac = Rational(0)
1000.times do
  frac = next_sqrt_iter(frac)
  num = 1 + frac
  cnt += 1 if num.numerator.to_s.length > num.denominator.to_s.length
end

puts cnt
