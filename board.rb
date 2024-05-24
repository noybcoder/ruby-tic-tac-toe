require_relative 'errors'

class Board
  attr_reader :layout
  @@board_count = 0

  def initialize
    @layout = set_board
  end

  def display_board
    layout.each_slice(3).each_with_index do |row, idx|
      puts " #{row.join(' | ')}"
      puts '---|---|---' if idx < 2
    end
  end

  private
  def set_board
    if @@board_count == 0
      layout = Array(1..9)
      @@board_count += 1
    else
      begin
        raise CustomErrors::GameRulesViolation.new('Each Tic-tac-toe game only allows 1 board.')
      rescue CustomErrors::GameRulesViolation => e
        puts e.message
      end
    end
    layout
  end

  def self.board_count
    @@board_count
  end
end

board1 = Board.new
board1.display_board
