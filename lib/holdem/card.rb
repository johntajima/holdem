module Holdem

  class Card
    include Comparable

    attr_reader :rank, :suit

    SUITS      = %w|c h d s|
    RANKS      = %w|2 3 4 5 6 7 8 9 T J Q K A|
    SUIT_COUNT = RANKS.size
    ICONS = {
      'c' => '♣',
      'd' => '♦',
      'h' => '♥',
      's' => '♠',
      'x' => 'x'
    }

    def initialize(card)
      @rank, @suit = sanitize(card)
    end

    def self.from_id(id)
      rank = RANKS[id % SUIT_COUNT]
      suit = SUITS[id / SUIT_COUNT]
      new("#{rank}#{suit}")
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
      RANKS.index(rank) + 2
    end

    def wheel_rank_value
      rank_value == 14 ? 1 : rank_value
    end

    def id
      @id ||= (SUITS.index(suit) * SUIT_COUNT) + RANKS.index(rank)
    end

    def <=>(other)
      id <=> other.id
    end


    private

    def sanitize(card_str)
      if card_str.is_a?(Holdem::Card)
        [card_str.rank, card_str.suit]
      else
        rank, suit = card_str.split("")
        rank.upcase!
        suit.downcase!
        raise InvalidCardError unless SUITS.include?(suit) && RANKS.include?(rank)
        [rank, suit]
      end
    end    
  end

end

