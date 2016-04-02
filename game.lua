game = {}
function game:new()
    local obj = {board = {{1,2,3},{4,5,6},{7,8,9}}}
    self.__index = self
    return setmetatable(obj, self)
end

function game:board()
    return self.board
end

function game:play(num, symbol)
    for i = 1,3 do
        for j = 1, 3 do
            if self.board[i][j] == num then
                self.board[i][j] = symbol
            end
        end
    end
end

function game:over()
    player1 = {}
    player2 = {}
    for i = 1,3 do
        for j = 1,3 do
            if self.board[i][j] == 'X' then
                player1[#player1+1] = {i,j}
            elseif self.board[i][j] == 'O' then
                player2[#player2+1] = {i,j}
            end
        end
    end

    if check(sameRow, player1) or check(sameColumn, player1) or diag(player1) == 3 then
        return 1
    end
    if check(sameRow, player2) or check(sameColumn, player2) or diag(player2) == 3 then
        return 2
    end

    -- if all of the board is filled, the game must be over
    for i = 1,3 do
        for j = 1,3 do
            -- if we see a number, then the board isn't filled and the game isn't over
            if tonumber(board[i][j]) ~= nil then
                return false
            end
        end
    end
    return true
end


board = {{1,2,3},{4,5,6},{7,8,9}}
-- board[i][j] is by row, column
function play(num, symbol)
    for i = 1,3 do
        for j = 1, 3 do
            if board[i][j] == num then
                board[i][j] = symbol
            end
        end
    end
end

function sameRow(list, target)
    count = 0
    for i = 1, #list do
        if list[i][1] == target then
            count = count + 1
        end
    end
    return count
end

function sameColumn(list, target)
    count = 0
    for i = 1, #list do
        if list[i][2] == target then
            count = count + 1
        end
    end
    return count
end

function check(fn, list)
    winCondition = false
    for i = 1,3 do
        winCondition = winCondition or fn(list, i) == 3
    end
    return winCondition
end


function diag(list)
    count = 0
    for i = 1, #list do
        d = {math.abs(1 - list[i][1]), math.abs(1 - list[i][2])}
        if (d[1] == d[2]) then
            count = count + 1
        end
    end
    return count
end

function gameOver()
    player1 = {}
    player2 = {}
    for i = 1,3 do
        for j = 1,3 do
            if board[i][j] == 'X' then
                player1[#player1+1] = {i,j}
            elseif board[i][j] == 'O' then
                player2[#player2+1] = {i,j}
            end
        end
    end

    if check(sameRow, player1) or check(sameColumn, player1) or diag(player1) == 3 then
        return 1
    end
    if check(sameRow, player2) or check(sameColumn, player2) or diag(player2) == 3 then
        return 2
    end

    -- if all of the board is filled, the game must be over
    for i = 1,3 do
        for j = 1,3 do
            -- if we see a number, then the board isn't filled and the game isn't over
            if tonumber(board[i][j]) ~= nil then
                return false
            end
        end
    end
    return true
    -- if neither player has won and the board isn't filled, the game is over
end

function display()
    for i = 1,3 do
        str = ''
        for j = 1,3 do
            str = str .. board[i][j] .. ' '
        end
        print(str)
    end
    print()
end

function displaySpecific(game)
    for i = 1,3 do
        str = ''
        for j = 1,3 do
            str = str .. game[i][j] .. ' '
        end
        print(str)
    end
    print()
end
