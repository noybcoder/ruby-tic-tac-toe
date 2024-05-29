require_relative 'errors'

class Board
  attr_reader :layout
  @@board_count = 0

  def initialize
    @layout = Array(1..9)
    @@board_count += 1

    begin
      raise CustomErrors::BoardLimitViolation if @@board_count > 1
    rescue CustomErrors::BoardLimitViolation => e
      puts e.message
      exit
    end
  end

  def vacant_positions
    layout.select { |position| position.is_a?(Integer) }
  end

  def display_board
    layout.each_slice(3).each_with_index do |row, idx|
      puts " #{row.join(' | ')}\n"
      puts '---|---|---' if idx < 2
    end
  end

  private
  def self.board_count
    @@board_count
  end
end
