-- transition extension - author: Danny Glover - copyright © Danny Glover 2020 - license: GNU General Public License v3.0

local cwd = (...):match("(.+)%.[^%.]+$") or (...)
local pingPongTransition = require(cwd .. ".ping-pong")
local M = {}

transition.pingPong = pingPongTransition.tween

return M
