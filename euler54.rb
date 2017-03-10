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

class Card
  @@card_map = {"2"  =>  2,
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
  attr_reader :value
  attr_reader :suit
  def initialize(s)
    @value = @@card_map[s[0]]
    @suit = s[1]
  end
  def self.StrToValue(value_str)
    @@card_map[value_str]
  end
  def <=> other
    c = @value <=> other.value
    unless c == 0
      c
    else
      @suit <=> other.suit
    end
  end
  def show
    "#@value#@suit"
  end
end

c1 = Card.new("4C")
puts c1.show, c1.value, c1.suit
c2 = Card.new("3D")
puts c1.show, c2.show, c1 <=> c2
puts c2.show, c1.show, c2 <=> c1
c3 = Card.new("3H")
puts c3.show, c2.show, c3 <=> c2
puts c2.show, c3.show, c2 <=> c3
puts c3.show, c3.show, c3 <=> c3
puts c3.show, c3.show, c3 <=> c3
# exit

class Hand
  attr_reader :cards
  attr_reader :all_same_suit
  attr_reader :all_ascending
  attr_reader :groups
  attr_reader :score
  attr_reader :score_type
  @@straight_flush  = 0
  @@four_of_a_kind  = 1
  @@full_house      = 2
  @@flush           = 3
  @@straight        = 4
  @@three_of_a_kind = 5
  @@two_pairs       = 6
  @@one_pair        = 7
  @@high_card       = 8
  @@code_to_hand_type = { 0 => 'Straight Flush',
                          1 => 'Four of a Kind',
                          2 => 'Full House',
                          3 => 'Flush',
                          4 => 'Straight',
                          5 => 'Three of a kind',
                          6 => 'Two Pairs',
                          7 => 'One Pair',
                          8 => 'High Card'}
  def initialize(cards)
    @cards = cards.sort.reverse
    @top_card = @cards[-1]
    @all_same_suit = Hand.all_same_suit?(@cards)
    @all_ascending = Hand.all_ascending?(@cards)
    @groups = Hand.group(@cards)
    @card_values_by_freq = @groups.map { |value,matching_cards| value }
    @card_values_by_value = @cards.map { |card| card.value }.uniq
    @score = self.score_hand
    @score_type = @@code_to_hand_type[@score[0]]
  end
  def show
    @cards.map { |card| card.show }.join(", ")
  end
  def self.all_same_suit?(cards)
    cards.map { |card| card.suit }.uniq.length == 1
  end
  def self.all_ascending?(cards)
    cards.sort.each_cons(2).all? { |c1,c2| c2.value == c1.value + 1 }
  end
  def self.group(cards)
    cards.group_by { |card| card.value }.sort_by { |value,matching_cards|
      matching_cards.length
    }.reverse
  end
  def score_hand
    puts "score_hand {(#{self.show}), (#{self.groups[0].length}), " +
         "(#{self.groups[1].length}), (#{self.groups})}\n\n---\n"
    if @all_same_suit and @all_ascending
      return [@@straight_flush, @card_values_by_value]
    elsif @groups[0][1].length >= 4
      return [@@four_of_a_kind, @card_values_by_freq]
    elsif @groups[0][1].length == 3 and @groups[1][1].length == 2
      return [@@full_house, @card_values_by_freq]
    elsif @all_same_suit
      return [@@flush, @card_values_by_value]
    elsif @all_ascending
      return [@@straight, @card_values_by_value]
    elsif @groups[0][1].length == 3
      return [@@three_of_a_kind, @card_values_by_freq]
    elsif @groups[0][1].length == 2 and @groups[1][1].length == 2
      return [@@two_pairs, @card_values_by_freq]
    elsif @groups[0][1].length == 2
      return [@@one_pair, @card_values_by_freq]
    else
      return [@@high_card, @card_values_by_value]
    end
  end
  def <=> other
    self.score <=> other.score
  end
end

h1 = Hand.new([c1,c2,c3])
puts h1.show, h1.all_ascending
p h1.groups

straight_flush  = Hand.new(["AS","JS","QS","KS","TS"].map { |c| Card.new(c) })
four_of_a_kind  = Hand.new(["8S","8D","9S","8H","8C"].map { |c| Card.new(c) })
full_house      = Hand.new(["TS","3D","TH","TC","3S"].map { |c| Card.new(c) })
flush           = Hand.new(["3S","7S","8S","JS","AS"].map { |c| Card.new(c) })
straight        = Hand.new(["4C","7D","6S","5H","8C"].map { |c| Card.new(c) })
three_of_a_kind = Hand.new(["4H","5S","AH","5D","5C"].map { |c| Card.new(c) })
two_pairs       = Hand.new(["KH","TC","AD","KS","AS"].map { |c| Card.new(c) })
one_pair        = Hand.new(["TS","JS","TH","2C","QS"].map { |c| Card.new(c) })
high_card       = Hand.new(["TH","9H","6D","4S","JS"].map { |c| Card.new(c) })
p straight_flush.show, straight_flush.score, straight_flush.score_type
p four_of_a_kind.show, four_of_a_kind.score, four_of_a_kind.score_type
p full_house.show, full_house.score, full_house.score_type
p flush.show, flush.score, flush.score_type
p straight.show, straight.score, straight.score_type
p three_of_a_kind.show, three_of_a_kind.score, three_of_a_kind.score_type
p two_pairs.show, two_pairs.score, two_pairs.score_type
p one_pair.show, one_pair.score, one_pair.score_type
p high_card.show, high_card.score, high_card.score_type

[straight_flush, four_of_a_kind, full_house, flush, straight, three_of_a_kind,
 two_pairs, one_pair, high_card].each do |hand|
  puts "(#{hand.show}), (#{hand.groups.map { |g,cs| [g,cs.length] }}), " + 
       "(#{hand.score}), (#{hand.score_type}), (#{hand.groups})\n---"
end

def comp_card(card1,card2)
  c = (card1[0] <=> card2[0])
  unless c == 0
    c
  else
    card1[1] <=> card2[1]
  end
end

# puts comp_card([3,"C"],[4,"H"])

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
  sorted_hand = hand.sort { |c1,c2|
    if c1[0] != c2[0]
      c1[0] <=> c2[0]
    else
      c1[1] <=> c2[1]
    end
  }
  high_card = sorted_hand[-1]
  all_same_suit = all_same_suit? sorted_hand
  all_in_row = all_in_row? sorted_hand
  
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

# p hands[0]
# p hands[1]

# hands[0][0].each_cons(2) do |c1,c2|
#   puts "c1: #{c1}, c2: #{c2}, cmp: #{comp_card(c1,c2)}"
# end

p "first in file:", hands[0][0], hands[0][1]
p comp_hand(hands[0][0], hands[0][1])

demohand1a = [[5,"H"],[5,"C"],[6,"S"],[7,"S"],[13,"D"]]
p demohand1a
demohand1b = [[2,"C"],[3,"S"],[8,"S"],[8,"D"],[10,"D"]]
p "demo:", demohand1a, demohand1b, comp_hand(demohand1a,demohand1b)

puts hands.count { |hand1,hand2|
  comp_hand(hand1,hand2) == 1
}
