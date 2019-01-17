require "test_helper"

class SimluationTest < Minitest::Test

  def setup
  end

  def test_simulation
    hand1 = "As Ks"
    hand2 = "Qh Qd"
    hand1 = "9c 9h"
    hand2 = "Ad 7d"
    board = ""

    sim = Holdem::Simulation.new([hand1, hand2], board)
    response = sim.run(10000)
    sim.print_results
  end

end
