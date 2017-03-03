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
