require_relative 'player'

player1 = Player.new
p "Player 1: #{player1.avatar}"

player2 = Player.new
p "Player 2: #{player2.avatar}"

player3 = Player.new
p "Player 3: #{player3.avatar}"

p Player.avatars
