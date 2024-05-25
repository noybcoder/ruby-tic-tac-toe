require_relative 'player'
require_relative 'board'
require_relative 'errors'

class Game
  # def initialize(player, board)
  #   @player = player
  #   @board = board
  # end

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
end

player1 = Player.new
board = Board.new
game = Game.new
game.update_board(player1, board)
board.display_board
