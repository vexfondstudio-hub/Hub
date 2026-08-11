local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

pcall(function()
    local ts = game:GetService("TeleportService")
    local gs = game:GetService("GuiService")
    local pid = game.PlaceId
    local jid = game.JobId
    gs.ErrorMessageChanged:Connect(function()
        if gs:GetErrorMessage() ~= "" then
            task.wait(2)
            ts:TeleportToPlaceInstance(pid, jid, player)
        end
    end)
end)

pcall(function()
    local mt = getrawmetatable(game)
    if mt then
        local oldNamecall = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "Kick" or method == "kick" then
                return nil
            end
            if method == "Destroy" and self == CoreGui then
                return nil
            end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
    end
end)

pcall(function()
    local mt = getrawmetatable(game)
    if mt then
        local oldIndex = mt.__index
        setreadonly(mt, false)
        mt.__index = newcclosure(function(self, key)
            if key == "Kick" or key == "kick" then
                return function() end
            end
            return oldIndex(self, key)
        end)
        setreadonly(mt, true)
    end
end)

pcall(function()
    for _, v in pairs(getconnections(RunService.RenderStepped)) do
        if v.Enabled then
            local scr = rawget(getfenv(v.Function), "script")
            if scr and scr.Name == "ZombieHub" then
                v:Disable()
                v:Enable()
            end
        end
    end
end)

pcall(function()
    _G.ZombieHub = nil
    getgenv().ZombieHub = nil
end)

if CoreGui:FindFirstChild("ZombieHub") then
    CoreGui.ZombieHub:Destroy()
end

local sg = Instance.new("ScreenGui")
sg.Name = "ZombieHub"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
sg.IgnoreGuiInset = true
sg.Parent = CoreGui

pcall(function()
    sg.Name = "RobloxGui"
end)

local loadFrame = Instance.new("Frame")
loadFrame.Size = UDim2.new(1, 0, 1, 0)
loadFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
loadFrame.BorderSizePixel = 0
loadFrame.ZIndex = 10000
loadFrame.Parent = sg

local logoBack = Instance.new("Frame")
logoBack.Size = UDim2.new(0, 120, 0, 120)
logoBack.Position = UDim2.new(0.5, -60, 0.5, -100)
logoBack.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
logoBack.BorderSizePixel = 0
logoBack.ZIndex = 10001
logoBack.Parent = loadFrame
local logoCorner = Instance.new("UICorner", logoBack)
logoCorner.CornerRadius = UDim.new(1, 0)

local logoGrad = Instance.new("UIGradient", logoBack)
logoGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 100)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 255, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 100))
}
logoGrad.Rotation = 45

local logoText = Instance.new("TextLabel")
logoText.Size = UDim2.new(1, 0, 1, 0)
logoText.BackgroundTransparency = 1
logoText.Text = "ZH"
logoText.TextColor3 = Color3.fromRGB(5, 5, 5)
logoText.TextSize = 48
logoText.Font = Enum.Font.GothamBlack
logoText.ZIndex = 10002
logoText.Parent = logoBack

local loadText = Instance.new("TextLabel")
loadText.Size = UDim2.new(0, 400, 0, 22)
loadText.Position = UDim2.new(0.5, -200, 0.5, 38)
loadText.BackgroundTransparency = 1
loadText.Text = "Initializing..."
loadText.TextColor3 = Color3.fromRGB(0, 255, 100)
loadText.TextSize = 16
loadText.Font = Enum.Font.GothamBold
loadText.ZIndex = 10001
loadText.Parent = loadFrame

local percentText = Instance.new("TextLabel")
percentText.Size = UDim2.new(0, 100, 0, 18)
percentText.Position = UDim2.new(0.5, -50, 0.5, 62)
percentText.BackgroundTransparency = 1
percentText.Text = "0%"
percentText.TextColor3 = Color3.fromRGB(0, 255, 100)
percentText.TextSize = 13
percentText.Font = Enum.Font.Gotham
percentText.ZIndex = 10001
percentText.Parent = loadFrame

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0, 280, 0, 5)
barBg.Position = UDim2.new(0.5, -140, 0.5, 86)
barBg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
barBg.BorderSizePixel = 0
barBg.ZIndex = 10001
barBg.Parent = loadFrame
Instance.new("UICorner", barBg).CornerRadius = UDim.new(0, 3)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
barFill.BorderSizePixel = 0
barFill.ZIndex = 10002
barFill.Parent = barBg
Instance.new("UICorner", barFill).CornerRadius = UDim.new(0, 3)

local barGrad = Instance.new("UIGradient", barFill)
barGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 100)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 255, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 100))
}

