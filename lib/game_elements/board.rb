class Board
  attr_accessor :spots

def initialize
  @spots = [Array.new(6, 'O'), Array.new(6, 'O'), Array.new(6, 'O'), Array.new(6, 'O'), Array.new(6, 'O'), Array.new(6, 'O')]
end

def to_s
  board_string = ''
  spots.reverse.each do |column|
    board_string += '|'
    column.each do |row|
      board_string += " #{row} |"
    end
    board_string += "\n"
  end
  board_string
end
end