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
      timed_run(trials) do
        deck    = Holdem::Deck.new(all_cards)
        runout  = deck.finish_board(board)
        hands   = build_hands(runout)
        winners = find_winners(hands)
        increment_counters(winners)
      end
      finalize_report
      report
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

    def print_results
      puts
      puts "Hole Cards | Board    | Win % | Tie %"
      puts "-------------------------------------"
      report[:cards].each_pair do |key, hand|
        puts sprintf("%10s | %8s | % 3.2f | % 3.2f", key, report[:board], hand[:win_pct], hand[:tie_pct] )
      end
      puts "Trials: #{report[:trials]}"
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

    def all_cards
      cards.flatten + board
    end

    def build_hands(full_board)
      cards.map {|c| Holdem::PokerHand.new(c + full_board) }
    end

    def find_winners(existing_hands)
      high_score = existing_hands.map(&:rank).max
      existing_hands.select {|h| h.rank == high_score}
    end

    def increment_counters(winners)
      key = winners.count == 1 ? :win : :tie        
      winners.each {|hand| starting_hands[hand.id][key] += 1 }
    end

    def timed_run(trials)
      stime = Time.now
      1.upto(trials) {|trial| yield }
      report[:duration] = Time.now - stime
      report[:trials] = trials
    end


    def finalize_report
      starting_hands.each_pair do |key, hand|
        hand[:win_pct] = (hand[:win].to_f / report[:trials].to_f) * 100
        hand[:tie_pct] = (hand[:tie].to_f / report[:trials].to_f) * 100
      end
    end

  end
end