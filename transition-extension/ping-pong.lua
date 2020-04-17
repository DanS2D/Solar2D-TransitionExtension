-- transition extension - author: Danny Glover - copyright © Danny Glover 2020 - license: GNU General Public License v3.0

local json = require("json")
local utils = require("transition-extension.transition-utils")
local M = {}
local jDecode = json.decode
local copyTable = utils.copyTable

local function loopsComplete(tag, currentLoops, requiredLoops, onComplete)
	if (currentLoops > 0 and currentLoops >= requiredLoops) then
		transition.cancel(tag)

		if (type(onComplete) == "function") then
			onComplete()
			return true
		end
	end
end

function M.tween(target, options)
	local origTarget = copyTable(jDecode(target._properties))
	local origOptions = copyTable(options)
	local initialDelay = options.initialDelay or 0
	local tweenDelay = options.delay or 0
	local requiredLoops = options.loops or 0
	local currentLoops = 0
	local onComplete = options.onComplete
	local onBackward = nil
	local onForward = nil
	local tag = options.tag or tostring(target)

	local function updateOptions(onComplete)
		options.tag = tag
		options.delay = tweenDelay
		options.onComplete = onComplete
	end

	onBackward = function()
		for k, v in pairs(origTarget) do
			if (type(v) == "number") then
				options[k] = v
			end
		end

		currentLoops = currentLoops + 1

		updateOptions(onForward)
		transition.to(target, options)
	end

	onForward = function()
		options = origOptions

		if (loopsComplete(tag, currentLoops, requiredLoops, onComplete)) then
			return
		end

		updateOptions(onBackward)
		transition.to(target, origOptions)
	end

	options.tag = tag
	options.delay = initialDelay
	options.iterations = nil -- iterations mess with the transition
	options.onComplete = onBackward

	transition.to(target, options)

	return tag
end

return M
