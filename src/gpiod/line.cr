require "./binding"

module Gpiod
  class Line
    getter chip
    @line : Binding::Line

    def initialize(@chip : Chip, offset)
      @pointer = Binding.chip_get_line(@chip.chip_struct_pointer, offset)
      @line = @pointer.value
    end

    def finalize
      Binding.line_release(@pointer)
    end

    def to_s(io : IO)
      io << "line #{offset}"
    end

    def offset
      @line.offset
    end

    def direction
      @line.direction
    end

    def name
      String.new(@line.name.to_unsafe)
    end

    def consumer
      String.new(@line.consumer.to_unsafe)
    end

    def read
      Binding.line_get_value(@pointer)
    end

    def write(new_value)
      Binding.line_set_value(@pointer, new_value)
    end

    def request_input(consumer = Gpiod.consumer)
      Binding.line_request_input(@pointer, consumer)
    end

    def request_output(consumer = Gpiod.consumer)
      Binding.line_request_output(@pointer, consumer)
    end

    def requested?
      Binding.line_is_requested(@pointer)
    end

    def free?
      Binding.line_is_free(@pointer)
    end
  end
end
