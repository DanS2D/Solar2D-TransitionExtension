# Solar2D-TransitionExtension
Transition Extension library for Solar2D. Adds new transition methods to the existing library. You simply require the module in your `main.lua` like so: `local transitionExtension = require("transition-extension.extension-transition")` and the methods below will be available to be called via the built-in `transition` module.

There is a demo included in the project. Just open the cloned root folder in the simulator to run it (or click on main.lua via the simulator on windows).

# New transition functions

* `transition.pingPong()` - Used to "ping pong" between two values, the properties in the options table and back to the objects original values.

# Requests

The `ping-pong` effect is just the first in a series of planned effects that will be added to this extension. If you have a request for a specific effect, please open [an issue](https://github.com/DannyGlover/Solar2D-TransitionExtension/issues/new) using the `enhancement` tag. Please include all possible details regarding the effect you are requesting. A video demonstrating the required effect would be very helpful.

If you find any bugs, please open [an issue](https://github.com/DannyGlover/Solar2D-TransitionExtension/issues/new) and I'll look into it.
