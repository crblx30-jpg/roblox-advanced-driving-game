# Advanced Roblox Driving Game Starter

This project gives you a functional Roblox driving game starter with:
- realistic-looking car body and interior
- wheel-based suspension handling
- throttle/brake/steering logic
- speedometer + tachometer UI
- generated car model from script

## What is included

- `src/Bootstrap.server.lua` - creates the car and wires the controller
- `src/CarFactory.lua` - builds the car model from scratch
- `src/CarController.lua` - handles acceleration, steering, suspension, and speed updates
- `src/SpeedometerUI.client.lua` - creates the dashboard UI

## How to use in Roblox Studio

1. Open a new Roblox Studio place.
2. Create a `Folder` named `DrivingGameScripts` in `ReplicatedStorage`.
3. Insert a `Script` into `ServerScriptService`.
4. Paste the contents of `src/Bootstrap.server.lua` into the Script.
5. Insert a `LocalScript` into `StarterPlayer > StarterPlayerScripts`.
6. Paste the contents of `src/SpeedometerUI.client.lua` into the LocalScript.
7. Press Play.

The game will generate a drivable car automatically.

## Driving controls

- W / Up Arrow: accelerate
- S / Down Arrow: brake/reverse
- A / D: steer
- Space: handbrake / drift assist

## Notes

This is a high-quality starting point for a Roblox driving game, but it is still a gameplay-focused implementation rather than fully simulating real-world automotive physics. The suspension and traction are tuned for fun, smooth driving in Roblox Studio.
