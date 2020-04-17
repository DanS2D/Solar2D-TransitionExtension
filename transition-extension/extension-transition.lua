-- transition extension - author: Danny Glover - copyright © Danny Glover 2020 - license: GNU General Public License v3.0

local pingPongTransition = require("transition-extension.ping-pong")
local M = {}

transition.pingPong = pingPongTransition.tween

return M
