# frozen_string_literal: true

require 'minitest/autorun'
require './lib/fuel_calc'

class FuelCalcTest < Minitest::Test
  def test_calculate
    assert_equal 'Fly me to the moon', FuelCalc.calculate(mass: 100, path: %w[Earth Moon])
  end
end
