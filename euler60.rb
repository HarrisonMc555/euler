#!/usr/bin/env ruby

require 'prime'

def concat(x,y)
  (x.to_s+y.to_s).to_i
end

def concats_prime(ns,x)
  ns.all? { |n| Prime.prime? concat(n,x) and Prime.prime? concat(x,n) }
end

def find_concats(nleft, nlistsandprimes)
  # puts "nleft: #{nleft}"
  # puts "nlists: #{nlistsandprimes[0...5].map { |ns,ps| [ns[0...5],ps[0...5]]}}"
  # puts "nlistsandprimes: " +
  #      "#{nlistsandprimes[0...5].map {|nlandps| nlandps[0][0...5]}}"
  return nlistsandprimes if nleft == 0
  nlistsandprimes = nlistsandprimes.flat_map { |nlistandprimes|
    nlist, primes = nlistandprimes
    # puts "\tnlist: #{nlist[0...10]}"
    # puts "\tprimes: #{primes[0...10]}"
    newprimes = primes.select { |p| concats_prime(nlist,p) }
    # puts "\tnewprimes: #{newprimes[0...10]}"
    # puts "\t"+"-"*40
    newprimes.map { |p| [nlist + [p], newprimes] }
  }
  find_concats(nleft-1, nlistsandprimes)
end

gs = Prime.take_while { |p| p < 10**4 }.drop(2).group_by { |x| x % 3 }

gs1, gs2 = gs[1], gs[2]

# primes = Prime.take_while { |p| p < 10**5 }
nlists = find_concats(4, [[[],[3]+gs1]])
puts nlists.min_by { |ns| ns.reduce(&:+) }
nlists = find_concats(4, [[[],[3]+gs2]])
puts nlists.min_by { |ns| ns.reduce(&:+) }

exit

puts gs1.combination(5).select { |xs|
  p xs
  tmp = xs.permutation(2).all? { |x1,x2| Prime.prime?((x1.to_s+x2.to_s).to_i) }
  if tmp
    puts "xs: #{xs}"
  end
  tmp
}
