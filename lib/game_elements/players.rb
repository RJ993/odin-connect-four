require 'rainbow'
require_relative 'board'

class Player
  attr_accessor :name, :color

  def initialize(color)
    @name = gets.chomp
    @color = color
    @winner = false
  end

  def insert(board)
    puts "#{@name}, where will your piece fall? (Choose a number between 1 and 7)"
    column = gets.chomp.to_i
    until [1, 2, 3, 4, 5, 6, 7].include?(column)
    puts 'Invalid, put a NUMBER between 1 and 7'
    column = gets.chomp.to_i
    end
    next_slot = board.spots[column - 1].index('O')
    board.spots[column - 1].delete_at(next_slot)
    board.spots[column - 1].insert(next_slot, color_the_input('O'))
  end

  def color_the_input(input)
    case color
    when 'red'
      Rainbow(input).color(:crimson)
    when 'yellow'
      Rainbow(input).color(:gold)
    end
  end

  def make_winner
    self.winner = true
  end
end