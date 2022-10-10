require_relative "game.rb"
require_relative "player.rb"

puts ("Welcome to Minimax Tic-Tac-Toe!")
player1 = Player.new("x")
game = Game.new(player1)
game.Play()
x = 5
