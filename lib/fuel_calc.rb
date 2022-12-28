# frozen_string_literal: true

class FuelCalcError < StandardError; end

class FuelCalc
  GRAVITIES = {
    'earth' => 9.807,
    'jupiter' => 24.79,
    'mars' => 3.711,
    'mercury' => 3.7,
    'moon' => 1.62,
    'neptune' => 11.15,
    'saturn' => 10.44,
    'uranus' => 8.87,
    'venus' => 8.87
  }.freeze
  LANDING_COEFFICIENT = 0.033
  LAUNCHING_COEFFICIENT = 0.042

  class << self
    def calculate(mass:, route:)
      parse_route(route).reverse.reduce(0) do |memo, point|
        case point[0]
        when :launch
          memo += calculate_fuel_for_launch(mass: mass + memo, gravity: point[1])
        when :land
          memo += calculate_fuel_for_land(mass: mass + memo, gravity: point[1])
        end

        memo
      end
    end

    def parse_route(route)
      raise FuelCalcError, 'Wrong route format. Must be an Array.' unless route.is_a?(Array)
      return route if route.all? { |el| el.is_a?(Array) }

      if route.all? { |el| el.is_a?(String) || el.is_a?(Symbol) }
        return route.map.with_index do |point, index|
          index.even? && [:launch, GRAVITIES[point.to_s.downcase]] || [:land, GRAVITIES[point.to_s.downcase]]
        end
      end

      raise FuelCalcError, "Unable to regonize the flight route: #{route}."
    end

    def calculate_fuel_for_launch(mass:, gravity:)
      return 0 unless mass.positive?

      additional_mass = launching_calculation_formula(mass: mass, gravity: gravity)
      additional_mass + [calculate_fuel_for_launch(mass: additional_mass, gravity: gravity), 0].max
    end

    def calculate_fuel_for_land(mass:, gravity:)
      return 0 unless mass.positive?

      additional_mass = landing_calculation_formula(mass: mass, gravity: gravity)
      additional_mass + [calculate_fuel_for_land(mass: additional_mass, gravity: gravity), 0].max
    end

    def launching_calculation_formula(mass:, gravity:)
      (mass * gravity * LAUNCHING_COEFFICIENT - LANDING_COEFFICIENT * 1000).floor
    end

    def landing_calculation_formula(mass:, gravity:)
      (mass * gravity * LANDING_COEFFICIENT - LAUNCHING_COEFFICIENT * 1000).floor
    end
  end
end

FuelCalc.calculate(mass: ARGV[0], route: ARGV[-1..1]) if ARGV.length > 1
