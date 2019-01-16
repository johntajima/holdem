module Holdem

  class Simulation

    attr_reader :board, :cards

    # cards => [ "As Kd", "5h 5d", ...]
    # board => "2h 3h 4h"  (can be empty, flop, turn, river)
    def initialize(cards = [], board)
      @cards = sanitize_cards(cards)
      @board = sanitize_board(board)
    end

    def run(trials)
      stime = Time.now()
      1.upto(trials) do |trial|
        deck    = Holdem::Deck.new(cards, board)
        runout  = deck.finish_board(board)
        hands   = build_hands(runout)
        winners = find_winners(hands)
        key = winners.count == 1 ? :win : :tie        
        winners.each {|i| starting_hands[i.id][key] += 1 }
      end
      finalize_report(trials, stime)
    end

    def starting_hands 
      @starting_hands ||= begin
        cards.inject(Hash.new) do |hash, hole_cards|
          id = hole_cards.map(&:to_s).join(" ")
          hash[id] = { cards: hole_cards, win: 0, tie: 0 }
          hash
        end
      end
    end

    def report
      @report ||= begin
        { trials: nil, board: @board_str, cards: starting_hands }
      end
    end


    private

    # can be "As5h" or "As 5h"
    def sanitize_cards(cards)
      @cards_str = cards
      cards.map do |card_str|
        card_str.split(" ").map {|c| Holdem::Card.new(c)}
      end
    end

    # board can be "AsKh4d" or "As Kh 5d"
    def sanitize_board(board)
      @board_str = board
      board.split(" ").map {|c| Holdem::Card.new(c)}
    end


    def build_hands(full_board)
      cards.map {|c| Holdem::PokerHand.new(c + full_board) }
    end

    def find_winners(existing_hands)
      hands = existing_hands.dup
      high_hands = compare_hands(hands)
      high_score = high_hands.map {|s| s.last }.max
      high_hands.select {|k,v| v == high_score }.keys
    end

    def compare_hands(hands)
      scores = hands.map do |hand|
        hands.sum {|vs_hand| hand.better_than?(vs_hand) }
      end
      scores.inject(Hash.new) do |hash, score|
        hash[hands.shift] = score
        hash
      end
    end

    def finalize_report(trials, stime)
      report[:duration] = Time.now - stime
      starting_hands.each_pair do |key, hand|
        hand[:win_pct] = (hand[:win].to_f / trials.to_f) * 100
        hand[:tie_pct] = (hand[:tie].to_f / trials.to_f) * 100
      end
      report[:trials] = trials
      report
    end

  end
end