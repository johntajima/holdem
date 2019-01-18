module Holdem

  class Deck
    IDS = (1..52).to_a
    FULL_BOARD = 5
    
    def initialize(cards = [])
      existing = cards.map(&:id)
      @order = (IDS - existing).shuffle(random: Random.new(Random.new_seed))
    end

    def deal_card!
      card(@order.shift)
    end

    def cards
      @cards = @order.map {|i| card(i)}
    end

    def finish_board(board)
      board + (FULL_BOARD - board.count).times.map { deal_card! }
    end

    def card?(id)
      @order.include?(id)
    end

    private

    def card(id)
      Card.from_id(id)
    end
  end
end