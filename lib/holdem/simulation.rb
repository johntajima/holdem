module Holdem

  # init with players' cards and board
  # run() with number of trials to test against
  # results is array of win/tie, based on order of cards passed in


  class Simulation

    attr_reader :players, :board, :cards

    def initialize(cards, board)
      @cards = cards
      @players = cards.map do |hole_cards|
        { cards: hole_cards, win: 0, tie: 0 }
      end
      @board = board
    end

    def cards
      @players.map {|player| player[:cards] }
    end

    def run(trials)
      reset_counts
      1.upto(trials) do |trial|
        deck = Holdem::Deck.new
        deck.remove_cards(board.cards)
        deck.remove_cards(cards.flatten)
        board.missing_cards.times {board.add_card(deck.deal_card!)}

        # calculate winners and ties
        report = Holdem::Ranking.rank_hands(cards, board)
        # increment counters
      end
      results
    end

    def results      
      players
    end


    private

    def reset_counts
      @players.each do |player|
        player[:win] = 0
        player[:tie] = 0
      end
    end
  end
end