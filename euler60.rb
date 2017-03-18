#!/usr/bin/env ruby

require 'prime'
require 'pp'

def concat(x,y)
  (x.to_s+y.to_s).to_i
end

def concats_prime(ns,x)
  ns.all? { |n| Prime.prime? concat(n,x) and Prime.prime? concat(x,n) }
end

def add_concats_prime(h,ns)
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

gs = Prime.take_while { |p| p < 10**3 }.drop(2).group_by { |x| x % 3 }

gs1, gs2 = gs[1], gs[2]

p gs1[0...10]
p gs2[0...10]

pairs = Hash.new { |h,k| [] }
pairs = add_concats_prime(pairs,gs1)
pairs = add_concats_prime(pairs,gs2)
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

puts gs1.combination(4).select { |xs|
  p xs
  tmp = xs.permutation(2).all? { |x1,x2| Prime.prime?((x1.to_s+x2.to_s).to_i) }
  if tmp
    puts "xs: #{xs}"
  end
  tmp
}
