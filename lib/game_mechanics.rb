require_relative 'game_elements/board'
require_relative 'game_elements/players'

class Game
  attr_reader :red_player, :yellow_player, :board
  attr_accessor :spots_occupied, :first, :second

  def initialize
    puts 'Who will be the red pieces?'
    @red_player = Player.new('red')
    puts 'Who will be the yellow pieces?'
    @yellow_player = Player.new('yellow')
    @board = Board.new
    @spots_occupied = 0
    @first = ''
    @second = ''
  end

  def play
    first?
    puts board
    while red_player.winner == false && yellow_player.winner == false && spots_occupied < 42
      first.insert(board)
      current_stats
      return unless red_player.winner == false && yellow_player.winner == false && spots_occupied < 42
      second.insert(board)
      current_stats
    end
    declare_winner
  end

  def first?
    until %w[r y].include?(first)
      puts 'Who is first? Red or yellow (R, Y)?'
      @first = gets.chomp.downcase
    end
    if first == 'r'
      @first = red_player
      @second = yellow_player
    elsif first == 'y'
      @first = yellow_player
      @second = red_player
    end
  end

  def current_stats
    puts board
    @spots_occupied += 1
    determine_winner
  end

  def determine_winner
    board.spots.each_with_index do |column, column_number|
      column.each_index do |row_number|
        look_at_diagonal(column_number, row_number)
        look_at_vertical(column_number, row_number)
        look_at_horizontal(column_number, row_number)
      end
    end
  end

  def look_at_diagonal(column, row)
    
  end

  def look_at_vertical(column, row)
    
  end

  def look_at_horizontal(column, row)
    
  end

  def declare_winner
    puts "#{red_player.name} is the winner!!!" if red_player.winner == true
    puts "#{yellow_player.name} is the winner!!!" if yellow_player.winner == true
    return unless red_player.winner == false && yellow_player.winner == false

    puts 'Draw!!!'
  end
end