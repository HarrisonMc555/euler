#!/usr/bin/env ruby

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
  @@card_rmap = { 2  => "2",
                  3  => "3",
                  4  => "4",
                  5  => "5",
                  6  => "6",
                  7  => "7",
                  8  => "8",
                  9  => "9",
                  10 => "T",
                  11 => "J",
                  12 => "Q",
                  13 => "K",
                  14 => "A"}
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
    "#{@@card_rmap[@value]}#@suit"
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
  @@straight_flush  = 8
  @@four_of_a_kind  = 7
  @@full_house      = 6
  @@flush           = 5
  @@straight        = 4
  @@three_of_a_kind = 3
  @@two_pairs       = 2
  @@one_pair        = 1
  @@high_card       = 0
  @@code_to_hand_type = { 8 => 'Straight Flush',
                          7 => 'Four of a Kind',
                          6 => 'Full House',
                          5 => 'Flush',
                          4 => 'Straight',
                          3 => 'Three of a kind',
                          2 => 'Two Pairs',
                          1 => 'One Pair',
                          0 => 'High Card'}
  def initialize(cards)
    @cards = cards.sort.reverse
    @top_card = @cards[-1]
    @all_same_suit = Hand.all_same_suit?(@cards)
    # p "after all_same_suit?", @cards, @all_same_suit, "---"
    @all_ascending = Hand.all_ascending?(@cards)
    @groups = Hand.group(@cards)
    @card_values_by_freq = @groups.map { |value,matching_cards| value }
    @card_values_by_value = @cards.map { |card| card.value }
    @score = self.score_hand
    @score_type = @@code_to_hand_type[@score[0]]
  end
  def show
    @cards.map { |card| card.show }.join(", ")
  end
  def self.all_same_suit?(cards)
    # p "all_same_suit?", cards, "#{cards.map { |card| card.suit }.uniq}"
    cards.map { |card| card.suit }.uniq.length == 1
  end
  def self.all_ascending?(cards)
    cards.sort.each_cons(2).all? { |c1,c2| c2.value == c1.value + 1 }
  end
  def self.group(cards)
    cards.sort.group_by { |card| card.value }.sort_by { |value,matching_cards|
      matching_cards.length
    }.reverse
  end
  def score_hand
    # puts "score_hand: #{self.show}"
    # puts "\tall_same_suit: #@all_same_suit"
    # puts "\tall_ascending: #@all_ascending"
    # puts "\tgroup lengths: #{@groups.map { |g,cs| cs.length }}"
    if @all_same_suit and @all_ascending
      # puts "\t\tstraight flush"
      return [@@straight_flush, @card_values_by_value]
    elsif @groups[0][1].length >= 4
      # puts "\t\tfour_of_a_kind"
      return [@@four_of_a_kind, @card_values_by_freq]
    elsif @groups[0][1].length == 3 and @groups[1][1].length == 2
      # puts "\t\tfull_house"
      return [@@full_house, @card_values_by_freq]
    elsif @all_same_suit
      # puts "\t\tflush"
      return [@@flush, @card_values_by_value]
    elsif @all_ascending
      # puts "\t\tstraight"
      return [@@straight, @card_values_by_value]
    elsif @groups[0][1].length == 3
      # puts "\t\tthree_of_a_kind"
      return [@@three_of_a_kind, @card_values_by_freq]
    elsif @groups[0][1].length == 2 and @groups[1][1].length == 2
      # puts "\t\ttwo_pairs"
      return [@@two_pairs, @card_values_by_freq]
    elsif @groups[0][1].length == 2
      # puts "\t\tone_pair"
      return [@@one_pair, @card_values_by_freq]
    else
      # puts "\t\thigh_card"
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
#        "(#{hand.score}), (#{hand.score_type})\n---"
# end

# test_hands.each_cons(2) do |hand1,hand2|
#   puts hand1 <=> hand2
# end

# demo1astr = "5H 5C 6S 7S KD"
# demo1bstr = "2C 3S 8S 8D TD"
# demo2astr = "5D 8C 9S JS AC"
# demo2bstr = "2C 5C 7D 8S QH"
# demo3astr = "2D 9C AS AH AC"
# demo3bstr = "3D 6D 7D TD QD"
# demo4astr = "4D 6S 9H QH QC"
# demo4bstr = "3D 6D 7H QD QS"
# demo5astr = "2H 2D 4C 4D 4S"
# demo5bstr = "3C 3D 3S 9S 9D"

# demo1a = Hand.new(demo1astr.split.map { |s| Card.new(s) })
# demo1b = Hand.new(demo1bstr.split.map { |s| Card.new(s) })
# demo2a = Hand.new(demo2astr.split.map { |s| Card.new(s) })
# demo2b = Hand.new(demo2bstr.split.map { |s| Card.new(s) })
# demo3a = Hand.new(demo3astr.split.map { |s| Card.new(s) })
# demo3b = Hand.new(demo3bstr.split.map { |s| Card.new(s) })
# demo4a = Hand.new(demo4astr.split.map { |s| Card.new(s) })
# demo4b = Hand.new(demo4bstr.split.map { |s| Card.new(s) })
# demo5a = Hand.new(demo5astr.split.map { |s| Card.new(s) })
# demo5b = Hand.new(demo5bstr.split.map { |s| Card.new(s) })

# demopairs = [[demo1a,demo1b],[demo2a,demo2b],[demo3a,demo3b],[demo4a,demo4b],
#              [demo5a,demo5b]]

# demopairs.each do |hand1,hand2|
#   print "#{hand1.show} (#{hand1.score_type}) | " +
#         "#{hand2.show} (#{hand2.score_type}) | Player"
#   if hand1 > hand2
#     print "1\n"
#   else
#     print "2\n"
#   end
# end
# exit

hands = File.open("./p054_poker.txt").map(&:strip).map { |line|
  cards = line.split
  # cards.map! { |card|
  #   [card_map[card[0]], card[-1]]
  # }
  [Hand.new(cards[0...5].map { |s| Card.new(s) }),
   Hand.new(cards[5...10].map { |s| Card.new(s) })]
}

# hands = hands[0...20]

# hands.each do |hand1,hand2|
#   h1str = "#{hand1.show} (#{hand1.score_type}, #{hand1.score[1]})".ljust(52)
#   h2str = "#{hand2.show} (#{hand2.score_type}, #{hand2.score[1]})".ljust(52)
#   if hand1 > hand2
#     pstr = "Player 1"
#   else
#     pstr = "Player 2"
#   end
#   puts "#{h1str} <#{pstr}>  #{h2str}"
#   # print "#{hand1.show} (#{hand1.score_type}) | " +
#   #       "#{hand2.show} (#{hand2.score_type}) | Player"
#   if hand1 == hand2
#     puts "----------------------------------ERROR-----------------------"
#   end
# end
  
puts hands.count { |hand1,hand2|
  hand1 > hand2
}
