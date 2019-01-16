require "test_helper"

class SimluationTest < Minitest::Test

  def setup
  end

  def test_simulation
    hand1 = "As Ks"
    hand2 = "Qh Qd"
    board = ""

    sim = Holdem::Simulation.new([hand1, hand2], board)
    response = sim.run(5000)
    assert_equal 5000, response[:trials]
    sim.print_results
  end

end
