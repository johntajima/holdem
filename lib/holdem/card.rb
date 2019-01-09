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
      @rank = card[0]
      @suit = card[1]
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

    def id
      (Holdem::SUITS.index(suit) * Holdem::SUIT_COUNT) + Holdem::RANKS.index(rank)
    end

    def <=>(other)
      id <=> other.id
    end
  end

end