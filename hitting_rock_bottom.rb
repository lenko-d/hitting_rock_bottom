require 'cave'
require 'water_unit'

cave_topology_input_file = File.open(ARGV[0])
num_water_units = cave_topology_input_file.first.strip.to_i
cave = Cave.new(cave_topology_input_file)

column_with_air_below = nil
x_current_coord = 1
y_current_coord = 1
num_water_units.times do
  water = WaterUnit.new(cave.topology, x_current_coord, y_current_coord)

  if !water.is_at_open_position?
    if water.can_flow_down?
      water.flow_down
    elsif water.can_flow_right?
      water.flow_right
    else 
      water.backtrack_position
    end 
  end

  # we've found a position for this drop of water
  x_current_coord = water.x
  y_current_coord = water.y
  cave.topology[x_current_coord][y_current_coord] = Cave::WATER_UNIT

  if water.can_flow_down?
    column_with_air_below = x_current_coord
  else
    column_with_air_below = nil
  end

  # puts cave.to_s  # if want_to_debug?
end

cave.count_water_units(column_with_air_below)
cave.save_water_units_counts(ARGV[1])
cave.save_topology(ARGV[2])
