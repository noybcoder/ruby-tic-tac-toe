require_relative 'player'
require_relative 'board'
require_relative 'errors'

class Game
  attr_reader :win_conditions
  def initialize
    @win_conditions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
  end

  def update_board(player, board)
    loop do
      vacancies = board.vacant_positions
      puts "Choose from positions #{vacancies.join(', ')} to place your avatar: "
      player_position = player.choose_position

      begin
        raise CustomErrors::InvalidBoardPosition.new unless vacancies.include?(player_position)
      rescue CustomErrors::InvalidBoardPosition => e
        puts e.message
      else
        board.layout[player_position - 1] = player.avatar
        break
      end
    end
  end

  def draw?(board)
    get_game_state(board, 0.upto(8))
  end

  def win?(board)
    get_win_pattern(board).length > 0
  end

  # def get_winner(player, board)

  # end

  private
  def get_win_pattern(board)
    win_conditions.select { |combo| get_game_state(board, combo) }.flatten
  end

  def get_game_state(board, combo)
    board.layout.values_at(*combo).all?(/[ox]/i)
  end


end

player1 = Player.new
board = Board.new
game = Game.new
game.update_board(player1, board)
game.update_board(player1, board)
game.update_board(player1, board)

board.display_board

p game.win?(board)
puts Player.avatars