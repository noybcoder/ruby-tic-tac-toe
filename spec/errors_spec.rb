require './lib/errors'

RSpec.describe CustomErrors do
  include CustomErrors  # Include the module

  describe '#handle_game_violations' do
    let(:player_limit_error) { CustomErrors::PlayerLimitViolation }

    context 'when the number of players is less than the limit' do
      it 'does not raise an error' do
        expect { handle_game_violations(player_limit_error, 1, 2) }.not_to raise_error
      end
    end

    context 'when the number of players equals the limit' do
      it 'does not raise an error' do
        expect { handle_game_violations(player_limit_error, 2, 2) }.not_to raise_error
      end
    end

    context 'when the number of players exceeds the limit' do
      it 'raises a PlayerLimitViolation error' do
        expect { handle_game_violations(player_limit_error, 3, 2) }
          .to raise_error(player_limit_error, 'Tic-tac-toe only allows up to 2 players.')
      end
    end

    let(:board_limit_error) { CustomErrors::BoardLimitViolation }

    context 'when the number of board(s) is equal to the limit' do
      it 'does not raise an error' do
        expect { handle_game_violations(player_limit_error, 1, 1) }.not_to raise_error
      end
    end

    context 'when the number of board(s) exceeds the limit' do
      it 'raises a BoardLimitViolation error' do
        expect { handle_game_violations(board_limit_error, 3, 2) }
          .to raise_error(board_limit_error, 'Tic-tac-toe only allows 1 board.')
      end
    end
  end
end
