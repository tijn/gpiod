require "../src/gpiod"

puts "Version: #{Gpiod.version}"

chip = Gpiod::Chip.all.first
puts "name: ", chip.name
puts "label: ", chip.label
puts "line: ", chip.get_line(0)
