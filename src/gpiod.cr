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
end
