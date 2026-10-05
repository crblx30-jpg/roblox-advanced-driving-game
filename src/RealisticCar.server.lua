local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- CREATE NETWORKING FOLDER
local folder = Instance.new("Folder")
folder.Name = "DrivingGame"
folder.Parent = ReplicatedStorage

local remote = Instance.new("RemoteEvent")
remote.Name = "SpeedUpdate"
remote.Parent = folder

local seatOccupantEvent = Instance.new("RemoteEvent")
seatOccupantEvent.Name = "SeatOccupantChanged"
seatOccupantEvent.Parent = folder

-- MAKE CAR PARTS WITH MORE DETAIL
local function makePart(name, size, color, material, parent, shape)
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.Color = color
	part.Material = material or Enum.Material.SmoothPlastic
	part.Shape = shape or Enum.PartType.Block
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Anchored = false
	part.CanCollide = true
	part.Parent = parent
	return part
end

-- WELD FUNCTION
local function weld(part0, part1)
	local w = Instance.new("WeldConstraint")
	w.Part0 = part0
	w.Part1 = part1
	w.Parent = part0
end

-- CREATE REALISTIC CAR MODEL
local car = Instance.new("Model")
car.Name = "RealisticSuperCar"
car.Parent = workspace

-- MAIN CHASSIS (Lower body)
local chassis = makePart("Chassis", Vector3.new(8.5, 1.2, 4.2), Color3.fromRGB(200, 30, 30), Enum.Material.SmoothPlastic, car)
chassis.CFrame = CFrame.new(0, 5, 0)
chassis.CanCollide = true
car.PrimaryPart = chassis

-- FLOOR PAN
local floorPan = makePart("FloorPan", Vector3.new(8.2, 0.3, 4), Color3.fromRGB(40, 40, 45), Enum.Material.Metal, car)
floorPan.CFrame = chassis.CFrame * CFrame.new(0, 0.4, 0)
floorPan.CanCollide = false
weld(chassis, floorPan)

-- FRONT FENDER (Left)
local frontFenderL = makePart("FrontFenderL", Vector3.new(2, 0.6, 1.8), Color3.fromRGB(200, 30, 30), Enum.Material.SmoothPlastic, car)
frontFenderL.CFrame = chassis.CFrame * CFrame.new(2.2, 0.9, 1.5)
frontFenderL.CanCollide = false
weld(chassis, frontFenderL)

-- FRONT FENDER (Right)
local frontFenderR = makePart("FrontFenderR", Vector3.new(2, 0.6, 1.8), Color3.fromRGB(200, 30, 30), Enum.Material.SmoothPlastic, car)
frontFenderR.CFrame = chassis.CFrame * CFrame.new(2.2, 0.9, -1.5)
frontFenderR.CanCollide = false
weld(chassis, frontFenderR)

-- REAR FENDER (Left)
local rearFenderL = makePart("RearFenderL", Vector3.new(1.8, 0.6, 1.8), Color3.fromRGB(200, 30, 30), Enum.Material.SmoothPlastic, car)
rearFenderL.CFrame = chassis.CFrame * CFrame.new(-2.4, 0.9, 1.5)
rearFenderL.CanCollide = false
weld(chassis, rearFenderL)

-- REAR FENDER (Right)
local rearFenderR = makePart("RearFenderR", Vector3.new(1.8, 0.6, 1.8), Color3.fromRGB(200, 30, 30), Enum.Material.SmoothPlastic, car)
rearFenderR.CFrame = chassis.CFrame * CFrame.new(-2.4, 0.9, -1.5)
rearFenderR.CanCollide = false
weld(chassis, rearFenderR)

-- HOOD (Engine Cover)
local hood = makePart("Hood", Vector3.new(2.4, 0.5, 3.8), Color3.fromRGB(200, 30, 30), Enum.Material.SmoothPlastic, car)
hood.CFrame = chassis.CFrame * CFrame.new(2.6, 0.9, 0)
hood.CanCollide = false
weld(chassis, hood)

