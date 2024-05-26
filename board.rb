require_relative 'errors'

class Board
  attr_reader :layout
  @@board_count = 0

  def initialize
    @layout = set_board
  end

  def vacant_positions
    layout.select { |spot| vacant?(spot) }
  end

  def display_board
    layout.each_slice(3).each_with_index do |row, idx|
      puts " #{row.join(' | ')}\n"
      puts '---|---|---' if idx < 2
    end
  end

  private
  def vacant?(element)
    element.to_s.match?(/^\d$/)
  end

  def set_board
    if @@board_count == 0
      layout = Array(1..9)
      @@board_count += 1
    else
      begin
        raise CustomErrors::BoardLimitViolation
      rescue CustomErrors::BoardLimitViolation => e
        puts e.message
      end
    end
    layout
  end

  def self.board_count
    @@board_count
  end
end

# player1 = Player.new

# board1 = Board.new
# board1.update_board(player1)
# board1.display_board
