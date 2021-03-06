def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) 
    move(board, index, current_player(board))
    display_board(board)
  else
    puts "Incorrect entry. Try again."
    turn(board)
  end
end

def turn_count(board)
  board.count do |i|
    i == "X" || i == "O"
  end
end

# def turn_count(board)
#   turn = 0
#   board.each do |turn|
#     if turn == "X" || turn == "O"
#       turn += 1
#     end
#   end
#   return turn
# end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
  # !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
]

def won?(board)
  WIN_COMBINATIONS.find do |i|
    board[i[0]] == board[i[1]] &&
    board[i[1]] == board[i[2]] &&
    position_taken?(board, i[0])
  end
end

def full?(board)
  board.all? do |i|
    i == "X" || i == "O"
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board).last]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

# bundle
# rake console initiates pry(main)
# rspec spec/01_tic_tac_toe_spec.rb
# rspec spec/02_play_spec.rb
# rspec spec/03_cli_spec.rb
