require "./binding"

module Gpiod
  class Line
    getter chip
    @line : Binding::Line

    def initialize(@chip : Chip, offset)
      @pointer = Binding.chip_get_line(@chip.chip_struct_pointer, offset)
      raise "Cannot open gpio line #{offset} of #{chip}" if @pointer.nil?
      @line = @pointer.value
    end

    def finalize
      Binding.line_release(@pointer)
    end

    def to_s(io : IO)
      io << "gpio line #{offset}"
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
      result = Binding.line_get_value(@pointer)
      raise "Reading #{self} failed" if result == -1
      result
    end

    def write(new_value)
      result = Binding.line_set_value(@pointer, new_value)
      raise "Writing #{self} failed" if result == -1
      result
    end

    def high
      write(1)
    end

    def low
      write(0)
    end

    def request_input(consumer = Gpiod.consumer)
      result = Binding.line_request_input(@pointer, consumer)
      raise "Request_input on #{self} failed" unless result.zero?
      self
    end

    def request_output(consumer = Gpiod.consumer)
      result = Binding.line_request_output(@pointer, consumer)
      raise "Request_output on #{self} failed" unless result.zero?
      self
    end

    def requested?
      Binding.line_is_requested(@pointer)
    end

    def free?
      Binding.line_is_free(@pointer)
    end
  end
end
