class Santa
  attr_accessor :x, :y, :houses, :name

  def initialize(x:0, y:0, houses: [], name: "Santa")
    @x = x
    @y = y
    new_house = House.new(x: x, y: y)
    @houses = houses.push(new_house)
  end

  def move(instruction)
    coordinates = next_position(instruction)
    clone_and_update(coordinates)
  end

  def move_multiple(instructions)
    instructions.inject(Santa.new) do |santa, instruction|
      santa.move(instruction)
    end
  end

  def next_position(instruction)
    case instruction
    when "^"
      { y: y+1 }
    when ">"
      { x: x + 1 }
    when "v"
      { y: y - 1 }
    when "<"
      { x: x - 1 }
    end
  end

  def clone_and_update(new_opts)
    merged_opts = { x: x, y: y, houses: houses, name: name }.merge(new_opts)
    self.class.new(merged_opts)
  end
end

class House
  attr_accessor :x, :y
  def initialize(opts)
    @x = opts.fetch(:x)
    @y = opts.fetch(:y)
  end

  def self.unique_houses(houses)
    houses.map { |house| [house.x, house.y] }.uniq.size
  end
end

# Solution - Part 1
# input = File.read('../../input/instructions.txt')
# santa_direction = input.split('')
# santa = Santa.new(name: "Santa").move_multiple(santa_directions)
# unique_houses = House.unique_houses(total_houses)

# Solution - Part 2
# input = File.read('../../input/instructions.txt')
# input_enum = input.split('').each_slice(2)
# santa_directions = input_enum.map(&:first)
# rs_directions = input_enum.map(&:last)
# santa = Santa.new(name: "Santa").move_multiple(santa_directions)
# robot_santa = Santa.new(name: "Robot Santa").move_multiple(rs_directions)
# total_houses = [santa.houses + robot_santa.houses].flatten
# unique_houses = House.unique_houses(total_houses)
