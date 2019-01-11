require "test_helper"

class SimluationTest < Minitest::Test

  def setup
  end

  def test_simulation
    hand1 = build_cards("As 2d")
    hand2 = build_cards("Qh Jd")
    board = build_board("Ac Kh Qc")

    sim = Holdem::Simulation.new([hand1, hand2], board)

    sim.run(10)
  end

end
