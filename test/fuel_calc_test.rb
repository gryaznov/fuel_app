# frozen_string_literal: true

require 'minitest/autorun'
require './lib/fuel_calc'

describe FuelCalc do
  describe 'calculate' do
    it 'returns correct results' do
      assert_equal \
        51_898,
        FuelCalc.calculate(mass: 28_801, route: [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]])

      assert_equal \
        33_388,
        FuelCalc.calculate(mass: 14_606, route: [[:launch, 9.807], [:land, 3.711], [:launch, 3.711], [:land, 9.807]])

      assert_equal \
        212_161,
        FuelCalc.calculate(mass: 75_432, route: [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 3.711], [:launch, 3.711], [:land, 9.807]])
    end
  end

  describe '.parse_route' do
    it 'raises an error if a given argument does not lool like a route' do
      assert_raises(FuelCalcError) { FuelCalc.parse_route(66) }
      assert_raises(FuelCalcError) { FuelCalc.parse_route([9.807, 1.62]) }
    end

    it 'returns correct value if a formal argument is given' do
      assert_equal [[:launch, 9.807], [:land, 3.711], [:launch, 3.711], [:land, 9.807]],
                   FuelCalc.parse_route([[:launch, 9.807], [:land, 3.711], [:launch, 3.711], [:land, 9.807]])
    end

    it 'returns correct value if an array of destination points names are given (strings)' do
      assert_equal [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 3.711], [:launch, 3.711], [:land, 9.807]],
                   FuelCalc.parse_route(%w[Earth Moon Moon Mars Mars Earth])
    end

    it 'returns correct value if an array of destination points names are given (symbols)' do
      assert_equal [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 3.711], [:launch, 3.711], [:land, 9.807]],
                   FuelCalc.parse_route(%i[earth moon moon mars mars earth])
    end
  end

  describe '.calculate_fuel_for_launch' do
    it 'returns 0 if given mass is negative' do
      assert_equal 0, FuelCalc.calculate_fuel_for_launch(mass: -100, gravity: 9.807)
    end

    it 'returns 0 if given mass is zero' do
      assert_equal 0, FuelCalc.calculate_fuel_for_launch(mass: 0, gravity: 9.807)
    end

    it 'returns correct result' do
      assert_equal 19_772, FuelCalc.calculate_fuel_for_launch(mass: 28_801, gravity: 9.807)
    end
  end

  describe '.calculate_fuel_for_land' do
    it 'returns 0 if given mass is negative' do
      assert_equal 0, FuelCalc.calculate_fuel_for_land(mass: -100, gravity: 9.807)
    end

    it 'returns 0 if given mass is zero' do
      assert_equal 0, FuelCalc.calculate_fuel_for_land(mass: 0, gravity: 9.807)
    end

    it 'returns correct result' do
      assert_equal 13_447, FuelCalc.calculate_fuel_for_land(mass: 28_801, gravity: 9.807)
    end
  end

  describe '.launching_calculation_formula' do
    it 'returns correct result' do
      assert_equal 10_264, FuelCalc.launching_calculation_formula(mass: 25_000, gravity: 9.807)
    end
  end

  describe '.landing_calculation_formula' do
    it 'returns correct result' do
      assert_equal 8048, FuelCalc.landing_calculation_formula(mass: 25_000, gravity: 9.807)
    end
  end
end
