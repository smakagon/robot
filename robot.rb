class Robot
  DIRECTIONS = %w[SOUTH EAST NORTH WEST].freeze
  TABLE_COORDINATES = (0..4).to_a.repeated_permutation(2).to_a.freeze

  Error = Class.new(StandardError)

  attr_reader :x, :y, :direction

  def place(x, y, direction)
    x, y = x.to_i, y.to_i
    raise Error if !valid_position?(x, y) || !valid_direction?(direction)

    @x = x
    @y = y
    @direction = direction
  end

  def move
    return unless placed?

    new_position = [x, y]

    coordinate = ['WEST', 'EAST'].include?(direction) ? 0 : 1
    unit = ['SOUTH', 'EAST'].include?(direction) ? 1 : -1

    new_position[coordinate] += unit

    @x, @y = new_position if valid_position?(*new_position)
  end

  def left
    return unless placed?

    direction_index = DIRECTIONS.index(direction) + 1
    @direction = DIRECTIONS.fetch(direction_index, DIRECTIONS[0])
  end

  def right
    return unless placed?

    @direction = DIRECTIONS.at(DIRECTIONS.index(direction) - 1)
  end

  def report
    return unless placed?

    "#{x},#{y},#{direction}"
  end

  def placed?
    !!x
  end

  private

  def valid_position?(x, y)
    TABLE_COORDINATES.include?([x, y])
  end

  def valid_direction?(direction)
    DIRECTIONS.include?(direction)
  end
end
