-- transition extension - author: Danny Glover - copyright © Danny Glover 2020 - license: GNU General Public License v3.0

local strict = require("strict")
local transitionExtension = require("transition-extension.extension-transition")
local sFormat = string.format
local dScreenOriginX = display.screenOriginX
local dScreenOriginY = display.dScreenOriginY
local dCenterX = display.contentCenterX
local dCenterY = display.contentCenterY
local dWidth = display.contentWidth
local dHeight = display.contentHeight
local dStatusBarHeight = display.topStatusBarContentHeight
local pingPongAlpha = nil
local pingPongX = nil
local pingPongY = nil
local pingPongXScale = nil
local pingPongYScale = nil
local pingPongAll = nil
local transitionHandle = nil
local statusPrefix = "Current Effect:\n"
local effectPrefix = "Ping-Pong"
local effectInitialDelay = 1000
local effectTime = 1000
local effectLoops = 2

local rect = display.newRect(0, 0, 80, 80)
rect.x = dCenterX
rect.y = dCenterY

local statusText =
	display.newText(
	{
		text = statusPrefix,
		x = dCenterX,
		y = dStatusBarHeight + 10,
		width = dWidth - 20,
		align = "center",
		font = native.systemFontBold,
		fontSize = 16
	}
)

pingPongAlpha = function(event)
	statusText.text = sFormat("%s%s Alpha", statusPrefix, effectPrefix)
	statusText.x = dCenterX

	transitionHandle =
		transition.pingPong(
		rect,
		{
			alpha = 0,
			initialDelay = effectInitialDelay,
			time = effectTime,
			transition = easing.inOutQuad,
			loops = effectLoops,
			onComplete = pingPongX
		}
	)
end

pingPongX = function(event)
	statusText.text = sFormat("%s%s X", statusPrefix, effectPrefix)

	transitionHandle =
		transition.pingPong(
		rect,
		{
			x = rect.x + 20,
			initialDelay = effectInitialDelay,
			time = effectTime,
			transition = easing.inOutQuad,
			loops = effectLoops,
			onComplete = pingPongY
		}
	)
end

pingPongY = function(event)
	statusText.text = sFormat("%s%s Y", statusPrefix, effectPrefix)

	transitionHandle =
		transition.pingPong(
		rect,
		{
			y = rect.y + 20,
			initialDelay = effectInitialDelay,
			time = effectTime,
			transition = easing.inOutQuad,
			loops = effectLoops,
			onComplete = pingPongXScale
		}
	)
end

pingPongXScale = function(event)
	statusText.text = sFormat("%s%s X Scale", statusPrefix, effectPrefix)

	transitionHandle =
		transition.pingPong(
		rect,
		{
			xScale = 2,
			initialDelay = effectInitialDelay,
			time = effectTime,
			transition = easing.inOutQuad,
			loops = effectLoops,
			onComplete = pingPongYScale
		}
	)
end

pingPongYScale = function(event)
	statusText.text = sFormat("%s%s Y Scale", statusPrefix, effectPrefix)

	transitionHandle =
		transition.pingPong(
		rect,
		{
			yScale = 2,
			initialDelay = effectInitialDelay,
			time = effectTime,
			transition = easing.inOutQuad,
			loops = effectLoops,
			onComplete = pingPongAll
		}
	)
end

pingPongAll = function(event)
	statusText.text = sFormat("%s%s Alpha, X, Y, X Scale, Y Scale", statusPrefix, effectPrefix)
	transitionHandle =
		transition.pingPong(
		rect,
		{
			alpha = 0,
			x = rect.x + 80,
			y = rect.y - 80,
			xScale = 2,
			yScale = 2,
			initialDelay = effectInitialDelay,
			time = effectTime,
			transition = easing.inOutQuad,
			loops = effectLoops,
			onComplete = pingPongAlpha
		}
	)
end

pingPongAlpha()
