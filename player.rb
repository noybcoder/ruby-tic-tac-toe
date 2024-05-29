require_relative 'errors'

# Player class that represents a player in the Tic-Tac-Toe game.
class Player
  attr_reader :avatar
  @@avatars = [] # Create a class variable to keep track of player count

  # Public: Initializes a new Player instance.
  #
  # Returns a new Player object.
  def initialize
    @avatar = set_avatar
  end

  # Public: Prompts the player to choose a position on the board.
  #
  # Returns an integer representing the chosen position.
  def choose_position
    gets.chomp.to_i
  end

  private

  # Private: Returns the array of avatars chosen by players.
  #
  # Returns an array of strings representing player avatars.
  def self.avatars
    @@avatars
  end

  # Private: Sets the avatar for the player.
  #
  # Returns a string representing the player's avatar.
  def set_avatar
    if @@avatars.empty? # If no avatars are chosen
      avatar = set_first_player_avatar # Prompt the first player to pick an avatar
      @@avatars << avatar # Add the chosen avatar to the list of avatars
    elsif @@avatars.size == 1 # If one avatar has been chosen
      avatar= @@avatars.include?('O')? 'X': 'O' # Assign the opposite avatar to the second player
      @@avatars << avatar # Add the chosen avatar to the list of avatars
    else
      # If more than two players attempt to join, raise an error
      handle_player_limit_violation
    end
    avatar # Return a chosen avatar
  end

  # Private: Prompts the first player to choose an avatar.
  #
  # Returns a string representing the chosen avatar.
  def set_first_player_avatar
    valid_avatar = false

    until valid_avatar
      puts 'Choose your avatar (O or X): '
      choice = gets.chomp

      if choice.match?(/^[ox]{1}$/i) # Validate the choice to be either 'O' or 'X'
        valid_avatar = true
        return choice.upcase # Return the chosen avatar in uppercase
      else
        puts 'Please only choose from "O" and "X".' # Prompt the player to choose a valid avatar
      end
    end
  end

  # Private: Handles the violation of player limit.
  #
  # Returns nothing.
  def handle_player_limit_violation
    begin
      raise CustomErrors::PlayerLimitViolation.new # Raise an error indicating player limit violation
    rescue CustomErrors::PlayerLimitViolation => e
      puts e.message # Display the error message
      exit # Terminate the program
    end
  end
end
