module Holdem

  class PokerHand

    CATEGORIES = [
      :invalid,
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

    attr_reader :rank, :category, :cards, :key, :cat

    def initialize(cards)
      @cards    = cards
      @rank     = HandRank.get(cards.map(&:id))
      @category = CATEGORIES[HandRank.category(@rank)]
      @cat      = HandRank.category(@rank)
      @key      = HandRank.category_key(@rank)
    end

    def id
      hole_cards.map(&:to_s).join(" ")
    end

    def hole_cards
      cards.slice(0,2)
    end

    def hand_id
      hole_cards.map(&:to_s).join(" ")
    end

    private

  end
end