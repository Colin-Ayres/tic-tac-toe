# frozen_string_literal: true
# Game that plays TicTacToe
class TicTacToe
  attr_accessor :player_one, :player_two, :marker, :output, :board
  attr_reader :current_player

  @@board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  WINNERS = [[0, 1, 2],[3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  def initialize(player_one, player_two)
    @player_one = player_one.downcase.capitalize
    @player_two = player_two.downcase.capitalize
    puts "#{@player_one}, you'll go first; you're playing with X. You'll go next, #{@player_two}; you're playing with O."
    show_board
    @current_player = player_one
    @marker = 'X'
  end

  def play
    while game_on?
      place_marker(@current_player, @marker)
      show_board
      switch
    end
    puts @output
  end

  def place_marker(current_player, marker)
    puts "#{current_player}, your turn. Place an #{marker} by choosing a numbered position on the board."
    input = $stdin.gets.chomp.to_i
    until @@board.include?(input)
      puts 'Try again.'
      input = $stdin.gets.chomp.to_i
    end
    @@board.map! { |i| i == input ? marker : i }
  end

  def game_on?
    x_indices = @@board.each_with_index.select{ |a, i| a == 'X' }.map &:last
    o_indices =@@board.each_with_index.select{ |a, i| a == 'O' }.map &:last
      if WINNERS.any? { |i| (i & x_indices) == i }
      @output = "#{player_one} wins!"
      false
    elsif WINNERS.any? { |i| (i & o_indices) == i }
      @output = "#{player_two} wins!"
      false
    elsif @@board.none?(Numeric)
      @output = 'The board is full. No winner.'
      false
    else
      @output = 'No winner yet.'
      true
    end
  end

  def show_board
    puts " #{@@board[0]} | #{@@board[1]} | #{@@board[2]} "
    puts ' --+---+--'
    puts " #{@@board[3]} | #{@@board[4]} | #{@@board[5]} "
    puts ' --+---+--'
    puts " #{@@board[6]} | #{@@board[7]} | #{@@board[8]} "
  end

  private

  def switch
    if @current_player == @player_one
      @current_player = @player_two
      @marker = 'O'
    else
      @current_player = @player_one
      @marker = 'X'
    end
  end
end

Game = TicTacToe.new('Bob', 'Alice')
Game.play
