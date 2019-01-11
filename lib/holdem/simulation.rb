module Holdem

  # init with players' cards and board
  # run() with number of trials to test against
  # results is array of win/tie, based on order of cards passed in


  class Simulation

    attr_reader :players, :board, :cards

    def initialize(cards = [], board)
      @cards = cards
      @players = cards.map do |hole_cards|
        { cards: hole_cards, win: 0, tie: 0 }
      end
      @board = board
    end

    def run(trials)
      reset_counts
      1.upto(trials) do |trial|

        deck = Holdem::Deck.new()
        deck.remove_cards(board.cards)
        deck.remove_cards(cards.flatten)
        new_board = Holdem::Board.new(board.cards)
        new_board.missing_cards.times {new_board.add_card(deck.deal_card!)}
        puts "\n\nRun #{trial} ---------------------------"
        puts "Board is #{new_board.cards}"

        # create new random deck
        # remove used cards
        # deal remaining cards to board
        poker_hands = players.map do |player|
          pokerhand = Holdem::PokerHand.new(player[:cards] + new_board.cards)
          p "#{pokerhand.hand_as_string}: #{pokerhand.rank}"
        end
        # for each player, 
          # calculate pokerhand for each player
        # determine winner/ties 
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