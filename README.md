## Robot

The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units
The robot is free to roam around the surface of the table.
Any movement that would result in the robot falling from the table is prevented.


`Robot` class provides methods:

 - `place(x, y, direction)` where direction is: EAST, WEST, NORTH, SOUTH
 - `move`
 - `left`
 - `right`
 - `report`
 - `placed?`

Make sure you place robot before sending any further commands.

To use this class in terminal, `cd` into directory with `robot.rb` and run `irb`:

```ruby
require_relative 'robot'

robot = Robot.new
robot.place(1, 1, "WEST")
robot.report # => "1,1,WEST"
robot.move
robot.report # => "0,1,WEST"
robot.right
robot.report # => "0,1,NORTH"
```

Also, you can run `ruby application.rb` in terminal and use commands:

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
EXIT
```

### Specs

All specs implemented with RSpec and could be run using `rspec` command inside project folder.
To install `rspec` please run `bundle install` inside project folder.
