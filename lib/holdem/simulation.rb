module Holdem

  # init with players' cards and board
  # run() with number of trials to test against
  # results is array of win/tie, based on order of cards passed in


  class Simulation

    attr_reader :report, :board, :cards

    WIN = 1
    TIE = 0
    LOSE = -1

    # cards => [ "As Kd", "5h 5d", ...]
    # board => "2h 3h 4h"  (can be empty, flop, turn, river)
    def initialize(cards = [], board)
      @board_str = board
      @cards_str = cards
      @cards = cards.map do |card_string| 
        card_string.split(" ").map {|card| Holdem::Card.new(card) }
      end
      @board = Holdem::Board.new(board.split(" "))
     # sanitize_input # ensure cards are valid...
    end

    def run(trials)
      report[:trials] = trials
      1.upto(trials) do |trial|
        curr_board = build_board(cards, board)
        hands      = build_hands(cards, curr_board)
        results    = find_winning_hand(hands.dup)  # [<hand> => score, ....]
        hands.each_with_index do |hand, i|
          key = results.count == 1 ? :win : :tie
          players[i][key] +=1 if hand.hand == results.first.hand
        end
      end
      finalize_report
      report
    end


    def players
      @players ||= begin
        @cards_str.map do |cards|
          { cards: cards, win: 0, tie: 0 }
        end
      end
    end

    def report
      @report ||= begin
        { trials: nil, board: @board_str, players: players }
      end
    end

    def build_board(cards, board)
      deck = Holdem::Deck.new()
      deck.remove_cards(board.cards)
      deck.remove_cards(cards.flatten)
      new_board = Holdem::Board.new(board.cards)
      new_board.missing_cards.times {new_board.add_card(deck.deal_card!)}
      new_board
    end

    def build_hands(cards, curr_board)
      cards.map {|cards| Holdem::PokerHand.new(cards + curr_board.cards) }
    end

    # compare hands x hands and sum results
    # if score == (total # hands - 1) => winner
    # else all other where score < 1/2 # of hands => reject
      # remainer are ties

    def find_winning_hand(hands)
      scores = compare_hands(hands)
      high_score = scores.map {|s| s.last }.max
      scores.select {|k,v| v == high_score }.keys
    end

    # recursive function that returns array of hands that win
    def compare_hands(hands)
      scores = hands.map do |hand|
        score = hands.sum do |vs_hand|
          hand.better_than?(vs_hand)
        end
        score
      end
      scores.inject(Hash.new) do |h, score|
        h[hands.shift] = score
        h
      end
    end



    private

    def finalize_report
      players.each do |player|
        player[:win] = Rational(player[:win], report[:trials])
        player[:tie] = Rational(player[:tie], report[:trials])
      end
    end

  end
end