class Player

    def initialize(playingAs)
        @playingAs = playingAs
    end

    def PlayingAs()
        return @playingAs
    end

    def GetMove(game)
        puts "Enter the x coordinate of your move:"
        x = gets.chomp.to_i
        puts "Enter the y coordinate of your move:"
        y = gets.chomp.to_i
        if game.CanPlayAt(x, y)
            return x, y
        else
            puts "Invalid move, try again."
            GetMove(game)
        end
    end

    def Play(game, xcoord, ycoord)
        if game.CanPlayAt(xcoord, ycoord)
            game.Emplace(@playingAs, xcoord, ycoord)
        end
    end
end