local glow = Instance.new("Frame")
glow.Size = UDim2.new(0, 160, 0, 160)
glow.Position = UDim2.new(0.5, -80, 0.5, -110)
glow.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
glow.BackgroundTransparency = 0.92
glow.BorderSizePixel = 0
glow.ZIndex = 9999
glow.Parent = loadFrame
Instance.new("UICorner", glow).CornerRadius = UDim.new(1, 0)

local glowGrad = Instance.new("UIGradient", glow)
glowGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 50))
}

local hudFrame = Instance.new("Frame")
hudFrame.Name = "HUD"
hudFrame.Size = UDim2.new(0, 220, 0, 80)
hudFrame.Position = UDim2.new(0, 14, 0, 14)
hudFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
hudFrame.BackgroundTransparency = 0.08
hudFrame.BorderSizePixel = 0
hudFrame.ZIndex = 5000
hudFrame.Parent = sg
hudFrame.Visible = false
hudFrame.Active = true
hudFrame.ClipsDescendants = true
Instance.new("UICorner", hudFrame).CornerRadius = UDim.new(0, 12)

local hudStroke = Instance.new("UIStroke", hudFrame)
hudStroke.Color = Color3.fromRGB(0, 255, 100)
hudStroke.Thickness = 1.5

local hudStrokeGrad = Instance.new("UIGradient", hudStroke)
hudStrokeGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 100)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 255, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 100))
}

local hudLogo = Instance.new("TextLabel")
hudLogo.Size = UDim2.new(0, 28, 0, 28)
hudLogo.Position = UDim2.new(0, 10, 0, 8)
hudLogo.BackgroundTransparency = 1
hudLogo.Text = "ZH"
hudLogo.TextColor3 = Color3.fromRGB(0, 255, 100)
hudLogo.TextSize = 20
hudLogo.Font = Enum.Font.GothamBlack
hudLogo.ZIndex = 5001
hudLogo.Parent = hudFrame

local hudTitle = Instance.new("TextLabel")
hudTitle.Size = UDim2.new(0, 150, 0, 20)
hudTitle.Position = UDim2.new(0, 42, 0, 12)
hudTitle.BackgroundTransparency = 1
hudTitle.Text = "Zombie Hub"
hudTitle.TextColor3 = Color3.fromRGB(0, 255, 100)
hudTitle.TextSize = 14
hudTitle.Font = Enum.Font.GothamBold
hudTitle.TextXAlignment = Enum.TextXAlignment.Left
hudTitle.ZIndex = 5001
hudTitle.Parent = hudFrame

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 100, 0, 18)
fpsLabel.Position = UDim2.new(0, 12, 0, 38)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: --"
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
fpsLabel.TextSize = 13
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.ZIndex = 5001
fpsLabel.Parent = hudFrame

local pingLabel = Instance.new("TextLabel")
pingLabel.Size = UDim2.new(0, 110, 0, 18)
pingLabel.Position = UDim2.new(0, 12, 0, 56)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "Ping: --"
pingLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
pingLabel.TextSize = 13
pingLabel.Font = Enum.Font.GothamBold
pingLabel.TextXAlignment = Enum.TextXAlignment.Left
pingLabel.ZIndex = 5001
pingLabel.Parent = hudFrame

local fpsCapLabel = Instance.new("TextLabel")
fpsCapLabel.Size = UDim2.new(0, 80, 0, 18)
fpsCapLabel.Position = UDim2.new(1, -90, 0, 38)
fpsCapLabel.BackgroundTransparency = 1
fpsCapLabel.Text = "UNCAPPED"
fpsCapLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
fpsCapLabel.TextSize = 11
fpsCapLabel.Font = Enum.Font.GothamBold
fpsCapLabel.TextXAlignment = Enum.TextXAlignment.Right
fpsCapLabel.ZIndex = 5001
fpsCapLabel.Parent = hudFrame

local divider = Instance.new("Frame")
divider.Size = UDim2.new(0, 1, 0, 44)
divider.Position = UDim2.new(1, -96, 0, 34)
divider.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
divider.BackgroundTransparency = 0.6
divider.BorderSizePixel = 0
divider.ZIndex = 5001
divider.Parent = hudFrame

local peekLeft = Instance.new("TextButton")
peekLeft.Name = "PeekLeft"
peekLeft.Size = UDim2.new(0, 22, 0, 50)
peekLeft.Position = UDim2.new(0, -22, 0, 14)
peekLeft.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
peekLeft.Text = ">"
peekLeft.TextColor3 = Color3.fromRGB(0, 255, 100)
peekLeft.TextSize = 16
peekLeft.Font = Enum.Font.GothamBold
peekLeft.BorderSizePixel = 0
peekLeft.AutoButtonColor = false
peekLeft.ZIndex = 4999
peekLeft.Parent = sg
peekLeft.Visible = false
Instance.new("UICorner", peekLeft).CornerRadius = UDim.new(0, 6)
local peekLeftStroke = Instance.new("UIStroke", peekLeft)
peekLeftStroke.Color = Color3.fromRGB(0, 255, 100)
peekLeftStroke.Thickness = 1.5

