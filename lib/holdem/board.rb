module Holdem

  class Board

    attr_reader :cards

    FULL_BOARD = 5

    def initialize(cards = [])
      @cards = cards.map {|card| Holdem::Card.new(card)}
    end

    def flop
      cards[0..2]
    end

    def turn
      cards[3]
    end

    def river
      cards[4]
    end

    def missing_cards
      FULL_BOARD - @cards.count
    end

    def add_card(card)
      raise if cards.count == FULL_BOARD
      @cards.push(Holdem::Card.new(card))
    end

    def inspect
      "<Holdem::Board flop=\"#{flop.join(' ')}\" turn=\"#{turn}\" river=\"#{river}\">"
    end
  end
end