require "test_helper"

class CardTest < Minitest::Test

  def test_new_card_with_string
    @card = Holdem::Card.new("As")
    assert_equal "As", @card.to_s
    assert_equal 52, @card.id
    assert_equal 's', @card.suit
    assert_equal 'A', @card.rank
  end

  def test_new_card_properly_sanitizes_string
    @card = Holdem::Card.new("aC")
    assert_equal "Ac", @card.to_s
    assert_equal 49, @card.id
    assert_equal 'c', @card.suit
    assert_equal 'A', @card.rank
  end

  def test_card_with_emoji
    @card = Holdem::Card.new("a♣️")
    assert_equal "Ac", @card.to_s
    @card = Holdem::Card.new("a♣")
    assert_equal "Ac", @card.to_s
    @card = Holdem::Card.new("a♥️")
    assert_equal "Ah", @card.to_s
    @card = Holdem::Card.new("a♥")
    assert_equal "Ah", @card.to_s
    @card = Holdem::Card.new("a♦️")
    assert_equal "Ad", @card.to_s
    @card = Holdem::Card.new("a♦")
    assert_equal "Ad", @card.to_s
    @card = Holdem::Card.new("a♠️")
    assert_equal "As", @card.to_s
    @card = Holdem::Card.new("a♠")
    assert_equal "As", @card.to_s
  end

  def test_new_card_raises_error_if_card_is_invalid
    assert_raises Holdem::InvalidCardError do
      @card = Holdem::Card.new("Ak")
    end
  end

  def test_new_card_from_card
    @card = Holdem::Card.new("As")
    @card2 = Holdem::Card.new(@card)
    assert_equal @card, @card2
  end


  # from_id
  
  def test_new_card_from_id
    @card = Holdem::Card.from_id(3)
    assert_equal 3, @card.id
    assert_equal "2h", @card.to_s
  end


  def test_two_cards_are_the_same_if_they_are_same_rank_and_suit
    @card = Holdem::Card.new("As")
    @card2 = Holdem::Card.new("As")
    assert_equal @card, @card2
    assert_equal @card.id, @card2.id
  end

end
