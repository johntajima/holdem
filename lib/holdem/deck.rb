module Holdem

  class Deck
    CARD_IDS = (0..51).to_a

    FULL_BOARD = 5

    def initialize(cards = [], board = [])
      @order = CARD_IDS.shuffle(random: Random.new(Random.new_seed))
      cards.flatten.each {|card| remove_card(card) }
      board.each {|card| remove_card(card) }
    end

    def deal_card!
      card(@order.shift)
    end

    def cards
      @order.map {|i| card(i)}
    end

    def remove_cards(cards = [])
      cards.each {|card| remove_card(card) }
    end

    def remove_card(card_str)
      card = card_str.is_a?(Holdem::Card) ? card_str : Card.new(card_str)
      @order.delete(card.id)
    end

    def finish_board(board)
      board + (FULL_BOARD - board.count).times.map { deal_card! }
    end


    private

    def card(index)
      raise EmptyDeckError if index.nil?

      rank = Holdem::RANKS[index % SUIT_COUNT]
      suit = Holdem::SUITS[index / SUIT_COUNT]
      Card.new("#{rank}#{suit}")
    end
  end
end