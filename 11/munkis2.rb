require 'pry-byebug'

munki = nil
munkis = []
items = {}
op = {}
test = {}
$divisor = {}
factor = {}
addend = {}
true_target = {}
false_target = {}
inspections = Hash.new(0)

class Item
  def initialize(level)
    @remainder = {}
    $divisor.values.each do |div|
      @remainder[div] = level % div
    end
  end

  def divisible_by?(divisor)
    @remainder[divisor] == 0
  end

  def add(addend)
    $divisor.values.each do |div|
      @remainder[div] = (@remainder[div] + addend) % div
    end
  end

  def multiply(multiplicand)
    $divisor.values.each do |div|
      @remainder[div] = (@remainder[div] * multiplicand) % div
    end
  end

  def square
    $divisor.values.each do |div|
      @remainder[div] = (@remainder[div] * @remainder[div]) % div
    end
  end

  def inspect
    @remainder.values.to_s
  end
end

file = File.open('input')
file.readlines.each do |line|
  case line
  when /Monkey (.*):/
    munki = $1.to_i
  when /Test: divisible by (\d+)$/
    $divisor[munki] = $1.to_i
  end
end

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
      item.add(addend[munki])
    end
  when /Operation: new = old \* (\d+)$/
    factor[munki] = $1.to_i
    op[munki] = -> (munki) do
      inspections[munki] += 1
      item = items[munki].first
      item.multiply(factor[munki])
    end
  when /Operation: new = old \+ old$/
    op[munki] = -> (munki) do
      inspections[munki] += 1
      item = items[munki].first
      item.multiply(2)
    end
  when /Operation: new = old \* old$/
    op[munki] = -> (munki) do
      inspections[munki] += 1
      item = items[munki].first
      item.square
    end
  when /Test: divisible by (\d+)$/
    # $divisor[munki] = $1.to_i
    test[munki] = -> (munki) do
      item = items[munki].shift
      if item.divisible_by?($divisor[munki])
        puts "  is divisible by #{$divisor[munki]}" if $debug
        items[true_target[munki]] << item
        puts "  thrown to munki #{true_target[munki]}" if $debug
      else
        puts "  is not divisible by #{$divisor[munki]}" if $debug
        items[false_target[munki]] << item
        puts "  thrown to munki #{false_target[munki]}" if $debug
      end
    end
  when /If true: throw to monkey (.*)/
    true_target[munki] = $1.to_i
  when /If false: throw to monkey (.*)/
    false_target[munki] = $1.to_i
  end
end

puts "before: #{items}"
puts

$debug = false

for round in 1..10000
  for munki in munkis
    puts "round #{round} munki #{munki}" if $debug
    while !items[munki].empty?
      op[munki].call(munki)
      test[munki].call(munki)
    end
  end
end

puts "after: #{items}"
puts
puts "inspections: #{inspections}"
puts
puts "munki business: #{inspections.values.max(2).reduce { |a, b| a * b }}"


