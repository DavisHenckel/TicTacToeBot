class Game

    def initialize(player, board=nil)
        row, col, default_value = 3, 3, "-"
        if board == nil
            @board = Array.new(row) {Array.new(col, default_value)}
        else
            @board = board
        end
        @player = player
        @lastMove = nil
        @playingAs = player.PlayingAs == "x" ? "o" : "x"
        @gameFinished = false
    end 

    def board()
        return @board
    end

    def CanPlayAt(xcoord, ycoord)
        return (@board[xcoord][ycoord] == "-")
    end

    def Emplace(move, xcoord, ycoord)
        if CanPlayAt(xcoord, ycoord)
            @board[xcoord][ycoord] = move
            @lastMove = move
        end
        CheckWin()
    end

    def BoardFull()
        3.times do |i|
            3.times do |j|
                if @board[i][j] == '-'
                    return false
                end
            end
        end
    end

    def HorizontalWin()
        if @board[0][0] == @board[0][1] && @board[0][1] == @board[0][2] && @board[0][0] != "-"
            return true, @board[0][0]
        end
        if @board[1][0] == @board[1][1] && @board[1][1] == @board[1][2] && @board[1][0] != "-"
            return true, @board[1][0]
        end
        if @board[2][0] == @board[2][1] && @board[2][1] == @board[2][2] && @board[2][0] != "-"
            return true, @board[2][0]
        end
    end

    def VerticalWin()
        if @board[0][0] == @board[1][0] && @board[1][0] == @board[2][0] && @board[0][0] != "-"
            return true, @board[0][0]
        end
        if @board[0][1] == @board[1][1] && @board[1][1] == @board[2][1] && @board[0][1] != "-"
            return true, @board[0][1]
        end
        if @board[0][2] == @board[1][2] && @board[1][2] == @board[2][2] && @board[0][2] != "-"
            return true, @board[0][2]
        end
    end

    def DiagonalWin()
        if @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] && @board[0][0] != "-"
            return true, @board[0][0]
        end
        if @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] && @board[0][2] != "-"
            return true, @board[0][2]
        end
    end

    def GetBoardValue()
        if @gameFinished
            winner = CheckWin()
            if winner == "draw"
                return 0
            elsif winner == @playingAs
                return 100
            else
                return -100
            end
        end
        return 0
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
                x, y = GetOptimalMove()
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
                    puts @board[i][j]
                else
                    print @board[i][j]
                end 
            end
        end
    end

    def GetOptimalMove()
        bestValue = -1
        xPosBestMove, yPosBestMove = nil
        while @gameFinished == false
            x, y = GetEmptyMove()
            @board[x][y] = @playingAs
            @lastMove = @playingAs
            moveValue = Minimax(@board, 0, false)
            @board[x][y] = '-'
            if moveValue > bestValue
                xPosBestMove = x
                yPosBestMove = y
                bestValue = moveValue
            end
        end
        return xPosBestMove, yPosBestMove
    end 

    def GetEmptyMove()
        3.times do |i|
            3.times do |j|
                if @board[i][j] == '-'
                    return i, j
                end
            end
        end
    end

    def Minimax(board, depth, maximizingPlayer)
        currentGame = Game.new(@player, board) #initialize a new game object, passing the current board.
        currentValue = currentGame.GetBoardValue()
        if currentValue == 100 || currentValue == -100
            return currentValue
        end
        if currentGame.BoardFull() #recursion base case
            return currentValue
        end
        if maximizingPlayer #AI turn
            highestValue = -1000
            x, y = currentGame.GetEmptyMove() #get the next empty move
            currentGame.Emplace(@playingAs, x, y) #make the move
            highestValue = [highestValue, (Minimax(currentGame.board, depth + 1, false))].max
            currentGame.board[x][y] = '-'
        else #player turn
            opponent = @playingAs == 'x' ? 'o' : 'x'  
            lowestValue = 1000
            x, y = currentGame.GetEmptyMove() #get the next empty move
            currentGame.Emplace(opponent, x, y) #make the move
            lowestValue = [lowestValue, (Minimax(currentGame.board, depth + 1, true))].min
            currentGame.board[x][y] = '-'
        end
    end
end
