#!/usr/bin/env ruby

require 'prime'

module Enumerable

  def this_many? n, &block
    count = 0
    self.each { |x|
      if block.call x
        count += 1
        return false if count > n
      end
    }
    return count == n
  end

  def this_many_range? range, &block
    count = 0
    e = self.each
    been_in_range = false
    loop do
      if block.call e.next
        count += 1
        if range.include? count
          been_in_range = true
        elsif been_in_range
          return false
        end
      end
    end
    return range.include? count
  end

end

if false
  puts [1,2,3].this_many?(1) { |x| x < 3 }
  puts [1,2,3].this_many?(2) { |x| x < 3 }
  puts [1,2,3].this_many?(3) { |x| x < 3 }
  puts '[1,2,3](1..2)  { |x| x < 3 }'
  p [1,2,3].this_many_range?(1..2) { |x| x < 3 }
  p '[1,2,3](1...2) { |x| x < 3 }'
  p [1,2,3].this_many_range?(1...2) { |x| x < 3 }
  p '[1,2,3](1..3)  { |x| x < 3 }'
  p [1,2,3].this_many_range?(1..3) { |x| x < 3 }
  p '[1,2,3](3..4)  { |x| x < 3 }'
  p [1,2,3].this_many_range?(3..4) { |x| x < 3 }
  p '[1,2,3](3..4)  { |x| x < 3 }'
  p [1,2,3].this_many_range?(2..2) { |x| x < 3 }
  p '[1,2,3](3..4)  { |x| x < 3 }'
  p [1,2,3].this_many_range?(2...2) { |x| x < 3 }
end

def valid_prime_digits(first, last)
  return ('1'..'9').reject { |d| d.to_i % 2 == 0 } if last
  return ('1'..'9') if first
  return ('0'..'9')
end

def prime_digit_families(num_digits, num_same, first=false)
  # offset = "\t"*(2-num_digits)
  # puts "#{offset}prime_digit_families(#{num_digits},  #{num_same}, #{first})"
  Enumerator.new do |enum|
    # base case, 0 digits left
    if num_digits == 0
      enum.yield ""
    else
      # only add a non-same digit if we have extra digits to use (if num_digits
      # == num_same then the rest of the digits need to be the same).
      if num_same < num_digits
        # if first
        #   my_digits = ('1'..'9')
        # else
        #   my_digits = ('0'..'9')
        # end
        digits = valid_prime_digits(first, num_digits == 1)
        # puts "#{offset}using digits #{my_digits}"
        digits.each do |digit|
          prime_digit_families(num_digits - 1, num_same).each { |family_str|
            # puts "#{offset} digit: '#{digit}' + family_str = '#{family_str}'"
            enum.yield(digit+family_str)
          }
        end
      end
      # if we have any of the 'same' digits to add, add them
      if num_same > 0
        # puts "#{offset}using same digit (*)"
        prime_digit_families(num_digits - 1, num_same - 1).each { |family_str|
          # puts "#{offset} digit: '*' + family_str = '#{family_str}'"
          enum.yield('*'+family_str)
        }
      end
    end
  end
end

p prime_digit_families(3,2,true).to_a

def nums_from_family(family_str)
  digits = ('0'..'9')
  digits = ('1'..'9')
  
end
