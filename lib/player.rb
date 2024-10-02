# frozen_string_literal: true

require_relative 'errors'

# Player class that represents a player in the Tic-Tac-Toe game.
class Player
  include CustomErrors
  attr_reader :avatar

  PLAYER_LIMIT = 1 # Sets the player limit
  @avatars = [] # Create a class variable to keep track of player count

  # Class-level constant to set the maximum limit of players
  class << self
    attr_accessor :avatars
  end

  # Public: Initializes a new Player instance.
  #
  # Returns a new Player object.
  def initialize
    @avatar = set_avatar
    puts "Player #{self.class.avatars.size} chose #{self.class.avatars.last}"
  end

  # Public: Prompts the player to choose a position on the board.
  #
  # Returns an integer representing the chosen position.
  def choose_position
    gets.chomp.to_i
  end

  # private

  # Private: Sets the avatar for the player.
  #
  # Returns a string representing the player's avatar.
  def set_avatar
    avatar = case self.class.avatars
             in []
               set_first_player_avatar # Prompt the first player to choose avatar
             in ['O'] | ['X']
               self.class.avatars.include?('O') ? 'X' : 'O' # Assign the opposite avatar to the second player
             else
               # If more than two players attempt to join, raise an error
               handle_game_violations(PlayerLimitViolation, self.class.avatars.size, PLAYER_LIMIT)
             end
    self.class.avatars << avatar # Add the chosen avatar to the list of avatars
    avatar # Return a chosen avatar
  end

  # Private: Prompts the first player to choose an avatar.
  #
  # Returns a string representing the chosen avatar.
  def set_first_player_avatar
    loop do
      puts 'Choose your avatar (O or X):'
      choice = gets.chomp.upcase # Prompt the player to choose avatar
      return choice if choice.match?(/^[ox]{1}$/i) # Validate the choice to be either 'O' or 'X'

      puts "Please only choose from O and X.\n\n" # Prompt the player to choose a valid avatar
    end
  end
end
