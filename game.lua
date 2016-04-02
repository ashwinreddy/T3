game = {}
function game:new()
    self.__index = self
    return setmetatable({board = {{1,2,3},{4,5,6},{7,8,9}}}, self)
end

function game:
