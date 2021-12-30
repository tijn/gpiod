require "../src/gpiod"

puts "Version: #{Gpiod.version}"

Gpiod::Chip.all.each do |chip|
  puts "name: ", chip.name
  puts "label: ", chip.label
  puts "line: ", chip.get_line(0)
end