-- TRUNK (Rear)
local trunk = makePart("Trunk", Vector3.new(1.8, 0.5, 3.8), Color3.fromRGB(200, 30, 30), Enum.Material.SmoothPlastic, car)
trunk.CFrame = chassis.CFrame * CFrame.new(-2.8, 0.9, 0)
trunk.CanCollide = false
weld(chassis, trunk)

-- CABIN BODY
local cabin = makePart("Cabin", Vector3.new(4.4, 1.9, 3.2), Color3.fromRGB(50, 50, 55), Enum.Material.SmoothPlastic, car)
cabin.CFrame = chassis.CFrame * CFrame.new(0.2, 1.4, 0)
cabin.CanCollide = true
weld(chassis, cabin)

-- ROOF
local roof = makePart("Roof", Vector3.new(3.8, 0.5, 3), Color3.fromRGB(25, 25, 30), Enum.Material.SmoothPlastic, car)
roof.CFrame = cabin.CFrame * CFrame.new(0, 1.2, 0)
roof.CanCollide = false
weld(chassis, roof)

-- BUMPERS
local frontBumper = makePart("FrontBumper", Vector3.new(8.2, 0.5, 0.6), Color3.fromRGB(30, 30, 35), Enum.Material.SmoothPlastic, car)
frontBumper.CFrame = chassis.CFrame * CFrame.new(3.2, 0.3, 0)
frontBumper.CanCollide = false
weld(chassis, frontBumper)

local rearBumper = makePart("RearBumper", Vector3.new(8.2, 0.5, 0.6), Color3.fromRGB(30, 30, 35), Enum.Material.SmoothPlastic, car)
rearBumper.CFrame = chassis.CFrame * CFrame.new(-3.2, 0.3, 0)
rearBumper.CanCollide = false
weld(chassis, rearBumper)

-- SPOILER (Aerodynamic)
local spoiler = makePart("Spoiler", Vector3.new(1.8, 0.3, 3.2), Color3.fromRGB(15, 15, 18), Enum.Material.SmoothPlastic, car)
spoiler.CFrame = chassis.CFrame * CFrame.new(-3.5, 2.2, 0)
spoiler.CanCollide = false
weld(chassis, spoiler)

-- WINDOWS - REALISTIC GLASS
local frontLeftWindow = makePart("FrontLeftWindow", Vector3.new(1.2, 1.4, 0.1), Color3.fromRGB(100, 150, 180), Enum.Material.Glass, car)
frontLeftWindow.CFrame = cabin.CFrame * CFrame.new(-0.5, 0.6, -1.8)
frontLeftWindow.CanCollide = false
weld(chassis, frontLeftWindow)

local frontRightWindow = makePart("FrontRightWindow", Vector3.new(1.2, 1.4, 0.1), Color3.fromRGB(100, 150, 180), Enum.Material.Glass, car)
frontRightWindow.CFrame = cabin.CFrame * CFrame.new(-0.5, 0.6, 1.8)
frontRightWindow.CanCollide = false
weld(chassis, frontRightWindow)

local rearLeftWindow = makePart("RearLeftWindow", Vector3.new(0.9, 1.2, 0.1), Color3.fromRGB(100, 150, 180), Enum.Material.Glass, car)
rearLeftWindow.CFrame = cabin.CFrame * CFrame.new(0.8, 0.6, -1.8)
rearLeftWindow.CanCollide = false
weld(chassis, rearLeftWindow)

local rearRightWindow = makePart("RearRightWindow", Vector3.new(0.9, 1.2, 0.1), Color3.fromRGB(100, 150, 180), Enum.Material.Glass, car)
rearRightWindow.CFrame = cabin.CFrame * CFrame.new(0.8, 0.6, 1.8)
rearRightWindow.CanCollide = false
weld(chassis, rearRightWindow)

local windshield = makePart("Windshield", Vector3.new(0.15, 1.5, 3.6), Color3.fromRGB(100, 150, 180), Enum.Material.Glass, car)
windshield.CFrame = cabin.CFrame * CFrame.new(-1.2, 0.5, 0)
windshield.CanCollide = false
weld(chassis, windshield)

