module Gpiod
  @[Link("gpiod")]
  lib Binding
    struct Chip
      lines : Pointer(Line)
      num_lines : LibC::UInt
      fd : LibC::Int
      name : LibC::Char[32]
      label : LibC::Char[32]
    end

    struct Line
      offset : LibC::UInt
      direction : LibC::Int
      active_state : Bool
      output_value : LibC::Int
      info_flags : UInt32
      req_flags : UInt32
      state : LibC::Int
      chip : Chip*
      fd_handle : LineFdHandle*
      name : LibC::Char[32]
      consumer : LibC::Char[32]
    end

    struct LineFdHandle
      fd : LibC::Int
      refcount : LibC::Int
    end

    fun version_string = gpiod_version_string : LibC::Char*

    # == opening and closing a chip ==

    # returns GPIO chip handle or NULL if an error occurred.
    fun chip_open = gpiod_chip_open(path : LibC::Char*) : Chip*
    fun chip_close = gpiod_chip_close(chip : Chip*)

    # == getting and releasing lines ==

    # returns Pointer to the GPIO line handle or NULL if an error occured.
    fun chip_get_line = gpiod_chip_get_line(chip : Chip*, offset : LibC::UInt) : Line*
    fun line_release = gpiod_line_release(line : Line*)

    # == configuring lines ==

    # returns 0 if the line was properly reserved, -1 on failure.
    fun line_request_input = gpiod_line_request_input(line : Line*, name : LibC::Char*) : LibC::Int
    # returns 0 if the line was properly reserved, -1 on failure.
    fun line_request_output = gpiod_line_request_output(line : Line*, name : LibC::Char*) : LibC::Int
    fun line_is_requested = gpiod_line_is_requested(line : Line*) : Bool
    fun line_is_free = gpiod_line_is_free(line : Line*) : Bool

    # == reading and writing values ==

    # returns 0 or 1 if the operation succeeds. On error this routine returns -1
    fun line_get_value = gpiod_line_get_value(line : Line*) : LibC::Int
    # returns 0 or 1 if the operation succeeds. On error this routine returns -1
    fun line_set_value = gpiod_line_set_value(line : Line*, value : LibC::Int) : LibC::Int
  end
end
