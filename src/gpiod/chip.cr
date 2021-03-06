require "./binding"
require "./line"

module Gpiod
  class Chip
    @chip : Binding::Chip
    getter path

    def initialize(@path : String)
      @pointer = Binding.chip_open(@path)
      raise "Cannot open gpio chip #{@path}" if @pointer.nil?
      @chip = @pointer.value
    end

    def finalize
      Binding.chip_close(@pointer)
    end

    def self.all
      Dir.glob("/dev/gpiochip*").sort.map { |path| new(path) }
    end

    def to_s(io : IO)
      io << "gpio chip #{@path}"
    end

    def name
      String.new(@chip.name.to_unsafe)
    end

    def label
      String.new(@chip.label.to_unsafe)
    end

    def get_line(offset) : Line
      Line.new(self, offset)
    end

    def chip_struct
      @chip
    end

    def chip_struct_pointer
      @pointer
    end

    private def chars_to_string(array = StaticArray(Char))
      array
        .select { |char| char.ord > 0 }
        .map { |char| char.to_s }.join
    end
  end
end
