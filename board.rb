require_relative 'errors'
# require_relative 'player'

class Board
  attr_reader :layout
  @@board_count = 0

  def initialize
    @layout = set_board
  end

  def vacant_positions
    layout.select { |spot| vacant?(spot) }
  end

  # def update_board(player)
  #   loop do
  #     puts "Choose from positions #{vacant_positions.join(', ')} to place your avatar: "
  #     position = player.choose_position
  #     begin
  #       raise CustomErrors::InvalidBoardPosition.new unless vacant_positions.include?(position)
  #     rescue CustomErrors::InvalidBoardPosition => e
  #       puts e.message
  #     else
  #       layout[position - 1] = player.avatar
  #       break
  #     end
  #   end
  # end

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
