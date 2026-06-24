local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local Window = Library:CreateWindow({
	Title = "scriptBOB",
	Footer = "version: 1.0.0",
	Icon = 17686742636,
	NotifySide = "Right",
	ShowCustomCursor = true,
	MobileButtonsSide = "Left",
})

local Tabs = {
	AimBot = Window:AddTab("AimBot", "crosshair"),
	Misc = Window:AddTab("Misc", "sliders"),
	["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

local AimBotGroup = Tabs.AimBot:AddLeftGroupbox("AimBot Settings", "crosshair")

AimBotGroup:AddToggle("AimBot", {
	Text = "AimBot",
	Tooltip = "Auto-aim at nearest player",
	Default = false,
	Callback = function(Value)
		Library:Notify({
			Title = "scriptBOB",
			Description = Value and "AimBot enabled!" or "AimBot disabled!",
			Duration = 3,
		})
	end,
})

AimBotGroup:AddDropdown("Hitbox", {
	Values = { "Head", "Body" },
	Default = 1,
	Multi = false,
	Text = "Hitbox",
	Tooltip = "Select target hitbox: Head or Body",
	Callback = function(Value)
		Library:Notify({
			Title = "scriptBOB",
			Description = "Hitbox set to: " .. tostring(Value),
			Duration = 2,
		})
	end,
})

AimBotGroup:AddToggle("AimThroughWalls", {
	Text = "Aim Through Walls",
	Tooltip = "Aim at players through walls",
	Default = false,
	Callback = function(Value)
		Library:Notify({
			Title = "scriptBOB",
			Description = Value and "Aim Through Walls enabled!" or "Aim Through Walls disabled!",
			Duration = 3,
		})
	end,
})

AimBotGroup:AddSlider("AimFOV", {
	Text = "Aim FOV",
	Default = 150,
	Min = 10,
	Max = 500,
	Rounding = 0,
	Compact = false,
	Callback = function(Value)
	end,
})

AimBotGroup:AddSlider("AimSmoothness", {
	Text = "Aim Smoothness",
	Default = 0.15,
	Min = 0,
	Max = 1,
	Rounding = 2,
	Compact = false,
	Callback = function(Value)
	end,
})

AimBotGroup:AddToggle("ShowFOV", {
	Text = "Show FOV Circle",
	Tooltip = "Visual FOV circle on screen",
	Default = true,
	Callback = function(Value)
	end,
})

AimBotGroup:AddColorPicker("FOVColor", {
	Default = Color3.new(0, 1, 0),
	Title = "FOV Color",
	Callback = function(Value)
	end,
})

AimBotGroup:AddDivider()
AimBotGroup:AddLabel("scriptBOB v1.0.0 - AimBot")

local MiscGroup = Tabs.Misc:AddLeftGroupbox("Movement", "sliders")

MiscGroup:AddToggle("NoClip", {
	Text = "NoClip",
	Tooltip = "Walk through walls",
	Default = false,
	Callback = function(Value)
		Library:Notify({
			Title = "scriptBOB",
			Description = Value and "NoClip enabled!" or "NoClip disabled!",
			Duration = 3,
		})
	end,
})

MiscGroup:AddSlider("WalkSpeed", {
	Text = "Walk Speed",
	Default = 16,
	Min = 1,
	Max = 200,
	Rounding = 0,
	Compact = false,
	Callback = function(Value)
		local player = game.Players.LocalPlayer
		local character = player.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.WalkSpeed = Value
			end
		end
	end,
})

MiscGroup:AddSlider("JumpPower", {
	Text = "Jump Power",
	Default = 50,
	Min = 1,
	Max = 200,
	Rounding = 0,
	Compact = false,
	Callback = function(Value)
		local player = game.Players.LocalPlayer
		local character = player.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.JumpPower = Value
			end
		end
	end,
})

MiscGroup:AddToggle("InfiniteJump", {
	Text = "Infinite Jump",
	Tooltip = "Jump without cooldown",
	Default = false,
	Callback = function(Value)
		Library:Notify({
			Title = "scriptBOB",
			Description = Value and "Infinite Jump enabled!" or "Infinite Jump disabled!",
			Duration = 3,
		})
	end,
})

MiscGroup:AddToggle("Fly", {
	Text = "Fly",
	Tooltip = "Enable flight mode",
	Default = false,
	Callback = function(Value)
		Library:Notify({
			Title = "scriptBOB",
			Description = Value and "Fly enabled!" or "Fly disabled!",
			Duration = 3,
		})
	end,
})

MiscGroup:AddSlider("FlySpeed", {
	Text = "Fly Speed",
	Default = 50,
	Min = 10,
	Max = 200,
	Rounding = 0,
	Compact = false,
	Callback = function(Value)
	end,
})

local MiscGroup2 = Tabs.Misc:AddRightGroupbox("ESP", "eye")

MiscGroup2:AddToggle("PlayerESP", {
	Text = "Player ESP",
	Tooltip = "See players through walls",
	Default = false,
	Callback = function(Value)
		Library:Notify({
			Title = "scriptBOB",
			Description = Value and "Player ESP enabled!" or "Player ESP disabled!",
			Duration = 3,
		})
	end,
})

MiscGroup2:AddColorPicker("PlayerESPColor", {
	Default = Color3.new(1, 0, 0),
	Title = "Player Color",
	Callback = function(Value)
	end,
})

MiscGroup2:AddToggle("PlayerESPName", {
	Text = "Show Names",
	Tooltip = "Show player names on ESP",
	Default = true,
	Callback = function(Value)
	end,
})

MiscGroup2:AddToggle("PlayerESPDistance", {
	Text = "Show Distance",
	Tooltip = "Show distance to players",
	Default = true,
	Callback = function(Value)
	end,
})

MiscGroup2:AddToggle("PlayerESPHealth", {
	Text = "Show Health",
	Tooltip = "Show player health bar",
	Default = true,
	Callback = function(Value)
	end,
})

MiscGroup2:AddToggle("PlayerESPBox", {
	Text = "Box ESP",
	Tooltip = "Draw box around players",
	Default = true,
	Callback = function(Value)
	end,
})

MiscGroup2:AddToggle("PlayerESPTracer", {
	Text = "Tracer ESP",
	Tooltip = "Draw line from screen center to players",
	Default = false,
	Callback = function(Value)
	end,
})

MiscGroup2:AddColorPicker("TracerColor", {
	Default = Color3.new(0, 1, 1),
	Title = "Tracer Color",
	Callback = function(Value)
	end,
})

MiscGroup2:AddDivider()
MiscGroup2:AddLabel("scriptBOB v1.0.0 - ESP")

local SettingsGroupBox = Tabs["UI Settings"]:AddLeftGroupbox("Menu", "settings")

SettingsGroupBox:AddButton({
	Text = "Unload UI",
	Func = function()
		Library:Unload()
	end,
	Tooltip = "Close the menu completely",
})

SettingsGroupBox:AddButton({
	Text = "Reset All",
	Func = function()
		for _, toggle in pairs(Toggles) do
			if toggle.Value then
				toggle:SetValue(false)
			end
		end
		Library:Notify({
			Title = "scriptBOB",
			Description = "All toggles reset!",
			Duration = 3,
		})
	end,
	Tooltip = "Reset all toggles to default",
})

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
ThemeManager:ApplyToTab(Tabs["UI Settings"])
SaveManager:BuildConfigSection(Tabs["UI Settings"])
SaveManager:LoadAutoloadConfig()

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local FOV_Circle = Drawing.new("Circle")
FOV_Circle.Visible = false
FOV_Circle.Thickness = 1.5
FOV_Circle.NumSides = 64
FOV_Circle.Filled = false
FOV_Circle.Transparency = 0.7

local ESPObjects = {}

local function createESP(player)
	if player == LocalPlayer then return end
	if ESPObjects[player] then return end

	local espData = {
		box = Drawing.new("Square"),
		name = Drawing.new("Text"),
		distance = Drawing.new("Text"),
		healthBar = Drawing.new("Square"),
		healthBarBg = Drawing.new("Square"),
		tracer = Drawing.new("Line"),
	}

	espData.box.Visible = false
	espData.box.Thickness = 1
	espData.box.Filled = false
	espData.box.Transparency = 1

	espData.name.Visible = false
	espData.name.Size = 14
	espData.name.Center = true
	espData.name.Outline = true
	espData.name.Font = Drawing.Fonts.UI

	espData.distance.Visible = false
	espData.distance.Size = 12
	espData.distance.Center = true
	espData.distance.Outline = true
	espData.distance.Font = Drawing.Fonts.UI

	espData.healthBar.Visible = false
	espData.healthBar.Filled = true
	espData.healthBar.Transparency = 1

	espData.healthBarBg.Visible = false
	espData.healthBarBg.Filled = true
	espData.healthBarBg.Color = Color3.new(0, 0, 0)
	espData.healthBarBg.Transparency = 0.5

	espData.tracer.Visible = false
	espData.tracer.Thickness = 1
	espData.tracer.Transparency = 0.7

	ESPObjects[player] = espData
end

local function removeESP(player)
	if not ESPObjects[player] then return end
	for _, obj in pairs(ESPObjects[player]) do
		obj:Remove()
	end
	ESPObjects[player] = nil
end

local function updateESP()
	for player, espData in pairs(ESPObjects) do
		if not player or not player.Character then
			for _, obj in pairs(espData) do
				obj.Visible = false
			end
			continue
		end

		local character = player.Character
		local hrp = character:FindFirstChild("HumanoidRootPart")
		local head = character:FindFirstChild("Head")
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if not hrp or not head or not humanoid or humanoid.Health <= 0 then
			for _, obj in pairs(espData) do
				obj.Visible = false
			end
			continue
		end

		local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
		if not onScreen then
			for _, obj in pairs(espData) do
				obj.Visible = false
			end
			continue
		end

		local playerColor = Options.PlayerESPColor and Options.PlayerESPColor.Value or Color3.new(1, 0, 0)
		local tracerColor = Options.TracerColor and Options.TracerColor.Value or Color3.new(0, 1, 1)
		local showNames = Toggles.PlayerESPName and Toggles.PlayerESPName.Value
		local showDist = Toggles.PlayerESPDistance and Toggles.PlayerESPDistance.Value
		local showHealth = Toggles.PlayerESPHealth and Toggles.PlayerESPHealth.Value
		local showBox = Toggles.PlayerESPBox and Toggles.PlayerESPBox.Value
		local showTracer = Toggles.PlayerESPTracer and Toggles.PlayerESPTracer.Value

		local localChar = LocalPlayer.Character
		local localHrp = localChar and localChar:FindFirstChild("HumanoidRootPart")
		local distance = localHrp and math.floor((localHrp.Position - hrp.Position).Magnitude) or 0

		local headPos = Camera:WorldToViewportPoint(head.Position)
		local footPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
		local boxHeight = math.abs(headPos.Y - footPos.Y)
		local boxWidth = boxHeight * 0.6

		if showBox then
			espData.box.Visible = true
			espData.box.Size = Vector2.new(boxWidth, boxHeight)
			espData.box.Position = Vector2.new(pos.X - boxWidth / 2, pos.Y - boxHeight / 2)
			espData.box.Color = playerColor
		else
			espData.box.Visible = false
		end

		if showNames then
			espData.name.Visible = true
			espData.name.Position = Vector2.new(pos.X, pos.Y - boxHeight / 2 - 15)
			espData.name.Text = player.Name
			espData.name.Color = playerColor
		else
			espData.name.Visible = false
		end

		if showDist then
			espData.distance.Visible = true
			espData.distance.Position = Vector2.new(pos.X, pos.Y + boxHeight / 2 + 5)
			espData.distance.Text = tostring(distance) .. " studs"
			espData.distance.Color = playerColor
		else
			espData.distance.Visible = false
		end

		if showHealth then
			espData.healthBarBg.Visible = true
			espData.healthBar.Visible = true
			local healthPercent = humanoid.Health / humanoid.MaxHealth
			local barHeight = boxHeight * 0.8
			local barWidth = 3
			local barPos = Vector2.new(pos.X - boxWidth / 2 - 8, pos.Y - boxHeight / 2 + (boxHeight - barHeight) / 2)

			espData.healthBarBg.Size = Vector2.new(barWidth, barHeight)
			espData.healthBarBg.Position = barPos

			espData.healthBar.Size = Vector2.new(barWidth, barHeight * healthPercent)
			espData.healthBar.Position = Vector2.new(barPos.X, barPos.Y + barHeight * (1 - healthPercent))
			espData.healthBar.Color = Color3.new(1 - healthPercent, healthPercent, 0)
		else
			espData.healthBarBg.Visible = false
			espData.healthBar.Visible = false
		end

		if showTracer then
			espData.tracer.Visible = true
			espData.tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
			espData.tracer.To = Vector2.new(pos.X, pos.Y + boxHeight / 2)
			espData.tracer.Color = tracerColor
		else
			espData.tracer.Visible = false
		end
	end
end

local function getClosestPlayer(throughWalls, fov, hitbox)
	local character = LocalPlayer.Character
	if not character then return nil end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return nil end

	local closest = nil
	local minDist = math.huge
	local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character ~= character then
			local targetChar = player.Character
			local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
			local targetHead = targetChar:FindFirstChild("Head")
			local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")
			local targetTorso = targetChar:FindFirstChild("Torso") or targetChar:FindFirstChild("UpperTorso")

			if targetHrp and targetHead and targetHumanoid and targetHumanoid.Health > 0 then
				local aimPart = hitbox == "Head" and targetHead or (targetTorso or targetHrp)
				local screenPos, onScreen = Camera:WorldToViewportPoint(aimPart.Position)
				local screenPos2D = Vector2.new(screenPos.X, screenPos.Y)
				local distanceFromCenter = (screenPos2D - screenCenter).Magnitude

				if distanceFromCenter <= fov then
					local worldDist = (hrp.Position - targetHrp.Position).Magnitude

					if not throughWalls then
						local raycastParams = RaycastParams.new()
						raycastParams.FilterDescendantsInstances = {character, targetChar, Camera}
						raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
						local direction = (aimPart.Position - Camera.CFrame.Position).Unit * (aimPart.Position - Camera.CFrame.Position).Magnitude
						local raycastResult = Workspace:Raycast(Camera.CFrame.Position, direction, raycastParams)

						if raycastResult then
							continue
						end
					end

					if worldDist < minDist then
						minDist = worldDist
						closest = aimPart
					end
				end
			end
		end
	end
	return closest
end

RunService.RenderStepped:Connect(function()
	local showFOV = Toggles.ShowFOV and Toggles.ShowFOV.Value
	local fovColor = Options.FOVColor and Options.FOVColor.Value or Color3.new(0, 1, 0)
	local fov = Options.AimFOV and Options.AimFOV.Value or 150

	FOV_Circle.Visible = showFOV and true or false
	FOV_Circle.Radius = fov
	FOV_Circle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
	FOV_Circle.Color = fovColor

	if Toggles.AimBot and Toggles.AimBot.Value then
		local throughWalls = Toggles.AimThroughWalls and Toggles.AimThroughWalls.Value
		local hitbox = Options.Hitbox and Options.Hitbox.Value or "Head"
		local smoothness = Options.AimSmoothness and Options.AimSmoothness.Value or 0.15
		local target = getClosestPlayer(throughWalls, fov, hitbox)

		if target then
			local targetPos = target.Position
			local cameraCFrame = Camera.CFrame
			local targetCFrame = CFrame.new(cameraCFrame.Position, targetPos)

			if smoothness > 0 then
				Camera.CFrame = cameraCFrame:Lerp(targetCFrame, smoothness)
			else
				Camera.CFrame = targetCFrame
			end
		end
	end

	if Toggles.PlayerESP and Toggles.PlayerESP.Value then
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer then
				createESP(player)
			end
		end
		updateESP()
	else
		for player, _ in pairs(ESPObjects) do
			removeESP(player)
		end
	end
end)

RunService.Stepped:Connect(function()
	if Toggles.NoClip and Toggles.NoClip.Value then
		local character = LocalPlayer.Character
		if character then
			for _, part in pairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end
	end
end)

local FlyBodyVelocity = nil
local FlyBodyGyro = nil

RunService.RenderStepped:Connect(function()
	if Toggles.Fly and Toggles.Fly.Value then
		local character = LocalPlayer.Character
		if not character then return end
		local hrp = character:FindFirstChild("HumanoidRootPart")
		if not hrp then return end

		if not FlyBodyVelocity then
			FlyBodyVelocity = Instance.new("BodyVelocity")
			FlyBodyVelocity.MaxForce = Vector3.new(500000, 500000, 500000)
			FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
			FlyBodyVelocity.Parent = hrp
		end

		if not FlyBodyGyro then
			FlyBodyGyro = Instance.new("BodyGyro")
			FlyBodyGyro.MaxTorque = Vector3.new(500000, 500000, 500000)
			FlyBodyGyro.P = 10000
			FlyBodyGyro.Parent = hrp
		end

		local flySpeed = Options.FlySpeed and Options.FlySpeed.Value or 50
		local moveDirection = Vector3.new(0, 0, 0)

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			moveDirection = moveDirection + Camera.CFrame.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			moveDirection = moveDirection - Camera.CFrame.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			moveDirection = moveDirection - Camera.CFrame.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			moveDirection = moveDirection + Camera.CFrame.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			moveDirection = moveDirection + Vector3.new(0, 1, 0)
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
			moveDirection = moveDirection - Vector3.new(0, 1, 0)
		end

		if moveDirection.Magnitude > 0 then
			moveDirection = moveDirection.Unit * flySpeed
		end

		FlyBodyVelocity.Velocity = moveDirection
		FlyBodyGyro.CFrame = Camera.CFrame
	else
		if FlyBodyVelocity then
			FlyBodyVelocity:Destroy()
			FlyBodyVelocity = nil
		end
		if FlyBodyGyro then
			FlyBodyGyro:Destroy()
			FlyBodyGyro = nil
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if Toggles.InfiniteJump and Toggles.InfiniteJump.Value then
		local character = LocalPlayer.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				local state = humanoid:GetState()
				if state == Enum.HumanoidStateType.Freefall then
					humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end
		end
	end
end)

LocalPlayer.CharacterAdded:Connect(function(character)
	wait(0.5)
	if Toggles.WalkSpeed and Toggles.WalkSpeed.Value then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = Options.WalkSpeed and Options.WalkSpeed.Value or 16
		end
	end
	if Toggles.JumpPower and Toggles.JumpPower.Value then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.JumpPower = Options.JumpPower and Options.JumpPower.Value or 50
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	removeESP(player)
end)

Library:Notify({
	Title = "scriptBOB",
	Description = "Loaded successfully! v1.0.0",
	Duration = 5,
})
