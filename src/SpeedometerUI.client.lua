local CarController = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function ensureNetwork()
	local folder = ReplicatedStorage:FindFirstChild("DrivingGame")
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = "DrivingGame"
		folder.Parent = ReplicatedStorage
	end

	local remote = folder:FindFirstChild("SpeedUpdate")
	if not remote then
		remote = Instance.new("RemoteEvent")
		remote.Name = "SpeedUpdate"
		remote.Parent = folder
	end

	return folder, remote
end

local function clamp(v, min, max)
	if v < min then return min end
	if v > max then return max end
	return v
end

function CarController.Start(car)
	local folder, speedEvent = ensureNetwork()
	local seat = car:FindFirstChild("DriverSeat")
	if not seat then
		return
	end

	local chassis = car.PrimaryPart
	if not chassis then
		return
	end

	local wheelInfo = {}
	for _, child in ipairs(car:GetChildren()) do
		if child:IsA("Part") and child.Name:find("Wheel") then
			table.insert(wheelInfo, child)
		end
	end

	local function updateSpeedUI()
		if not seat.Occupant then
			return
		end
		local player = Players:GetPlayerFromCharacter(seat.Occupant.Parent)
		if not player then
			return
		end
		local speedMph = math.abs(chassis.AssemblyLinearVelocity.Magnitude * 0.68)
		speedEvent:FireClient(player, speedMph)
	end

	local suspensionTravel = car:GetAttribute("SuspensionTravel") or 0.7
	local wheelRadius = car:GetAttribute("WheelRadius") or 0.6
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = {car}

	local lastYaw = 0
	RunService.Heartbeat:Connect(function(dt)
		if not chassis then return end
		if not seat or not seat.Parent then return end

		local throttle = seat.ThrottleFloat
		local brake = seat.Brake
		local steer = seat.SteerFloat
		local handbrake = seat.Boost or false

		local forward = chassis.CFrame.LookVector
		local right = chassis.CFrame.RightVector
		local currentSpeed = chassis.AssemblyLinearVelocity:Dot(forward)
		local maxForward = 70
		local maxReverse = -28
		local targetSpeed = 0

		if throttle > 0 then
			targetSpeed = math.clamp(currentSpeed + throttle * 26 * dt, maxReverse, maxForward)
		elseif brake > 0 then
			targetSpeed = math.clamp(currentSpeed - brake * 50 * dt, maxReverse, maxForward)
		else
			targetSpeed = currentSpeed * 0.96
		end

		local dampedVelocity = currentSpeed * forward
		local driveForce = (targetSpeed - currentSpeed) * 6.4
		local newVelocity = dampedVelocity + (forward * driveForce * dt)
		local verticalVel = Vector3.new(0, chassis.AssemblyLinearVelocity.Y, 0)
		chassis.AssemblyLinearVelocity = Vector3.new(newVelocity.X, verticalVel.Y, newVelocity.Z)

		local steerTorque = steer * 0.9 * clamp(math.abs(currentSpeed) * 0.08, 0.2, 2.2)
		local targetAngular = Vector3.new(0, steerTorque * 0.9, 0)
		chassis.AssemblyAngularVelocity = targetAngular

		for _, wheel in ipairs(wheelInfo) do
			local origin = wheel.Position + Vector3.new(0, 1.2, 0)
			local ray = workspace:Raycast(origin, Vector3.new(0, -3.5, 0), rayParams)
			if ray then
				local hitPoint = ray.Position
				local suspensionOffset = (origin.Y - hitPoint.Y) - wheelRadius
				local compression = clamp(suspensionOffset, 0, suspensionTravel)
				local lift = compression * 12
				local restY = chassis.Position.Y + (wheelRadius + 0.7)
				local desiredY = hitPoint.Y + wheelRadius + 0.5 + lift * 0.05
				local currentY = chassis.Position.Y
				local correctedY = currentY + (desiredY - currentY) * 0.18
				chassis.Position = Vector3.new(chassis.Position.X, correctedY, chassis.Position.Z)
				wheel.CFrame = CFrame.new(wheel.Position.X, hitPoint.Y + wheelRadius, wheel.Position.Z) * CFrame.Angles(0, 0, math.rad(90))
			end

			local spin = (currentSpeed * dt) * 2.2
			wheel.Orientation = Vector3.new(0, 0, 90 + (spin * 40))
		end

		if handbrake then
			chassis.AssemblyLinearVelocity = Vector3.new(chassis.AssemblyLinearVelocity.X * 0.97, chassis.AssemblyLinearVelocity.Y, chassis.AssemblyLinearVelocity.Z * 0.97)
		end

		if seat.Occupant then
			updateSpeedUI()
		end
	end)
end

return CarController
