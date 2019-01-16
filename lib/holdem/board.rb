module Holdem

  class Board

    attr_reader :cards

    def initialize(card_str)
      @cards = card_str.split(" ").map {|card| Holdem::Card.new(card)}
    end

    def inspect
      cards.map(&:inspect)
    end
  end
end