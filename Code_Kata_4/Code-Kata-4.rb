# Part One - day number with smallest temperature spread

  input = File.open('weather.dat', 'r'){|f| f.read }
  data = input.lines.map(&:split)

  data.map! do |line|
    line.take(3).map!(&:to_i)
  end

  data.delete_if { |elem| elem.empty? || elem[0] == 0 }

  smallest_diff = data[0][1] - data[0][2]
  day_num = nil

  data.each do |day|
    if day[1] - day[2] < smallest_diff
      smallest_diff = day[1] - day[2]
      day_num = day[0]
    end
  end

  puts "The smallest temperature spread for June 2012 was on June  {day_num}, 2012 with a spread of  {smallest_diff} degrees."

# Part Two - print team name with smallest difference between ‘for’ and ‘against’ goals

  input = File.open('football.dat', 'r'){|f| f.read }
  scores = input.lines.map(&:split)

  scores.delete_if { |elem| elem[0].to_i == 0 }

  index = scores[0].index("-")

  team = nil
  smallest_diff = (scores[0][index - 1].to_i - scores[0][index + 1].to_i).abs

  scores.each do |points|
    if (points[index - 1].to_i - points[index + 1].to_i).abs < smallest_diff
      smallest_diff = (points[index - 1].to_i - points[index + 1].to_i).abs
      team = points[1]
    end
  end

  p " {team} has the smallest point difference of  {smallest_diff}."

# Part Three: "DRY" it up, factor out shared functionality

class SmallestDiff

  attr_reader :filename, :data, :smallest, :entity

  def initialize(options)
    @filename = options.fetch(:filename)
    @data = parse_data
    clean_data
  end

  def smallest_diff(title, first, last)
    @smallest = (@data[0][first].to_i - @data[0][last].to_i).abs
    @entity = @data[0][title]

    @data.each do |datum|
      if (datum[first].to_i - datum[last].to_i).abs < @smallest
        @smallest = (datum[first].to_i - datum[last].to_i).abs
        @entity = datum[title]
      end
    end

  end

  def print_diff(item_measured)
    "The smallest  {item_measured} difference is  {@smallest} belonging to  {@entity}."
  end

  private

  def parse_data
    File.open(@filename, 'r') {|f| f.read }.lines.map(&:split)
  end

  def clean_data
    @data.delete_if { |elem| elem.empty? || elem[0].to_i == 0 }
  end

end

weather = SmallestDiff.new(filename: "weather.dat")
weather.smallest_diff(0,1,2)
puts weather.print_diff("June 2013 day temperature")

scores = SmallestDiff.new(filename: "football.dat")
index = scores.data[0].index("-")
scores.smallest_diff(1, index-1, index+1)
puts scores.print_diff("for/against point")