local peekRight = Instance.new("TextButton")
peekRight.Name = "PeekRight"
peekRight.Size = UDim2.new(0, 22, 0, 50)
peekRight.Position = UDim2.new(1, 0, 0, 14)
peekRight.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
peekRight.Text = "<"
peekRight.TextColor3 = Color3.fromRGB(0, 255, 100)
peekRight.TextSize = 16
peekRight.Font = Enum.Font.GothamBold
peekRight.BorderSizePixel = 0
peekRight.AutoButtonColor = false
peekRight.ZIndex = 4999
peekRight.Parent = sg
peekRight.Visible = false
Instance.new("UICorner", peekRight).CornerRadius = UDim.new(0, 6)
local peekRightStroke = Instance.new("UIStroke", peekRight)
peekRightStroke.Color = Color3.fromRGB(0, 255, 100)
peekRightStroke.Thickness = 1.5

local fpsCount = 0
local fpsLast = tick()
RunService.RenderStepped:Connect(function()
    fpsCount = fpsCount + 1
    local now = tick()
    if now - fpsLast >= 1 then
        fpsLabel.Text = "FPS: " .. fpsCount
        fpsCount = 0
        fpsLast = now
    end
end)

task.spawn(function()
    while true do
        local ping = 0
        pcall(function()
            ping = player:GetNetworkPing() * 1000
        end)
        pingLabel.Text = "Ping: " .. math.floor(ping) .. " ms"
        task.wait(1)
    end
end)

task.spawn(function()
    while barGrad and barGrad.Parent do
        TweenService:Create(barGrad, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {Offset = Vector2.new(1, 0)}):Play()
        task.wait(1.5)
        if not barGrad or not barGrad.Parent then break end
        barGrad.Offset = Vector2.new(-1, 0)
    end
end)

task.spawn(function()
    while logoGrad and logoGrad.Parent do
        TweenService:Create(logoGrad, TweenInfo.new(2.5, Enum.EasingStyle.Linear), {Rotation = logoGrad.Rotation + 180}):Play()
        task.wait(2.5)
    end
end)

task.spawn(function()
    while hudStrokeGrad and hudStrokeGrad.Parent do
        TweenService:Create(hudStrokeGrad, TweenInfo.new(2, Enum.EasingStyle.Linear), {Offset = Vector2.new(1, 0)}):Play()
        task.wait(2)
        if not hudStrokeGrad or not hudStrokeGrad.Parent then break end
        hudStrokeGrad.Offset = Vector2.new(-1, 0)
    end
end)

local hudHidden = false
local hudSide = nil
local savedHudPos = nil
local HUD_EDGE_MARGIN = 18
local PEEK_MARGIN = 12

local function snapHudToEdge()
    if not hudFrame.Visible then return end
    local vp = camera.ViewportSize
    local absX = hudFrame.AbsolutePosition.X
    local absY = hudFrame.AbsolutePosition.Y
    local w = hudFrame.AbsoluteSize.X
    local h = hudFrame.AbsoluteSize.Y
    local edgeDist = 35

    if absX < edgeDist then
        hudSide = "left"
        savedHudPos = UDim2.new(0, HUD_EDGE_MARGIN, 0, math.clamp(absY, HUD_EDGE_MARGIN, vp.Y - h - HUD_EDGE_MARGIN))
        TweenService:Create(hudFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(0, -w + 4, 0, absY)}):Play()
        task.wait(0.3)
        hudFrame.Visible = false
        hudHidden = true
        peekLeft.Position = UDim2.new(0, 0, 0, math.clamp(absY + h / 2 - 25, PEEK_MARGIN, vp.Y - 50 - PEEK_MARGIN))
        peekLeft.Visible = true
        TweenService:Create(peekLeft, TweenInfo.new(0.25), {Position = UDim2.new(0, 4, 0, peekLeft.Position.Y.Offset)}):Play()
    elseif absX + w > vp.X - edgeDist then
        hudSide = "right"
        savedHudPos = UDim2.new(1, -w - HUD_EDGE_MARGIN, 0, math.clamp(absY, HUD_EDGE_MARGIN, vp.Y - h - HUD_EDGE_MARGIN))
        TweenService:Create(hudFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -4, 0, absY)}):Play()
        task.wait(0.3)
        hudFrame.Visible = false
        hudHidden = true
        peekRight.Position = UDim2.new(1, -22, 0, math.clamp(absY + h / 2 - 25, PEEK_MARGIN, vp.Y - 50 - PEEK_MARGIN))
        peekRight.Visible = true
        TweenService:Create(peekRight, TweenInfo.new(0.25), {Position = UDim2.new(1, -26, 0, peekRight.Position.Y.Offset)}):Play()
    end