local rearGlass = makePart("RearGlass", Vector3.new(0.15, 1.3, 3.6), Color3.fromRGB(100, 150, 180), Enum.Material.Glass, car)
rearGlass.CFrame = cabin.CFrame * CFrame.new(1.8, 0.5, 0)
rearGlass.CanCollide = false
weld(chassis, rearGlass)

-- ===== REALISTIC INTERIOR =====

-- DASHBOARD
local dashboard = makePart("Dashboard", Vector3.new(4, 0.8, 2.5), Color3.fromRGB(30, 30, 35), Enum.Material.SmoothPlastic, car)
dashboard.CFrame = cabin.CFrame * CFrame.new(-0.8, 0.3, 0)
dashboard.CanCollide = false
weld(chassis, dashboard)

-- STEERING WHEEL (Leather wrapped)
local steeringWheel = makePart("SteeringWheel", Vector3.new(0.2, 1.2, 1.2), Color3.fromRGB(40, 30, 25), Enum.Material.SmoothPlastic, car)
steeringWheel.CFrame = dashboard.CFrame * CFrame.new(0.8, 0.3, -1.3)
steeringWheel.Shape = Enum.PartType.Cylinder
steeringWheel.Orientation = Vector3.new(0, 0, 90)
steeringWheel.CanCollide = false
weld(chassis, steeringWheel)

-- STEERING WHEEL HUB
local steeringHub = makePart("SteeringHub", Vector3.new(0.3, 0.3, 0.3), Color3.fromRGB(180, 180, 180), Enum.Material.Metal, car)
steeringHub.CFrame = steeringWheel.CFrame
steeringHub.CanCollide = false
weld(chassis, steeringHub)

-- INSTRUMENT CLUSTER PANEL
local instrumentPanel = makePart("InstrumentPanel", Vector3.new(3.2, 0.8, 0.2), Color3.fromRGB(20, 20, 22), Enum.Material.SmoothPlastic, car)
instrumentPanel.CFrame = dashboard.CFrame * CFrame.new(-0.5, 0.15, -1.1)
instrumentPanel.CanCollide = false
weld(chassis, instrumentPanel)

-- DRIVER SEAT (Racing style)
local seatBase = makePart("SeatBase", Vector3.new(2, 1.8, 1.8), Color3.fromRGB(20, 15, 10), Enum.Material.SmoothPlastic, car)
seatBase.CFrame = cabin.CFrame * CFrame.new(0.3, -0.2, -0.9)
seatBase.CanCollide = false
weld(chassis, seatBase)

local seatBack = makePart("SeatBack", Vector3.new(2, 1.5, 0.4), Color3.fromRGB(25, 18, 12), Enum.Material.SmoothPlastic, car)
seatBack.CFrame = seatBase.CFrame * CFrame.new(0, 0.7, -0.8)
seatBack.CanCollide = false
weld(chassis, seatBack)

local seatHeadrest = makePart("Headrest", Vector3.new(2, 0.5, 0.5), Color3.fromRGB(25, 18, 12), Enum.Material.SmoothPlastic, car)
seatHeadrest.CFrame = seatBack.CFrame * CFrame.new(0, 0.95, 0)
seatHeadrest.CanCollide = false
weld(chassis, seatHeadrest)

-- PASSENGER SEAT
local passengerSeatBase = makePart("PassengerSeatBase", Vector3.new(2, 1.8, 1.8), Color3.fromRGB(20, 15, 10), Enum.Material.SmoothPlastic, car)
passengerSeatBase.CFrame = cabin.CFrame * CFrame.new(0.3, -0.2, 0.9)
passengerSeatBase.CanCollide = false
weld(chassis, passengerSeatBase)

-- CENTER CONSOLE
local centerConsole = makePart("CenterConsole", Vector3.new(0.8, 1.2, 3.2), Color3.fromRGB(25, 25, 28), Enum.Material.SmoothPlastic, car)
centerConsole.CFrame = cabin.CFrame * CFrame.new(0.3, -0.3, 0)
centerConsole.CanCollide = false
weld(chassis, centerConsole)

