require_relative 'player'
require_relative 'board'
require_relative 'errors'

class Game
  attr_reader :players, :board, :win_conditions
  def initialize(players, board)
    @players = players
    @board = board
    @win_conditions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
  end

  def update_board(player)
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

  def draw?
    board.layout.none?(/\d/i)
  end

  def win?
    get_win_pattern.length > 0
  end

  def get_winner
    Player.avatars[board.layout[get_win_pattern[0]]]
  end


  def get_win_pattern
    win_conditions.select { |combo| get_game_state(combo) }.flatten
  end

  private
  def get_game_state(combo)
    board.layout.values_at(*combo).all?(/o/i) || board.layout.values_at(*combo).all?(/x/i)
  end


end

player1 = Player.new
player2 = Player.new
board = Board.new
game = Game.new([player1, player2], board)

loop do
  if game.win?
    puts game.get_win_pattern
    break
  elsif game.draw?
    puts 'It is a draw.'
    break
  end
  game.update_board(player1)
  board.display_board

  game.update_board(player2)
  board.display_board

end
