require './lib/player'
require './lib/errors'

RSpec.describe Player do
  describe '#set_avatar' do
    subject(:player1) { Player.new }

    context 'when player 1 decides to choose "O"' do
      before do
        allow_any_instance_of(Player).to receive(:gets).and_return('O') # Mock user input to be "O"
        allow(Player).to receive(:avatars).and_return([]) # Ensure Player class starts with no avatars
      end

      it 'assigns "O" as the avatar for player 1' do
        expect(player1.avatar).to eq('O') # Check that the player's avatar is set correctly
        expect(Player.avatars).to eq(['O']) # Ensure that the avatar is added to the class-level avatars array
      end
    end

    context 'when player 1 decides to choose "X"' do
      before do
        allow_any_instance_of(Player).to receive(:gets).and_return('X')
        allow(Player).to receive(:avatars).and_return([])
      end

      it 'assigns "O" as the avatar for player 1' do
        expect(player1.avatar).to eq('X')
        expect(Player.avatars).to eq(['X'])
      end
    end

    context 'when player 1 has chosen "O" as their avatar' do
      before do
        allow_any_instance_of(Player).to receive(:gets).and_return('O')
        allow(Player).to receive(:avatars).and_return([])
      end

      it 'assigns "X" as the avatar for player 2' do
        player1 = Player.new
        expect(player1.avatar).to eq('O')
        expect(Player.avatars).to eq(['O']) # Player 1's avatar is stored

        player2 = Player.new
        expect(player2.avatar).to eq('X') # Player 2 should automatically get "X"
        expect(Player.avatars).to eq(['O', 'X']) # Check that both avatars are stored correctly
      end
    end

    context 'when player 1 has chosen "X" as their avatar' do
      before do
        allow_any_instance_of(Player).to receive(:gets).and_return('X')
        allow(Player).to receive(:avatars).and_return([])
      end

      it 'assigns "X" as the avatar for player 2' do
        player1 = Player.new
        expect(player1.avatar).to eq('X')
        expect(Player.avatars).to eq(['X']) # Player 1's avatar is stored

        player2 = Player.new
        expect(player2.avatar).to eq('O') # Player 2 should automatically get "O"
        expect(Player.avatars).to eq(['X', 'O']) # Check that both avatars are stored correctly
      end
    end

    context 'when a third player attempts to join' do
      it 'raises a PlayerLimitViolation error' do
        # Mock gets for player 1 and 2
        allow_any_instance_of(Player).to receive(:gets).and_return("O")
        Player.new
        Player.new
        # Test for PlayerLimitViolation when attempting to create a third player
        expect { Player.new }.to raise_error(CustomErrors::PlayerLimitViolation, 'Tic-tac-toe only allows up to 2 players.')
      end
    end

  end

  subject(:player) { Player.allocate } # Allocate memory for the player object without calling initialize

  describe '#set_first_player_avatar' do
    context 'when the first player enters "x" as avatar' do
      before do
        allow(player).to receive(:gets).and_return('x')
      end

      it 'stops the loop and no error message is shown' do
        prompt_message = 'Choose your avatar (O or X):'
        error_message = "Please only choose from O and X.\n\n"

        expect(player).to receive(:puts).with(prompt_message)
        expect(player).not_to receive(:puts).with(error_message)
        player.set_first_player_avatar
      end
    end

    context 'when the first player enters "o" as avatar' do
      before do
        allow(player).to receive(:gets).and_return('o')
      end

      it 'stops the loop and no error message is shown' do
        prompt_message = 'Choose your avatar (O or X):'
        error_message = "Please only choose from O and X.\n\n"

        expect(player).to receive(:puts).with(prompt_message)
        expect(player).not_to receive(:puts).with(error_message)
        player.set_first_player_avatar
      end
    end

    context 'when the first player enters "X" as avatar' do
      before do
        allow(player).to receive(:gets).and_return('X')
      end

      it 'stops the loop and no error message is shown' do
        prompt_message = 'Choose your avatar (O or X):'
        error_message = "Please only choose from O and X.\n\n"

        expect(player).to receive(:puts).with(prompt_message)
        expect(player).not_to receive(:puts).with(error_message)
        player.set_first_player_avatar
      end
    end

    context 'when the first player enters "O" as avatar' do
      before do
        allow(player).to receive(:gets).and_return('O')
      end

      it 'stops the loop and no error message is shown' do
        prompt_message = 'Choose your avatar (O or X):'
        error_message = "Please only choose from O and X.\n\n"

        expect(player).to receive(:puts).with(prompt_message)
        expect(player).not_to receive(:puts).with(error_message)
        player.set_first_player_avatar
      end
    end

    context 'when the first player enters "@" as avatar' do
      before do
        allow(player).to receive(:gets).and_return('@', 'x')
      end

      it 'stops the loop and no error message is shown' do
        prompt_message = 'Choose your avatar (O or X):'
        error_message = "Please only choose from O and X.\n\n"

        expect(player).to receive(:puts).with(prompt_message).twice
        expect(player).to receive(:puts).with(error_message).once
        player.set_first_player_avatar
      end
    end
  end

  describe '#choose_position' do
    context 'when the player enters the integer 4 as the input' do
      it 'returns the integer 4' do
        allow(player).to receive(:gets).and_return('4')
        expect(player.choose_position).to eq(4)
      end
    end

    context 'when the player enters the letter "w" as the input' do
      it 'returns the integer 0' do
        allow(player).to receive(:gets).and_return('w')
        expect(player.choose_position).to be_zero
      end
    end
  end

end