end

local function restoreHud()
    if hudSide == "left" then
        TweenService:Create(peekLeft, TweenInfo.new(0.2), {Position = UDim2.new(0, -22, 0, peekLeft.Position.Y.Offset)}):Play()
        task.wait(0.2)
        peekLeft.Visible = false
        hudFrame.Visible = true
        hudHidden = false
        TweenService:Create(hudFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = savedHudPos or UDim2.new(0, HUD_EDGE_MARGIN, 0, HUD_EDGE_MARGIN)}):Play()
    elseif hudSide == "right" then
        TweenService:Create(peekRight, TweenInfo.new(0.2), {Position = UDim2.new(1, 0, 0, peekRight.Position.Y.Offset)}):Play()
        task.wait(0.2)
        peekRight.Visible = false
        hudFrame.Visible = true
        hudHidden = false
        TweenService:Create(hudFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = savedHudPos or UDim2.new(1, -220 - HUD_EDGE_MARGIN, 0, HUD_EDGE_MARGIN)}):Play()
    end
    hudSide = nil
end

peekLeft.MouseButton1Click:Connect(restoreHud)
peekRight.MouseButton1Click:Connect(restoreHud)

peekLeft.MouseEnter:Connect(function()
    if hudHidden and hudSide == "left" then
        TweenService:Create(peekLeft, TweenInfo.new(0.15), {Position = UDim2.new(0, 8, 0, peekLeft.Position.Y.Offset)}):Play()
    end
end)
peekLeft.MouseLeave:Connect(function()
    if hudHidden and hudSide == "left" then
        TweenService:Create(peekLeft, TweenInfo.new(0.15), {Position = UDim2.new(0, 4, 0, peekLeft.Position.Y.Offset)}):Play()
    end
end)

peekRight.MouseEnter:Connect(function()
    if hudHidden and hudSide == "right" then
        TweenService:Create(peekRight, TweenInfo.new(0.15), {Position = UDim2.new(1, -30, 0, peekRight.Position.Y.Offset)}):Play()
    end
end)
peekRight.MouseLeave:Connect(function()
    if hudHidden and hudSide == "right" then
        TweenService:Create(peekRight, TweenInfo.new(0.15), {Position = UDim2.new(1, -26, 0, peekRight.Position.Y.Offset)}):Play()
    end
end)

local dragging = false
local dragStart = nil
local startPos = nil

hudFrame.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = inp.Position
        startPos = hudFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(inp)
    if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
        local delta = inp.Position - dragStart
        hudFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(inp)
    if dragging and (inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch) then
        dragging = false
        snapHudToEdge()
    end
end)

UserInputService.InputBegan:Connect(function(inp, gpe)
    if not gpe and inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == Enum.KeyCode.RightShift then
        if hudHidden then
            restoreHud()
        else
            hudFrame.Visible = not hudFrame.Visible
        end
    end
end)

local function setProgress(pct, txt)
    percentText.Text = pct .. "%"
    loadText.Text = txt
    TweenService:Create(barFill, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(pct / 100, 0, 1, 0)}):Play()
end

local function closeLoader()
    local ti = TweenInfo.new(0.6, Enum.EasingStyle.Quad)
    TweenService:Create(loadFrame, ti, {BackgroundTransparency = 1}):Play()
    for _, c in ipairs(loadFrame:GetDescendants()) do
        if c:IsA("GuiObject") then
            local props = {BackgroundTransparency = 1}
            if c:IsA("TextLabel") or c:IsA("TextButton") then
                props.TextTransparency = 1
            end
            if c:IsA("ImageLabel") or c:IsA("ImageButton") then
                props.ImageTransparency = 1
            end
            TweenService:Create(c, ti, props):Play()
        end
    end
    task.wait(0.7)
    loadFrame.Visible = false
    task.wait(0.1)
    pcall(function() loadFrame:Destroy() end)
    hudFrame.Visible = true
end

local function showNotify(msg, col)
    col = col or Color3.fromRGB(0, 255, 100)
    local toast = Instance.new("Frame")
    toast.Size = UDim2.new(0, 320, 0, 30)
    toast.Position = UDim2.new(0.5, -160, 1, 40)
    toast.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    toast.BackgroundTransparency = 0.1
    toast.BorderSizePixel = 0
    toast.ZIndex = 9000
    toast.Parent = sg
    Instance.new("UICorner", toast).CornerRadius = UDim.new(0, 8)
    local ts = Instance.new("UIStroke", toast)
    ts.Color = col
    ts.Thickness = 1.5
    local tl = Instance.new("TextLabel")
    tl.Size = UDim2.new(1, -16, 1, 0)
    tl.Position = UDim2.new(0, 8, 0, 0)
    tl.BackgroundTransparency = 1
    tl.Text = msg
    tl.TextColor3 = col
    tl.TextSize = 11
    tl.Font = Enum.Font.GothamBold
    tl.TextXAlignment = Enum.TextXAlignment.Center
    tl.ZIndex = 9001
    tl.Parent = toast
    TweenService:Create(toast, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -160, 1, -44)}):Play()
    task.wait(4)
    TweenService:Create(toast, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -160, 1, 40)}):Play()
    task.wait(0.45)
    pcall(function() toast:Destroy() end)
