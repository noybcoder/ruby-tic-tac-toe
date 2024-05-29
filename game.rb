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

  def take_turns
    players.each_with_index do |player, idx|
      loop do
        vacancies = board.vacant_positions
        break if win? || draw?

        puts "Player #{idx + 1}, place #{player.avatar} in one of the positions #{vacancies.join(', ')}: "
        player_position = player.choose_position
        valid_position = vacancies.include?(player_position)

        if valid_position
          board.layout[player_position - 1] = player.avatar
          break
        elsif player_position.between?(1, 9) && !valid_position
          puts 'The position has been taken.'
        else
          puts 'The position is not valid.'
        end
      end
    end
  end

  def draw?
    board.vacant_positions.empty? && !win?
  end

  def win?
    get_winning_pattern.size > 0
  end

  def get_winner
    winning_avatar = board.layout[get_winning_pattern[0]]
    winner_index = players.map { |player| player.avatar }.find_index(winning_avatar)
    puts "Player #{winner_index + 1} is the winner!"
  end

  private
  def get_winning_pattern
    win_conditions.select { |combo| winning_pattern(combo) }.flatten
  end

  def winning_pattern(combo)
    board.layout.values_at(*combo).all?(/o/i) || board.layout.values_at(*combo).all?(/x/i)
  end
end

player1 = Player.new
player2 = Player.new
board = Board.new
game = Game.new([player1, player2], board)

round = 1

loop do
  puts "Round #{round}:\n"
  game.take_turns
  puts "\n"
  board.display_board
  puts "\n"

  if game.win?
    game.get_winner
    break
  elsif game.draw?
    puts 'It is a draw.'
    break
  end
  round += 1
end
