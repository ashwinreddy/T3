require("AI")
debug = false
sound = false
player = 1
sym = 'X'
winner = false
state = 'playing'
ai = true
function pen(rgb)
    love.graphics.setColor(rgb)
end

function drawBoard()
    pen({255, 0, 0})
    love.graphics.line(150, 80, 150, 400-80)
    pen({0, 255, 0})
    love.graphics.line(250, 80, 250, 400-80)
    pen({0, 0, 255})
    love.graphics.line(80, 150, 400-80, 150)
    pen({255, 255, 0})
    love.graphics.line(80, 250, 400-80, 250)
    pen({255, 255, 255})
end

function numbers()
    love.graphics.setFont(love.graphics.newFont(17))
    love.graphics.print(board[1][1], 130, 90)
    love.graphics.print(board[1][2], 200, 90)
    love.graphics.print(board[1][3], 270, 90)
    love.graphics.print(board[2][1], 130, 200)
    love.graphics.print(board[2][2], 200, 200)
    love.graphics.print(board[2][3], 270, 200)
    love.graphics.print(board[3][1], 130, 290)
    love.graphics.print(board[3][2], 200, 290)
    love.graphics.print(board[3][3], 270, 290)
    love.graphics.setFont(love.graphics.newFont(12))
end

function love.graphics.load()
end

function displayMenu()
    love.graphics.print('Welcome to T3!', 150, 10)
    print(love.mouse.isDown(1))
end

function love.draw(dt)
    if debug then
        love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 10, 10)
    end
    if state == 'menu' then
        displayMenu()
    end
    if state == 'playing' then
        drawBoard()
        numbers()
        love.graphics.print('It is player '..player.."'s turn. \nType the number of a square you'd like to play", 10, 10)
    end
    if state == 'winner' then
        drawBoard()
        numbers()
        love.graphics.print('Winnner is P' .. winner .. '!', 10, 10)
    end
end

function aiMove()
    if not gameOver() then
        player = 2
        sym = 'O'
        minimax(board)
        -- play(pointToNum(choice), sym)
        choice = nil
        player = 1
        sym = 'X'
    end
end

function love.keypressed(key)
    if state == 'playing' and ai == false then
        for i = 1, 9 do
            if key == tostring(i) then
                play(i, sym)
                if player == 1 then
                    player = 2
                    sym = 'O'
                elseif player == 2 then
                    player = 1
                    sym = 'X'
                end
                break
            end
        end
    elseif state == 'playing' and ai then
        print('keypress')
        for i = 1, 9 do
            if key == tostring(i) then
                print('User play')
                play(i, sym)
            end
        end
        aiMove()
    end
end


function love.update(dt)
    local res = gameOver()
    if gameOver() ~= false then
        winner = res
        state = 'winner'
    end
end

function love.load(args)
    if sound then
        background_theme = love.audio.newSource("assets/theme.wav", "stream")
        background_theme:setLooping(true)
        background_theme:setVolume(1)
        background_theme:play()
    end
    love.graphics.setBackgroundColor(128, 128, 128)
end