-- GEAR SHIFT
local gearShift = makePart("GearShift", Vector3.new(0.3, 0.8, 0.3), Color3.fromRGB(40, 30, 20), Enum.Material.SmoothPlastic, car)
gearShift.CFrame = centerConsole.CFrame * CFrame.new(0, -0.3, -0.8)
gearShift.CanCollide = false
weld(chassis, gearShift)

-- DOOR HANDLES (Interior)
local leftDoorHandle = makePart("LeftDoorHandle", Vector3.new(0.2, 0.4, 0.4), Color3.fromRGB(180, 180, 180), Enum.Material.Metal, car)
leftDoorHandle.CFrame = cabin.CFrame * CFrame.new(-1.8, 0, -1.8)
leftDoorHandle.CanCollide = false
weld(chassis, leftDoorHandle)

local rightDoorHandle = makePart("RightDoorHandle", Vector3.new(0.2, 0.4, 0.4), Color3.fromRGB(180, 180, 180), Enum.Material.Metal, car)
rightDoorHandle.CFrame = cabin.CFrame * CFrame.new(-1.8, 0, 1.8)
rightDoorHandle.CanCollide = false
weld(chassis, rightDoorHandle)

-- VENTS
local leftVent = makePart("LeftVent", Vector3.new(0.8, 0.3, 0.2), Color3.fromRGB(35, 35, 38), Enum.Material.SmoothPlastic, car)
leftVent.CFrame = dashboard.CFrame * CFrame.new(-1.2, 0.2, -1)
leftVent.CanCollide = false
weld(chassis, leftVent)

local rightVent = makePart("RightVent", Vector3.new(0.8, 0.3, 0.2), Color3.fromRGB(35, 35, 38), Enum.Material.SmoothPlastic, car)
rightVent.CFrame = dashboard.CFrame * CFrame.new(-1.2, 0.2, 1)
rightVent.CanCollide = false
weld(chassis, rightVent)

-- CENTER VENT
local centerVent = makePart("CenterVent", Vector3.new(2.5, 0.3, 0.2), Color3.fromRGB(35, 35, 38), Enum.Material.SmoothPlastic, car)
centerVent.CFrame = instrumentPanel.CFrame * CFrame.new(0, -0.5, 0)
centerVent.CanCollide = false
weld(chassis, centerVent)

-- PEDALS (Accelerator, Brake, Clutch)
local pedalBase = makePart("PedalBase", Vector3.new(1.2, 0.1, 0.8), Color3.fromRGB(40, 40, 40), Enum.Material.SmoothPlastic, car)
pedalBase.CFrame = cabin.CFrame * CFrame.new(1.2, -1, -0.7)
pedalBase.CanCollide = false
weld(chassis, pedalBase)

local acceleratorPedal = makePart("AcceleratorPedal", Vector3.new(0.3, 0.4, 0.3), Color3.fromRGB(50, 50, 50), Enum.Material.SmoothPlastic, car)
acceleratorPedal.CFrame = pedalBase.CFrame * CFrame.new(0.2, -0.3, -0.2)
acceleratorPedal.CanCollide = false
weld(chassis, acceleratorPedal)

local brakePedal = makePart("BrakePedal", Vector3.new(0.3, 0.4, 0.3), Color3.fromRGB(50, 50, 50), Enum.Material.SmoothPlastic, car)
brakePedal.CFrame = pedalBase.CFrame * CFrame.new(-0.2, -0.3, -0.2)
brakePedal.CanCollide = false
weld(chassis, brakePedal)

-- ===== WHEELS - REALISTIC =====

local wheelPositions = {
	{Vector3.new(2.5, 0.7, 2.1), "FrontLeftWheel"},
	{Vector3.new(2.5, 0.7, -2.1), "FrontRightWheel"},
	{Vector3.new(-2.5, 0.7, 2.1), "RearLeftWheel"},
	{Vector3.new(-2.5, 0.7, -2.1), "RearRightWheel"},
}

