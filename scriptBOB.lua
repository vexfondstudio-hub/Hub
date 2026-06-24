local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "scriptBOB",
	LoadingTitle = "scriptBOB",
	LoadingSubtitle = "by BOB Team",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "scriptBOB",
		FileName = "scriptBOB_Config"
	},
	Discord = {
		Enabled = false,
		Invite = "",
		RememberJoins = true
	},
	KeySystem = false,
})

local AimBotTab = Window:CreateTab("AimBot", 4483345998)
local MiscTab = Window:CreateTab("Misc", 4483362458)

local AimBotSection = AimBotTab:CreateSection("AimBot Settings")

local AimBotToggle = AimBotTab:CreateToggle({
	Name = "AimBot",
	CurrentValue = false,
	Flag = "AimBot",
	Callback = function(Value)
		Rayfield:Notify({
			Title = "scriptBOB",
			Content = Value and "AimBot enabled!" or "AimBot disabled!",
			Duration = 3,
		})
	end,
})

local HitboxDropdown = AimBotTab:CreateDropdown({
	Name = "Hitbox",
	Options = {"Head", "Body"},
	CurrentOption = "Head",
	Flag = "Hitbox",
	Callback = function(Option)
		Rayfield:Notify({
			Title = "scriptBOB",
			Content = "Hitbox set to: " .. tostring(Option),
			Duration = 2,
		})
	end,
})

local AimThroughWallsToggle = AimBotTab:CreateToggle({
	Name = "Aim Through Walls",
	CurrentValue = false,
	Flag = "AimThroughWalls",
	Callback = function(Value)
		Rayfield:Notify({
			Title = "scriptBOB",
			Content = Value and "Aim Through Walls enabled!" or "Aim Through Walls disabled!",
			Duration = 3,
		})
	end,
})

local AimFOVSlider = AimBotTab:CreateSlider({
	Name = "Aim FOV",
	Range = {10, 500},
	Increment = 1,
	Suffix = "px",
	CurrentValue = 150,
	Flag = "AimFOV",
	Callback = function(Value)
	end,
})

local AimSmoothnessSlider = AimBotTab:CreateSlider({
	Name = "Aim Smoothness",
	Range = {0, 1},
	Increment = 0.01,
	Suffix = "",
	CurrentValue = 0.15,
	Flag = "AimSmoothness",
	Callback = function(Value)
	end,
})

local AimBotKeybind = AimBotTab:CreateKeybind({
	Name = "AimBot Keybind (Hold)",
	CurrentKeybind = "Q",
	HoldToInteract = true,
	Flag = "AimBotKeybind",
	Callback = function(Keybind)
	end,
})

local MiscSection = MiscTab:CreateSection("Movement")

local NoClipToggle = MiscTab:CreateToggle({
	Name = "NoClip",
	CurrentValue = false,
	Flag = "NoClip",
	Callback = function(Value)
		Rayfield:Notify({
			Title = "scriptBOB",
			Content = Value and "NoClip enabled!" or "NoClip disabled!",
			Duration = 3,
		})
	end,
})

