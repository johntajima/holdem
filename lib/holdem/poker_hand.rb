module Holdem

  class PokerHand

    CATEGORIES = [
      "Invalid Hand",
      "High Card",
      "Pair",
      "Two Pairs",
      "Three of a Kind",
      "Straight",
      "Flush",
      "Full House",
      "Four of a Kind",
      "Straight Flush",
      "Royal Flush"
    ]

    attr_reader :rank, :category, :cards

    def initialize(cards)
      @cards    = cards
      @rank     = HandRank.get(cards.map(&:hand_rank_id))
      @category = CATEGORIES[HandRank.category(@rank)]
      @key      = HandRank.category_key(@rank)
    end

    def id
      hole_cards.map(&:to_s).join(" ")
    end

    def hole_cards
      cards.slice(0,2)
    end


    private

  end

end