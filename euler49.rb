#!/usr/bin/env ruby

require 'prime'

# create a unique hash based on the characters in the string, an easy way is to
# return a sorted string
def letter_hash s
  s.each_char.to_a.sort.join('')
end

# get all four digit primes
my_primes = Prime.lazy.drop_while { |x| x < 1000 }.take_while { |x| x < 10000 }

# find groups of primes that have the same digits
primes_by_digits = my_primes.group_by { |x| letter_hash(x.to_s).freeze }.values

# there must by at least 3 numbers with the same digits
valid_primes_by_digits = primes_by_digits.reject { |xs| xs.length < 3 }

# find all combinations of sets of three numbers that have the same digits
sets_of_three = valid_primes_by_digits.flat_map { |xs| xs.combination(3).to_a }

# find the sets of three numbers that have the same difference between the
# second and third as between the first and second
same_diff_sets = sets_of_three.select { |xs| xs[1] - xs[0] == xs[2] - xs[1] }

# we know that one answer has 1487, so get rid of that and grab the last one
answer_set = same_diff_sets.reject { |xs| xs.include? 1487 }.first

# print the concatenated numbers
puts answer_set.map(&:to_s).join('')

exit

# this works but is hard to follow
puts my_primes.group_by { |x|
  letter_hash(x.to_s).freeze
}.values.reject { |xs|
  xs.length < 3
}.map { |xs|
  xs.combination 3
}.map { |allxs|
  allxs.select { |xs| xs[2] - xs[1] == xs[1] - xs[0] }
}.reject { |allxs|
  allxs.empty?
}.map { |allxs|
  allxs.flatten
}.reject { |xs|
  xs[0] == 1487
}[0].map(&:to_s).join('')