local WalkSpeedSlider = MiscTab:CreateSlider({
	Name = "Walk Speed",
	Range = {1, 200},
	Increment = 1,
	Suffix = "",
	CurrentValue = 16,
	Flag = "WalkSpeed",
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

local JumpPowerSlider = MiscTab:CreateSlider({
	Name = "Jump Power",
	Range = {1, 200},
	Increment = 1,
	Suffix = "",
	CurrentValue = 50,
	Flag = "JumpPower",
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

local InfiniteJumpToggle = MiscTab:CreateToggle({
	Name = "Infinite Jump",
	CurrentValue = false,
	Flag = "InfiniteJump",
	Callback = function(Value)
		Rayfield:Notify({
			Title = "scriptBOB",
			Content = Value and "Infinite Jump enabled!" or "Infinite Jump disabled!",
			Duration = 3,
		})
	end,
})

local FlyToggle = MiscTab:CreateToggle({
	Name = "Fly",
	CurrentValue = false,
	Flag = "Fly",
	Callback = function(Value)
		Rayfield:Notify({
			Title = "scriptBOB",
			Content = Value and "Fly enabled!" or "Fly disabled!",
			Duration = 3,
		})
	end,
})

local FlySpeedSlider = MiscTab:CreateSlider({
	Name = "Fly Speed",
	Range = {10, 200},
	Increment = 1,
	Suffix = "",
	CurrentValue = 50,
	Flag = "FlySpeed",
	Callback = function(Value)
	end,
})

local ESPSection = MiscTab:CreateSection("ESP")

local PlayerESPToggle = MiscTab:CreateToggle({
	Name = "Player ESP",
	CurrentValue = false,
	Flag = "PlayerESP",
	Callback = function(Value)
		Rayfield:Notify({
			Title = "scriptBOB",
			Content = Value and "Player ESP enabled!" or "Player ESP disabled!",
			Duration = 3,
		})
	end,
})

local PlayerESPColor = MiscTab:CreateColorPicker({
	Name = "Player ESP Color",
	Color = Color3.fromRGB(255, 0, 0),
	Flag = "PlayerESPColor",
	Callback = function(Value)
	end,
})

local ShowNamesToggle = MiscTab:CreateToggle({
	Name = "Show Names",
	CurrentValue = true,
	Flag = "ShowNames",
	Callback = function(Value)
	end,
})

local ShowDistanceToggle = MiscTab:CreateToggle({
	Name = "Show Distance",
	CurrentValue = true,
	Flag = "ShowDistance",
	Callback = function(Value)
	end,
})

local ShowHealthToggle = MiscTab:CreateToggle({
	Name = "Show Health",
	CurrentValue = true,
	Flag = "ShowHealth",
	Callback = function(Value)
	end,
})

local BoxESPToggle = MiscTab:CreateToggle({
	Name = "Box ESP",
	CurrentValue = true,
	Flag = "BoxESP",
	Callback = function(Value)
	end,
})

local TracerESPToggle = MiscTab:CreateToggle({
	Name = "Tracer ESP",
	CurrentValue = false,
	Flag = "TracerESP",
	Callback = function(Value)
	end,
})

local TracerColor = MiscTab:CreateColorPicker({
	Name = "Tracer Color",
	Color = Color3.fromRGB(0, 255, 255),
	Flag = "TracerColor",
	Callback = function(Value)
	end,
})

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

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

		local playerColor = PlayerESPColor.CurrentColor or Color3.fromRGB(255, 0, 0)
		local tracerColor = TracerColor.CurrentColor or Color3.fromRGB(0, 255, 255)
		local showNames = ShowNamesToggle.CurrentValue
		local showDist = ShowDistanceToggle.CurrentValue
		local showHealth = ShowHealthToggle.CurrentValue
		local showBox = BoxESPToggle.CurrentValue
		local showTracer = TracerESPToggle.CurrentValue

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
			espData.box.Position = Vector2.new(headPos.X - boxWidth / 2, headPos.Y)
			espData.box.Color = playerColor
		else
			espData.box.Visible = false
		end

		if showNames then
			espData.name.Visible = true
			espData.name.Position = Vector2.new(headPos.X, headPos.Y - 15)
			espData.name.Text = player.Name
			espData.name.Color = playerColor
		else
			espData.name.Visible = false
		end

		if showDist then
			espData.distance.Visible = true
			espData.distance.Position = Vector2.new(headPos.X, footPos.Y + 5)
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
			local barPos = Vector2.new(headPos.X - boxWidth / 2 - 8, headPos.Y + (boxHeight - barHeight) / 2)

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
			espData.tracer.To = Vector2.new(headPos.X, footPos.Y)
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

local function isKeybindPressed()
	local keybind = AimBotKeybind.CurrentKeybind
	if not keybind or keybind == "" then return true end

	if isMobile then
		return UserInputService:IsMouseButtonPressed(Enum.UserInputType.Touch)
	else
		return UserInputService:IsKeyDown(Enum.KeyCode[keybind])
	end
end

RunService.RenderStepped:Connect(function()
	local aimBotEnabled = AimBotToggle.CurrentValue
	local isHoldingKeybind = isKeybindPressed()

	if aimBotEnabled and isHoldingKeybind then
		local throughWalls = AimThroughWallsToggle.CurrentValue
		local hitbox = HitboxDropdown.CurrentOption
		local fov = AimFOVSlider.CurrentValue
		local smoothness = AimSmoothnessSlider.CurrentValue
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

	if PlayerESPToggle.CurrentValue then
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
	if NoClipToggle.CurrentValue then
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
	if FlyToggle.CurrentValue then
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

		local flySpeed = FlySpeedSlider.CurrentValue
		local moveDirection = Vector3.new(0, 0, 0)

		if isMobile then
			local touchPoints = UserInputService:GetTouchPoints()
			if #touchPoints > 0 then
				local touch = touchPoints[1]
				local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
				local touchOffset = touch.Position - screenCenter

				if touchOffset.X > 50 then
					moveDirection = moveDirection + Camera.CFrame.RightVector
				elseif touchOffset.X < -50 then
					moveDirection = moveDirection - Camera.CFrame.RightVector
				end

				if touchOffset.Y > 50 then
					moveDirection = moveDirection - Camera.CFrame.LookVector
				elseif touchOffset.Y < -50 then
					moveDirection = moveDirection + Camera.CFrame.LookVector
				end
			end

			moveDirection = moveDirection + Vector3.new(0, 1, 0)
		else
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
	if InfiniteJumpToggle.CurrentValue then
		local character = LocalPlayer.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				local state = humanoid:GetState()
				if state == Enum.HumanoidStateType.Freefall then
					if isMobile then
						VirtualInputManager:SendTouchEvent(100, 500, 0, true, game, 0)
						wait(0.05)
						VirtualInputManager:SendTouchEvent(100, 500, 0, false, game, 0)
					else
						VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
						wait(0.05)
						VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
					end
				end
			end
		end
	end
end)

LocalPlayer.CharacterAdded:Connect(function(character)
	wait(0.5)
	if WalkSpeedSlider.CurrentValue ~= 16 then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = WalkSpeedSlider.CurrentValue
		end
	end
	if JumpPowerSlider.CurrentValue ~= 50 then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.JumpPower = JumpPowerSlider.CurrentValue
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	removeESP(player)
end)

Rayfield:Notify({
	Title = "scriptBOB",
	Content = "Loaded successfully! v1.0.0 - PC & Mobile",
	Duration = 5,
})
