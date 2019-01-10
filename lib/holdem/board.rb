module Holdem

  class Board

    attr_reader :cards

    def initialize(cards)
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
  end
end