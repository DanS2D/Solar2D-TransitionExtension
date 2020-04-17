-- transition extension - author: Danny Glover - copyright © Danny Glover 2020 - license: GNU General Public License v3.0

local cwd = (...):match("(.+)%.[^%.]+$") or (...)
local json = require("json")
local utils = require(cwd .. ".transition-utils")
local M = {}
local jDecode = json.decode
local copyTable = utils.copyTable

local function loopsComplete(tag, currentLoops, requiredLoops, onComplete)
	if (requiredLoops > -1 and currentLoops >= requiredLoops) then
		transition.cancel(tag)

		if (type(onComplete) == "function") then
			onComplete()
		end

		return true
	end
end

function M.tween(target, options)
	local origTarget = copyTable(jDecode(target._properties))
	local origOptions = copyTable(options)
	local initialDelay = options.initialDelay or 0
	local tweenDelay = options.delay or 0
	local requiredLoops = options.loops or -1
	local currentLoops = 0
	local origOnComplete = options.onComplete
	local onBackward = nil
	local onForward = nil
	local tag = options.tag or tostring(target)

	local function updateOptions(opt, onComplete)
		opt.tag = tag
		opt.delay = tweenDelay
		opt.loops = requiredLoops
		opt.onComplete = onComplete
	end

	onBackward = function()
		local opt = {}

		for k, v in pairs(options) do
			opt[k] = v
		end

		for k, v in pairs(origTarget) do
			if (type(v) == "number") then
				opt[k] = v
			end
		end

		if (requiredLoops > -1) then
			currentLoops = currentLoops + 1
		end

		updateOptions(opt, onForward)
		transition.to(target, opt)
	end

	onForward = function()
		local opt = copyTable(origOptions)
		updateOptions(opt, onBackward)

		if (loopsComplete(tag, currentLoops, requiredLoops, origOnComplete)) then
			return
		end

		transition.to(target, opt)
	end

	options.tag = tag
	options.delay = initialDelay
	options.iterations = nil -- iterations mess with the transition
	options.onComplete = onBackward

	transition.to(target, options)

	return tag
end

return M
