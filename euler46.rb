#!/usr/bin/env ruby

require 'prime'

p (2...Float::INFINITY).lazy.
   select { |x| x % 2 == 1 }.
   reject { |x| Prime.prime? x }.find { |x|
  # puts "x = #{x}"
  (1...Float::INFINITY).lazy.map { |y|
    # puts "\ty = #{y}, d = #{x - 2*y**2}"
    x - 2*y**2
  }.take_while { |d| d > 0 }.none? { |d| Prime.prime? d }
}
