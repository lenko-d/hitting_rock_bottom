
class Cave
  AIR_UNIT = ' '
  ROCK_UNIT = '#'
  WATER_UNIT = '~'

  attr_accessor :topology

  def initialize(file)
    @topology = []

    file.each do |line|
      line.strip.split("").each_with_index do |unit, i|
        @topology[i] = @topology[i] || []
        @topology[i].push(unit)
      end
    end
  end

  def save_topology(file_name)
    File.open(file_name, "w") do |file|
      topology.transpose.each do |row|
        file.puts row.join("")
      end
    end
  end

  def count_water_units(column_with_air_below)
    @counts_per_column = topology.map do |column|
      count = column.count { |unit| unit == WATER_UNIT }
    end

    @counts_per_column[column_with_air_below] = "~" if column_with_air_below
  end

  def save_water_units_counts(file_name)
    File.open(file_name, "w") do |file|
      file.puts @counts_per_column.join(" ")
    end
  end

  def to_s
    topology.transpose.map do |row|
      row.join("").concat("\n")
    end
  end
end

