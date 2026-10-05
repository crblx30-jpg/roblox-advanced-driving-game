local CarFactory = {}

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
	part.Parent = parent
	return part
end

local function weld(part0, part1, cframe)
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = part0
	weld.Part1 = part1
	weld.Parent = part0
	if cframe then
		part1.CFrame = part0.CFrame * cframe
	end
	return weld
end

function CarFactory.CreateCar(parent)
	local car = Instance.new("Model")
	car.Name = "SuperCar"
	car.Parent = parent

	local chassis = makePart("Chassis", Vector3.new(8, 1.3, 4), Color3.fromRGB(230, 40, 40), Enum.Material.SmoothPlastic, car)
	chassis.CFrame = CFrame.new(0, 5, 0)
	chassis.CanCollide = true
	car.PrimaryPart = chassis

	local cabin = makePart("Cabin", Vector3.new(4.2, 1.8, 3.2), Color3.fromRGB(35, 35, 35), Enum.Material.SmoothPlastic, car)
	cabin.CFrame = chassis.CFrame * CFrame.new(0, 1.4, 0)
	cabin.CanCollide = true
	local roof = makePart("Roof", Vector3.new(3.2, 0.6, 2.5), Color3.fromRGB(10, 10, 14), Enum.Material.SmoothPlastic, car)
	roof.CFrame = cabin.CFrame * CFrame.new(0, 1.2, 0)
	roof.CanCollide = true

	local hood = makePart("Hood", Vector3.new(2.2, 0.8, 3.1), Color3.fromRGB(220, 60, 60), Enum.Material.SmoothPlastic, car)
	hood.CFrame = chassis.CFrame * CFrame.new(2.25, 0.8, 0)
	hood.CanCollide = true
	local trunk = makePart("Trunk", Vector3.new(1.6, 0.7, 3.1), Color3.fromRGB(220, 60, 60), Enum.Material.SmoothPlastic, car)
	trunk.CFrame = chassis.CFrame * CFrame.new(-2.45, 0.8, 0)
	trunk.CanCollide = true

	local spoiler = makePart("Spoiler", Vector3.new(1.5, 0.2, 3.2), Color3.fromRGB(20, 20, 20), Enum.Material.SmoothPlastic, car)
	spoiler.CFrame = chassis.CFrame * CFrame.new(-3.1, 1.9, 0)
	spoiler.CanCollide = false
	local windshield = makePart("Windshield", Vector3.new(0.18, 1.5, 2.6), Color3.fromRGB(90, 90, 110), Enum.Material.Glass, car)
	windshield.CFrame = chassis.CFrame * CFrame.new(0.05, 1.9, 0)
	windshield.CanCollide = false
	local rearGlass = makePart("RearGlass", Vector3.new(0.18, 1.5, 2.4), Color3.fromRGB(90, 90, 110), Enum.Material.Glass, car)
	rearGlass.CFrame = chassis.CFrame * CFrame.new(-1.8, 1.9, 0)
	rearGlass.CanCollide = false

	local dashboard = makePart("Dashboard", Vector3.new(3.4, 0.6, 2.7), Color3.fromRGB(20, 20, 24), Enum.Material.SmoothPlastic, car)
	dashboard.CFrame = chassis.CFrame * CFrame.new(0.3, 1.4, 0)
	dashboard.CanCollide = false

	local steeringWheel = makePart("SteeringWheel", Vector3.new(0.8, 0.8, 0.18), Color3.fromRGB(25, 25, 25), Enum.Material.SmoothPlastic, car)
	steeringWheel.CFrame = chassis.CFrame * CFrame.new(1.1, 1.9, -0.7) * CFrame.Angles(0, 0, math.rad(30))
	steeringWheel.CanCollide = false

	local seatBase = makePart("SeatBase", Vector3.new(1.9, 0.6, 1.9), Color3.fromRGB(12, 12, 16), Enum.Material.SmoothPlastic, car)
	seatBase.CFrame = chassis.CFrame * CFrame.new(0.8, 1.3, 0)
	seatBase.CanCollide = false
	local seatBack = makePart("SeatBack", Vector3.new(1.9, 1.4, 0.4), Color3.fromRGB(18, 18, 22), Enum.Material.SmoothPlastic, car)
	seatBack.CFrame = seatBase.CFrame * CFrame.new(0, 0.8, -0.8)
	seatBack.CanCollide = false

	local seat = Instance.new("VehicleSeat")
	seat.Name = "DriverSeat"
	seat.Size = Vector3.new(2, 1, 2)
	seat.CFrame = chassis.CFrame * CFrame.new(0.8, 2.15, 0)
	seat.Parent = car
	seat.CanCollide = false
	seat.Color = Color3.fromRGB(25, 25, 25)
	seat.Material = Enum.Material.SmoothPlastic
	seat.Massless = true
	seat.CFrame = seat.CFrame

	local wheelPositions = {
		{Vector3.new(2.5, 1, 2.2), "FrontLeftWheel"},
		{Vector3.new(2.5, 1, -2.2), "FrontRightWheel"},
		{Vector3.new(-2.5, 1, 2.2), "RearLeftWheel"},
		{Vector3.new(-2.5, 1, -2.2), "RearRightWheel"},
	}

	local wheelInfo = {}
	for _, item in ipairs(wheelPositions) do
		local offset, name = item[1], item[2]
		local wheel = makePart(name, Vector3.new(1, 0.9, 0.9), Color3.fromRGB(20, 20, 20), Enum.Material.SmoothPlastic, car, Enum.PartType.Cylinder)
		wheel.Orientation = Vector3.new(0, 0, 90)
		wheel.CFrame = chassis.CFrame * CFrame.new(offset.x, offset.y, offset.z)
		wheel.CanCollide = true
		wheel.Massless = false
		local tire = makePart(name .. "Tire", Vector3.new(1.2, 1.0, 1.0), Color3.fromRGB(12, 12, 12), Enum.Material.SmoothPlastic, car, Enum.PartType.Cylinder)
		tire.Orientation = Vector3.new(0, 0, 90)
		tire.CFrame = wheel.CFrame
		tire.CanCollide = false
		tire.Massless = true
		local wheelWeld = Instance.new("WeldConstraint")
		wheelWeld.Part0 = wheel
		wheelWeld.Part1 = tire
		wheelWeld.Parent = wheel
		table.insert(wheelInfo, {
			wheel = wheel,
			tire = tire,
			offset = offset,
			baseY = offset.y,
		})
	end

	local bodyParts = {
		chassis, cabin, roof, hood, trunk, spoiler, windshield, rearGlass, dashboard, steeringWheel, seatBase, seatBack
	}
	for i = 1, #bodyParts - 1 do
		local current = bodyParts[i]
		local nextPart = bodyParts[i + 1]
		weld(current, nextPart, CFrame.new())
	end
	weld(chassis, seatBase, CFrame.new())
	weld(chassis, seatBack, CFrame.new())
	weld(chassis, seat, CFrame.new())
	weld(chassis, steeringWheel, CFrame.new())

	for _, info in ipairs(wheelInfo) do
		local wheel = info.wheel
		local tire = info.tire
		local wheelWeld = Instance.new("WeldConstraint")
		wheelWeld.Part0 = chassis
		wheelWeld.Part1 = wheel
		wheelWeld.Parent = chassis
		local tireWeld = Instance.new("WeldConstraint")
		tireWeld.Part0 = wheel
		tireWeld.Part1 = tire
		tireWeld.Parent = wheel
	end

	local steeringAxis = Instance.new("Attachment")
	steeringAxis.Name = "SteeringAxis"
	steeringAxis.Visible = false
	steeringAxis.Parent = chassis

	car:SetAttribute("TopSpeed", 180)
	car:SetAttribute("TurnSpeed", 1.55)
	car:SetAttribute("WheelRadius", 0.6)
	car:SetAttribute("SuspensionTravel", 0.7)
	car:SetAttribute("GroundOffset", 1.1)

	return car, wheelInfo
end

return CarFactory
