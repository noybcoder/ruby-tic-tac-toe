require './lib/game'
require './lib/board'

RSpec.describe Game do
  let(:player1) { instance_double(Player, avatar: 'O') }
  let(:player2) { instance_double(Player, avatar: 'X') }
  let(:board) { instance_double(Board, layout: [Array(1..9)]) }
  subject(:game) { Game.new([player1, player2], board) }

  describe '#take_turns' do
    before do
      allow(game).to receive(:win?).and_return(false)
      allow(game).to receive(:draw?).and_return(false)
      allow(board).to receive(:display_board)
    end

    context 'when the players place their avatars in valid board positions' do
      before do
        allow(board).to receive(:vacant_positions).and_return([1, 2, 3, 4, 5, 6, 7, 8, 9])
        allow(player1).to receive(:choose_position).and_return(1)
        allow(player2).to receive(:choose_position).and_return(3)
      end

      it 'prompts player 1 and player 2 to place their avatars on the board' do
        prompt_message = "\nPlayer 1, place X in one of the positions 1, 2, 3, 4, 5, 6, 7, 8, 9:\n" \
                         "\nPlayer 2, place O in one of the positions 1, 2, 3, 4, 5, 6, 7, 8, 9:\n"
        expect { game.take_turns }.to output(prompt_message).to_stdout
      end
    end

    context 'when a player places their avatar in an occupied board position' do
      before do
        allow(board).to receive(:vacant_positions).and_return([1, 3, 5, 7, 9])
        allow(player1).to receive(:choose_position).and_return(4, 1)
        allow(player2).to receive(:choose_position).and_return(7)
      end

      it 'lets the player know the position has been taken' do
        warning = 'The position has been taken.'
        expect{ game.take_turns }.to output(/.*#{warning}.*/).to_stdout
      end
    end

    context 'when an invalid board position is entered' do
      before do
        allow(board).to receive(:vacant_positions).and_return([1, 3, 5, 7, 9])
        allow(player1).to receive(:choose_position).and_return('%', 1)
        allow(player2).to receive(:choose_position).and_return(7)
      end

      it 'notifies the player that the position is not valid' do
        warning = 'The position is not valid.'
        expect{ game.take_turns }.to output(/.*#{warning}.*/).to_stdout
      end
    end
  end

  describe '#draw?' do

    context 'given there is no vacancy in the board' do
      before do
        allow(board).to receive(:vacant_positions).and_return([])
      end
      context 'when no player is winning' do
        it 'returns true' do
          allow(game).to receive(:win?).and_return(false)
          expect(game.draw?).to be(true)
        end
      end

      context 'when one of the players is winning' do
        it 'returns false' do
          allow(game).to receive(:win?).and_return(true)
          expect(game.draw?).to be(false)
        end
      end
    end

    context 'given there are vacancies in the board' do
      before do
        allow(board).to receive(:vacant_positions).and_return([4, 7])
      end
      context 'when no player is winning' do
        it 'returns false' do
          allow(game).to receive(:win?).and_return(false)
          expect(game.draw?).to be(false)
        end
      end

      context 'when one of the players is winning' do
        it 'returns false' do
          allow(game).to receive(:win?).and_return(true)
          expect(game.draw?).to be(false)
        end
      end
    end
  end

  describe '#win?' do
    context 'when a winning pattern is provided' do
      before do
        allow(game).to receive(:display_winning_pattern).and_return([0, 3, 6])
      end
      it 'returns true' do
        expect(game.win?).to be(true)
      end
    end

    context 'when a winning pattern is not provided' do
      before do
        allow(game).to receive(:display_winning_pattern).and_return([])
      end

      it 'returns false' do
        expect(game.win?).to be(false)
      end
    end


  end

  let(:player1) { instance_double(Player, avatar: 'X') }
  let(:player2) { instance_double(Player, avatar: 'O') }
  let(:board) { instance_double(Board, layout: ['X', 2, 'O', 'X', 5, 'O', 'X', 8, 'O']) }
  subject(:game) { Game.new([player1, player2], board) }

  describe '#display_winner' do
    context 'when indices 1, 4 and 8 are filled with "X"' do
      it 'returns [1, 4, 7]' do
        allow(board).to receive(:layout).and_return([1, 'X', 3, 4, 'X', 6, 7, 'X', 9])
        expect(game.display_winning_pattern).not_to be_empty
        expect{ game.display_winner }.to output("\nPlayer 1 is the winner!\n").to_stdout
      end
    end

    context 'when indices 2, 4 and 6 are filled with "O"' do
      it 'prints message indicating that player 1 is the winner' do
        allow(board).to receive(:layout).and_return([1, 2, 'O', 4, 'O', 6, 'O', 8, 9])
        expect(game.display_winning_pattern).not_to be_empty
        expect{ game.display_winner }.to output("\nPlayer 2 is the winner!\n").to_stdout
      end
    end

    context 'when no winning combination is found' do
      it 'does not print a winner' do
        allow(board).to receive(:layout).and_return(['X', 'O', 'O', 'O', 'X', 'X', 'X', 'X', 'O'])
        expect(game.display_winning_pattern).to be_empty
        expect{ game.display_winner }.not_to output.to_stdout
      end
    end
  end

  describe '#display_winning_pattern' do
    context 'when indices 1, 4 and 8 are filled with "X"' do
      it 'returns [1, 4, 7]' do
        allow(board).to receive(:layout).and_return([1, 'X', 3, 4, 'X', 6, 7, 'X', 9])
        expect(game.display_winning_pattern).to eq([1, 4, 7])
      end
    end

    context 'when indices 2, 4 and 6 are filled with "O"' do
      it 'returns [2, 4, 6]' do
        allow(board).to receive(:layout).and_return([1, 2, 'O', 4, 'O', 6, 'O', 8, 9])
        expect(game.display_winning_pattern).to eq([2, 4, 6])
      end
    end

    context 'when no winning combination is found' do
      it 'returns []' do
        allow(board).to receive(:layout).and_return(['X', 'O', 'O', 'O', 'X', 'X', 'X', 'X', 'O'])
        expect(game.display_winning_pattern).to eq([])
      end
    end
  end

  describe '#winning_pattern?' do
    context 'when indices 0, 3 and 6 are occupied by player 1\'s avatar "X"' do
      it 'returns true' do
        expect(game.winning_pattern?([0, 3, 6])).to be(true)
      end
    end

    context 'when indices 2, 5 and 8 are occupied by player 2\'s avatar "X"' do
      it 'returns false' do
        expect(game.winning_pattern?([2, 5, 8])).to be(true)
      end
    end

    context 'when indices 0, 4 and 8 are occupied by ["X", 5, "O"]' do
      it 'returns false' do
        expect(game.winning_pattern?([0, 4, 8])).to be(false)
      end
    end
  end

  describe '#same_pattern?' do
    context 'when indices 0, 3 and 6 are occupied by player 1\'s avatar "X"' do
      it 'returns true' do
        expect(game.same_pattern?([0, 3, 6], player1)).to be(true)
      end
    end

    context 'when indices 2, 5 and 8 are occupied by player 2\'s avatar "X"' do
      it 'returns false' do
        expect(game.same_pattern?([2, 5, 8], player2)).to be(true)
      end
    end

    context 'when indices 0, 4 and 8 are occupied by ["X", 5, "O"] and compared to "X" ' do
      it 'returns false' do
        expect(game.same_pattern?([0, 4, 8], player1)).to be(false)
      end
    end

    context 'when indices 0, 4 and 8 are occupied by ["X", 5, "O"] and compared to "O" ' do
      it 'returns false' do
        expect(game.same_pattern?([0, 4, 8], player2)).to be(false)
      end
    end
  end
end
