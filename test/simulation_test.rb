require "test_helper"

class SimluationTest < Minitest::Test

  def setup
  end

  def test_simulation
    hand1 = "As 3c"
    hand2 = "Qh 3d"
    hand3 = "Kh 3h"
    board = "6c 8h 9h"

    sim = Holdem::Simulation.new([hand1, hand2, hand3], board)
    response   = sim.run(100)
    sim.print_results
  end


  

end
