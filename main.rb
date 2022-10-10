require_relative "game.rb"
require_relative "player.rb"

puts ("Welcome to Minimax Tic-Tac-Toe!")
player1 = Player.new("x")
player2 = Player.new("o")
game = Game.new
player2.play(game, 0, 0)
player1.play(game, 1, 1)
