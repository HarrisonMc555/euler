#!/usr/bin/env ruby

require 'prime'

# below a million
Limit = 10**6

# all primes < 1 million
MyPrimes = Prime.take_while { |x| x < Limit }

# try summing up n primes until that's more than a million, take the longest
# sequence that didn't go over
nmax = (1..MyPrimes.length).
       take_while { |i| MyPrimes.take(i).reduce(&:+) < Limit }.
       last

# count down from nmax
nmax.step(1,-1) { |n|
  i = 0 # current index
  s = MyPrimes.take(n).reduce(&:+) # current sum
  answers = [] # current answers (will only be non-empty once)
  while s < Limit
    answers << s if Prime.prime? s
    s -= MyPrimes[i]
    s += MyPrimes[i+n]
    i += 1
  end
  if not answers.empty?
    puts answers[-1]
    exit
  end
}

