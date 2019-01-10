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

  # add_card

  def test_add_cards_to_missing_board
    @board = Holdem::Board.new
    assert_equal 5, @board.missing_cards
    @board.add_card("Kh")
    @board.add_card("Qh")
    @board.add_card("4d")
    assert_equal 2, @board.missing_cards    
  end

  def test_cannot_add_cards_to_full_board
    @board = Holdem::Board.new(["As", "3h", "4d", "5c", "Kh"])
    assert_equal 0, @board.missing_cards
    assert_raises StandardError do 
      @board.add_card("Ac")
    end
  end

  def test_cannot_add_existing_card_to_board
    #
  end

end
