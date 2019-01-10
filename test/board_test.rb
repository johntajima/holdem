require "test_helper"

class BoardTest < Minitest::Test

  def setup
    @board = Holdem::Board.new(["As", "3h", "4d", "5c", "Kh"])
  end

  def test_new_board_with_5_cards
    @board = Holdem::Board.new(["As", "3h", "4d", "5c", "Kh"])
    assert_equal ["As", "3h", "4d"].join, @board.flop.to_a.join
    assert_equal "5c", @board.turn.to_s
    assert_equal "Kh", @board.river.to_s
  end

  def test_board_contains_cards
    @board = Holdem::Board.new(["As", "3h", "4d", "5c", "Kh"])
    assert @board.cards.all? {|x| x.is_a?(Holdem::Card)}
  end

  def test_board_has_no_turn_card
    @board = Holdem::Board.new(["As", "3h", "4d"])
    assert_nil @board.turn
  end

  def test_board_has_4_cards
    @board = Holdem::Board.new(["As", "3h", "4d", "Qh"])
    assert_equal "Qh", @board.turn.to_s
    assert_nil @board.river
  end

end
