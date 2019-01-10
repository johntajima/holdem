module Holdem

  class Card
    include Comparable

    attr_reader :rank, :suit

    ICONS = {
      'c' => '♣',
      'd' => '♦',
      'h' => '♥',
      's' => '♠',
      'x' => 'x'
    }

    def initialize(card)
      if card.is_a?(Holdem::Card)
        @rank = card.rank
        @suit = card.suit
      else
        @rank, @suit = card.split("")
      end
    end

    def to_s
      "#{rank}#{suit}"
    end

    def to_display
      "#{rank}#{icon}"
    end

    def inspect
      to_s
    end

    def icon
      ICONS[suit]
    end

    def rank_value
      Holdem::RANKS.index(rank) + 2
    end

    def wheel_rank_value
      rank_value == 14 ? 1 : rank_value
    end

    def id
      @id ||= (Holdem::SUITS.index(suit) * Holdem::SUIT_COUNT) + Holdem::RANKS.index(rank)
    end

    def <=>(other)
      id <=> other.id
    end
  end

end

