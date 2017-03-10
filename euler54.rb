#!/usr/bin/env ruby

card_map = {"2"  =>  2,
            "3"  =>  3,
            "4"  =>  4,
            "5"  =>  5,
            "6"  =>  6,
            "7"  =>  7,
            "8"  =>  8,
            "9"  =>  9,
            "T"  => 10,
            "J"  => 11,
            "Q"  => 12,
            "K"  => 13,
            "A"  => 14}

def comp_card(card1,card2)
  c = card1[0] <=> card2[1]
  unless c == 0
    c
  else
    card1[1] <=> card2[1]
  end
end

def comp_hand(hand1,hand2)
  score1,score2 = [hand1,hand2].map { |hand| hand_score hand }
  c = score1[0] <=> score2[0]
  unless c == 0
    c
  else
    high1,high2 = score1[1].zip(score2[1]).find { |high1,high2| high1 != high2 }
    high1 <=> high2
  end
end

def all_same_suit?(hand)
  hand.map { |card| card[1] }.uniq.length == 1
end

def all_in_row?(hand)
  hand.sort { |c1,c2| comp_card(c1,c2) }.each_cons(2).all? { |c1,c2|
    c2[0] = c1[0] + 1
  }
end

def common_cards(hand)
  hand.group_by { |card| card[0] }.sort_by { |g,cards|
    cards.length
  }.reverse.map { |g,cards| cards }
end

def hand_score(hand)
  hand.sort! { |c1,c2|
    if c1[0] != c2[0]
      c1[0] <=> c2[0]
    else
      c1[1] <=> c2[1]
    end
  }
  high_card = hand[-1]
  all_same_suit = all_same_suit? hand
  all_in_row = all_in_row? hand
  
  # flush
  return [9,[high_card]] if all_same_suit and all_in_row
  common = common_cards(hand)
  # four of a kind
  return [8,[common[0][0],common[1][0]]] if common[0].length == 4
  # full house
  return [7,[common[0][0],common[1][0]]] if common[0].length == 3 and
    common[1].length == 5
  # flush
  return [6,hand] if all_same_suit
  # straight
  return [5,[high_card]] if all_in_row
  # three of a kind
  return [4,common.map { |cards| cards[0] }] if common[0].length == 3
  # two pairs
  return [3,common.map { |cards| cards[0] }] if common[0].length == 2 and
    common[1].length == 2
  # one pair
  return [2,common.map { |cards| cards[0] }] if common[0].length == 2
  # high card
  return [1,[high_card]]
end

hands = File.open("./p054_poker.txt").map(&:strip).map { |line|
  cards = line.split
  cards.map! { |card|
    [card_map[card[0]], card[-1]]
  }
  [cards[0...5], cards[5...10]]
}

p hands[0]
p hands[1]
p comp_hand(hands[0][0], hands[0][1])
