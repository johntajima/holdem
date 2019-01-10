module Holdem

  # Hand simulator
  # pass in array of players' hole cards, board
  # run calculate! to return simulation results


  class Hand
    DEFAULT_TRIALS = 10_000

    attr_reader :trials, :players, :board, :results

    def initialize(players_cards = [], board = [], options = {})
      @players = set_players(players_cards)
      @board   = Holdem::Board.new(board)
      @trials  = options.fetch(:trials, DEFAULT_TRIALS)
      @results = {
        players: @players,
        board: @board,
        trials: @trials
      }
    end

    def calculate!
      sim = Holdem::Simulation.new(cards, board)
      results = sim.run(trials)
      # results => [{win: 123, tie: 1}, {win: 19323, tie: 1}, ...]
      results.each_with_index do |result, index|
        @results[index][:win] = Rational(result[:win], trials).to_f
        @results[index][:tie] = Rational(result[:tie], trials).to_f
      end
    end


    private

    def set_players(players_cards)
      players_cards.map do |player|
        {
          cards: player.map {|card| Holdem::Card.new(card)},
          win: nil,
          tie: nil
        }
      end
    end
  end

end