require './lib/board'

RSpec.describe Board do
  # Stub the handle_game_violations to prevent it from raising an error
  before do
    allow_any_instance_of(Board).to receive(:handle_game_violations)
  end

  subject(:board) { Board.new }

  describe '#vacant_positions' do

    context 'when no player has placed their avatar yet' do
      it 'returns [1, 2, 3, 4, 5, 6, 7, 8, 9]' do
        expect(board.vacant_positions).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
      end
    end

    context 'when some positions are taken in the board' do
      before do
        allow(board).to receive(:layout).and_return([1, 'O', 3, 'X', 5, 'O', 7, 'X', 9])
      end

      it 'returns [1, 3, 5, 7, 9]' do
        expect(board.vacant_positions).to eq([1, 3, 5, 7, 9])
      end
    end

    context 'when the board is full' do
      before do
        allow(board).to receive(:layout).and_return(['O', 'O', 'X', 'X', 'O', 'X', 'O', 'X', 'X'])
      end

      it 'returns []' do
        expect(board.vacant_positions).to eq([])
      end
    end
  end

  describe '#display_board' do

    context 'when no player has placed their avatar yet' do
      it 'returns the following' do
        expected_output = <<~BOARD

          1 | 2 | 3
         ---|---|---
          4 | 5 | 6
         ---|---|---
          7 | 8 | 9
        BOARD

        expect { board.display_board }.to output(expected_output).to_stdout
      end
    end

    context 'when some positions are taken in the board' do
      before do
        allow(board).to receive(:layout).and_return([1, 'O', 3, 'X', 5, 'O', 7, 'X', 9])
      end

      it 'returns the following' do
        expected_output = <<~BOARD

          1 | O | 3
         ---|---|---
          X | 5 | O
         ---|---|---
          7 | X | 9
        BOARD

        expect { board.display_board }.to output(expected_output).to_stdout
      end
    end

    context 'when the board is full' do
      before do
        allow(board).to receive(:layout).and_return(['O', 'O', 'X', 'X', 'O', 'X', 'O', 'X', 'X'])
      end
      it 'returns the following' do

        expected_output = <<~BOARD

          O | O | X
         ---|---|---
          X | O | X
         ---|---|---
          O | X | X
        BOARD

        expect { board.display_board }.to output(expected_output).to_stdout
      end

    end
  end
end
