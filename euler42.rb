#!/usr/bin/env ruby

Chr0 = 'A'.ord-1

def letter_value c
  c.ord - Chr0
end

def word_value s
  s.each_char.map { |c| letter_value c }.reduce(&:+)
end

def triangle_num? n
  n2 = n*2
  a = Math.sqrt(n2).to_i
  b = a+1
  return a*b == n2
end

def triangle_word? word
  return triangle_num? (word_value word)
end

p File.read("p042_words.txt").strip.tr!('"','').split(',').
   select { |word| triangle_word? word }.count

