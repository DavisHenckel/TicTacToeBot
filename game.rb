class Game

    def initialize(player)
        @player = player
        @lastMove = nil
        @playingAs = player.PlayingAs == "x" ? "o" : "x"
        @gameFinished = false
        row, col, default_value = 3, 3, "-"
        @game = Array.new(row) {Array.new(col, default_value)}
    end

    def CanPlayAt(xcoord, ycoord)
        return (@game[xcoord][ycoord] == "-")
    end

    def Emplace(move, xcoord, ycoord)
        if CanPlayAt(xcoord, ycoord)
            @game[xcoord][ycoord] = move
            @lastMove = move
        end
        CheckWin()
    end

    def BoardFull()
        @game.each do |row|
            row.each do |col|
                if col == "-"
                    return false
                end
            end
        end
    end

    def HorizontalWin()
        if @game[0][0] == @game[0][1] && @game[0][1] == @game[0][2] && @game[0][0] != "-"
            return true, @game[0][0]
        end
        if @game[1][0] == @game[1][1] && @game[1][1] == @game[1][2] && @game[1][0] != "-"
            return true, @game[1][0]
        end
        if @game[2][0] == @game[2][1] && @game[2][1] == @game[2][2] && @game[2][0] != "-"
            return true, @game[2][0]
        end
    end

    def VerticalWin()
        if @game[0][0] == @game[1][0] && @game[1][0] == @game[2][0] && @game[0][0] != "-"
            return true, @game[0][0]
        end
        if @game[0][1] == @game[1][1] && @game[1][1] == @game[2][1] && @game[0][1] != "-"
            return true, @game[0][1]
        end
        if @game[0][2] == @game[1][2] && @game[1][2] == @game[2][2] && @game[0][2] != "-"
            return true, @game[0][2]
        end
    end

    def DiagonalWin()
        if @game[0][0] == @game[1][1] && @game[1][1] == @game[2][2] && @game[0][0] != "-"
            return true, @game[0][0]
        end
        if @game[0][2] == @game[1][1] && @game[1][1] == @game[2][0] && @game[0][2] != "-"
            return true, @game[0][2]
        end
    end

    def CheckWin()
        h, winner = HorizontalWin()
        if h
            @gameFinished = true
            return winner
        end
        v, winner = VerticalWin()
        if v
            @gameFinished = true
            return winner
        end
        d, winner = DiagonalWin()
        if d
            @gameFinished = true
            return winner
        end
        if BoardFull()
            @gameFinished = true
            return "draw"
        end
    end

    def Play()
        PrintBoard()
        winner = nil
        while @gameFinished == false
            if @lastMove == nil
                @lastMove = @playingAs
            end
            @nextMove = @lastMove == "x" ? "o" : "x"
            if @nextMove == @playingAs
                # AI Turn
                @lastMove = @playingAs
            else
                puts "Your turn!"
                x, y = @player.GetMove(self)
                @player.Play(self, x, y)
                @lastMove = @player.PlayingAs
            end
            PrintBoard()
            winner = CheckWin()  
        end
        puts "Game is finished! Winner is #{winner}!"
    end

    def PrintBoard()
        puts "Current Board:"
        3.times do |i|
            3.times do |j|
                if j == 2
                    puts @game[i][j]
                else
                    print @game[i][j]
                end 
            end
        end
    end
end
