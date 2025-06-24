class Board
  attr_accessor :spots

def initialize
  @spots = [Array.new(6, 'O'), Array.new(6, 'O'), Array.new(6, 'O'), Array.new(6, 'O'), Array.new(6, 'O'), Array.new(6, 'O'), Array.new(6, 'O')]
end

def to_s
  board_string = ''
  column = 0
  spots[0].each_index do |row|
    board_string += '|'
    7.times do
      board_string += " #{spots[column].reverse[row]} |"
      column += 1
    end
    column = 0
    board_string += "\n"
  end
  board_string
end
end