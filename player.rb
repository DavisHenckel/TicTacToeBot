class Player

    def initialize(playingAs)
        @playingAs = playingAs
    end

    def play(game, xcoord, ycoord)
        if game.CanPlayAt(xcoord, ycoord)
            game.Emplace(@playingAs, xcoord, ycoord)
        end
    end
end