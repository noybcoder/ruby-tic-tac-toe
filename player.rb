require_relative 'errors'

class Player
  attr_reader :avatar
  @@avatars = []

  def initialize
    @avatar = set_avatar
  end

  def self.avatars
    @@avatars
  end

  private
  def set_avatar
    if @@avatars.length == 0
      avatar = set_first_player_avatar
      @@avatars << avatar
    elsif @@avatars.length == 1
      avatar= @@avatars.include?('O')? 'X': 'O'
      @@avatars << avatar
    else
      begin
        raise CustomErrors::GameRulesViolation.new
      rescue CustomErrors::GameRulesViolation => e
        puts e.message
      end
    end
    avatar
  end

  def set_first_player_avatar
    loop do
      puts 'Choose your avatar (O or X): '
      choice = gets.chomp

      begin
        raise CustomErrors::InvalidAvatarChoice.new unless choice.match(/^[ox]{1}$/i)
      rescue CustomErrors::InvalidAvatarChoice => e
        puts e.message
      else
        return choice.upcase
        break
      end
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
