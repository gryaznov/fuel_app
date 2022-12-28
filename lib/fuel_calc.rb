# frozen_string_literal: true

class FuelCalc
  class << self
    def calculate(mass:, path:)
      puts mass
      puts path
      'Fly me to the moon'
    end
  end
end

FuelCalc.calculate(mass: ARGV[0], path: ARGV[-1..1]) if ARGV.length > 1
