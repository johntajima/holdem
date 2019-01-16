module Holdem

  class Deck
    CARD_IDS   = (0..51).to_a   # 0-12 clubs, 13-25 h, 26-38 d, 39-51 spades
    FULL_BOARD = 5              # flop, turn, river

    def initialize(cards = [], board = [])
      @order = CARD_IDS.shuffle(random: Random.new(Random.new_seed))
      remove_existing_cards(cards + board)
    end

    def deal_card!
      card(@order.shift)
    end

    def cards
      @order.map {|i| card(i)}
    end

    def remove_card(card_str)
      @order.delete(Card.new(card_str).id)
    end

    def finish_board(board)
      board + (FULL_BOARD - board.count).times.map { deal_card! }
    end


    private

    def card(id)
      raise EmptyDeckError if id.nil?
      Card.from_id(id)
    end

    def remove_existing_cards(cards)
      cards.flatten.each {|card| remove_card(card) }
    end
  end
end