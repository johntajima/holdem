module Holdem

  class Card
    include Comparable

    attr_reader :rank, :suit

    SUITS = %w|c d h s|
    RANKS = %w|2 3 4 5 6 7 8 9 T J Q K A|
    ICONS = {
      'c' => '♣',
      'd' => '♦',
      'h' => '♥',
      's' => '♠',
      'x' => 'x'
    }
    CARD_LOOKUP = {
      #       spacer,  A,  2,  3,  4,  5,  6,  7,  8,  9, 10,  J,  Q,  K,  A
        "c" => [ nil, 49,  1,  5,  9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49 ],
        "d" => [ nil, 50,  2,  6, 10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50 ],
        "h" => [ nil, 51,  3,  7, 11, 15, 19, 23, 27, 31, 35, 39, 43, 47, 51 ],
        "s" => [ nil, 52,  4,  8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52 ],
    }

    CARD_ID_TO_STR = {
      1  => { rank: "2", suit: "c" },
      2  => { rank: "2", suit: "d" },
      3  => { rank: "2", suit: "h" },
      4  => { rank: "2", suit: "s" },
      5  => { rank: "3", suit: "c" },
      6  => { rank: "3", suit: "d" },
      7  => { rank: "3", suit: "h" },
      8  => { rank: "3", suit: "s" },
      9  => { rank: "4", suit: "c" },
      10 => { rank: "4", suit: "d" },
      11 => { rank: "4", suit: "h" },
      12 => { rank: "4", suit: "s" },
      13 => { rank: "5", suit: "c" },
      14 => { rank: "5", suit: "d" },
      15 => { rank: "5", suit: "h" },
      16 => { rank: "5", suit: "s" },
      17 => { rank: "6", suit: "c" },
      18 => { rank: "6", suit: "d" },
      19 => { rank: "6", suit: "h" },
      20 => { rank: "6", suit: "s" },
      21 => { rank: "7", suit: "c" },
      22 => { rank: "7", suit: "d" },
      23 => { rank: "7", suit: "h" },
      24 => { rank: "7", suit: "s" },
      25 => { rank: "8", suit: "c" },
      26 => { rank: "8", suit: "d" },
      27 => { rank: "8", suit: "h" },
      28 => { rank: "8", suit: "s" },
      29 => { rank: "9", suit: "c" },
      30 => { rank: "9", suit: "d" },
      31 => { rank: "9", suit: "h" },
      32 => { rank: "9", suit: "s" },
      33 => { rank: "T", suit: "c" },
      34 => { rank: "T", suit: "d" },
      35 => { rank: "T", suit: "h" },
      36 => { rank: "T", suit: "s" },
      37 => { rank: "J", suit: "c" },
      38 => { rank: "J", suit: "d" },
      39 => { rank: "J", suit: "h" },
      40 => { rank: "J", suit: "s" },
      41 => { rank: "Q", suit: "c" },
      42 => { rank: "Q", suit: "d" },
      43 => { rank: "Q", suit: "h" },
      44 => { rank: "Q", suit: "s" },
      45 => { rank: "K", suit: "c" },
      46 => { rank: "K", suit: "d" },
      47 => { rank: "K", suit: "h" },
      48 => { rank: "K", suit: "s" },
      49 => { rank: "A", suit: "c" },
      50 => { rank: "A", suit: "d" },
      51 => { rank: "A", suit: "h" },
      52 => { rank: "A", suit: "s" }
    }

    def initialize(card)
      @rank, @suit = sanitize(card)
    end

    def self.from_id(id)      
      rank = CARD_ID_TO_STR[id][:rank]
      suit = CARD_ID_TO_STR[id][:suit]
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

    def id
      @id ||= CARD_VALUE_LOOKUP[suit][RANKS.index(rank) + 2]
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