local wheelInfo = {}
for _, item in ipairs(wheelPositions) do
	local offset, name = item[1], item[2]
	
	-- RIM
	local rim = makePart(name .. "Rim", Vector3.new(0.8, 1.2, 1.2), Color3.fromRGB(60, 60, 65), Enum.Material.Metal, car, Enum.PartType.Cylinder)
	rim.Orientation = Vector3.new(0, 0, 90)
	rim.CFrame = chassis.CFrame * CFrame.new(offset.x, offset.y, offset.z)
	rim.CanCollide = true
	
	-- TIRE
	local tire = makePart(name .. "Tire", Vector3.new(1.2, 1.4, 1.4), Color3.fromRGB(25, 25, 25), Enum.Material.SmoothPlastic, car, Enum.PartType.Cylinder)
	tire.Orientation = Vector3.new(0, 0, 90)
	tire.CFrame = rim.CFrame
	tire.CanCollide = true
	
	-- BRAKE DISC
	local brakeDisc = makePart(name .. "BrakeDisc", Vector3.new(0.15, 1.3, 1.3), Color3.fromRGB(80, 80, 85), Enum.Material.Metal, car)
	brakeDisc.CFrame = rim.CFrame * CFrame.new(0.5, 0, 0)
	brakeDisc.CanCollide = false
	weld(rim, brakeDisc)
	
	weld(rim, tire)
	weld(chassis, rim)
	
	table.insert(wheelInfo, {
		rim = rim,
		tire = tire,
		brakeDisc = brakeDisc,
		offset = offset,
		rotation = 0,
	})
end

-- DRIVER SEAT (VehicleSeat for actual functionality)
local driverSeat = Instance.new("VehicleSeat")
driverSeat.Name = "DriverSeat"
driverSeat.Size = Vector3.new(2, 1, 2)
driverSeat.CFrame = seatBase.CFrame
driverSeat.Parent = car
driverSeat.CanCollide = false
driverSeat.Color = Color3.fromRGB(20, 15, 10)
driverSeat.Material = Enum.Material.SmoothPlastic
driverSeat.Massless = true
driverSeat.Transparency = 0
weld(chassis, driverSeat)

-- SUSPENSION SYSTEM (Springs under each wheel)
local suspensionData = {}
for i, info in ipairs(wheelInfo) do
	suspensionData[i] = {
		wheel = info.rim,
		tire = info.tire,
		offset = info.offset,
		currentHeight = info.offset.y,
		velocity = 0,
		springStiffness = 25,
		damping = 3.5,
		maxTravel = 0.5,
		minTravel = -0.5,
	}
end

-- ===== ADVANCED PHYSICS =====

local carSettings = {
	topSpeed = 85,
	acceleration = 35,
	deceleration = 45,
	turnSpeed = 2.2,
	maxRPM = 8500,
	wheelRadius = 0.7,
	mass = 1500,
}

local carState = {
	speed = 0,
	rpm = 0,
	steer = 0,
	throttle = 0,
	brake = 0,
	isHandbraking = false,
}

