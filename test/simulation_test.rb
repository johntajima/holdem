require "test_helper"

class SimluationTest < Minitest::Test

  def setup
  end

  def test_simulation
    hand1 = "As Ks"
    hand2 = "Qh Qd"
    board = ""

    sim = Holdem::Simulation.new([hand1, hand2], board)
    response = sim.run(10000)
    assert response.key?(:trials)
    assert response.key?(:board)
    assert_equal 2, response[:cards].count
    assert response[:cards].key?(hand1)
    assert response[:cards][hand1].key?(:win)
    assert response[:cards][hand1].key?(:tie)
    assert response[:cards].key?(hand2)
    sim.print_results
  end

end
