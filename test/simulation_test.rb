require "test_helper"

class SimluationTest < Minitest::Test

  def setup
  end

  def test_simulation
    hand1 = "As 3h"
    hand2 = "Qh 3d"
    hand3 = "Kh 3c"
    board = "6c 8h 9d"

    sim = Holdem::Simulation.new([hand1, hand2, hand3], board)
    response   = sim.run(1000)
    p response
  end


  

end
