require "test_helper"

class DeckTest < Minitest::Test

  def setup
    @deck = Holdem::Deck.new
  end

  def test_new_deck_has_52_cards
    assert_equal 52, @deck.cards.count
  end

  def test_new_deck_in_random
    deck2 = Holdem::Deck.new
    assert @deck.cards.to_s != deck2.cards.to_s
  end

  def test_new_deck_with_cards_passed_in_removes_cards_from_deck
    cards1 = build_cards("Ac Kc")
    cards2 = build_cards("3d 4d")
    @deck = Holdem::Deck.new(cards1 + cards2)
    assert_equal 48, @deck.cards.count
    refute @deck.card?(build_cards("Ac").first.id)
  end


  # deal_card!

  def test_deal_card_removes_card_from_deck
    @deck.deal_card!
    assert_equal 51, @deck.cards.count
  end

  def test_deal_card_returns_a_card
    card = @deck.deal_card!
    assert card.is_a?(Holdem::Card)
  end


  # finish_board

  def test_finish_board_returns_full_dealt_board
    board = @deck.finish_board([])
    assert_equal 47, @deck.cards.count
    assert_equal 5, board.count
  end

  def test_finish_board_returns_full_dealt_board_with_existing_board
    board  = build_cards("6h 7h 8h")
    @deck = Holdem::Deck.new(board)
    full_board = @deck.finish_board(board)
    assert_equal 47, @deck.cards.count
    assert_equal 5, full_board.count
    assert_equal full_board.slice(0,3), board
  end


end
