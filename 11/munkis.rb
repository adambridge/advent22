require 'pry-byebug'

class Item
  attr_accessor :worry_level

  def initialize(worry_level)
    @worry_level = worry_level
  end

  def inspect
    worry_level.to_s
  end
end

munki = nil
munkis = []
items = {}
op = {}
test = {}
divisor = {}
factor = {}
addend = {}
true_target = {}
false_target = {}
inspections = Hash.new(0)

file = File.open('input')
file.readlines.each do |line|
  case line
  when /Monkey (.*):/
    munki = $1.to_i
    munkis << munki
  when /Starting items: (.*)$/
    items[munki] = []
    $1.split(', ').each do |worry_level|
      items[munki] << Item.new(worry_level.to_i)
    end
  when /Operation: new = old \+ (\d+)$/
    addend[munki] = $1.to_i
    op[munki] = -> (munki) do
      inspections[munki] += 1
      item = items[munki].first
      item.worry_level = (item.worry_level + addend[munki]) / 3
    end
  when /Operation: new = old \* (\d+)$/
    factor[munki] = $1.to_i
    op[munki] = -> (munki) do
      inspections[munki] += 1
      item = items[munki].first
      item.worry_level = (item.worry_level * factor[munki]) / 3
    end
  when /Operation: new = old \+ old$/
    op[munki] = -> (munki) do
      inspections[munki] += 1
      item = items[munki].first
      item.worry_level = (item.worry_level + item.worry_level ) / 3
    end
  when /Operation: new = old \* old$/
    op[munki] = -> (munki) do
      inspections[munki] += 1
      item = items[munki].first
      item.worry_level = (item.worry_level * item.worry_level ) / 3
    end
  when /Test: divisible by (\d+)$/
    divisor[munki] = $1.to_i
    test[munki] = -> (munki) do
      item = items[munki].first
      if item.worry_level % divisor[munki] == 0
        items[true_target[munki]] << items[munki].shift
      else
        items[false_target[munki]] << items[munki].shift
      end
    end
  when /If true: throw to monkey (.*)/
    true_target[munki] = $1.to_i
  when /If false: throw to monkey (.*)/
    false_target[munki] = $1.to_i
  end
end

puts items
puts

for round in 1..20
  for munki in munkis
    while !items[munki].empty?
      op[munki].call(munki)
      test[munki].call(munki)
    end
  end
end

puts items
puts
puts inspections
puts
puts inspections.values.sort.max(2).reduce { |a, b| a * b }