end

local function applyFastFlags()
    local ok = false
    pcall(function()
        local fflags = {
            FFlagDebugSkyGray = true,
            FFlagRenderSky = false,
            FFlagRenderClouds = false,
            FFlagDebugForceAtmosphereDisable = true,
            FFlagDebugForceCloudDisable = true,
            FFlagDebugDisableDynamicAtmosphere2 = true,
            FFlagDebugRenderingDisableMaterials = true,
            FFlagDebugRenderingDisableDecals = true,
            FFlagRenderTextureQuality = 0,
            DFIntTextureQualityOverride = 0,
            DFFlagTextureAggregatorUseLowResFactor = true,
            FFlagRenderTerrainMaterials = false,
            DFFlagDebugGraphicsDisableParticles = true,
            DFFlagDebugGraphicsDisablePostFx = true,
            FFlagRenderShadows = false,
            FFlagRenderHighQuality = false,
            FFlagDebugForceLowQualityShaders = true,
            FFlagRenderLightingQuality = 0,
            FFlagRenderBloom = false,
            FFlagRenderMotionBlur = false,
            FFlagRenderDOF = false,
            FFlagRenderVignette = false,
            FFlagRenderAmbientOcclusion = false,
            FFlagRenderReflections = false,
            FFlagRenderTerrainShadows = false,
            FFlagRenderGlobalShadows = false,
            FFlagRenderLocalLightShadows = false,
            FIntRenderShadowIntensity = 0,
            FFlagDebugGraphicsDisablePostFxUI = true,
            FFlagDebugGraphicsDisableUiBlur = true,
            FFlagDebugGraphicsDisableUIAntiAliasing = true,
            FFlagOptimizeNetwork = true,
            FFlagOptimizeNetworkTransport = true,
            FFlagEnableNewNetworkRoute = true,
            DFIntOptimizePingThreshold = 7,
            DFIntRakNetResendRttMultiple = 1,
            DFIntRakNetLoopMs = 1,
            DFIntRakNetSelectTimeoutMs = 1,
            DFFlagRakNetPriorityPings = true,
            DFIntRakNetUrgentPriorityAggressiveSendIntervalMS = 1,
            FFlagNetworkOptimizeIncomingPacketQueue = true,
            FFlagNetworkUseSubTickPacketProcessing = true,
            FFlagNetworkDisablePacketThrottling = true,
            DFIntNetworkPacketLimitOverride = 999999,
            FFlagNetworkStreamInAggressiveMode = true,
            DFIntNetworkBufferTargetLatencyMS = 0,
            DFIntNetworkIncomingPacketQueueTargetLatencyMs = 0,
            FFlagDisableNetworkNaglesAlgorithm = true,
            DFIntTaskSchedulerTargetFps = 1000,
            FFlagTaskSchedulerLimitTargetFpsToScreenRefreshRate = false,
            FFlagDebugDisableVsync = true,
            FFlagTaskSchedulerPrioritizeNetworkOverRender = true,
            FFlagFastQuit = true,
            FIntFastQuitTimeoutMs = 0,
            FFlagDebugDisplayFPS = true,
            DFFlagTextureQualityOverrideEnabled = "True",
            FFlagHandleAltEnterFullscreenManually = "False",
            DFFlagDisableDPIScale = "True",
            DFFlagDebugPauseVoxelizer = "True",
            DFIntDebugFRMQualityLevelOverride = "1",
            FIntDebugForceMSAASamples = "1",
            FIntFRMMinGrassDistance = "0",
            FIntFRMMaxGrassDistance = "0",
            DFIntCSGLevelOfDetailSwitchingDistance = "0",
            DFIntCSGLevelOfDetailSwitchingDistanceL12 = "0",
            DFIntCSGLevelOfDetailSwitchingDistanceL34 = "0",
            DFIntCSGLevelOfDetailSwitchingDistanceL23 = "0",
            DFIntStreamingMinRadius = 0,
            DFIntStreamingTargetRadius = 0,
            FFlagDebugStreamingForceEnable = false,
            FFlagStreamingEnabled = false,
            DFIntLevelOfDetailMin = 0,
            DFIntLevelOfDetailMax = 0,
            FFlagDebugRenderingSetLODDistance = false,
            FFlagRenderLODs = false
        }
        if writefile then
            writefile("ClientSettings/ClientAppSettings.json", HttpService:JSONEncode(fflags))
            ok = true
        end
    end)
    return ok
