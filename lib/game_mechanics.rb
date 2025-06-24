require_relative 'game_elements/board'
require_relative 'game_elements/players'
require 'rainbow'

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
    while red_player.winner == false && yellow_player.winner == false && spots_occupied != 42
      first.insert(board)
      current_stats
      if red_player.winner == false && yellow_player.winner == false && spots_occupied != 42
        second.insert(board)
        current_stats
      end
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
        look_at_upward_diagonal(column_number, row_number)
        look_at_downward_diagonal(column_number, row_number)
        look_at_vertical(column_number, row_number)
        look_at_horizontal(column_number, row_number)
      end
    end
  end

  def look_at_upward_diagonal(column, row)
    one = board.spots[column][row] if board.spots[column] != nil
    two = board.spots[column + 1][row + 1] if board.spots[column + 1] != nil
    three = board.spots[column + 2][row + 2] if board.spots[column + 2] != nil
    four = board.spots[column + 3][row + 3] if board.spots[column + 3] != nil
    array = [one, two, three, four]
    array.delete(nil)
    return if array.length != 4
    red_player.make_winner if array.all? {|spot| spot == Rainbow('O').color(:crimson)}
    yellow_player.make_winner if array.all? {|spot| spot == Rainbow('O').color(:gold)}
  end

  def look_at_downward_diagonal(column, row)
    one = board.spots[column][row] if board.spots[column] != nil
    two = board.spots[column + 1][row - 1] if board.spots[column + 1] != nil
    three = board.spots[column + 2][row - 2] if board.spots[column + 2] != nil
    four = board.spots[column + 3][row - 3] if board.spots[column + 3] != nil
    array = [one, two, three, four]
    array.delete(nil)
    return if array.length != 4
    red_player.make_winner if array.all? {|spot| spot == Rainbow('O').color(:crimson)}
    yellow_player.make_winner if array.all? {|spot| spot == Rainbow('O').color(:gold)}
  end

  def look_at_vertical(column, row)
    one = board.spots[column][row] if board.spots[column] != nil
    two = board.spots[column + 1][row] if board.spots[column + 1] != nil
    three = board.spots[column + 2][row] if board.spots[column + 2] != nil
    four = board.spots[column + 3][row] if board.spots[column + 3] != nil
    array = [one, two, three, four]
    array.delete(nil)
    return if array.length != 4
    red_player.make_winner if array.all? {|spot| spot == Rainbow('O').color(:crimson)}
    yellow_player.make_winner if array.all? {|spot| spot == Rainbow('O').color(:gold)}
  end

  def look_at_horizontal(column, row)
    one = board.spots[column][row]
    two = board.spots[column][row + 1]
    three = board.spots[column][row + 2]
    four = board.spots[column][row + 3]
    array = [one, two, three, four]
    array.delete(nil)
    return if array.length != 4
    red_player.make_winner if array.all? {|spot| spot == Rainbow('O').color(:crimson)}
    yellow_player.make_winner if array.all? {|spot| spot == Rainbow('O').color(:gold)}
  end

  def declare_winner
    puts "#{red_player.name} is the winner!!!" if red_player.winner == true
    puts "#{yellow_player.name} is the winner!!!" if yellow_player.winner == true
    return unless red_player.winner == false && yellow_player.winner == false

    puts 'Draw!!!'
  end
end