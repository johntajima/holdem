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
    start_time = Time.now()
    response   = sim.run(10000)
    end_time   = Time.now()
    puts
    puts "#{end_time - start_time}"
    response[:players].map {|player| 
      p "[#{player[:cards]}] [#{response[:board]}] Wins: #{"%.2f" % ((player[:win].to_f).round(4) * 100)}% tie: #{"%.2f" % ((player[:tie].to_f).round(4) * 100)}%"}
  end

end
