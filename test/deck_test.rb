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


  # deal_card!

  def test_deal_card_removes_card_from_deck
    @deck.deal_card!
    assert_equal 51, @deck.cards.count
  end

  def test_deal_card_returns_a_card
    card = @deck.deal_card!
    assert card.is_a?(Holdem::Card)
  end

  def test_deal_card_cannot_deal_card_if_none_exist
    _ = 52.times {|x| @deck.deal_card!}
    assert_equal 0, @deck.cards.count

    assert_raises Holdem::EmptyDeckError do 
      @deck.deal_card!
    end
  end


  # remove_card

  def test_remove_card_removes_card_from_deck
    card = Holdem::Card.new('2c')
    assert @deck.cards.include?(card)
    @deck.remove_card(card)
    assert !@deck.cards.include?(card)
  end

  def test_remove_card_removes_card_as_string
    card = Holdem::Card.new('2c')
    assert @deck.cards.include?(card)
    @deck.remove_card('2c')
    assert !@deck.cards.include?(card)
  end

  # remove_cards

  def test_remove_cards_removes_multiple_cards_at_once
    card = Holdem::Card.new('2c')
    card2 = Holdem::Card.new('2s')
    assert @deck.cards.include?(card)
    assert @deck.cards.include?(card2)
    @deck.remove_cards([card, card2])
    assert !@deck.cards.include?(card)
    assert !@deck.cards.include?(card2)
  end


end
