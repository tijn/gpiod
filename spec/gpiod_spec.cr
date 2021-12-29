require "./spec_helper"

describe Gpiod do
  # TODO: Write tests

  it "works" do
    false.should eq(true)

    chip = Gpiod::Chip.new("/dev/gpiochip0")
    puts "name: ", chip.name
    puts "label: ", chip.label
  end
end
