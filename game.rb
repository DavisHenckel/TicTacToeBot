class Game

    def initialize
        @isGameOver = false
        row, col, default_value = 3, 3, "-"
        @game = Array.new(row) {Array.new(col, default_value)}
    end

    def CanPlayAt(xcoord, ycoord)
        return (@game[xcoord][ycoord] == "-")
    end

    def Emplace(move, xcoord, ycoord)
        if CanPlayAt(xcoord, ycoord)
            @game[xcoord][ycoord] = move
        end
    end

end
