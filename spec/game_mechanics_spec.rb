require 'rspec'
require_relative '../lib/game_mechanics'

describe Game do
  subject(:game) { described_class.new }
  describe '#first?' do
    context 'when red wants to go first' do
      before do
        allow(game).to receive(:gets).and_return('r')
      end
      it 'makes red go first' do
        expect { game.first? }.to change { game.first }.to(game.red_player)
      end
    end
    context 'when yellow wants to go first but types in "yellow" two times instead of "y" two times' do
      before do
        allow(game).to receive(:gets).and_return('yellow', 'yellow', 'y')
      end
      it 'makes yellow go first' do
        expect { game.first? }.to change { game.first }.to(game.yellow_player)
      end

      it 'cycles through 3 inputs' do
        expect(game).to receive(:gets).exactly(3).times
        game.first?
      end
    end
  end

  describe '#play' do
    context 'when red is first' do
      before do
        allow(game).to receive(:gets).and_return('r')
        allow(game.red_player).to receive(:gets).and_return('1', '1', '1', '1')
        allow(game.yellow_player).to receive(:gets).and_return('2', '2', '3')
      end
      it 'should fill column one with four reds' do
        expect { game.play }.to change {
          game.board.spots[0]
        }.to([Rainbow('O').color(:crimson), Rainbow('O').color(:crimson), Rainbow('O').color(:crimson),
              Rainbow('O').color(:crimson), 'O', 'O'])
      end
      it 'should fill column two with two yellows' do
        expect { game.play }.to change {
          game.board.spots[1]
        }.to([Rainbow('O').color(:gold), Rainbow('O').color(:gold), 'O', 'O', 'O', 'O'])
      end
      it 'should fill column three with one yellow' do
        expect { game.play }.to change { game.board.spots[2][0] }.to(Rainbow('O').color(:gold))
      end
      it 'should increase spots_occupied to be 7' do
        expect { game.play }.to change { game.spots_occupied }.to(7)
      end
    end
  end

  describe '#determine_winner' do
    context 'when red has winning combos' do
      it 'detect a vertical winning combo' do
        game.board.spots.delete_at(0)
        game.board.spots.insert(0,
                                [Rainbow('O').color(:crimson), Rainbow('O').color(:crimson), Rainbow('O').color(:crimson),
                                 Rainbow('O').color(:crimson), 'O', 'O'])
        expect { game.determine_winner }.to change { game.red_player.winner }.to(true)
      end
      it 'detect a horizontal winning combo' do
        game.board.spots[0].delete_at(0)
        game.board.spots[0].insert(0, Rainbow('O').color(:crimson))
        game.board.spots[1].delete_at(0)
        game.board.spots[1].insert(0, Rainbow('O').color(:crimson))
        game.board.spots[2].delete_at(0)
        game.board.spots[2].insert(0, Rainbow('O').color(:crimson))
        game.board.spots[3].delete_at(0)
        game.board.spots[3].insert(0, Rainbow('O').color(:crimson))
        expect { game.determine_winner }.to change { game.red_player.winner }.to(true)
      end
      it 'detect a diagonal winning combo' do
        game.board.spots[0].delete_at(0)
        game.board.spots[0].insert(0, Rainbow('O').color(:crimson))
        game.board.spots[1].delete_at(1)
        game.board.spots[1].insert(1, Rainbow('O').color(:crimson))
        game.board.spots[2].delete_at(2)
        game.board.spots[2].insert(2, Rainbow('O').color(:crimson))
        game.board.spots[3].delete_at(3)
        game.board.spots[3].insert(3, Rainbow('O').color(:crimson))
        expect { game.determine_winner }.to change { game.red_player.winner }.to(true)
      end
    end
  end
end
