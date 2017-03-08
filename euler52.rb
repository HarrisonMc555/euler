#!/usr/bin/env ruby

def same_digits(n1,n2)
  n1.to_s.each_char.sort == n2.to_s.each_char.sort
end

# def valid_same_digits(k,n)
#   n < 10**(n1.to_s.length)/k
# end

def max_valid_same_digits(k,num_digits)
  10**num_digits/k
end

# def find_multiples(k,max_digits)
#   (1..max_digits).flat_map { |num_digits|
#     max_valid = max_valid_same_digits(k,num_digits)
#     min_valid = 10**(num_digits-1)
#     (min_valid..max_valid).select { |x| same_digits x, k*x }
#   }
# end

puts (1..Float::INFINITY).lazy.flat_map { |num_digits|
  max_valid = max_valid_same_digits(6,num_digits)
  min_valid = 10**(num_digits-1)
  xs = (min_valid..max_valid).to_a
  (2..6).to_a.reverse.each do |k|
    xs.select! { |x| same_digits x, k*x }
  end
  xs
}.find.first
