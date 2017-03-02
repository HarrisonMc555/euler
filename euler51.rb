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
    in_range_fun = lambda { |c| not range.include? c }
    @cur_fun = lambda { |c| @cur_fun = in_range_fun if c > range.begin; false }
    self.each { |x|
      if block.call x
        count += 1
        return false if @cur_fun.call count
      end
    }
    return range.include?(count)
  end

end

puts [1,2,3].this_many?(1) { |x| x < 3 }
puts [1,2,3].this_many?(2) { |x| x < 3 }
puts [1,2,3].this_many?(3) { |x| x < 3 }
puts [1,2,3].this_many_range?(1..2) { |x| x < 3 }
puts [1,2,3].this_many_range?(1...2) { |x| x < 3 }
puts [1,2,3].this_many_range?(1..3) { |x| x < 3 }
puts [1,2,3].this_many_range?(3..4) { |x| x < 3 }
