
class WaterUnit
  attr_accessor :x, :y

  def initialize(cave_topology,x,y)
    @cave_topology=cave_topology
    @x=x
    @y=y
  end

  def is_at_open_position?
    @cave_topology[@x][@y] != Cave::WATER_UNIT and @cave_topology[@x][@y] != Cave::ROCK_UNIT
  end

  def can_flow_down?
    @cave_topology[@x][@y + 1] == Cave::AIR_UNIT
  end

  def can_flow_right?
    @cave_topology[@x + 1][@y] == Cave::AIR_UNIT
  end

  def flow_down
    @y = @y + 1
  end

  def flow_right
    @x = @x + 1
  end

  def backtrack_position
    move_up

    move_left while can_move_left?
  end

  def move_up
    @y = @y - 1
  end

  def can_move_left?
    @cave_topology[@x - 1][@y] == Cave::AIR_UNIT
  end

  def move_left
    @x = @x - 1
  end
end
