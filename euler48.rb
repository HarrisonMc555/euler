#!/usr/bin/env ruby

puts (1..1000).map { |x| x**x }.reduce(&:+) % (10**10)
