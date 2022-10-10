class Game
    Game = Array.New(Array.New(3), "-")
    bool isGameOver

    def initialize
        isGameOver = false
    end

    def CanPlayAt(xcoord, ycoord)
        return (this.Game[xcoord][ycoord] == "-")
    end

    def Emplace(move, xcoord, ycoord)
        if CanPlayAt(xcoord, ycoord)
            this.Game[xcoord][ycoord] = move
        end
    end

end
