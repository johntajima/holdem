module Holdem

  class PokerRank

    RANKS = [
      :high_card,
      :pair,
      :two_pair,
      :three_kind,
      :straight,
      :flush,
      :full_house,
      :four_kind,
      :straight_flush,
      :royal_flush
    ]

    # returns hash with:
      # cards: xxx
      # hand: xx, xx, xx, xx, xx
      # hand_name: "Pair"
      # score: 2

    attr_reader :orig_cards, :cards, :rank, :key_cards, :hand

    def initialize(cards)
      @orig_cards = cards
      @cards      = sort_cards(cards)
      @hand       = []    # made hand
      @key_cards  = []
      @rank       = nil   # :high_card, :pair, etc.
      rank_hand
    end

    def score
      RANKS.index(rank) + 1
    end

    # order A -> 2, irregardless of suit
    def rank_hand
      RANKS.reverse.each do |rank|
        if self.send("#{rank}?".to_sym) 
          self.send("build_#{rank}".to_sym) && return
        end
      end
    end

    def build_royal_flush
      @rank = :royal_flush
    end

    def royal_flush?
    end


    def build_straight_flush
      @rank = :straight_flush
    end

    def straight_flush?
    end

    def build_four_kind
      @rank = :four_kind
    end

    def four_kind?
    end

    def build_full_house
      @rank = :full_house
    end

    def full_house?
    end

    def build_flush
      @rank = :flush
    end

    def flush?
    end

    def build_straight
      @rank = :straight
    end

    def straight?
      wheel? || regular_straight?
    end

    def build_three_kind
      @rank = :three_kind
      selected = cards.select {|card| cards.count {|c| c.rank_value == card.rank_value} > 2}.uniq
      @key_cards = selected
      @hand = @key_cards + (cards - selected).slice(0,2)
    end

    def three_kind?
      three = cards.select {|card| cards.count {|c| c.rank_value == card.rank_value} > 2}.uniq
      !three.empty?
    end

    def build_two_pair
      @rank = :two_pair
    end

    def two_pair?
      pairs = cards.select {|card| cards.count {|c| c.rank_value == card.rank_value} > 1}.uniq
      pairs.count > 4
    end

    def build_pair
      @rank = :pair
      pairs = cards.select {|card| cards.count {|c| c.rank_value == card.rank_value} > 1}.uniq
      @key_cards = pairs
      @hand = pairs + (cards - pairs).slice(0,3)
    end

    def pair?
      pairs = cards.select {|card| cards.count {|c| c.rank_value == card.rank_value} > 1}.uniq
      !pairs.empty?
    end

    def build_high_card
      @rank = :high_card
      @hand = @cards[0..4]
      @key_cards = @hand.slice(0,1)
    end

    def high_card?
      true
    end

    def wheel?
      rank_values = cards.map do |card|
        card.rank_value == Holdem::ACE ? 1 : card.rank_value
      end.sort.uniq
      found_hands = rank_values.each_cons(5).map do |set|
        set.each_cons(2).all? {|a,b| b == a + 1 }
      end

    end


    private 

    def sort_cards(cards)
      cards.sort {|a,b| b.rank_value <=> a.rank_value }
    end

  end

end