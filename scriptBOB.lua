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
	Tooltip = "Select target hitbox",
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

local MiscGroup2 = Tabs.Misc:AddRightGroupbox("Combat", "sword")

MiscGroup2:AddToggle("GodMode", {
	Text = "God Mode",
	Tooltip = "Take no damage",
	Default = false,
	Risky = true,
	Callback = function(Value)
		Library:Notify({
			Title = "scriptBOB",
			Description = Value and "God Mode enabled! (Risky)" or "God Mode disabled!",
			Duration = 3,
		})
	end,
})

MiscGroup2:AddToggle("Fullbright", {
	Text = "Fullbright",
	Tooltip = "Remove darkness from the map",
	Default = false,
	Callback = function(Value)
		if Value then
			game:GetService("Lighting").Brightness = 2
			game:GetService("Lighting").ClockTime = 14
			game:GetService("Lighting").GlobalShadows = false
			game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
			game:GetService("Lighting").OutdoorAmbient = Color3.new(1, 1, 1)
		else
			game:GetService("Lighting").Brightness = 1
			game:GetService("Lighting").ClockTime = 12
			game:GetService("Lighting").GlobalShadows = true
			game:GetService("Lighting").Ambient = Color3.new(0, 0, 0)
			game:GetService("Lighting").OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
		end
	end,
})

MiscGroup2:AddToggle("AutoReload", {
	Text = "Auto Reload",
	Tooltip = "Automatically reload weapon when empty",
	Default = false,
	Callback = function(Value)
		Library:Notify({
			Title = "scriptBOB",
			Description = Value and "Auto Reload enabled!" or "Auto Reload disabled!",
			Duration = 3,
		})
	end,
})

MiscGroup2:AddToggle("NoRecoil", {
	Text = "No Recoil",
	Tooltip = "Remove weapon recoil",
	Default = false,
	Callback = function(Value)
		Library:Notify({
			Title = "scriptBOB",
			Description = Value and "No Recoil enabled!" or "No Recoil disabled!",
			Duration = 3,
		})
	end,
})

MiscGroup2:AddToggle("NoSpread", {
	Text = "No Spread",
	Tooltip = "Remove bullet spread",
	Default = false,
	Callback = function(Value)
		Library:Notify({
			Title = "scriptBOB",
			Description = Value and "No Spread enabled!" or "No Spread disabled!",
			Duration = 3,
		})
	end,
})

MiscGroup2:AddToggle("InstantKill", {
	Text = "Instant Kill",
	Tooltip = "One shot kill",
	Default = false,
	Risky = true,
	Callback = function(Value)
		Library:Notify({
			Title = "scriptBOB",
			Description = Value and "Instant Kill enabled! (Risky)" or "Instant Kill disabled!",
			Duration = 3,
		})
	end,
})

MiscGroup2:AddDivider()
MiscGroup2:AddLabel("scriptBOB v1.0.0 - Combat")

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
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local FOV_Circle = Drawing.new("Circle")
FOV_Circle.Visible = false
FOV_Circle.Thickness = 1.5
FOV_Circle.NumSides = 64
FOV_Circle.Filled = false
FOV_Circle.Transparency = 0.7

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

RunService.RenderStepped:Connect(function()
	if Toggles.GodMode and Toggles.GodMode.Value then
		local character = LocalPlayer.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.Health = humanoid.MaxHealth
				humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
			end
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if Toggles.AutoReload and Toggles.AutoReload.Value then
		local character = LocalPlayer.Character
		if character then
			for _, tool in pairs(character:GetChildren()) do
				if tool:IsA("Tool") then
					local ammo = tool:FindFirstChild("Ammo") or tool:FindFirstChild(" ammo") or tool:FindFirstChild("CurrentAmmo")
					if ammo and ammo:IsA("NumberValue") and ammo.Value <= 0 then
						local reloadEvent = tool:FindFirstChild("Reload") or tool:FindFirstChild("ReloadEvent")
						if reloadEvent and reloadEvent:IsA("RemoteEvent") then
							reloadEvent:FireServer()
						end
					end
				end
			end
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if Toggles.NoRecoil and Toggles.NoRecoil.Value then
		local character = LocalPlayer.Character
		if character then
			for _, tool in pairs(character:GetChildren()) do
				if tool:IsA("Tool") then
					for _, v in pairs(tool:GetDescendants()) do
						if v:IsA("NumberValue") and (v.Name:lower():find("recoil") or v.Name:lower():find("kick")) then
							v.Value = 0
						end
					end
				end
			end
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if Toggles.NoSpread and Toggles.NoSpread.Value then
		local character = LocalPlayer.Character
		if character then
			for _, tool in pairs(character:GetChildren()) do
				if tool:IsA("Tool") then
					for _, v in pairs(tool:GetDescendants()) do
						if v:IsA("NumberValue") and (v.Name:lower():find("spread") or v.Name:lower():find("accuracy") or v.Name:lower():find("bulletspread")) then
							v.Value = 0
						end
					end
				end
			end
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if Toggles.InstantKill and Toggles.InstantKill.Value then
		local character = LocalPlayer.Character
		if character then
			for _, tool in pairs(character:GetChildren()) do
				if tool:IsA("Tool") then
					for _, v in pairs(tool:GetDescendants()) do
						if v:IsA("NumberValue") and (v.Name:lower():find("damage") or v.Name:lower():find("dmg") or v.Name:lower():find("hitdamage")) then
							v.Value = 999999
						end
					end
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

Library:Notify({
	Title = "scriptBOB",
	Description = "Loaded successfully! v1.0.0 - War Tycoon",
	Duration = 5,
})
