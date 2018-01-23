#!/usr/bin/env ruby

################################################################################
## DESCRIPTION #################################################################

# The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes
# and concatenating them in any order the result will always be prime. For
# example, taking 7 and 109, both 7109 and 1097 are prime. The sum of these four
# primes, 792, represents the lowest sum for a set of four primes with this
# property.

# Find the lowest sum for a set of five primes for which any two primes
# concatenate to produce another prime.

################################################################################
## THOUGHTS ####################################################################

###################
# Digit Sum Mod 3 #
###################

# The sum of the digits of any prime number (besides 3) are never 0 mod 3, they
# are always either 1 mod 3 or 2 mod 3. If we concatenate two numbers, then the
# sums of their digits will also add. Since we're only ever concatenating two
# prime numbers, we know that they must either both be 1 mod 3 or both be 2 mod
# 3. If you concatenated a number whose digit sum is 1 mod 3 and one whose digit
# sum is 2 mod 3, you would get a numbers whose digit sum is 0 mod 3, which will
# not be a prime number.

# Thus, we can categorize our prime numbers by their digit sum mod 3 and only
# try them together.

# Keep in mind that 3 is a viable number to pair with any number from either
# group, since it will not change the digit sum mod 3.

################################################################################


require 'prime'
require 'pp'

# Concatenates the numbers x and y
def concat(x, y)
  (x.to_s + y.to_s).to_i
end


# Sees if the number x is prime when concatenated with every number in ns
def concats_prime(ns, x)
  ns.all? { |n| Prime.prime? concat(n, x) and Prime.prime? concat(x, n) }
end


# For all primes in ns, adds all the primes that can concatenate with it to form
# more primes into the hash h. After this functions, all the primes that can
# concatenate with a number to form more primes are in lists that the hash
# points to.
def add_concats_prime(h, ns)
  for prime1, i in ns.each_with_index
    xs = h[prime1] + [prime1]
    for prime2 in ns
      if concats_prime(xs, prime2)
        h[prime1] << prime2
      end
    end
  end
  h
end


# Group primes by modulus 3
gs = Prime.take_while { |p| p < 10**3 }.drop(2).group_by { |x| x % 3 }


# No primes are divisible by three, these are grouped by whether they're 1 mod 3
# or 2 mod 3
gs1, gs2 = gs[1], gs[2]

p gs1[0...10]
p gs2[0...10]


# Initialize a new hash that maps from prime numbers to a list of numbers that
# concatenate with it to form more primes
pairs = Hash.new { |h, k| [] }
pairs = add_concats_prime(pairs, gs1)
pairs = add_concats_prime(pairs, gs2)
p pairs

exit

# puts pairs.class
for prime1, i in gs1.each_with_index
  # puts "#{prime1} (#{i})"
  ns = [prime1]
  for prime2, j in gs1[i..-1].each_with_index
    # puts "\t#{prime2} (#{j})"
    if concats_prime(ns, prime2)
      # puts "\t\t#{prime1} and #{prime2} match!"
      pairs[prime1] = [] if not pairs.include?(prime1)
      pairs[prime1] << prime2
      # puts pairs.class
      # pairs << [prime1, prime2]
    end
  end
end
for prime1, i in gs2.each_with_index
  # puts "#{prime1} (#{i})"
  ns = [prime1]
  for prime2, j in gs2[i..-1].each_with_index
    # puts "\t#{prime2} (#{j})"
    if concats_prime(ns, prime2)
      # puts "\t\t#{prime1} and #{prime2} match!"
      pairs[prime1] = [] if not pairs.include?(prime1)
      pairs[prime1] << prime2
      # puts pairs.class
      # pairs << [prime1, prime2]
    end
  end
end

# p pairs
# p pairs[0]
# p pairs[0...10]
# p pairs[1]

exit

def find_concats(nleft, nlistsandprimes)
  # puts "nleft: #{nleft}"
  # puts "nlists: #{nlistsandprimes[0...5].map { |ns, ps| [ns[0...5], ps[0...5]]}}"
  # puts "nlistsandprimes: " +
  #      "#{nlistsandprimes[0...5].map {|nlandps| nlandps[0][0...5]}}"
  return nlistsandprimes if nleft == 0
  nlistsandprimes = nlistsandprimes.flat_map { |nlistandprimes|
    nlist, primes = nlistandprimes
    # puts "\tnlist: #{nlist[0...10]}"
    # puts "\tprimes: #{primes[0...10]}"
    newprimes = primes.select { |p| concats_prime(nlist, p) }
    # puts "\tnewprimes: #{newprimes[0...10]}"
    # puts "\t"+"-"*40
    newprimes.map { |p| [nlist + [p], newprimes] }
  }
  find_concats(nleft - 1, nlistsandprimes)
end

gs = Prime.take_while { |p| p < 10**4 }.drop(2).group_by { |x| x % 3 }

gs1, gs2 = gs[1], gs[2]

# primes = Prime.take_while { |p| p < 10**5 }
nlists = find_concats(4, [[[], [3] + gs1]])
puts nlists.min_by { |ns| ns.reduce(&:+) }
nlists = find_concats(4, [[[], [3] + gs2]])
puts nlists.min_by { |ns| ns.reduce(&:+) }

exit

puts gs1.combination(4).select { |xs|
  p xs
  tmp = xs.permutation(2).all? { |x1, x2| Prime.prime?((x1.to_s + x2.to_s).to_i) }
  if tmp
    puts "xs: #{xs}"
  end
  tmp
}



################################################################################

def digits(x, base=10)
  ds = []
  while x > 0
    ds << x % base
    x /= base
  end
  ds.reverse
end
