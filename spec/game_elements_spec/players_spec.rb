require 'rspec'
require_relative '../../lib/game_elements/players'
require_relative '../../lib/game_elements/board'
require 'rainbow'

describe Player do
  subject(:dummy) { described_class.new('red') }
  let(:board) { Board.new }
  describe '#insert' do
    context 'when player has put 4 invalid inputs' do
      before do
        allow(dummy).to receive(:gets).and_return('jim', 'jim', 'jim', 'jim', '1')
      end

      it 'changes the bottom of column 1' do
        expect { dummy.insert(board) }.to change { board.spots[0][0] }.to(Rainbow('O').color(:crimson))
      end

      it 'cycles through 4 invalid inputs' do
        expect(dummy).to receive(:gets).exactly(5).times
        dummy.insert(board)
      end
    end
  end
end