end

local markerName = "ZombieHub_Marker"
local visualCache = {}

local function createMarker(char)
    pcall(function()
        if not char:FindFirstChild(markerName) then
            local folder = Instance.new("Folder")
            folder.Name = markerName
            folder.Parent = char
        end
    end)
end

local function setupLocalVisuals(char)
    pcall(function()
        local hrp = char:WaitForChild("HumanoidRootPart", 3)
        local head = char:WaitForChild("Head", 3)
        if not hrp or not head then return end

        local att0 = Instance.new("Attachment")
        att0.Name = "ZH_Trail0"
        att0.Position = Vector3.new(0, 0, 1.2)
        att0.Parent = hrp

        local att1 = Instance.new("Attachment")
        att1.Name = "ZH_Trail1"
        att1.Position = Vector3.new(0, 0, -1.2)
        att1.Parent = hrp

        local trail = Instance.new("Trail")
        trail.Name = "ZH_Trail"
        trail.Attachment0 = att0
        trail.Attachment1 = att1
        trail.Color = ColorSequence.new(Color3.fromRGB(0, 255, 100))
        trail.WidthScale = NumberSequence.new(0.15, 0)
        trail.Lifetime = 0.6
        trail.LightEmission = 1
        trail.LightInfluence = 0
        trail.FaceCamera = true
        trail.Parent = hrp

        local bb = Instance.new("BillboardGui")
        bb.Name = "ZH_NameTag"
        bb.Size = UDim2.new(0, 160, 0, 24)
        bb.StudsOffset = Vector3.new(0, 3.2, 0)
        bb.AlwaysOnTop = true
        bb.MaxDistance = 500
        bb.Parent = head

        local nl = Instance.new("TextLabel")
        nl.Size = UDim2.new(1, 0, 1, 0)
        nl.BackgroundTransparency = 1
        nl.Text = player.Name .. "|Zombie Hub"
        nl.TextColor3 = Color3.fromRGB(0, 255, 100)
        nl.TextStrokeTransparency = 0.4
        nl.TextStrokeColor3 = Color3.fromRGB(0, 40, 20)
        nl.TextSize = 14
        nl.Font = Enum.Font.GothamBold
        nl.Parent = bb
    end)
end

local function setupOtherVisuals(targetPlr)
    pcall(function()
        if targetPlr == player then return end
        if visualCache[targetPlr] then return end
        local char = targetPlr.Character
        if not char then return end
        if not char:FindFirstChild(markerName) then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local head = char:FindFirstChild("Head")
        if not hrp or not head then return end

        local visuals = {}

        local att0 = Instance.new("Attachment")
        att0.Name = "ZH_Trail0"
        att0.Position = Vector3.new(0, 0, 1.2)
        att0.Parent = hrp
        table.insert(visuals, att0)

        local att1 = Instance.new("Attachment")
        att1.Name = "ZH_Trail1"
        att1.Position = Vector3.new(0, 0, -1.2)
        att1.Parent = hrp
        table.insert(visuals, att1)

        local trail = Instance.new("Trail")
        trail.Name = "ZH_Trail"
        trail.Attachment0 = att0
        trail.Attachment1 = att1
        trail.Color = ColorSequence.new(Color3.fromRGB(0, 255, 100))
        trail.WidthScale = NumberSequence.new(0.15, 0)
        trail.Lifetime = 0.6
        trail.LightEmission = 1
        trail.LightInfluence = 0
        trail.FaceCamera = true
        trail.Parent = hrp
        table.insert(visuals, trail)

        local bb = Instance.new("BillboardGui")
        bb.Name = "ZH_NameTag"
        bb.Size = UDim2.new(0, 160, 0, 24)
        bb.StudsOffset = Vector3.new(0, 3.2, 0)
        bb.AlwaysOnTop = true
        bb.MaxDistance = 500
        bb.Parent = head
        table.insert(visuals, bb)

        local nl = Instance.new("TextLabel")
        nl.Size = UDim2.new(1, 0, 1, 0)
        nl.BackgroundTransparency = 1
        nl.Text = targetPlr.Name .. "|Zombie Hub"
        nl.TextColor3 = Color3.fromRGB(0, 255, 100)
        nl.TextStrokeTransparency = 0.4
        nl.TextStrokeColor3 = Color3.fromRGB(0, 40, 20)
        nl.TextSize = 14
        nl.Font = Enum.Font.GothamBold
        nl.Parent = bb
        table.insert(visuals, nl)

        visualCache[targetPlr] = visuals
    end)
end

