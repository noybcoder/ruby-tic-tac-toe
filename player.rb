require_relative 'errors'

class Player
  attr_reader :avatar
  @@avatars = {}

  def initialize
    @avatar = set_avatar
  end

  def self.avatars
    @@avatars
  end

  def choose_position
    gets.chomp.to_i
  end

  private
  def set_avatar
    if @@avatars.empty?
      avatar = set_first_player_avatar
      @@avatars[avatar] = 'Player 1'
    elsif @@avatars.size == 1
      avatar= @@avatars.key?('O')? 'X': 'O'
      @@avatars[avatar] = 'Player 2'
    else
      handle_player_limit_violation
    end
    avatar
  end

  def set_first_player_avatar
    valid_avatar = false

    until valid_avatar
      puts 'Choose your avatar (O or X): '
      choice = gets.chomp

      if choice.match?(/^[ox]{1}$/i)
        valid_avatar = true
        return choice.upcase
      else
        puts 'Please only choose from "O" and "X".'
      end
    end
  end

  def handle_player_limit_violation
    begin
      raise CustomErrors::PlayerLimitViolation.new
    rescue CustomErrors::PlayerLimitViolation => e
      puts e.message
      exit
    end
  end
end

# player1 = Player.new
# p "Player 1: #{player1.avatar}"

# player2 = Player.new
# p "Player 2: #{player2.avatar}"

# player3 = Player.new
# p "Player 3: #{player3.avatar}"

# p Player.avatars