-- ADVANCED SUSPENSION PHYSICS
RunService.Heartbeat:Connect(function(dt)
	if not driverSeat or not driverSeat.Parent then return end
	if not driverSeat.Occupant then 
		seatOccupantEvent:FireAllClients(false)
		return 
	end
	
	seatOccupantEvent:FireAllClients(true)

	local throttle = driverSeat.ThrottleFloat or 0
	local brake = driverSeat.Brake or 0
	local steer = driverSeat.SteerFloat or 0
	local handbrake = driverSeat.Boost or false

	local forward = chassis.CFrame.LookVector
	local right = chassis.CFrame.RightVector
	local up = chassis.CFrame.UpVector
	local currentSpeed = chassis.AssemblyLinearVelocity:Dot(forward)
	
	carState.speed = math.abs(currentSpeed)
	carState.steer = steer
	carState.throttle = throttle
	carState.brake = brake
	carState.isHandbraking = handbrake

	-- ADVANCED ACCELERATION & BRAKING WITH ENGINE SIMULATION
	local targetSpeed = 0
	if throttle > 0 then
		targetSpeed = carSettings.topSpeed * throttle
		carState.rpm = math.min(carState.rpm + (throttle * carSettings.acceleration * dt), carSettings.maxRPM)
	elseif brake > 0 then
		carState.rpm = math.max(carState.rpm - (brake * 2000 * dt), 0)
	else
		carState.rpm = math.max(carState.rpm - (500 * dt), 0)
	end

	local speedDifference = targetSpeed - currentSpeed
	local accelerationForce = speedDifference * (carSettings.acceleration * throttle) * dt
	local brakingForce = -brake * carSettings.deceleration * dt
	
	local velocityChange = (accelerationForce + brakingForce) / carSettings.mass
	local newVelocity = currentSpeed + velocityChange

	local horizontalVel = forward * newVelocity
	local verticalVel = Vector3.new(0, chassis.AssemblyLinearVelocity.Y, 0)
	chassis.AssemblyLinearVelocity = horizontalVel + verticalVel

	-- REALISTIC STEERING WITH SPEED INFLUENCE
	local speedInfluence = math.clamp(carState.speed / carSettings.topSpeed, 0, 1)
	local steerAmount = steer * carSettings.turnSpeed * speedInfluence
	chassis.AssemblyAngularVelocity = Vector3.new(0, steerAmount, 0)

	-- ADVANCED SUSPENSION SIMULATION
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = {car}

	for i, suspension in ipairs(suspensionData) do
		local wheel = suspension.wheel
		local wheelPos = wheel.Position
		
		-- RAYCAST TO GROUND
		local rayOrigin = wheelPos + Vector3.new(0, 1.5, 0)
		local rayDirection = Vector3.new(0, -3, 0)
		local rayResult = workspace:Raycast(rayOrigin, rayDirection, rayParams)

		if rayResult then
			local groundDistance = (rayOrigin - rayResult.Position).Magnitude
			local wheelDistance = suspension.wheelRadius + groundDistance - 1.5

			-- SPRING FORCE CALCULATION
			local compression = suspension.maxTravel - wheelDistance
			local springForce = compression * suspension.springStiffness
			local dampingForce = suspension.velocity * suspension.damping
			local totalForce = springForce - dampingForce

			-- UPDATE SUSPENSION VELOCITY
			suspension.velocity = suspension.velocity + (totalForce / carSettings.mass) * dt
			suspension.currentHeight = suspension.currentHeight + suspension.velocity * dt
			suspension.currentHeight = math.clamp(suspension.currentHeight, suspension.offset.y + suspension.minTravel, suspension.offset.y + suspension.maxTravel)

			-- POSITION WHEEL AND APPLY CHASSIS LIFT
			local targetY = rayResult.Position.Y + suspension.wheelRadius
			wheel.CFrame = CFrame.new(wheel.Position.X, targetY, wheel.Position.Z) * CFrame.Angles(0, 0, math.rad(90))

			-- SMOOTH CHASSIS HEIGHT ADJUSTMENT
			local chassisTargetY = rayResult.Position.Y + suspension.wheelRadius + 0.8 + (springForce * 0.02)
			local chassisCurrentY = chassis.Position.Y
			chassis.Position = Vector3.new(chassis.Position.X, chassisCurrentY + (chassisTargetY - chassisCurrentY) * 0.12, chassis.Position.Z)
		end

		-- WHEEL ROTATION BASED ON SPEED
		suspension.wheel.rotation = (suspension.wheel.rotation or 0) + (currentSpeed * dt * 5)
		wheel.Orientation = Vector3.new(0, 0, 90 + suspension.wheel.rotation)
	end

	-- HANDBRAKE / DRIFT EFFECT
	if handbrake then
		chassis.AssemblyLinearVelocity = Vector3.new(
			chassis.AssemblyLinearVelocity.X * 0.93,
			chassis.AssemblyLinearVelocity.Y,
			chassis.AssemblyLinearVelocity.Z * 0.93
		)
	end

	-- SEND TELEMETRY TO CLIENT
	if driverSeat.Occupant then
		local player = Players:GetPlayerFromCharacter(driverSeat.Occupant.Parent)
		if player then
			local speedMph = carState.speed * 1.4
			remote:FireClient(player, speedMph, carState.rpm, carState.throttle, carState.brake)
		end
	end
end)

print("✅ Realistic Advanced Car System Loaded!")
print("🚗 Car Features: Advanced Suspension Physics | Realistic Interior | Engine Simulation")
