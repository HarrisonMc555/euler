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
  include Comparable
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

# c1 = Card.new("4C")
# puts c1.show, c1.value, c1.suit
# c2 = Card.new("3D")
# puts c1.show, c2.show, c1 <=> c2
# puts c2.show, c1.show, c2 <=> c1
# c3 = Card.new("3H")
# puts c3.show, c2.show, c3 <=> c2
# puts c2.show, c3.show, c2 <=> c3
# puts c3.show, c3.show, c3 <=> c3
# puts c3.show, c3.show, c3 <=> c3

class Hand
  include Comparable
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

# straight_flush  = Hand.new(["AS","JS","QS","KS","TS"].map { |c| Card.new(c) })
# four_of_a_kind  = Hand.new(["8S","8D","9S","8H","8C"].map { |c| Card.new(c) })
# full_house      = Hand.new(["TS","3D","TH","TC","3S"].map { |c| Card.new(c) })
# flush           = Hand.new(["3S","7S","8S","JS","AS"].map { |c| Card.new(c) })
# straight        = Hand.new(["4C","7D","6S","5H","8C"].map { |c| Card.new(c) })
# three_of_a_kind = Hand.new(["4H","5S","AH","5D","5C"].map { |c| Card.new(c) })
# two_pairs       = Hand.new(["KH","TC","AD","KS","AS"].map { |c| Card.new(c) })
# one_pair        = Hand.new(["TS","JS","TH","2C","QS"].map { |c| Card.new(c) })
# high_card       = Hand.new(["TH","9H","6D","4S","JS"].map { |c| Card.new(c) })

# test_hands = [straight_flush, four_of_a_kind, full_house, flush, straight,
#               three_of_a_kind, two_pairs, one_pair, high_card]
# test_hands.each do |hand|
#   puts "(#{hand.show}), (#{hand.groups.map { |g,cs| [g,cs.length] }}), " + 
#        "(#{hand.score}), (#{hand.score_type}), (#{hand.groups})\n---"
# end

# test_hands.each_cons(2) do |hand1,hand2|
#   puts hand1 <=> hand2
# end


hands = File.open("./p054_poker.txt").map(&:strip).map { |line|
  cards = line.split
  # cards.map! { |card|
  #   [card_map[card[0]], card[-1]]
  # }
  [Hand.new(cards[0...5].map { |c| Card.new(c) }),
   Hand.new(cards[5...10].map { |c| Card.new(c) })]
}

puts hands.count { |hand1,hand2|
  hand1 > hand2
}
