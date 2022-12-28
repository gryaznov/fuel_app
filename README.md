### Fuel App
##### A tech task demo app, which calculates fuel required for the space flight.

#### Usage:
###### CLI:
```bash
$ cd fuel_app
$ ruby ./lib/fuel_calc.rb 28801, "[[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]]"
$ ruby ./lib/fuel_calc.rb 14606, [[:launch, 9.807], [:land, 3.711], [:launch, 3.711], [:land, 9.807]]
$ ruby ./lib/fuel_calc.rb 75432, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 3.711], [:launch, 3.711], [:land, 9.807]]

# or more human-friendly:
$ ruby ./lib/fuel_calc.rb 75432, "Earth", "Moon", "Moon", "Mars", "Mars", "Earth"
```
###### IRB:
```ruby
> require './lib/fuel_calc'
> FuelCalc.calculate(mass: 28801, route: [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]])
> FuelCalc.calculate(mass: 75432, route: ["Earth", "Moon", "Moon", "Mars", "Mars", "Earth"])
> FuelCalc.calculate(mass: 75432, route: [:earth, :moon, :moon, :mars, :mars, :earth])
```

#### Tests:
```bash
$ cd fuel_app
$ ruby ./test/fuel_calc_test.rb
```
