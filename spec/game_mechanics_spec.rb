require 'rspec'
require_relative '../lib/game_mechanics'

describe Game do
  subject(:game) {described_class.new}
  describe '#first?' do
    context 'when red wants to go first' do
      before do
        allow(game).to receive(:gets).and_return('r')
      end
      it 'makes red go first' do
        expect {game.first?}.to change{game.first}.to(game.red_player)
      end
    end
    context "when yellow wants to go first but types in \"yellow\" two times instead of \"y\" two times" do
      before do
        allow(game).to receive(:gets).and_return('yellow', 'yellow', 'y')
      end
      it 'makes yellow go first' do
        expect {game.first?}.to change{game.first}.to(game.yellow_player)
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
        allow(game.red_player).to receive(:gets).and_return('1', '1', '1', '1')
        allow(game.yellow_player).to receive(:gets).and_return('2', '2', '3')
      end
      xit 'should fill column one with four reds' do
        expect {game.play}.to change {board.spots[1]}.to([Rainbow('O').color(:crimson), Rainbow('O').color(:crimson), Rainbow('O').color(:crimson), Rainbow('O').color(:crimson), 'O', 'O'])
      end
      xit 'should fill column two with two yellows' do
        expect {game.play}.to change {board.spots[1]}.to([Rainbow('O').color(:gold), Rainbow('O').color(:gold), 'O', 'O', 'O', 'O'])
      end
      xit 'should fill column three with one yellow' do
        expect {game.play}.to change {board.spots[2][0]}.to(Rainbow('O').color(:gold))
      end
      xit 'should expect 7 calls of insert' do
        expect(game).to receive(:insert).exactly(7).times
        game.play
      end
      xit 'should increase spots_occupied to be 7' do
        expect {game.play}.to change {spots_occupied}.to(7)
      end
    end
  end

  describe '#determine_winner' do
    context 'when red has winning combos' do
      xit 'detect a vertical winning combo' do
        board.spots.delete_at(0)
        board.spots.insert(0, [Rainbow('O').color(:crimson), Rainbow('O').color(:crimson), Rainbow('O').color(:crimson), Rainbow('O').color(:crimson), 'O', 'O'])
        expect {game.determine_winner}.to change {game.red_player.winner}.to(true)
      end
      xit 'detect a horizontal winning combo' do
        board.spots[0].delete_at(0)
        board.spots[0].insert(0, Rainbow('O').color(:crimson))
        board.spots[1].delete_at(0)
        board.spots[1].insert(0, Rainbow('O').color(:crimson))
        board.spots[2].delete_at(0)
        board.spots[2].insert(0, Rainbow('O').color(:crimson))
        board.spots[3].delete_at(0)
        board.spots[3].insert(0, Rainbow('O').color(:crimson))
        expect {game.determine_winner}.to change {game.red_player.winner}.to(true)
      end
      xit 'detect a diagonal winning combo' do
        board.spots[0].delete_at(0)
        board.spots[0].insert(0, Rainbow('O').color(:crimson))
        board.spots[1].delete_at(1)
        board.spots[1].insert(1, Rainbow('O').color(:crimson))
        board.spots[2].delete_at(2)
        board.spots[2].insert(2, Rainbow('O').color(:crimson))
        board.spots[3].delete_at(3)
        board.spots[3].insert(3, Rainbow('O').color(:crimson))
        expect {game.determine_winner}.to change {game.red_player.winner}.to(true)
      end
    end
  end
end