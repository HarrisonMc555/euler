#!/usr/bin/env ruby

require 'prime'

# def pandigital? x
#   s = x.to_s
#   return (1..9).all? { |i| s.include? i.to_s }
# end

# def n_pandigital? x
#   s = x.to_s
#   return (1..s.size).all? { |i| s.include? i.to_s }
# end

# puts Prime.take_while { |x| x < 10**9 }.reverse.find { |x| n_pandigital? x }

# puts (1..9).to_a.reverse.map { |n|
#   (1..n).to_a.reverse.map(&:to_s).
#     permutation.map { |xs| xs.join.to_i }.
#     find { |x| Prime.prime? x }
# }.find { |x| x }

# pandigital numbers with digits 1..9 and 1..8 can't be prime, since a number is
# divisible by 3 iff the sum of its digits is divisible by 3. Since
# (1..9).reduce(&:+) = 45 % 3 == 0 and (1..8).reduce(&:+) = 36 % 3 == 0, we can
# skip straight to using the digits 1..7
puts (1..7).to_a.reverse.lazy.map { |n|
  (1..n).to_a.reverse.map(&:to_s).
    permutation.map { |xs| xs.join.to_i }.
    select { |x| Prime.prime? x }.first
}.find { |x| x }
