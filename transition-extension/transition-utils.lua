-- transition extension - author: Danny Glover - copyright © Danny Glover 2020 - license: GNU General Public License v3.0

local M = {}

function M.copyTable(obj)
    if (type(obj) ~= "table") then
        return obj
    end

    local res = setmetatable({}, getmetatable(obj))

    for k, v in pairs(obj) do
        res[M.copyTable(k)] = M.copyTable(v)
    end

    return res
end

return M
