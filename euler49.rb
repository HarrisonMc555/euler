#!/usr/bin/env ruby

require 'prime'

def letter_hash s
  s.each_char.group_by { |c| c }.map { |k, v| [k, v.length] }.to_h
end

k = 3
puts Prime.take_while { |x| x < 10000 }.drop_while { |x| x < 1000 }.
      group_by { |x| letter_hash(x.to_s).freeze }.values.
      reject! { |xs| xs.length < k }.map { |xs| xs.combination k }.
      map { |allxs| allxs.select { |xs| xs[2] - xs[1] == xs[1] - xs[0] } }.
      reject! { |allxs| allxs.empty? }.map { |allxs| allxs[0] }.
      reject { |xs| xs[0] == 1487 }[0].map(&:to_s).join('')
