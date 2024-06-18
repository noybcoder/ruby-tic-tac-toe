# frozen_string_literal: true

require_relative 'errors'

# Board class that represents a game board in the Tic-Tac-Toe game.
class Board
  attr_reader :layout

  BOARD_LIMIT = 1 # Set the maximum limit of board

  class << self # Class-level constant to set the maximum limit of board
    attr_accessor :board_count
  end

  # Public: Initializes a new Board instance.
  #
  # Returns a new Board object.
  def initialize
    self.class.board_count ||= 0 # Ensures board count is not nil
    self.class.board_count += 1 # Increment the board count
    @layout = Array(1..9) # Initialize the board layout with positions 1 to 9

    begin
      # Raise error if more than one board instance is created
      raise CustomErrors::BoardLimitViolation if self.class.board_count > BOARD_LIMIT
    rescue CustomErrors::BoardLimitViolation => e
      puts e.message # Display the error message
      exit # Terminate the program
    end
  end

  # Public: Returns an array of vacant positions on the board.
  #
  # Returns an array of integers representing vacant positions.
  def vacant_positions
    layout.select { |position| position.is_a?(Integer) }
  end

  # Public: Displays the current state of the board.
  #
  # Displays the board layout with positions and markers.
  def display_board
    puts "\n"
    layout.each_slice(3).each_with_index do |row, idx|
      puts " #{row.join(' | ')}"
      puts '---|---|---' if idx < 2
    end
  end
end
