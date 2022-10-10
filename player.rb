class Player
    string  playingAs
    def initialize(playingAs)
        this.playingAs = playingAs
    end

    def play(game, xcoord, ycoord)
        if game.CanPlayAt(xcoord, ycoord)
            game.Emplace(this.playingAs, xcoord, ycoord)
        end
    end
end