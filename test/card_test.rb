require "test_helper"

class CardTest < Minitest::Test

  def test_new_card_with_string
    @card = Holdem::Card.new("As")
    assert_equal "As", @card.to_s
    assert_equal 51,  @card.id
    assert_equal 's',  @card.suit
    assert_equal 'A',  @card.rank
  end

  def test_new_card_from_card
    @card = Holdem::Card.new("As")
    @card2 = Holdem::Card.new(@card)
    assert_equal @card, @card2
  end

  def test_two_cards_are_the_same_if_they_are_same_rank_and_suit
    @card = Holdem::Card.new("As")
    @card2 = Holdem::Card.new("As")
    assert_equal @card, @card2
    assert_equal @card.id, @card2.id
  end
end
