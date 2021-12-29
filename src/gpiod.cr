require "./gpiod/chip"

module Gpiod
  VERSION = "0.1.0"

  def self.version
    String.new(Binding.version_string)
  end

  def self.consumer
    @@consumer || ""
  end

  def self.consumer=(string : String)
    @@consumer = string
  end

  puts version

  chip = Gpiod::Chip.all.first
  puts "name: ", chip.name
  puts "label: ", chip.label
  puts "line: ", chip.get_line(0)
end
