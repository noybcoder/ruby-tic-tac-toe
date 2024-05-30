require './lib/game'

# Create two players
player1 = Player.new
player2 = Player.new

# Create a new game board
board = Board.new

# Create a new game instance with the players and board
game = Game.new([player1, player2], board)

# Initialize round counter
round = 1

# Start the game loop
loop do
  puts "\nRound #{round}:" # Display the current round
  game.take_turns # Players take turns placing their markers on the board

  if game.win? # Check if there is a winner
    game.get_winner # Reveal the winner
    break # Game over
  elsif game.draw? # Check if it is a draw
    puts '\nIt is a draw.' # Notify the players
    break # Game over
  end
  round += 1 # Increment the round counter
end
