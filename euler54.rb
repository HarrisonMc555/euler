#!/usr/bin/env ruby

card_map = {"2"  =>  2,
            "3"  =>  3,
            "4"  =>  4,
            "5"  =>  5,
            "6"  =>  6,
            "7"  =>  7,
            "8"  =>  8,
            "9"  =>  9,
            "T" => 10,
            "J"  => 11,
            "Q"  => 12,
            "K"  => 13,
            "A"  => 14}

hands = File.open("./p054_poker.txt").map(&:strip).map { |line|
  cards = line.split
  cards.map! { |card|
    [card_map[card[0]], card[-1]]
  }
  [cards[0...5], cards[5...10]]
}

p hands[0]
p hands[1]

