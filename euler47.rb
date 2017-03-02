#!/usr/bin/env ruby

require 'prime'

k = gets.to_i

# try 1 - user 2.432s
# puts (1...Float::INFINITY).lazy.find { |x|
#   factors = (x...x+k).lazy.map { |y|
#     Prime.prime_division(y).length
#   }.all? { |nfactors| nfactors == k }
# }

# exit

# try 2 - user 1.485s
i = 0
(1..Float::INFINITY).lazy.map { |x|
  [x, Prime.prime_division(x).length]
}.each do |x, numfactors|
  if numfactors == k
    i += 1
    if i == k
      puts x-k+1
      exit
    end
  else
    i = 0
  end
end
puts "Did not find an answer"

exit

# try 3 - user 11.000s
# Min_k = Prime.take(k).reduce(&:*)
# Erat_gen = Prime::EratosthenesGenerator.new
# $primes = Erat_gen.take_while { |x| x < 2*Min_k }
# # p $primes
# def n_distinct_factors? n, x
#   # puts x
#   if x > $primes[-1]
#     $primes += Erat_gen.take($primes.length)
#     # p $primes
#   end
#   nfactors = 0
#   $primes.each do |prime|
#     if x == 1 then return nfactors == n end
#     if x % prime == 0
#       nfactors += 1
#       if nfactors > n then return false end
#       while x >= prime and x % prime == 0
#         x /= prime
#       end
#     end
#   end
# end

# puts (Min_k...Float::INFINITY).lazy.chunk { |x|
#   n_distinct_factors? k, x
# }.find { |nfactors, xs|
#   nfactors and xs.length == k
# }[1][0]

# exit
