require("game")
function score()
    if gameOver() == 1 then
        return -10
    elseif gameOver() == 2 then
        return 10
    else
        return 0
    end
end

function new_state(move)
    local copy = {{}, {}, {}}
    for i = 1, 3 do
        for j = 1, 3 do
            copy[i][j] = board[i][j]
        end
    end
    copy[move[1]][move[2]] = sym
    return copy
end

function available_moves()
    local moves = {}
    for i = 1,3 do
        for j = 1,3 do
            if tonumber(board[i][j]) ~= nil then
                moves[#moves+1] = {i, j}
            end
        end
    end
    return moves
end

choice = nil

function max(scores)
    local index = 1
    local max = scores[1]
    for i = 1, #scores do
        if scores[i] > max then
            max = scores[i]
            index = i
        end
    end
    return index
end

function pointToNum(point)
    return board[point[1]][point[2]]
end

function mini(scores)
    local index = 1
    local min = scores[1]
    for i = 1, #scores do
        if scores[i] < min then
            min = scores[i]
            index = i
        end
    end
    return index
end

difficulty = 'hard'
local playerCopy = player
function minimax(state)
    local moves = available_moves(board)
    if difficulty == 'easy' then
        choice = moves[math.random(1, #moves-1)]
        return
    else
        if then
            return score()
        end
        displaySpecific(board)
        for i = 1, #moves do
            print('We could play the ' .. pointToNum(moves[i]) .. '->')
            displaySpecific(new_state(moves[i]))
            print('If we assume that we and the opponent do our best, the score would be ' .. minimax(new_state(moves[i])))
        end
        if playerCopy == 2 then
            choice = moves[max(scores)]
            return scores[max(scores)]
        elseif playerCopy == 1 then
            choice = moves[min(scores)]
            return scores[min(scores)]
        end
    end
end
