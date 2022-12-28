### Fuel App
##### A tech task demo app, which calculates fuel required for the space flight.

#### Usage:
###### IRB:
```ruby
> require './lib/fuel_calc'
> FuelCalc.calculate(mass: 28801, route: [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]])
> FuelCalc.calculate(mass: 75432, route: ["Earth", "Moon", "Moon", "Mars", "Mars", "Earth"])
> FuelCalc.calculate(mass: 75432, route: [:earth, :moon, :moon, :mars, :mars, :earth])
```
###### CLI:
```bash
$ cd fuel_app
$ ruby ./lib/fuel_calc.rb 75432 Earth Moon Moon Mars Mars Earth
```
#### Tests:
```bash
$ cd fuel_app
$ ruby ./test/fuel_calc_test.rb
```
