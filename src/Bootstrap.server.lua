local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local drivingFolder = ReplicatedStorage:WaitForChild("DrivingGame")
local speedEvent = drivingFolder:WaitForChild("SpeedUpdate")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DrivingHUD"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, 270, 0, 160)
panel.Position = UDim2.new(1, -310, 1, -190)
panel.BackgroundColor3 = Color3.fromRGB(17, 17, 20)
panel.BackgroundTransparency = 0.2
panel.BorderSizePixel = 0
panel.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = panel

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -20, 0.5, -10)
speedLabel.Position = UDim2.new(0, 10, 0, 8)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "0"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.Font = Enum.Font.GothamBlack
speedLabel.TextScaled = true
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = panel

local unitLabel = Instance.new("TextLabel")
unitLabel.Size = UDim2.new(0, 90, 0, 28)
unitLabel.Position = UDim2.new(1, -105, 1, -44)
unitLabel.BackgroundTransparency = 1
unitLabel.Text = "MPH"
unitLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
unitLabel.Font = Enum.Font.GothamBold
unitLabel.TextSize = 22
unitLabel.TextXAlignment = Enum.TextXAlignment.Right
unitLabel.Parent = panel

local rpmLabel = Instance.new("TextLabel")
rpmLabel.Size = UDim2.new(0, 150, 0, 24)
rpmLabel.Position = UDim2.new(0, 18, 0.5, 10)
rpmLabel.BackgroundTransparency = 1
rpmLabel.Text = "RPM 0000"
rpmLabel.TextColor3 = Color3.fromRGB(120, 216, 255)
rpmLabel.Font = Enum.Font.GothamBold
rpmLabel.TextSize = 18
rpmLabel.Parent = panel

local speedDial = Instance.new("Frame")
speedDial.Size = UDim2.new(0, 110, 0, 110)
speedDial.Position = UDim2.new(1, -130, 0, 25)
speedDial.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
speedDial.BorderSizePixel = 0
speedDial.Parent = panel

local dialCorner = Instance.new("UICorner")
dialCorner.CornerRadius = UDim.new(0, 55)
dialCorner.Parent = speedDial

local dialInner = Instance.new("Frame")
dialInner.Size = UDim2.new(1, -16, 1, -16)
dialInner.Position = UDim2.new(0, 8, 0, 8)
dialInner.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
dialInner.BorderSizePixel = 0
dialInner.Parent = speedDial

local dialInnerCorner = Instance.new("UICorner")
dialInnerCorner.CornerRadius = UDim.new(0, 50)
dialInnerCorner.Parent = dialInner

local needle = Instance.new("Frame")
needle.Size = UDim2.new(0, 4, 0, 40)
needle.Position = UDim2.new(0.5, -2, 0.5, -12)
needle.BackgroundColor3 = Color3.fromRGB(255, 90, 90)
needle.BorderSizePixel = 0
needle.AnchorPoint = Vector2.new(0.5, 1)
needle.Parent = speedDial

local needleShadow = Instance.new("Frame")
needleShadow.Size = UDim2.new(0, 4, 0, 40)
needleShadow.Position = UDim2.new(0.5, -2, 0.5, -12)
needleShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
needleShadow.BorderSizePixel = 0
needleShadow.AnchorPoint = Vector2.new(0.5, 1)
needleShadow.Transparency = 0.6
needleShadow.Parent = speedDial

local speedValue = 0

speedEvent.OnClientEvent:Connect(function(value)
	speedValue = value
	speedLabel.Text = tostring(math.floor(value))
	local rpm = math.clamp(value * 160, 0, 9000)
	rpmLabel.Text = "RPM " .. tostring(math.floor(rpm))

	local angle = -120 + (math.clamp(value, 0, 200) / 200) * 240
	needle.Rotation = angle
	needleShadow.Rotation = angle
end)

local function pulse()
	local alpha = math.sin(os.clock() * 8) * 0.5 + 0.5
	panel.BackgroundColor3 = Color3.fromRGB(17 + math.floor(alpha * 10), 17 + math.floor(alpha * 10), 20)
end

while true do
	pulse()
	task.wait(0.05)
end