local function cleanupOtherVisuals(targetPlr)
    pcall(function()
        local visuals = visualCache[targetPlr]
        if visuals then
            for _, obj in ipairs(visuals) do
                pcall(function() obj:Destroy() end)
            end
            visualCache[targetPlr] = nil
        end
    end)
end

player.CharacterAdded:Connect(function(char)
    createMarker(char)
    setupLocalVisuals(char)
end)
if player.Character then
    createMarker(player.Character)
    setupLocalVisuals(player.Character)
end

local function onPlayerAdded(targetPlr)
    targetPlr.CharacterAdded:Connect(function(char)
        task.wait(0.6)
        setupOtherVisuals(targetPlr)
    end)
    if targetPlr.Character then
        setupOtherVisuals(targetPlr)
    end
end

for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= player then
        onPlayerAdded(plr)
    end
end
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(cleanupOtherVisuals)

task.spawn(function()
    while true do
        task.wait(3)
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player then
                setupOtherVisuals(plr)
            end
        end
    end
end)

pcall(function()
    local nv = Instance.new("ColorCorrectionEffect")
    nv.Name = "ZH_NightVision"
    nv.Brightness = 0.15
    nv.Contrast = 0.25
    nv.Saturation = -0.3
    nv.TintColor = Color3.fromRGB(160, 255, 180)
    nv.Enabled = true
    nv.Parent = Lighting
end)

local renderOptimized = {}
local RENDER_DISTANCE = 800
local DETAIL_DISTANCE = 250
local SMALL_PART_SIZE = 4

local function optimizePart(part)
    pcall(function()
        if part:IsA("MeshPart") then
            part.RenderFidelity = Enum.RenderFidelity.Performance
        end
        if part:IsA("BasePart") and not part:IsA("Terrain") then
            local size = part.Size.Magnitude
            if size < SMALL_PART_SIZE then
                part.CastShadow = false
            end
        end
    end)
end

local function cullDistantParts()
    pcall(function()
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local pos = hrp.Position
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not obj:IsDescendantOf(char) then
                local dist = (obj.Position - pos).Magnitude
                if dist > RENDER_DISTANCE then
                    if not renderOptimized[obj] then
                        renderOptimized[obj] = obj.LocalTransparencyModifier
                        obj.LocalTransparencyModifier = 1
                    end
                elseif dist > DETAIL_DISTANCE then
                    if renderOptimized[obj] == nil then
                        renderOptimized[obj] = obj.LocalTransparencyModifier
                    end
                    obj.LocalTransparencyModifier = 0.7
                else
                    if renderOptimized[obj] ~= nil then
                        obj.LocalTransparencyModifier = renderOptimized[obj]
                        renderOptimized[obj] = nil
                    end
                end
            end
        end
    end)
end

local function stripUselessDetails()
    pcall(function()
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Beam") or obj:IsA("RopeConstraint") or obj:IsA("RodConstraint") or obj:IsA("CylindricalConstraint") or obj:IsA("PrismaticConstraint") or obj:IsA("HingeConstraint") or obj:IsA("BallSocketConstraint") then
                obj:Destroy()
            elseif obj:IsA("SurfaceGui") or obj:IsA("BillboardGui") then
                if not obj:IsDescendantOf(sg) then
                    obj:Destroy()
                end
            elseif obj:IsA("BoxHandleAdornment") or obj:IsA("SphereHandleAdornment") or obj:IsA("ConeHandleAdornment") or obj:IsA("CylinderHandleAdornment") or obj:IsA("LineHandleAdornment") then
                obj:Destroy()
            elseif obj:IsA("Model") then
                pcall(function()
                    obj.LevelOfDetail = Enum.ModelLevelOfDetail.Disabled
                end)
            elseif obj:IsA("BasePart") then
                optimizePart(obj)
            end
        end
    end)
end

pcall(function()
    local terrain = Workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        terrain.WaterReflectance = 0
        terrain.WaterTransparency = 1
    end
end)

