require_relative 'player'
require_relative 'board'

# Game class represents the logic and flow of a Tic-Tac-Toe game.
class Game
  attr_reader :players, :board, :win_conditions

  # Public: Initializes a new Game instance.
  #
  # players - An array of Player objects representing the players of the game.
  # board   - A Board object representing the game board.
  #
  # Returns a new Game object.
  def initialize(players, board)
    @players = players
    @board = board
    @win_conditions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], # Set up win conditions for rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], # Set up win conditions for columns
      [0, 4, 8], [2, 4, 6] # Set up win conditions for diagonals
    ]
  end

  # Public: Allows players to take turns placing their markers on the board.
  #
  # Returns nothing.
  def take_turns
    players.each_with_index do |player, idx|
      loop do
        vacancies = board.vacant_positions
        break if win? || draw? # Stop the game when there is a winner or if it is a draw

        # Ask the player to place their avatar on the board
        puts "Player #{idx + 1}, place #{player.avatar} in one of the positions #{vacancies.join(', ')}: "
        player_position = player.choose_position
        valid_position = vacancies.include?(player_position)

        # If the player chooses a valid position on the board
        if valid_position
          board.layout[player_position - 1] = player.avatar # Mark the position with the player's avatar
          board.display_board # Show the current board layout
          break
        # Notify the player if the position on the board is taken
        elsif player_position.between?(1, 9) && !valid_position
          puts 'The position has been taken.'
        # Notify the player if the position on the board is invalid
        else
          puts 'The position is not valid.'
        end
      end
    end
  end

  # Public: Checks if the game has ended in a draw.
  #
  # Returns true if the game is a draw, otherwise false.
  def draw?
    board.vacant_positions.empty? && !win?
  end

  # Public: Checks if a player has won the game.
  #
  # Returns true if a player has won, otherwise false.
  def win?
    get_winning_pattern.size > 0
  end

  # Public: Determines the winner of the game and displays the result.
  #
  # Returns nothing.
  def get_winner
    winning_avatar = board.layout[get_winning_pattern[0]] # Retrieve the winner's avatar
    # Look up the index of the winner
    winner_index = players.map { |player| player.avatar }.find_index(winning_avatar)
    puts "Player #{winner_index + 1} is the winner!" # Reveal the winner
  end

  private

  # Private: Finds the winning pattern on the board.
  #
  # Returns an array containing the winning positions, or an empty array if no winner.
  def get_winning_pattern
    win_conditions.select { |combo| winning_pattern(combo) }.flatten
  end

  # Private: Checks if a specific player has achieved a winning pattern on the board.
  #
  # combo  - An array representing a winning combination of positions.
  # player - The avatar of the player to check for.
  #
  # Returns true if the player has a winning pattern, otherwise false.
  def winning_pattern(combo)
    same_pattern?(combo, players[0]) || same_pattern?(combo, players[1])
  end

  # Private: Checks if all positions in a combo have the same marker.
  #
  # combo  - An array representing a combination of positions on the board.
  # player - The avatar of the player to check for.
  #
  # Returns true if all positions have the player's marker, otherwise false.
  def same_pattern?(combo, player)
    board.layout.values_at(*combo).all?(player.avatar)
  end
end
