#!/usr/bin/env ruby

# Pentagonal_hash = {}
# Pentagonal_list = []

# 0 =   a*x**2 + b*x + c
# x = (-b +/- sqrt(b**2 - 4*a*c))/(2a)
# Pn = n(3n-1)/2 = 3/2*n**2 - n/2
# 0 = 3/2*n**2 - n/2 - Pn
# n = (1/2 +/- sqrt(1/4 + 6*Pn))/3
def pentagonal_num? pn
  # if Pentagonal_hash.has_key? pn then return Pentagonal_hash[pn] end
  # if not Pentagonal_list.empty? and Pentagonal_list[-1] > pn
  #   return Pentagonal_list.bsearch { |x| x >= pn } == pn
  # end
  # puts "pentagonal_num? #{pn}"
  # nf = (1.0/2 + Math.sqrt(1.0/4 + 6*pn))/3.0
  nf = (1 + Math.sqrt(1.0 + 24*pn))/6.0
  n = nf.to_i
  return n == nf
  # is_pentagonal = n*(3*n-1)/2 == pn
  # # Pentagonal_hash[pn] = is_pentagonal
  # # if is_pentagonal then Pentagonal_list.push(pn) end
  # return is_pentagonal
end

def pentagonal_nums
  Enumerator.new do |enum|
    n = 1
    while true
      enum.yield n*(3*n-1)/2
      n += 1
    end
  end
end

# [1, 5, 12, 22, 35, 51, 70, 92, 117, 145].each do |x|
#   puts "#{x}: #{pentagonal_num? x}" # should be true
#   puts "#{x+1}: #{pentagonal_num? x+1}" # should be false
# end

a,b = pentagonal_nums.lazy.flat_map { |a|
  pentagonal_nums.lazy.take_while { |b| b < a }.map { |b| [a,b] }
}.find { |a,b|
  pentagonal_num? (a+b) and pentagonal_num? (a-b)
}

puts (a-b)
