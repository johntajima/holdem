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

    attr_reader :rank, :key_cards, :hand

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
      RANKS.reverse.map do |rank|
        next if !@rank.nil?
        self.send("build_#{rank}".to_sym, @cards)
      end
    end

    def hand_as_string
      hand.map(&:to_s).join(" ")
    end


    def build_royal_flush(cards)
    #  @rank = :royal_flush
    end

    def build_straight_flush(cards)
    #  @rank = :straight_flush
    end

    def build_four_kind(cards)
    #  @rank = :four_kind
    end

    def build_full_house(cards)
    #  @rank = :full_house
    end

    def build_flush(cards)
    #  @rank = :flush
    end

    def build_straight(cards)
      build_high_straight(cards) || build_wheel(cards)
    end

    def build_high_straight(cards)
      uniq_cards = cards.uniq {|card| card.rank_value }
      uniq_cards.each_cons(5).each do |set|
        if set.each_cons(2).all? {|a,b| a.rank_value == b.rank_value + 1}
          @rank = :straight
          @hand = set.reverse
          @key_cards = @hand
          return true
        end
      end
      false
    end

    def build_wheel(cards)
      wheel_sorted = cards.sort {|a,b| a.wheel_rank_value <=> b.wheel_rank_value}
      uniq_cards = wheel_sorted.uniq {|card| card.wheel_rank_value }
      uniq_cards.each_cons(5).each do |set|
        if set.each_cons(2).all? {|a,b| b.wheel_rank_value == a.wheel_rank_value + 1}
          @rank = :straight
          @hand = set
          @key_cards = @hand
          return true
        end
      end
      false
    end

    def build_three_kind(cards)
      selected = cards.select {|card| cards.count {|c| c.rank_value == card.rank_value} > 2}
      return if selected.empty?

      @rank = :three_kind
      @key_cards = selected
      @hand = @key_cards + (cards - selected).slice(0,2)
    end

    def build_two_pair(cards)
      selected = cards.select {|card| cards.count {|c| c.rank_value == card.rank_value} > 1}
      return if selected.count < 4

      @rank = :two_pair
      @key_cards = selected.slice(0,4)
      @hand = @key_cards + (cards - @key_cards).slice(0,1)
    end

    def build_pair(cards)
      selected = cards.select {|card| cards.count {|c| c.rank_value == card.rank_value} > 1}
      return if selected.empty?

      @rank = :pair
      @key_cards = selected
      @hand = @key_cards + (cards - @key_cards).slice(0,3)
    end

    def build_high_card(cards)
      @rank = :high_card
      @hand = cards.slice(0,5)
      @key_cards = @hand.slice(0,1)
    end


    private 

    def sort_cards(cards)
      cards.sort {|a,b| b.rank_value <=> a.rank_value }
    end

  end

end