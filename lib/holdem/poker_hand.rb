module Holdem

  class PokerHand

    RANKS = [
      :high_card,
      :pair,
      :two_pair,
      :three_kind,
      :wheel_straight,
      :straight,
      :flush,
      :full_house,
      :four_kind,
      :wheel_straight_flush,
      :straight_flush,
      :royal_flush
    ]

    attr_reader :rank, :key_cards, :hand, :hole_cards

    def initialize(cards)
      @orig_cards = cards
      @hole_cards = cards.slice(0,2)
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
      return unless flush = flush?(cards)
      return unless straight_flush = straight?(flush) || wheel_straight?(flush)
      return unless straight_flush.last.rank_value == Holdem::ACE
      set_rank(:royal_flush, straight_flush, cards)      
    end

    def build_straight_flush(cards)
      return unless flush = flush?(cards)
      return unless straight_flush = straight?(flush)
      set_rank(:straight_flush, straight_flush, cards)
    end

    def build_wheel_straight_flush(cards)
      return unless flush = flush?(cards)
      return unless straight_flush = wheel_straight?(flush)
      set_rank(:wheel_straight_flush, straight_flush, cards)
    end

    def build_four_kind(cards)
      selected = cards.select {|card| cards.count {|c| c.rank_value == card.rank_value} == 4}
      return if selected.empty?
      set_rank(:four_kind, selected, cards)
    end

    def build_full_house(cards)
      # find three of a kind
      sets = cards.select {|card| cards.count {|c| c.rank_value == card.rank_value} > 2}
      return if sets.empty?

      pairs_group = cards - sets.slice(0,3)
      pairs = pairs_group.select {|card| cards.count {|c| c.rank_value == card.rank_value} > 1}
      return if pairs.count < 2

      set_rank(:full_house, sets.slice(0,3) + pairs.slice(0,2), cards)
    end

    def build_flush(cards)
      if selected = flush?(cards)
        set_rank(:flush, selected, cards)
      end
    end

    def build_straight(cards)
      return unless straight = straight?(cards)
      set_rank(:straight, straight, cards) 
    end

    def build_wheel_straight(cards)
      return unless straight = wheel_straight?(cards)
      set_rank(:wheel_straight, straight, cards)
    end

    def build_three_kind(cards)
      selected = cards.select {|card| cards.count {|c| c.rank_value == card.rank_value} > 2}
      return if selected.empty?
      set_rank(:three_kind, selected, cards)
    end

    def build_two_pair(cards)
      selected = cards.select {|card| cards.count {|c| c.rank_value == card.rank_value} > 1}
      return if selected.count < 4
      set_rank(:two_pair, selected, cards)
    end

    def build_pair(cards)
      selected = cards.select {|card| cards.count {|c| c.rank_value == card.rank_value} > 1}
      return if selected.empty?
      set_rank(:pair, selected, cards)
    end

    def build_high_card(cards)
      set_rank(:high_card, cards.slice(0,1), cards)
    end


    def kickers
      case rank
      when :straight, :straight_flush
        hand.reverse.map {|c| c.rank_value }
      when :wheel_straight, :wheel_straigh_flush
        hand.reverse.map {|c| c.wheel_rank_value }
      else
        hand.map {|c| c.rank_value }
      end
    end

    # true if self is a stronger hand than passed in hand.

    def better_than?(hand)
      return 0 if hand == self
      if score > hand.score
        1
      elsif score < hand.score
        -1
      else
        compare_kickers(hand)
      end
    end

    # 1 if my is better, -1 if I'm work, 0 if tie
    def compare_kickers(hand)
      state = 0
      (0..4).each do |index|
        state = kickers[index] - hand.kickers[index]
        return state unless state == 0
      end
      state
    end

    private 

    def flush?(cards)
      selected = cards.select {|card| cards.count {|c| c.suit == card.suit} >= 5}
      selected.empty? ? nil : selected
    end

    def straight?(cards)
      uniq_cards = cards.uniq {|card| card.rank_value }
      uniq_cards.each_cons(5).each do |set|
        if set.each_cons(2).all? {|a,b| a.rank_value == b.rank_value + 1}
          return set.reverse
        end
      end
      false
    end

    def wheel_straight?(cards)
      wheel_sorted = wheel_sort(cards)
      uniq_cards = wheel_sorted.uniq {|card| card.wheel_rank_value }
      uniq_cards.each_cons(5).each do |set|
        if set.each_cons(2).all? {|a,b| b.wheel_rank_value == a.wheel_rank_value + 1}
          return set
        end
      end
      false
    end


    def set_rank(key, selected, cards)
      @rank = key
      key_cards_count = case @rank
        when :high_card then 1
        when :pair then 2
        when :three_kind then 3
        when :two_pair, :four_kind then 4
        else 5
      end

      @key_cards = selected.slice(0,key_cards_count)
      @hand      = @key_cards + (cards - @key_cards).slice(0, (5 - key_cards_count))
    end

    def sort_cards(cards)
      cards.sort {|a,b| b.rank_value <=> a.rank_value }
    end

    def wheel_sort(cards)
      cards.sort {|a,b| a.wheel_rank_value <=> b.wheel_rank_value }
    end

  end

end