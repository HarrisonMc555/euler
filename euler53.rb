#!/usr/bin/env ruby

def product(xs)
    xs.inject(:*) || 1
end

def factorial(x)
    product(1..x)
end

# http://www.programming-idioms.org/
# idiom/67/binomial-coefficient-n-choose-k/1656/ruby
def binom(n,k)
  num = (1+n-k..n).inject(:*) || 1
  den = (1..k).inject(:*) || 1
  num/den
end

def num_greater_binom(n,k)
  (n-2*k).abs + 1
end

one_million = 10**6
puts (1..100).map { |n|
  min_k = (1..(n+1)/2).find { |k|
    binom(n,k) > one_million
  }
  if min_k
    num_greater_binom(n,min_k)
  else
    0
  end
}.inject(:+)
