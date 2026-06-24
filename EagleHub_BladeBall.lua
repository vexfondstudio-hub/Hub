local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local Window = Library:CreateWindow({
	Title = "Eagle Hub",
	Footer = "version: 1.0.0",
	Icon = 95816097006870,
	NotifySide = "Right",
	ShowCustomCursor = true,
	MobileButtonsSide = "Left",
})

local Tabs = {
	Main = Window:AddTab("Main", "sword"),
	ESP = Window:AddTab("ESP", "eye"),
	["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox("Blade Ball", "sword")

LeftGroupBox:AddToggle("AutoParry", {
	Text = "Auto Parry Ball",
	Tooltip = "Automatically parry the ball when it comes near",
	Default = false,
	Callback = function(Value)
		Library:Notify({
			Title = "Eagle Hub",
			Description = Value and "Auto Parry enabled!" or "Auto Parry disabled!",
			Duration = 3,
		})
	end,
})

LeftGroupBox:AddSlider("ParryDistance", {
	Text = "Parry Distance",
	Default = 15,
	Min = 5,
	Max = 50,
	Rounding = 1,
	Compact = false,
	Callback = function(Value)
	end,
})

LeftGroupBox:AddSlider("ParryDelay", {
	Text = "Parry Delay (ms)",
	Default = 0,
	Min = 0,
	Max = 500,
	Rounding = 0,
	Compact = false,
	Callback = function(Value)
	end,
})

LeftGroupBox:AddToggle("InfinityJump", {
	Text = "Infinity Jump",
	Tooltip = "Jump infinitely without cooldown",
	Default = false,
	Callback = function(Value)
		Library:Notify({
			Title = "Eagle Hub",
			Description = Value and "Infinity Jump enabled!" or "Infinity Jump disabled!",
			Duration = 3,
		})
	end,
})

LeftGroupBox:AddDivider()

LeftGroupBox:AddLabel("Eagle Hub v1.0.0 - Blade Ball")
LeftGroupBox:AddLabel("PC & Mobile Compatible")

local ESPGroupBox = Tabs.ESP:AddLeftGroupbox("ESP", "eye")

ESPGroupBox:AddToggle("BallESP", {
	Text = "Ball ESP",
	Tooltip = "See ball through walls",
	Default = false,
	Callback = function(Value)
		Library:Notify({
			Title = "Eagle Hub",
			Description = Value and "Ball ESP enabled!" or "Ball ESP disabled!",
			Duration = 3,
		})
	end,
})

ESPGroupBox:AddColorPicker("BallESPColor", {
	Default = Color3.new(1, 0.5, 0),
	Title = "Ball Color",
	Callback = function(Value)
	end,
})

ESPGroupBox:AddToggle("PlayerESP", {
	Text = "Player ESP",
	Tooltip = "See players through walls",
	Default = false,
	Callback = function(Value)
		Library:Notify({
			Title = "Eagle Hub",
			Description = Value and "Player ESP enabled!" or "Player ESP disabled!",
			Duration = 3,
		})
	end,
})

ESPGroupBox:AddColorPicker("PlayerESPColor", {
	Default = Color3.new(1, 0, 0),
	Title = "Player Color",
	Callback = function(Value)
	end,
})

ESPGroupBox:AddToggle("PlayerESPName", {
	Text = "Show Names",
	Tooltip = "Show player names on ESP",
	Default = true,
	Callback = function(Value)
	end,
})

ESPGroupBox:AddToggle("PlayerESPDistance", {
	Text = "Show Distance",
	Tooltip = "Show distance to players",
	Default = true,
	Callback = function(Value)
	end,
})

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
			Title = "Eagle Hub",
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

local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "EagleHubESP"
ESPFolder.Parent = CoreGui

local function getBall()
	for _, v in pairs(Workspace:GetDescendants()) do
		if v:IsA("BasePart") and (v.Name:lower():find("ball") or v.Name:lower():find("swordball") or v.Name:lower():find("blade") or v.Name:lower():find("target")) then
			return v
		end
	end
	for _, v in pairs(Workspace:GetChildren()) do
		if v:IsA("BasePart") and v.Shape == Enum.PartType.Ball then
			return v
		end
	end
	return nil
end

local function createESP(part, color, name, isPlayer)
	if not part then return end
	if part:FindFirstChild("EagleHubESP") then return end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "EagleHubESP"
	billboard.AlwaysOnTop = true
	billboard.Size = UDim2.new(0, 200, 0, 50)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.Parent = part

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundTransparency = 1
	frame.Parent = billboard

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.TextColor3 = color
	nameLabel.TextStrokeTransparency = 0
	nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextSize = 14
	nameLabel.Text = name or "Unknown"
	nameLabel.Parent = frame

	local distLabel = Instance.new("TextLabel")
	distLabel.Size = UDim2.new(1, 0, 0.5, 0)
	distLabel.Position = UDim2.new(0, 0, 0.5, 0)
	distLabel.BackgroundTransparency = 1
	distLabel.TextColor3 = color
	distLabel.TextStrokeTransparency = 0
	distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
	distLabel.Font = Enum.Font.GothamBold
	distLabel.TextSize = 12
	distLabel.Text = ""
	distLabel.Parent = frame

	local highlight = Instance.new("Highlight")
	highlight.Name = "EagleHubHighlight"
	highlight.FillColor = color
	highlight.OutlineColor = color
	highlight.FillTransparency = 0.7
	highlight.OutlineTransparency = 0
	highlight.Adornee = part
	highlight.Parent = part

	return billboard
end

local function removeESP(part)
	if not part then return end
	for _, v in pairs(part:GetDescendants()) do
		if v.Name == "EagleHubESP" or v.Name == "EagleHubHighlight" then
			v:Destroy()
		end
	end
end

local function clearESP()
	for _, v in pairs(ESPFolder:GetDescendants()) do
		v:Destroy()
	end
	for _, v in pairs(Workspace:GetDescendants()) do
		removeESP(v)
	end
end

local function clickPC()
	VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
	wait(0.05)
	VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
end

local function clickMobile()
	local player = LocalPlayer
	local character = player.Character
	if not character then return end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local ball = getBall()
	if ball then
		local screenPos, onScreen = Camera:WorldToViewportPoint(ball.Position)
		if onScreen then
			VirtualInputManager:SendTouchEvent(screenPos.X, screenPos.Y, 0, true, game, 0)
			wait(0.05)
			VirtualInputManager:SendTouchEvent(screenPos.X, screenPos.Y, 0, false, game, 0)
		end
	end
end

local function click()
	if isMobile then
		clickMobile()
	else
		clickPC()
	end
end

task.spawn(function()
	while true do
		wait(0.01)
		if Toggles.AutoParry and Toggles.AutoParry.Value then
			local ball = getBall()
			local character = LocalPlayer.Character
			if ball and character then
				local hrp = character:FindFirstChild("HumanoidRootPart")
				if hrp then
					local distance = (hrp.Position - ball.Position).Magnitude
					local parryDist = Options.ParryDistance and Options.ParryDistance.Value or 15
					if distance <= parryDist then
						local delay = Options.ParryDelay and Options.ParryDelay.Value or 0
						if delay > 0 then
							wait(delay / 1000)
						end
						click()
					end
				end
			end
		end
	end
end)

task.spawn(function()
	while true do
		wait(0.1)
		if Toggles.InfinityJump and Toggles.InfinityJump.Value then
			local character = LocalPlayer.Character
			if character then
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					local state = humanoid:GetState()
					if state == Enum.HumanoidStateType.Freefall or state == Enum.HumanoidStateType.Landed then
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
	end
end)

task.spawn(function()
	while true do
		wait(0.2)
		if Toggles.BallESP and Toggles.BallESP.Value then
			local ball = getBall()
			local ballColor = Options.BallESPColor and Options.BallESPColor.Value or Color3.new(1, 0.5, 0)
			if ball then
				if not ball:FindFirstChild("EagleHubESP") then
					createESP(ball, ballColor, "Ball", false)
				end
			end
		else
			local ball = getBall()
			if ball then
				removeESP(ball)
			end
		end
	end
end)

task.spawn(function()
	while true do
		wait(0.2)
		if Toggles.PlayerESP and Toggles.PlayerESP.Value then
			local playerColor = Options.PlayerESPColor and Options.PlayerESPColor.Value or Color3.new(1, 0, 0)
			local showNames = Toggles.PlayerESPName and Toggles.PlayerESPName.Value
			local showDist = Toggles.PlayerESPDistance and Toggles.PlayerESPDistance.Value

			for _, player in pairs(Players:GetPlayers()) do
				if player ~= LocalPlayer then
					local character = player.Character
					if character then
						local hrp = character:FindFirstChild("HumanoidRootPart")
						if hrp then
							if not hrp:FindFirstChild("EagleHubESP") then
								local esp = createESP(hrp, playerColor, player.Name, true)
								if esp then
									local nameLabel = esp:FindFirstChild("Frame") and esp.Frame:FindFirstChild("TextLabel")
									if nameLabel then
										nameLabel.Visible = showNames ~= false
									end
								end
							else
								local esp = hrp:FindFirstChild("EagleHubESP")
								if esp then
									local frame = esp:FindFirstChild("Frame")
									if frame then
										local nameLabel = frame:FindFirstChild("TextLabel")
										local distLabel = nil
										for _, child in pairs(frame:GetChildren()) do
											if child:IsA("TextLabel") and child ~= nameLabel then
												distLabel = child
												break
											end
										end
										if nameLabel then
											nameLabel.Visible = showNames ~= false
											nameLabel.Text = player.Name
										end
										if distLabel then
											distLabel.Visible = showDist ~= false
											local localChar = LocalPlayer.Character
											if localChar then
												local localHrp = localChar:FindFirstChild("HumanoidRootPart")
												if localHrp then
													local dist = math.floor((localHrp.Position - hrp.Position).Magnitude)
													distLabel.Text = tostring(dist) .. " studs"
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		else
			for _, player in pairs(Players:GetPlayers()) do
				if player ~= LocalPlayer then
					local character = player.Character
					if character then
						local hrp = character:FindFirstChild("HumanoidRootPart")
						if hrp then
							removeESP(hrp)
						end
					end
				end
			end
		end
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	local character = player.Character
	if character then
		local hrp = character:FindFirstChild("HumanoidRootPart")
		if hrp then
			removeESP(hrp)
		end
	end
end)

Library:Notify({
	Title = "Eagle Hub",
	Description = "Loaded successfully! v1.0.0 (PC & Mobile)",
	Duration = 5,
})