task.spawn(function()
    task.wait(0.3)
    setProgress(5, "Unlocking FPS cap...")
    pcall(function()
        if setfpscap then
            setfpscap(0)
        end
    end)
    task.wait(0.2)

    setProgress(12, "Scanning game objects...")
    local allDescendants = {}
    pcall(function()
        allDescendants = game:GetDescendants()
    end)
    local total = #allDescendants
    local batch = math.max(1, math.floor(total / 20))

    setProgress(18, "Removing textures & decals...")
    for i, obj in ipairs(allDescendants) do
        pcall(function()
            if obj:IsA("Texture") or obj:IsA("Decal") then
                obj:Destroy()
            end
        end)
        if i % batch == 0 then
            local sub = math.floor((i / total) * 10)
            barFill.Size = UDim2.new((18 + sub) / 100, 0, 1, 0)
            task.wait()
        end
    end

    setProgress(30, "Removing particles & trails...")
    for _, obj in ipairs(allDescendants) do
        pcall(function()
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj:Destroy()
            end
        end)
    end
    task.wait(0.1)

    setProgress(42, "Optimizing base parts...")
    for _, obj in ipairs(allDescendants) do
        pcall(function()
            if obj:IsA("BasePart") then
                obj.CastShadow = false
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
            elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
                obj.Shadows = false
            end
        end)
    end
    task.wait(0.1)

    setProgress(54, "Optimizing lighting engine...")
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.Outlines = false
        Lighting.FogEnd = 100000
        Lighting.Brightness = 1
        for _, effect in ipairs(Lighting:GetDescendants()) do
            if effect:IsA("PostEffect") or effect:IsA("Atmosphere") or effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or effect:IsA("ColorCorrectionEffect") or effect:IsA("SunRaysEffect") then
                effect:Destroy()
            end
        end
    end)
    task.wait(0.1)

    setProgress(62, "Replacing moon texture...")
    pcall(function()
        local sky = Lighting:FindFirstChildOfClass("Sky")
        if not sky then
            sky = Instance.new("Sky")
            sky.Parent = Lighting
        end
        sky.MoonTextureId = "rbxassetid://128638738589848"
    end)
    task.wait(0.1)

    setProgress(70, "Boosting rendering...")
    pcall(function()
        settings().Rendering.QualityLevel = 1
        settings().Network.IncomingReplicationLag = 0
    end)
    task.wait(0.1)

    setProgress(76, "Extending camera range...")
    pcall(function()
        player.CameraMaxZoomDistance = 10000
        player.CameraMinZoomDistance = 0
    end)
    task.wait(0.1)

    setProgress(82, "Maximizing render distance...")
    pcall(function()
        Workspace.StreamingEnabled = false
        Workspace.StreamingMinRadius = 0
        Workspace.StreamingTargetRadius = 0
    end)
    pcall(function()
        local char = player.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                player.ReplicationFocus = hrp
            end
        end
    end)
    task.wait(0.1)

    setProgress(88, "Cleaning audio & effects...")
    pcall(function()
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Sound") then
                obj.Volume = 0
            end
        end
    end)
    task.wait(0.1)

    setProgress(92, "Stripping useless details...")
    stripUselessDetails()
    task.wait(0.1)

    setProgress(95, "Applying network tweaks...")
    task.wait(0.2)
    setProgress(100, "Zombie Hub Loaded")
    task.wait(0.5)
    closeLoader()

    task.wait(0.3)
    local fflagsOk = applyFastFlags()
    if fflagsOk then
        showNotify("FastFlags Applied Successfully | Authors: Zombie Hub Team", Color3.fromRGB(0, 255, 100))
    else
        showNotify("FastFlags Failed | Authors: Zombie Hub Team", Color3.fromRGB(255, 60, 60))
    end
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        cullDistantParts()
    end
end)

Workspace.DescendantAdded:Connect(function(obj)
    task.wait(0.1)
    pcall(function()
        if obj:IsA("Texture") or obj:IsA("Decal") or obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            obj:Destroy()
        elseif obj:IsA("BasePart") then
            obj.CastShadow = false
            obj.Material = Enum.Material.Plastic
            obj.Reflectance = 0
            optimizePart(obj)
        elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
            obj.Shadows = false
        elseif obj:IsA("Beam") or obj:IsA("RopeConstraint") or obj:IsA("RodConstraint") or obj:IsA("CylindricalConstraint") or obj:IsA("PrismaticConstraint") or obj:IsA("HingeConstraint") or obj:IsA("BallSocketConstraint") then
            obj:Destroy()
        elseif obj:IsA("SurfaceGui") or obj:IsA("BillboardGui") then
            if not obj:IsDescendantOf(sg) then
                obj:Destroy()
            end
        elseif obj:IsA("BoxHandleAdornment") or obj:IsA("SphereHandleAdornment") or obj:IsA("ConeHandleAdornment") or obj:IsA("CylinderHandleAdornment") or obj:IsA("LineHandleAdornment") then
            obj:Destroy()
        elseif obj:IsA("Model") then
            obj.LevelOfDetail = Enum.ModelLevelOfDetail.Disabled
        end
    end)
end)

Lighting.DescendantAdded:Connect(function(obj)
    pcall(function()
        if obj:IsA("PostEffect") or obj:IsA("Atmosphere") or obj:IsA("BloomEffect") or obj:IsA("BlurEffect") or obj:IsA("ColorCorrectionEffect") or obj:IsA("SunRaysEffect") then
            if obj.Name ~= "ZH_NightVision" then
                obj:Destroy()
            end
        elseif obj:IsA("Sky") then
            obj.MoonTextureId = "rbxassetid://128638738589848"
        end
    end)
end)
