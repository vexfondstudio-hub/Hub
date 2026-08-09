local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local LogService = game:GetService("LogService")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

if CoreGui:FindFirstChild("ZB_ai") then
    CoreGui.ZB_ai:Destroy()
end

local sg = Instance.new("ScreenGui")
sg.Name = "ZB_ai"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Global
sg.IgnoreGuiInset = true
sg.Parent = CoreGui

local C = {
    bg = Color3.fromRGB(10, 10, 14),
    surface = Color3.fromRGB(18, 18, 24),
    surfaceHi = Color3.fromRGB(26, 26, 34),
    border = Color3.fromRGB(45, 45, 60),
    accent = Color3.fromRGB(0, 255, 100),
    accentDim = Color3.fromRGB(0, 180, 70),
    text = Color3.fromRGB(220, 220, 230),
    textMuted = Color3.fromRGB(130, 130, 145),
    textDim = Color3.fromRGB(80, 80, 95),
    red = Color3.fromRGB(220, 90, 90),
    green = Color3.fromRGB(0, 255, 100),
    yellow = Color3.fromRGB(220, 170, 60),
    blue = Color3.fromRGB(80, 160, 255),
    purple = Color3.fromRGB(160, 100, 255),
    orange = Color3.fromRGB(255, 140, 60),
    cyan = Color3.fromRGB(0, 200, 255),
}

local ICONS = {
    logo = "rbxassetid://108304827782551",
    settings = "rbxassetid://7734053495",
    close = "rbxassetid://7733658504",
    minimize = "rbxassetid://7733715400",
    menu = "rbxassetid://7734068321",
    send = "rbxassetid://7733701545",
    inject = "rbxassetid://7733955511",
    chat = "rbxassetid://7733954760",
    console = "rbxassetid://7733955740",
    tools = "rbxassetid://7734022107",
    key = "rbxassetid://7733955740",
    loader = "rbxassetid://7734068321",
}

local TIF = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local function corner(inst, r)
    local c = Instance.new("UICorner", inst)
    c.CornerRadius = UDim.new(0, r or 10)
    return c
end

local function stroke(inst, col, t)
    local s = Instance.new("UIStroke", inst)
    s.Color = col or C.border
    s.Thickness = t or 1
    return s
end

local function tw(inst, info, props)
    TweenService:Create(inst, info, props):Play()
end

local function makeDraggable(frame, handle)
    handle = handle or frame
    local dragging, dragStart, startPos = false, nil, nil
    handle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = inp.Position
            startPos = frame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

local mainFrame = Instance.new("Frame")
mainFrame.Name = "Main"
mainFrame.Size = UDim2.new(0.95, 0, 0.9, 0)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = C.bg
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = sg
corner(mainFrame, 14)
stroke(mainFrame, C.border, 1.5)

local sizeConstraint = Instance.new("UISizeConstraint", mainFrame)
sizeConstraint.MinSize = Vector2.new(320, 240)
sizeConstraint.MaxSize = Vector2.new(1200, 800)

local aspectConstraint = Instance.new("UIAspectRatioConstraint", mainFrame)
aspectConstraint.AspectRatio = 1.6
aspectConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
aspectConstraint.DominantAxis = Enum.DominantAxis.Width

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, isMobile and 52 or 44)
titleBar.BackgroundColor3 = C.surface
titleBar.BackgroundTransparency = 0.2
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 400
titleBar.Parent = mainFrame
corner(titleBar, 14)

local tbLine = Instance.new("Frame")
tbLine.Size = UDim2.new(1, 0, 0, 1)
tbLine.Position = UDim2.new(0, 0, 1, -1)
tbLine.BackgroundColor3 = C.border
tbLine.BorderSizePixel = 0
tbLine.ZIndex = 401
tbLine.Parent = titleBar

makeDraggable(mainFrame, titleBar)

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -280, 1, 0)
titleText.Position = UDim2.new(0, 14, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "ZB.ai"
titleText.TextColor3 = C.accent
titleText.TextSize = isMobile and 18 or 16
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.ZIndex = 402
titleText.Parent = titleBar

local modelDropdown = Instance.new("TextButton")
modelDropdown.Size = UDim2.new(0, isMobile and 120 or 160, 0, isMobile and 32 or 28)
modelDropdown.Position = UDim2.new(1, -280, 0.5, -14)
modelDropdown.BackgroundColor3 = C.surfaceHi
modelDropdown.BackgroundTransparency = 0.3
modelDropdown.Text = "deepseek-r1"
modelDropdown.TextColor3 = C.text
modelDropdown.TextSize = isMobile and 12 or 11
modelDropdown.Font = Enum.Font.GothamBold
modelDropdown.BorderSizePixel = 0
modelDropdown.AutoButtonColor = false
modelDropdown.ZIndex = 403
modelDropdown.Parent = titleBar
corner(modelDropdown, 6)
stroke(modelDropdown, C.border, 1)

local closeBtn = Instance.new("ImageButton")
closeBtn.Size = UDim2.new(0, isMobile and 34 or 26, 0, isMobile and 34 or 26)
closeBtn.Position = UDim2.new(1, -40, 0.5, -13)
closeBtn.BackgroundTransparency = 1
closeBtn.Image = ICONS.close
closeBtn.ImageColor3 = C.red
closeBtn.ImageTransparency = 0.2
closeBtn.ScaleType = Enum.ScaleType.Fit
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
closeBtn.ZIndex = 403
closeBtn.Parent = titleBar

closeBtn.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

local minimizeBtn = Instance.new("ImageButton")
minimizeBtn.Size = UDim2.new(0, isMobile and 34 or 26, 0, isMobile and 34 or 26)
minimizeBtn.Position = UDim2.new(1, -76, 0.5, -13)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Image = ICONS.minimize
minimizeBtn.ImageColor3 = C.textMuted
minimizeBtn.ImageTransparency = 0.2
minimizeBtn.ScaleType = Enum.ScaleType.Fit
minimizeBtn.BorderSizePixel = 0
minimizeBtn.AutoButtonColor = false
minimizeBtn.ZIndex = 403
minimizeBtn.Parent = titleBar

local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, 0, 1, -titleBar.Size.Y.Offset)
contentFrame.Position = UDim2.new(0, 0, 0, titleBar.Size.Y.Offset)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -20, 0, isMobile and 44 or 36)
tabBar.Position = UDim2.new(0, 10, 0, 8)
tabBar.BackgroundTransparency = 1
tabBar.BorderSizePixel = 0
tabBar.Parent = contentFrame

local tabFrames = {}
local currentTab = nil

local function createTab(name, icon, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, isMobile and 90 or 80, 1, 0)
    btn.Position = UDim2.new(0, (order - 1) * (isMobile and 96 or 86), 0, 0)
    btn.BackgroundColor3 = C.surface
    btn.BackgroundTransparency = 0.3
    btn.Text = "  " .. name
    btn.TextColor3 = C.textMuted
    btn.TextSize = isMobile and 13 or 11
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Parent = tabBar
    corner(btn, 8)
    stroke(btn, C.border, 1)

    local iconImg = Instance.new("ImageLabel")
    iconImg.Size = UDim2.new(0, 16, 0, 16)
    iconImg.Position = UDim2.new(0, 8, 0.5, -8)
    iconImg.BackgroundTransparency = 1
    iconImg.Image = icon
    iconImg.ImageColor3 = C.textMuted
    iconImg.ImageTransparency = 0.3
    iconImg.ScaleType = Enum.ScaleType.Fit
    iconImg.Parent = btn

    return btn
end

local tabChatBtn = createTab("Chat", ICONS.chat, 1)
local tabConsoleBtn = createTab("Console", ICONS.console, 2)
local tabToolsBtn = createTab("Tools", ICONS.tools, 3)
local tabSettingsBtn = createTab("Settings", ICONS.settings, 4)
local tabModelsBtn = createTab("Models", ICONS.key, 5)
local tabApiBtn = createTab("API", ICONS.key, 6)

local chatFrame = Instance.new("Frame")
chatFrame.Name = "ChatTab"
chatFrame.Size = UDim2.new(1, -20, 1, -110)
chatFrame.Position = UDim2.new(0, 10, 0, isMobile and 60 or 52)
chatFrame.BackgroundColor3 = C.surface
chatFrame.BackgroundTransparency = 0.2
chatFrame.BorderSizePixel = 0
chatFrame.Parent = contentFrame
chatFrame.Visible = true
corner(chatFrame, 10)
stroke(chatFrame, C.border, 1)
tabFrames["chat"] = chatFrame

local consoleFrame = Instance.new("Frame")
consoleFrame.Name = "ConsoleTab"
consoleFrame.Size = UDim2.new(1, -20, 1, -110)
consoleFrame.Position = UDim2.new(0, 10, 0, isMobile and 60 or 52)
consoleFrame.BackgroundColor3 = C.surface
consoleFrame.BackgroundTransparency = 0.2
consoleFrame.BorderSizePixel = 0
consoleFrame.Parent = contentFrame
consoleFrame.Visible = false
corner(consoleFrame, 10)
stroke(consoleFrame, C.border, 1)
tabFrames["console"] = consoleFrame

local toolsFrame = Instance.new("Frame")
toolsFrame.Name = "ToolsTab"
toolsFrame.Size = UDim2.new(1, -20, 1, -110)
toolsFrame.Position = UDim2.new(0, 10, 0, isMobile and 60 or 52)
toolsFrame.BackgroundColor3 = C.surface
toolsFrame.BackgroundTransparency = 0.2
toolsFrame.BorderSizePixel = 0
toolsFrame.Parent = contentFrame
toolsFrame.Visible = false
corner(toolsFrame, 10)
stroke(toolsFrame, C.border, 1)
tabFrames["tools"] = toolsFrame

local settingsFrameTab = Instance.new("Frame")
settingsFrameTab.Name = "SettingsTab"
settingsFrameTab.Size = UDim2.new(1, -20, 1, -110)
settingsFrameTab.Position = UDim2.new(0, 10, 0, isMobile and 60 or 52)
settingsFrameTab.BackgroundColor3 = C.surface
settingsFrameTab.BackgroundTransparency = 0.2
settingsFrameTab.BorderSizePixel = 0
settingsFrameTab.Parent = contentFrame
settingsFrameTab.Visible = false
corner(settingsFrameTab, 10)
stroke(settingsFrameTab, C.border, 1)
tabFrames["settings"] = settingsFrameTab

local modelsFrame = Instance.new("Frame")
modelsFrame.Name = "ModelsTab"
modelsFrame.Size = UDim2.new(1, -20, 1, -110)
modelsFrame.Position = UDim2.new(0, 10, 0, isMobile and 60 or 52)
modelsFrame.BackgroundColor3 = C.surface
modelsFrame.BackgroundTransparency = 0.2
modelsFrame.BorderSizePixel = 0
modelsFrame.Parent = contentFrame
modelsFrame.Visible = false
corner(modelsFrame, 10)
stroke(modelsFrame, C.border, 1)
tabFrames["models"] = modelsFrame

local apiFrame = Instance.new("Frame")
apiFrame.Name = "ApiTab"
apiFrame.Size = UDim2.new(1, -20, 1, -110)
apiFrame.Position = UDim2.new(0, 10, 0, isMobile and 60 or 52)
apiFrame.BackgroundColor3 = C.surface
apiFrame.BackgroundTransparency = 0.2
apiFrame.BorderSizePixel = 0
apiFrame.Parent = contentFrame
apiFrame.Visible = false
corner(apiFrame, 10)
stroke(apiFrame, C.border, 1)
tabFrames["api"] = apiFrame

local function switchTab(tabName)
    for name, frame in pairs(tabFrames) do
        frame.Visible = (name == tabName)
    end
    currentTab = tabName

    tabChatBtn.BackgroundColor3 = (tabName == "chat") and C.surfaceHi or C.surface
    tabChatBtn.TextColor3 = (tabName == "chat") and C.accent or C.textMuted
    tabChatBtn:FindFirstChildOfClass("UIStroke").Color = (tabName == "chat") and C.accent or C.border

    tabConsoleBtn.BackgroundColor3 = (tabName == "console") and C.surfaceHi or C.surface
    tabConsoleBtn.TextColor3 = (tabName == "console") and C.accent or C.textMuted
    tabConsoleBtn:FindFirstChildOfClass("UIStroke").Color = (tabName == "console") and C.accent or C.border

    tabToolsBtn.BackgroundColor3 = (tabName == "tools") and C.surfaceHi or C.surface
    tabToolsBtn.TextColor3 = (tabName == "tools") and C.accent or C.textMuted
    tabToolsBtn:FindFirstChildOfClass("UIStroke").Color = (tabName == "tools") and C.accent or C.border

    tabSettingsBtn.BackgroundColor3 = (tabName == "settings") and C.surfaceHi or C.surface
    tabSettingsBtn.TextColor3 = (tabName == "settings") and C.accent or C.textMuted
    tabSettingsBtn:FindFirstChildOfClass("UIStroke").Color = (tabName == "settings") and C.accent or C.border

    tabModelsBtn.BackgroundColor3 = (tabName == "models") and C.surfaceHi or C.surface
    tabModelsBtn.TextColor3 = (tabName == "models") and C.accent or C.textMuted
    tabModelsBtn:FindFirstChildOfClass("UIStroke").Color = (tabName == "models") and C.accent or C.border

    tabApiBtn.BackgroundColor3 = (tabName == "api") and C.surfaceHi or C.surface
    tabApiBtn.TextColor3 = (tabName == "api") and C.accent or C.textMuted
    tabApiBtn:FindFirstChildOfClass("UIStroke").Color = (tabName == "api") and C.accent or C.border
end

tabChatBtn.MouseButton1Click:Connect(function() switchTab("chat") end)
tabConsoleBtn.MouseButton1Click:Connect(function() switchTab("console") end)
tabToolsBtn.MouseButton1Click:Connect(function() switchTab("tools") end)
tabSettingsBtn.MouseButton1Click:Connect(function() switchTab("settings") end)
tabModelsBtn.MouseButton1Click:Connect(function() switchTab("models") end)
tabApiBtn.MouseButton1Click:Connect(function() switchTab("api") end)

local chatScroll = Instance.new("ScrollingFrame")
chatScroll.Name = "ChatScroll"
chatScroll.Size = UDim2.new(1, -12, 1, -12)
chatScroll.Position = UDim2.new(0, 6, 0, 6)
chatScroll.BackgroundTransparency = 1
chatScroll.BorderSizePixel = 0
chatScroll.ScrollBarThickness = isMobile and 6 or 3
chatScroll.ScrollBarImageColor3 = C.accentDim
chatScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
chatScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
chatScroll.Parent = chatFrame
chatScroll.ScrollingDirection = Enum.ScrollingDirection.Y
chatScroll.ScrollingEnabled = true
chatScroll.Active = true

local chatList = Instance.new("UIListLayout", chatScroll)
chatList.SortOrder = Enum.SortOrder.LayoutOrder
chatList.Padding = UDim.new(0, 6)

local chatPad = Instance.new("UIPadding", chatScroll)
chatPad.PaddingTop = UDim.new(0, 4)
chatPad.PaddingBottom = UDim.new(0, 4)
chatPad.PaddingLeft = UDim.new(0, 4)
chatPad.PaddingRight = UDim.new(0, 4)

local inputFrame = Instance.new("Frame")
inputFrame.Size = UDim2.new(1, -20, 0, isMobile and 52 or 40)
inputFrame.Position = UDim2.new(0, 10, 1, -62)
inputFrame.BackgroundColor3 = C.surface
inputFrame.BackgroundTransparency = 0.2
inputFrame.BorderSizePixel = 0
inputFrame.Parent = contentFrame
corner(inputFrame, 10)
stroke(inputFrame, C.border, 1)

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -56, 1, -8)
inputBox.Position = UDim2.new(0, 8, 0, 4)
inputBox.BackgroundTransparency = 1
inputBox.Text = ""
inputBox.PlaceholderText = "Ask AI..."
inputBox.TextColor3 = C.text
inputBox.PlaceholderColor3 = C.textDim
inputBox.TextSize = isMobile and 15 or 13
inputBox.Font = Enum.Font.Gotham
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.TextWrapped = true
inputBox.ClearTextOnFocus = false
inputBox.Parent = inputFrame

local sendBtn = Instance.new("ImageButton")
sendBtn.Size = UDim2.new(0, isMobile and 40 or 32, 0, isMobile and 40 or 32)
sendBtn.Position = UDim2.new(1, -48, 0.5, -16)
sendBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 30)
sendBtn.BackgroundTransparency = 0.2
sendBtn.Image = ICONS.send
sendBtn.ImageColor3 = C.green
sendBtn.ImageTransparency = 0
sendBtn.ScaleType = Enum.ScaleType.Fit
sendBtn.BorderSizePixel = 0
sendBtn.AutoButtonColor = false
sendBtn.Parent = inputFrame
corner(sendBtn, 8)
stroke(sendBtn, C.green, 1)

local typingIndicator = Instance.new("Frame")
typingIndicator.Size = UDim2.new(0, 0, 0, 0)
typingIndicator.AutomaticSize = Enum.AutomaticSize.XY
typingIndicator.BackgroundColor3 = C.surfaceHi
typingIndicator.BackgroundTransparency = 0.3
typingIndicator.BorderSizePixel = 0
typingIndicator.Visible = false
typingIndicator.Parent = chatScroll
corner(typingIndicator, 8)

local typingLbl = Instance.new("TextLabel")
typingLbl.Size = UDim2.new(0, 0, 0, 0)
typingLbl.AutomaticSize = Enum.AutomaticSize.XY
typingLbl.Position = UDim2.new(0, 10, 0, 6)
typingLbl.BackgroundTransparency = 1
typingLbl.Text = "AI is thinking..."
typingLbl.TextColor3 = C.accentDim
typingLbl.TextSize = 12
typingLbl.Font = Enum.Font.Gotham
typingLbl.Parent = typingIndicator

local typingPad = Instance.new("UIPadding", typingIndicator)
typingPad.PaddingBottom = UDim.new(0, 6)
typingPad.PaddingRight = UDim.new(0, 10)

local consoleScroll = Instance.new("ScrollingFrame")
consoleScroll.Size = UDim2.new(1, -12, 1, -12)
consoleScroll.Position = UDim2.new(0, 6, 0, 6)
consoleScroll.BackgroundTransparency = 1
consoleScroll.BorderSizePixel = 0
consoleScroll.ScrollBarThickness = isMobile and 6 or 3
consoleScroll.ScrollBarImageColor3 = C.accentDim
consoleScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
consoleScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
consoleScroll.Parent = consoleFrame

local consoleList = Instance.new("UIListLayout", consoleScroll)
consoleList.SortOrder = Enum.SortOrder.LayoutOrder
consoleList.Padding = UDim.new(0, 2)

local consolePad = Instance.new("UIPadding", consoleScroll)
consolePad.PaddingTop = UDim.new(0, 4)
consolePad.PaddingBottom = UDim.new(0, 4)
consolePad.PaddingLeft = UDim.new(0, 4)
consolePad.PaddingRight = UDim.new(0, 4)

local consoleLines = {}
local maxConsoleLines = 200

local function addConsoleLine(text, msgType)
    local col = C.text
    if msgType == Enum.MessageType.MessageWarning then col = C.yellow
    elseif msgType == Enum.MessageType.MessageError then col = C.red
    elseif msgType == Enum.MessageType.MessageInfo then col = C.blue end

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 0)
    lbl.AutomaticSize = Enum.AutomaticSize.Y
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = col
    lbl.TextSize = isMobile and 13 or 11
    lbl.Font = Enum.Font.Code
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true
    lbl.LayoutOrder = #consoleLines
    lbl.Parent = consoleScroll

    table.insert(consoleLines, lbl)
    if #consoleLines > maxConsoleLines then
        consoleLines[1]:Destroy()
        table.remove(consoleLines, 1)
    end
end

pcall(function()
    LogService.MessageOut:Connect(function(message, msgType)
        if Tools and Tools.ConsoleCapture then
            addConsoleLine(message, msgType)
        end
    end)
end)

local Tools = {
    ScanWorkspace = false,
    SpyPlayers = false,
    ScriptReader = false,
    AutoInject = false,
    GUIBuilder = false,
    NightVision = false,
    ConsoleCapture = true,
}

local toggleRefs = {}
local toolOrder = {"ScanWorkspace", "SpyPlayers", "ScriptReader", "AutoInject", "GUIBuilder", "NightVision", "ConsoleCapture"}
local toolLabels = {
    ScanWorkspace = "Scan Workspace",
    SpyPlayers = "Spy Players",
    ScriptReader = "Script Reader",
    AutoInject = "Auto Inject",
    GUIBuilder = "GUI Builder",
    NightVision = "Night Vision",
    ConsoleCapture = "Console Capture",
}

local toolsScroll = Instance.new("ScrollingFrame")
toolsScroll.Size = UDim2.new(1, -12, 1, -12)
toolsScroll.Position = UDim2.new(0, 6, 0, 6)
toolsScroll.BackgroundTransparency = 1
toolsScroll.BorderSizePixel = 0
toolsScroll.ScrollBarThickness = isMobile and 6 or 3
toolsScroll.ScrollBarImageColor3 = C.accentDim
toolsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
toolsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
toolsScroll.Parent = toolsFrame

local toolsListLayout = Instance.new("UIListLayout", toolsScroll)
toolsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
toolsListLayout.Padding = UDim.new(0, 6)

local toolsPad = Instance.new("UIPadding", toolsScroll)
toolsPad.PaddingTop = UDim.new(0, 4)
toolsPad.PaddingBottom = UDim.new(0, 4)
toolsPad.PaddingLeft = UDim.new(0, 4)
toolsPad.PaddingRight = UDim.new(0, 4)

for i, key in ipairs(toolOrder) do
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -8, 0, isMobile and 48 or 38)
    row.BackgroundColor3 = C.surfaceHi
    row.BackgroundTransparency = 0.3
    row.BorderSizePixel = 0
    row.LayoutOrder = i
    row.Parent = toolsScroll
    corner(row, 8)
    stroke(row, C.border, 1)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -70, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = toolLabels[key]
    lbl.TextColor3 = C.text
    lbl.TextSize = isMobile and 14 or 12
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, isMobile and 56 or 48, 0, isMobile and 30 or 24)
    btn.Position = UDim2.new(1, -64, 0.5, -12)
    btn.BackgroundColor3 = C.surface
    btn.BackgroundTransparency = 0.3
    btn.Text = "OFF"
    btn.TextColor3 = C.textMuted
    btn.TextSize = isMobile and 12 or 10
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Parent = row
    corner(btn, 6)
    stroke(btn, C.border, 1)

    toggleRefs[key] = btn

    btn.MouseButton1Click:Connect(function()
        Tools[key] = not Tools[key]
        btn.Text = Tools[key] and "ON" or "OFF"
        btn.TextColor3 = Tools[key] and C.green or C.textMuted
        tw(btn, TIF, {BackgroundColor3 = Tools[key] and Color3.fromRGB(0, 60, 30) or C.surface})
        local st = btn:FindFirstChildOfClass("UIStroke")
        if st then st.Color = Tools[key] and C.green or C.border end
        if key == "NightVision" then
            pcall(function()
                local nv = Lighting:FindFirstChild("ZH_NightVision")
                if Tools[key] and not nv then
                    nv = Instance.new("ColorCorrectionEffect")
                    nv.Name = "ZH_NightVision"
                    nv.Brightness = 0.15
                    nv.Contrast = 0.25
                    nv.Saturation = -0.3
                    nv.TintColor = Color3.fromRGB(160, 255, 180)
                    nv.Enabled = true
                    nv.Parent = Lighting
                elseif not Tools[key] and nv then
                    nv:Destroy()
                end
            end)
        end
    end)
end

local settingsScroll = Instance.new("ScrollingFrame")
settingsScroll.Size = UDim2.new(1, -12, 1, -12)
settingsScroll.Position = UDim2.new(0, 6, 0, 6)
settingsScroll.BackgroundTransparency = 1
settingsScroll.BorderSizePixel = 0
settingsScroll.ScrollBarThickness = isMobile and 6 or 3
settingsScroll.ScrollBarImageColor3 = C.accentDim
settingsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
settingsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
settingsScroll.Parent = settingsFrameTab

local settingsListLayout = Instance.new("UIListLayout", settingsScroll)
settingsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
settingsListLayout.Padding = UDim.new(0, 6)

local settingsPad = Instance.new("UIPadding", settingsScroll)
settingsPad.PaddingTop = UDim.new(0, 4)
settingsPad.PaddingBottom = UDim.new(0, 4)
settingsPad.PaddingLeft = UDim.new(0, 4)
settingsPad.PaddingRight = UDim.new(0, 4)

local autoScroll = true
local showTimestamps = false
local compactMode = false
local darkTheme = true
local maxTokens = 4000
local temperature = 0.7
local requestTimeout = 30
local streamMode = false

local function addSettingRow(labelText, defaultVal, order, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -8, 0, isMobile and 48 or 38)
    row.BackgroundColor3 = C.surfaceHi
    row.BackgroundTransparency = 0.3
    row.BorderSizePixel = 0
    row.LayoutOrder = order
    row.Parent = settingsScroll
    corner(row, 8)
    stroke(row, C.border, 1)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -70, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = C.text
    lbl.TextSize = isMobile and 14 or 12
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, isMobile and 56 or 48, 0, isMobile and 30 or 24)
    btn.Position = UDim2.new(1, -64, 0.5, -12)
    btn.BackgroundColor3 = C.surface
    btn.BackgroundTransparency = 0.3
    btn.Text = defaultVal and "ON" or "OFF"
    btn.TextColor3 = defaultVal and C.green or C.textMuted
    btn.TextSize = isMobile and 12 or 10
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Parent = row
    corner(btn, 6)
    stroke(btn, defaultVal and C.green or C.border, 1)

    local val = defaultVal
    btn.MouseButton1Click:Connect(function()
        val = not val
        btn.Text = val and "ON" or "OFF"
        btn.TextColor3 = val and C.green or C.textMuted
        local st = btn:FindFirstChildOfClass("UIStroke")
        if st then st.Color = val and C.green or C.border end
        if callback then callback(val) end
    end)
    return btn
end

addSettingRow("Auto Scroll", true, 1, function(v) autoScroll = v end)
addSettingRow("Timestamps", false, 2, function(v) showTimestamps = v end)
addSettingRow("Compact Mode", false, 3, function(v) compactMode = v end)
addSettingRow("Dark Theme", true, 4, function(v) darkTheme = v end)
addSettingRow("Console Capture", true, 5, function(v) Tools.ConsoleCapture = v end)
addSettingRow("Auto Inject", false, 6, function(v) Tools.AutoInject = v end)
addSettingRow("Stream Mode", false, 7, function(v) streamMode = v end)

local currentAPI = {
    name = "OpenRouter",
    key = "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",
    url = "https://openrouter.ai/api/v1/chat/completions",
    model = "deepseek/deepseek-r1",
    modelDisplay = "deepseek-r1",
    format = "openai",
    headers = {}
}

local allCompanies = {
    OpenRouter = {
        color = C.orange,
        url = "https://openrouter.ai/api/v1/chat/completions",
        format = "openai",
        models = {
            {id = "deepseek/deepseek-r1", display = "DeepSeek-R1"},
            {id = "deepseek/deepseek-chat", display = "DeepSeek-V3"},
            {id = "anthropic/claude-3.5-sonnet", display = "Claude-3.5-Sonnet"},
            {id = "anthropic/claude-3.5-haiku", display = "Claude-3.5-Haiku"},
            {id = "anthropic/claude-3-opus", display = "Claude-3-Opus"},
            {id = "openai/gpt-4o", display = "GPT-4o"},
            {id = "openai/gpt-4o-mini", display = "GPT-4o-Mini"},
            {id = "openai/gpt-4-turbo", display = "GPT-4-Turbo"},
            {id = "meta-llama/llama-3.3-70b-instruct", display = "Llama-3.3-70B"},
            {id = "meta-llama/llama-3.1-405b-instruct", display = "Llama-3.1-405B"},
            {id = "meta-llama/llama-3.1-8b-instruct", display = "Llama-3.1-8B"},
            {id = "google/gemini-2.0-flash-exp:free", display = "Gemini-2.0-Flash"},
            {id = "google/gemini-1.5-pro", display = "Gemini-1.5-Pro"},
            {id = "google/gemini-1.5-flash", display = "Gemini-1.5-Flash"},
            {id = "mistralai/mistral-large", display = "Mistral-Large"},
            {id = "mistralai/mistral-small", display = "Mistral-Small"},
            {id = "mistralai/codestral-2501", display = "Codestral"},
            {id = "qwen/qwen-2.5-72b-instruct", display = "Qwen-2.5-72B"},
            {id = "qwen/qwen-2.5-coder-32b-instruct", display = "Qwen-Coder-32B"},
            {id = "nvidia/llama-3.1-nemotron-70b-instruct", display = "Nemotron-70B"},
            {id = "microsoft/phi-4", display = "Phi-4"},
            {id = "perplexity/sonar", display = "Perplexity-Sonar"},
            {id = "perplexity/sonar-reasoning", display = "Perplexity-Sonar-Reasoning"},
            {id = "cohere/command-r-plus", display = "Command-R-Plus"},
            {id = "cohere/command-r", display = "Command-R"},
            {id = "x-ai/grok-2", display = "Grok-2"},
            {id = "x-ai/grok-2-mini", display = "Grok-2-Mini"},
        }
    },
    OpenAI = {
        color = C.green,
        url = "https://api.openai.com/v1/chat/completions",
        format = "openai",
        models = {
            {id = "gpt-4o", display = "GPT-4o"},
            {id = "gpt-4o-mini", display = "GPT-4o-Mini"},
            {id = "gpt-4-turbo", display = "GPT-4-Turbo"},
            {id = "gpt-4", display = "GPT-4"},
            {id = "gpt-3.5-turbo", display = "GPT-3.5-Turbo"},
            {id = "o1-preview", display = "o1-Preview"},
            {id = "o1-mini", display = "o1-Mini"},
            {id = "o3-mini", display = "o3-Mini"},
        }
    },
    Anthropic = {
        color = C.yellow,
        url = "https://api.anthropic.com/v1/messages",
        format = "anthropic",
        models = {
            {id = "claude-3-5-sonnet-20241022", display = "Claude-3.5-Sonnet"},
            {id = "claude-3-5-haiku-20241022", display = "Claude-3.5-Haiku"},
            {id = "claude-3-opus-20240229", display = "Claude-3-Opus"},
            {id = "claude-3-sonnet-20240229", display = "Claude-3-Sonnet"},
            {id = "claude-3-haiku-20240307", display = "Claude-3-Haiku"},
        }
    },
    Google = {
        color = C.blue,
        url = "https://generativelanguage.googleapis.com/v1beta/models/",
        format = "google",
        models = {
            {id = "gemini-3.5-pro", display = "Gemini-3.5-Pro"},
            {id = "gemini-3.5-flash", display = "Gemini-3.5-Flash"},
            {id = "gemini-3.1-pro", display = "Gemini-3.1-Pro"},
            {id = "gemini-3.1-flash", display = "Gemini-3.1-Flash"},
            {id = "gemini-3.1-flash-lite", display = "Gemini-3.1-Flash-Lite"},
            {id = "gemini-2.5-pro", display = "Gemini-2.5-Pro"},
            {id = "gemini-2.5-flash", display = "Gemini-2.5-Flash"},
            {id = "gemini-2.5-flash-lite", display = "Gemini-2.5-Flash-Lite"},
            {id = "gemini-3.1-flash-tts-preview", display = "Gemini-3.1-TTS"},
            {id = "gemini-3.1-flash-image", display = "Gemini-3.1-Image"},
            {id = "gemini-3-pro-image", display = "Gemini-3-Pro-Image"},
            {id = "gemini-2.5-flash-image", display = "Gemini-2.5-Image"},
            {id = "gemini-omni-flash", display = "Gemini-Omni-Video"},
            {id = "gemini-embedding-2", display = "Gemini-Embedding-2"},
            {id = "gemini-embedding-001", display = "Gemini-Embedding-001"},
            {id = "deep-research-preview-04-2026", display = "Deep-Research"},
            {id = "deep-research-max-preview-04-2026", display = "Deep-Research-Max"},
            {id = "antigravity-preview-05-2026", display = "AntiGravity-Agent"},
            {id = "gemini-2.5-computer-use-preview", display = "Computer-Use"},
            {id = "veo-3.1-generate-preview", display = "Veo-3.1-Video"},
            {id = "veo-3.1-lite-generate-preview", display = "Veo-3.1-Lite"},
            {id = "lyria-3-pro-preview", display = "Lyria-3-Music"},
            {id = "lyria-3-clip-preview", display = "Lyria-3-Clip"},
        }
    },
    DeepSeek = {
        color = C.cyan,
        url = "https://api.deepseek.com/v1/chat/completions",
        format = "openai",
        models = {
            {id = "deepseek-chat", display = "DeepSeek-V3"},
            {id = "deepseek-reasoner", display = "DeepSeek-R1"},
            {id = "deepseek-coder", display = "DeepSeek-Coder"},
        }
    },
    Groq = {
        color = C.purple,
        url = "https://api.groq.com/openai/v1/chat/completions",
        format = "openai",
        models = {
            {id = "llama-3.3-70b-versatile", display = "Llama-3.3-70B"},
            {id = "llama-3.1-8b-instant", display = "Llama-3.1-8B"},
            {id = "llama-3.1-70b-versatile", display = "Llama-3.1-70B"},
            {id = "llama-3.1-405b-reasoning", display = "Llama-3.1-405B"},
            {id = "llama3-70b-8192", display = "Llama-3-70B"},
            {id = "llama3-8b-8192", display = "Llama-3-8B"},
            {id = "mixtral-8x7b-32768", display = "Mixtral-8x7b"},
            {id = "gemma2-9b-it", display = "Gemma-2-9B"},
            {id = "gemma-7b-it", display = "Gemma-7B"},
        }
    },
    Mistral = {
        color = C.accent,
        url = "https://api.mistral.ai/v1/chat/completions",
        format = "openai",
        models = {
            {id = "mistral-large-latest", display = "Mistral-Large"},
            {id = "mistral-small-latest", display = "Mistral-Small"},
            {id = "codestral-latest", display = "Codestral"},
            {id = "ministral-8b-latest", display = "Ministral-8B"},
            {id = "ministral-3b-latest", display = "Ministral-3B"},
            {id = "pixtral-large-latest", display = "Pixtral-Large"},
        }
    },
    Cohere = {
        color = C.red,
        url = "https://api.cohere.ai/v1/chat",
        format = "cohere",
        models = {
            {id = "command-r-plus", display = "Command-R-Plus"},
            {id = "command-r", display = "Command-R"},
            {id = "command", display = "Command"},
            {id = "command-light", display = "Command-Light"},
        }
    },
    Qwen = {
        color = C.cyan,
        url = "https://dashscope.aliyuncs.com/api/v1/services/aigc/text-generation/generation",
        format = "qwen",
        models = {
            {id = "qwen-turbo", display = "Qwen-Turbo"},
            {id = "qwen-plus", display = "Qwen-Plus"},
            {id = "qwen-max", display = "Qwen-Max"},
            {id = "qwen-coder-plus", display = "Qwen-Coder-Plus"},
            {id = "qwen2.5-72b-instruct", display = "Qwen-2.5-72B"},
            {id = "qwen2.5-14b-instruct", display = "Qwen-2.5-14B"},
            {id = "qwen2.5-7b-instruct", display = "Qwen-2.5-7B"},
        }
    },
    Moonshot = {
        color = C.purple,
        url = "https://api.moonshot.cn/v1/chat/completions",
        format = "openai",
        models = {
            {id = "moonshot-v1-8k", display = "Moonshot-V1-8k"},
            {id = "moonshot-v1-32k", display = "Moonshot-V1-32k"},
            {id = "moonshot-v1-128k", display = "Moonshot-V1-128k"},
        }
    },
    GLM = {
        color = C.blue,
        url = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
        format = "openai",
        models = {
            {id = "glm-4", display = "GLM-4"},
            {id = "glm-4-plus", display = "GLM-4-Plus"},
            {id = "glm-4-flash", display = "GLM-4-Flash"},
            {id = "glm-4-air", display = "GLM-4-Air"},
            {id = "glm-4v", display = "GLM-4V"},
            {id = "codegeex-4", display = "CodeGeeX-4"},
        }
    },
    Together = {
        color = C.orange,
        url = "https://api.together.xyz/v1/chat/completions",
        format = "openai",
        models = {
            {id = "meta-llama/Llama-3.3-70B-Instruct-Turbo", display = "Llama-3.3-70B"},
            {id = "meta-llama/Llama-3.1-405B-Instruct-Turbo", display = "Llama-3.1-405B"},
            {id = "meta-llama/Llama-3.1-8B-Instruct-Turbo", display = "Llama-3.1-8B"},
            {id = "mistralai/Mixtral-8x22B-Instruct-v0.1", display = "Mixtral-8x22B"},
            {id = "mistralai/Mistral-7B-Instruct-v0.3", display = "Mistral-7B"},
            {id = "Qwen/Qwen2.5-72B-Instruct-Turbo", display = "Qwen-2.5-72B"},
            {id = "deepseek-ai/DeepSeek-V3", display = "DeepSeek-V3"},
            {id = "nvidia/Llama-3.1-Nemotron-70B-Instruct-HF", display = "Nemotron-70B"},
        }
    },
    Perplexity = {
        color = C.green,
        url = "https://api.perplexity.ai/chat/completions",
        format = "openai",
        models = {
            {id = "sonar", display = "Sonar"},
            {id = "sonar-pro", display = "Sonar-Pro"},
            {id = "sonar-reasoning", display = "Sonar-Reasoning"},
            {id = "sonar-deep-research", display = "Sonar-Deep-Research"},
        }
    },
    xAI = {
        color = C.red,
        url = "https://api.x.ai/v1/chat/completions",
        format = "openai",
        models = {
            {id = "grok-2", display = "Grok-2"},
            {id = "grok-2-mini", display = "Grok-2-Mini"},
            {id = "grok-2-vision", display = "Grok-2-Vision"},
        }
    },
    AI21 = {
        color = C.purple,
        url = "https://api.ai21.com/studio/v1/chat/completions",
        format = "openai",
        models = {
            {id = "jamba-1.5-large", display = "Jamba-1.5-Large"},
            {id = "jamba-1.5-mini", display = "Jamba-1.5-Mini"},
            {id = "jamba-instruct", display = "Jamba-Instruct"},
        }
    },
    Fireworks = {
        color = C.orange,
        url = "https://api.fireworks.ai/inference/v1/chat/completions",
        format = "openai",
        models = {
            {id = "accounts/fireworks/models/llama-v3p1-405b-instruct", display = "Llama-3.1-405B"},
            {id = "accounts/fireworks/models/llama-v3p1-70b-instruct", display = "Llama-3.1-70B"},
            {id = "accounts/fireworks/models/llama-v3p1-8b-instruct", display = "Llama-3.1-8B"},
            {id = "accounts/fireworks/models/mixtral-8x22b-instruct", display = "Mixtral-8x22B"},
            {id = "accounts/fireworks/models/deepseek-v3", display = "DeepSeek-V3"},
            {id = "accounts/fireworks/models/qwen2p5-72b-instruct", display = "Qwen-2.5-72B"},
        }
    },
    Hyperbolic = {
        color = C.cyan,
        url = "https://api.hyperbolic.xyz/v1/chat/completions",
        format = "openai",
        models = {
            {id = "meta-llama/Llama-3.3-70B-Instruct", display = "Llama-3.3-70B"},
            {id = "meta-llama/Llama-3.1-405B-Instruct", display = "Llama-3.1-405B"},
            {id = "deepseek-ai/DeepSeek-V3", display = "DeepSeek-V3"},
            {id = "Qwen/Qwen2.5-72B-Instruct", display = "Qwen-2.5-72B"},
        }
    },
    Novita = {
        color = C.yellow,
        url = "https://api.novita.ai/v3/openai/chat/completions",
        format = "openai",
        models = {
            {id = "meta-llama/llama-3.3-70b-instruct", display = "Llama-3.3-70B"},
            {id = "meta-llama/llama-3.1-8b-instruct", display = "Llama-3.1-8B"},
            {id = "deepseek/deepseek_v3", display = "DeepSeek-V3"},
            {id = "qwen/qwen-2.5-72b-instruct", display = "Qwen-2.5-72B"},
        }
    },
    Ollama = {
        color = C.textMuted,
        url = "http://localhost:11434/api/generate",
        format = "ollama",
        models = {
            {id = "llama3.2", display = "Llama-3.2"},
            {id = "llama3.1", display = "Llama-3.1"},
            {id = "llama3", display = "Llama-3"},
            {id = "mistral", display = "Mistral"},
            {id = "mixtral", display = "Mixtral"},
            {id = "qwen2.5", display = "Qwen-2.5"},
            {id = "codellama", display = "CodeLlama"},
            {id = "deepseek-coder", display = "DeepSeek-Coder"},
            {id = "gemma2", display = "Gemma-2"},
            {id = "phi4", display = "Phi-4"},
        }
    },
    LMStudio = {
        color = C.textMuted,
        url = "http://localhost:1234/v1/chat/completions",
        format = "openai",
        models = {
            {id = "local-model", display = "Local-Model"},
        }
    },
}

local companyKeys = {}
for name, data in pairs(allCompanies) do
    data.key = ""
    table.insert(companyKeys, name)
end
table.sort(companyKeys)

local modelsScroll = Instance.new("ScrollingFrame")
modelsScroll.Name = "ModelsScroll"
modelsScroll.Size = UDim2.new(1, -12, 1, -12)
modelsScroll.Position = UDim2.new(0, 6, 0, 6)
modelsScroll.BackgroundTransparency = 1
modelsScroll.BorderSizePixel = 0
modelsScroll.ScrollBarThickness = isMobile and 6 or 3
modelsScroll.ScrollBarImageColor3 = C.accentDim
modelsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
modelsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
modelsScroll.Parent = modelsFrame

local modelsListLayout = Instance.new("UIListLayout", modelsScroll)
modelsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
modelsListLayout.Padding = UDim.new(0, 8)

local modelsPad = Instance.new("UIPadding", modelsScroll)
modelsPad.PaddingTop = UDim.new(0, 4)
modelsPad.PaddingBottom = UDim.new(0, 4)
modelsPad.PaddingLeft = UDim.new(0, 4)
modelsPad.PaddingRight = UDim.new(0, 4)

local selectedCompany = nil
local selectedModel = nil
local companyRows = {}
local modelRows = {}

local function clearModelRows()
    for _, row in ipairs(modelRows) do
        row:Destroy()
    end
    modelRows = {}
end

local function showCompanies()
    clearModelRows()
    for _, row in ipairs(companyRows) do
        row.Visible = true
    end
    selectedCompany = nil
end

local function selectModel(companyName, modelData)
    selectedCompany = companyName
    selectedModel = modelData
    local comp = allCompanies[companyName]
    currentAPI = {
        name = companyName,
        key = comp.key,
        url = comp.url,
        model = modelData.id,
        modelDisplay = modelData.display,
        format = comp.format,
    }
    modelDropdown.Text = companyName .. " | " .. modelData.display
    addChatBubble("Switched to " .. companyName .. " - " .. modelData.display, false)
    switchTab("chat")
end

local function showModels(companyName)
    for _, row in ipairs(companyRows) do
        row.Visible = false
    end
    clearModelRows()

    local comp = allCompanies[companyName]

    local backRow = Instance.new("Frame")
    backRow.Size = UDim2.new(1, -8, 0, isMobile and 44 or 36)
    backRow.BackgroundColor3 = C.surfaceHi
    backRow.BackgroundTransparency = 0.3
    backRow.BorderSizePixel = 0
    backRow.LayoutOrder = 0
    backRow.Parent = modelsScroll
    corner(backRow, 8)
    stroke(backRow, C.border, 1)
    table.insert(modelRows, backRow)

    local backBtn = Instance.new("TextButton")
    backBtn.Size = UDim2.new(1, 0, 1, 0)
    backBtn.BackgroundTransparency = 1
    backBtn.Text = "  < Back to Companies"
    backBtn.TextColor3 = C.accent
    backBtn.TextSize = isMobile and 14 or 12
    backBtn.Font = Enum.Font.GothamBold
    backBtn.TextXAlignment = Enum.TextXAlignment.Left
    backBtn.Parent = backRow

    backBtn.MouseButton1Click:Connect(function()
        showCompanies()
    end)

    local headerRow = Instance.new("Frame")
    headerRow.Size = UDim2.new(1, -8, 0, isMobile and 40 or 32)
    headerRow.BackgroundColor3 = comp.color
    headerRow.BackgroundTransparency = 0.8
    headerRow.BorderSizePixel = 0
    headerRow.LayoutOrder = 1
    headerRow.Parent = modelsScroll
    corner(headerRow, 8)
    stroke(headerRow, comp.color, 1)
    table.insert(modelRows, headerRow)

    local headerLbl = Instance.new("TextLabel")
    headerLbl.Size = UDim2.new(1, -12, 1, 0)
    headerLbl.Position = UDim2.new(0, 10, 0, 0)
    headerLbl.BackgroundTransparency = 1
    headerLbl.Text = companyName .. " Models"
    headerLbl.TextColor3 = comp.color
    headerLbl.TextSize = isMobile and 15 or 13
    headerLbl.Font = Enum.Font.GothamBold
    headerLbl.TextXAlignment = Enum.TextXAlignment.Left
    headerLbl.Parent = headerRow

    for i, model in ipairs(comp.models) do
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, -8, 0, isMobile and 44 or 36)
        row.BackgroundColor3 = C.surfaceHi
        row.BackgroundTransparency = 0.3
        row.BorderSizePixel = 0
        row.LayoutOrder = i + 1
        row.Parent = modelsScroll
        corner(row, 8)
        stroke(row, C.border, 1)
        table.insert(modelRows, row)

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -80, 1, 0)
        lbl.Position = UDim2.new(0, 12, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = model.display
        lbl.TextColor3 = C.text
        lbl.TextSize = isMobile and 14 or 12
        lbl.Font = Enum.Font.GothamBold
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = row

        local useBtn = Instance.new("TextButton")
        useBtn.Size = UDim2.new(0, 60, 0, isMobile and 28 or 24)
        useBtn.Position = UDim2.new(1, -70, 0.5, -12)
        useBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 30)
        useBtn.BackgroundTransparency = 0.2
        useBtn.Text = "USE"
        useBtn.TextColor3 = C.green
        useBtn.TextSize = 10
        useBtn.Font = Enum.Font.GothamBold
        useBtn.BorderSizePixel = 0
        useBtn.AutoButtonColor = false
        useBtn.Parent = row
        corner(useBtn, 6)
        stroke(useBtn, C.green, 1)

        useBtn.MouseButton1Click:Connect(function()
            selectModel(companyName, model)
        end)
    end
end

for i, companyName in ipairs(companyKeys) do
    local comp = allCompanies[companyName]
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -8, 0, isMobile and 56 or 44)
    row.BackgroundColor3 = C.surfaceHi
    row.BackgroundTransparency = 0.3
    row.BorderSizePixel = 0
    row.LayoutOrder = i
    row.Parent = modelsScroll
    corner(row, 8)
    stroke(row, comp.color, 1)
    table.insert(companyRows, row)

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, -80, 0, 22)
    nameLbl.Position = UDim2.new(0, 10, 0, 6)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = companyName
    nameLbl.TextColor3 = comp.color
    nameLbl.TextSize = isMobile and 15 or 13
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.Parent = row

    local countLbl = Instance.new("TextLabel")
    countLbl.Size = UDim2.new(1, -80, 0, 16)
    countLbl.Position = UDim2.new(0, 10, 0, 28)
    countLbl.BackgroundTransparency = 1
    countLbl.Text = #comp.models .. " models"
    countLbl.TextColor3 = C.textDim
    countLbl.TextSize = 9
    countLbl.Font = Enum.Font.Gotham
    countLbl.TextXAlignment = Enum.TextXAlignment.Left
    countLbl.Parent = row

    local openBtn = Instance.new("TextButton")
    openBtn.Size = UDim2.new(0, 60, 0, isMobile and 30 or 26)
    openBtn.Position = UDim2.new(1, -70, 0.5, -13)
    openBtn.BackgroundColor3 = comp.color
    openBtn.BackgroundTransparency = 0.8
    openBtn.Text = "OPEN"
    openBtn.TextColor3 = comp.color
    openBtn.TextSize = 10
    openBtn.Font = Enum.Font.GothamBold
    openBtn.BorderSizePixel = 0
    openBtn.AutoButtonColor = false
    openBtn.Parent = row
    corner(openBtn, 6)
    stroke(openBtn, comp.color, 1)

    openBtn.MouseButton1Click:Connect(function()
        showModels(companyName)
    end)
end

local apiScroll = Instance.new("ScrollingFrame")
apiScroll.Size = UDim2.new(1, -12, 1, -12)
apiScroll.Position = UDim2.new(0, 6, 0, 6)
apiScroll.BackgroundTransparency = 1
apiScroll.BorderSizePixel = 0
apiScroll.ScrollBarThickness = isMobile and 6 or 3
apiScroll.ScrollBarImageColor3 = C.accentDim
apiScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
apiScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
apiScroll.Parent = apiFrame

local apiListLayout = Instance.new("UIListLayout", apiScroll)
apiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
apiListLayout.Padding = UDim.new(0, 6)

local apiPad = Instance.new("UIPadding", apiScroll)
apiPad.PaddingTop = UDim.new(0, 4)
apiPad.PaddingBottom = UDim.new(0, 4)
apiPad.PaddingLeft = UDim.new(0, 4)
apiPad.PaddingRight = UDim.new(0, 4)

local customAPIs = {}

local function refreshAPIDropdown()
    if selectedCompany and selectedModel then
        modelDropdown.Text = selectedCompany .. " | " .. selectedModel.display
    end
end

local function createAPIRow(apiData, isCustom, index)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -8, 0, isMobile and 56 or 44)
    row.BackgroundColor3 = C.surfaceHi
    row.BackgroundTransparency = 0.3
    row.BorderSizePixel = 0
    row.LayoutOrder = index
    row.Parent = apiScroll
    corner(row, 8)
    stroke(row, C.border, 1)

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, -120, 0, 20)
    nameLbl.Position = UDim2.new(0, 10, 0, 6)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = apiData.name .. " | " .. apiData.modelDisplay
    nameLbl.TextColor3 = C.accent
    nameLbl.TextSize = isMobile and 13 or 11
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.Parent = row

    local urlLbl = Instance.new("TextLabel")
    urlLbl.Size = UDim2.new(1, -120, 0, 16)
    urlLbl.Position = UDim2.new(0, 10, 0, 26)
    urlLbl.BackgroundTransparency = 1
    urlLbl.Text = apiData.url:sub(1, 40) .. (apiData.url:len() > 40 and "..." or "")
    urlLbl.TextColor3 = C.textDim
    urlLbl.TextSize = 9
    urlLbl.Font = Enum.Font.Gotham
    urlLbl.TextXAlignment = Enum.TextXAlignment.Left
    urlLbl.Parent = row

    local useBtn = Instance.new("TextButton")
    useBtn.Size = UDim2.new(0, 50, 0, 28)
    useBtn.Position = UDim2.new(1, -110, 0.5, -14)
    useBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 30)
    useBtn.BackgroundTransparency = 0.2
    useBtn.Text = "USE"
    useBtn.TextColor3 = C.green
    useBtn.TextSize = 10
    useBtn.Font = Enum.Font.GothamBold
    useBtn.BorderSizePixel = 0
    useBtn.AutoButtonColor = false
    useBtn.Parent = row
    corner(useBtn, 6)
    stroke(useBtn, C.green, 1)

    useBtn.MouseButton1Click:Connect(function()
        currentAPI = apiData
        modelDropdown.Text = apiData.modelDisplay
        addChatBubble("Switched to " .. apiData.name .. " (" .. apiData.modelDisplay .. ")", false)
    end)

    local keyBtn = Instance.new("TextButton")
    keyBtn.Size = UDim2.new(0, 50, 0, 28)
    keyBtn.Position = UDim2.new(1, -56, 0.5, -14)
    keyBtn.BackgroundColor3 = C.surface
    keyBtn.BackgroundTransparency = 0.3
    keyBtn.Text = apiData.key ~= "" and "SET" or "ADD"
    keyBtn.TextColor3 = apiData.key ~= "" and C.green or C.yellow
    keyBtn.TextSize = 10
    keyBtn.Font = Enum.Font.GothamBold
    keyBtn.BorderSizePixel = 0
    keyBtn.AutoButtonColor = false
    keyBtn.Parent = row
    corner(keyBtn, 6)
    stroke(keyBtn, apiData.key ~= "" and C.green or C.yellow, 1)

    keyBtn.MouseButton1Click:Connect(function()
        local keyFrame = Instance.new("Frame")
        keyFrame.Size = UDim2.new(0, 300, 0, 120)
        keyFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
        keyFrame.BackgroundColor3 = C.surface
        keyFrame.BackgroundTransparency = 0.1
        keyFrame.BorderSizePixel = 0
        keyFrame.ZIndex = 600
        keyFrame.Parent = sg
        corner(keyFrame, 12)
        stroke(keyFrame, C.accent, 2)

        local keyTitle = Instance.new("TextLabel")
        keyTitle.Size = UDim2.new(1, 0, 0, 28)
        keyTitle.Position = UDim2.new(0, 0, 0, 8)
        keyTitle.BackgroundTransparency = 1
        keyTitle.Text = "Enter API Key for " .. apiData.name
        keyTitle.TextColor3 = C.accent
        keyTitle.TextSize = 13
        keyTitle.Font = Enum.Font.GothamBold
        keyTitle.ZIndex = 601
        keyTitle.Parent = keyFrame

        local keyInput = Instance.new("TextBox")
        keyInput.Size = UDim2.new(1, -20, 0, 32)
        keyInput.Position = UDim2.new(0, 10, 0, 40)
        keyInput.BackgroundColor3 = C.bg
        keyInput.BackgroundTransparency = 0.2
        keyInput.Text = apiData.key
        keyInput.PlaceholderText = "sk-..."
        keyInput.TextColor3 = C.text
        keyInput.PlaceholderColor3 = C.textDim
        keyInput.TextSize = 11
        keyInput.Font = Enum.Font.Code
        keyInput.ClearTextOnFocus = false
        keyInput.ZIndex = 601
        keyInput.Parent = keyFrame
        corner(keyInput, 6)
        stroke(keyInput, C.border, 1)

        local saveBtn = Instance.new("TextButton")
        saveBtn.Size = UDim2.new(0, 80, 0, 28)
        saveBtn.Position = UDim2.new(0.5, -85, 1, -36)
        saveBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 30)
        saveBtn.BackgroundTransparency = 0.2
        saveBtn.Text = "SAVE"
        saveBtn.TextColor3 = C.green
        saveBtn.TextSize = 11
        saveBtn.Font = Enum.Font.GothamBold
        saveBtn.BorderSizePixel = 0
        saveBtn.AutoButtonColor = false
        saveBtn.ZIndex = 601
        saveBtn.Parent = keyFrame
        corner(saveBtn, 6)
        stroke(saveBtn, C.green, 1)

        local cancelBtn = Instance.new("TextButton")
        cancelBtn.Size = UDim2.new(0, 80, 0, 28)
        cancelBtn.Position = UDim2.new(0.5, 5, 1, -36)
        cancelBtn.BackgroundColor3 = C.surfaceHi
        cancelBtn.BackgroundTransparency = 0.3
        cancelBtn.Text = "CANCEL"
        cancelBtn.TextColor3 = C.red
        cancelBtn.TextSize = 11
        cancelBtn.Font = Enum.Font.GothamBold
        cancelBtn.BorderSizePixel = 0
        cancelBtn.AutoButtonColor = false
        cancelBtn.ZIndex = 601
        cancelBtn.Parent = keyFrame
        corner(cancelBtn, 6)
        stroke(cancelBtn, C.red, 1)

        saveBtn.MouseButton1Click:Connect(function()
            apiData.key = keyInput.Text
            if allCompanies[apiData.name] then
                allCompanies[apiData.name].key = keyInput.Text
            end
            keyBtn.Text = "SET"
            keyBtn.TextColor3 = C.green
            local st = keyBtn:FindFirstChildOfClass("UIStroke")
            if st then st.Color = C.green end
            keyFrame:Destroy()
            refreshAPIDropdown()
        end)

        cancelBtn.MouseButton1Click:Connect(function()
            keyFrame:Destroy()
        end)
    end)
end

for i, companyName in ipairs(companyKeys) do
    local comp = allCompanies[companyName]
    local apiData = {
        name = companyName,
        key = comp.key,
        url = comp.url,
        model = comp.models[1] and comp.models[1].id or "",
        modelDisplay = comp.models[1] and comp.models[1].display or "",
        format = comp.format,
    }
    createAPIRow(apiData, false, i)
end

local addApiBtn = Instance.new("TextButton")
addApiBtn.Size = UDim2.new(1, -8, 0, isMobile and 48 or 38)
addApiBtn.BackgroundColor3 = C.surfaceHi
addApiBtn.BackgroundTransparency = 0.3
addApiBtn.Text = "+ Add Custom API"
addApiBtn.TextColor3 = C.accent
addApiBtn.TextSize = isMobile and 14 or 12
addApiBtn.Font = Enum.Font.GothamBold
addApiBtn.BorderSizePixel = 0
addApiBtn.AutoButtonColor = false
addApiBtn.LayoutOrder = 999
addApiBtn.Parent = apiScroll
corner(addApiBtn, 8)
stroke(addApiBtn, C.accent, 1)

addApiBtn.MouseButton1Click:Connect(function()
    local addFrame = Instance.new("Frame")
    addFrame.Size = UDim2.new(0, 340, 0, 280)
    addFrame.Position = UDim2.new(0.5, -170, 0.5, -140)
    addFrame.BackgroundColor3 = C.surface
    addFrame.BackgroundTransparency = 0.1
    addFrame.BorderSizePixel = 0
    addFrame.ZIndex = 600
    addFrame.Parent = sg
    corner(addFrame, 12)
    stroke(addFrame, C.accent, 2)

    local fields = {
        {label = "Name", placeholder = "My API", val = ""},
        {label = "API Key", placeholder = "sk-...", val = ""},
        {label = "URL", placeholder = "https://api.example.com/v1/chat/completions", val = ""},
        {label = "Model", placeholder = "gpt-4o", val = ""},
        {label = "Display Name", placeholder = "GPT-4o", val = ""},
    }

    local inputs = {}
    for i, field in ipairs(fields) do
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -20, 0, 18)
        lbl.Position = UDim2.new(0, 10, 0, 10 + (i - 1) * 48)
        lbl.BackgroundTransparency = 1
        lbl.Text = field.label
        lbl.TextColor3 = C.accent
        lbl.TextSize = 11
        lbl.Font = Enum.Font.GothamBold
        lbl.ZIndex = 601
        lbl.Parent = addFrame

        local inp = Instance.new("TextBox")
        inp.Size = UDim2.new(1, -20, 0, 28)
        inp.Position = UDim2.new(0, 10, 0, 28 + (i - 1) * 48)
        inp.BackgroundColor3 = C.bg
        inp.BackgroundTransparency = 0.2
        inp.Text = field.val
        inp.PlaceholderText = field.placeholder
        inp.TextColor3 = C.text
        inp.PlaceholderColor3 = C.textDim
        inp.TextSize = 11
        inp.Font = Enum.Font.Gotham
        inp.ClearTextOnFocus = false
        inp.ZIndex = 601
        inp.Parent = addFrame
        corner(inp, 6)
        stroke(inp, C.border, 1)
        inputs[field.label] = inp
    end

    local saveBtn = Instance.new("TextButton")
    saveBtn.Size = UDim2.new(0, 100, 0, 30)
    saveBtn.Position = UDim2.new(0.5, -105, 1, -40)
    saveBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 30)
    saveBtn.BackgroundTransparency = 0.2
    saveBtn.Text = "ADD API"
    saveBtn.TextColor3 = C.green
    saveBtn.TextSize = 12
    saveBtn.Font = Enum.Font.GothamBold
    saveBtn.BorderSizePixel = 0
    saveBtn.AutoButtonColor = false
    saveBtn.ZIndex = 601
    saveBtn.Parent = addFrame
    corner(saveBtn, 6)
    stroke(saveBtn, C.green, 1)

    local cancelBtn = Instance.new("TextButton")
    cancelBtn.Size = UDim2.new(0, 100, 0, 30)
    cancelBtn.Position = UDim2.new(0.5, 5, 1, -40)
    cancelBtn.BackgroundColor3 = C.surfaceHi
    cancelBtn.BackgroundTransparency = 0.3
    cancelBtn.Text = "CANCEL"
    cancelBtn.TextColor3 = C.red
    cancelBtn.TextSize = 12
    cancelBtn.Font = Enum.Font.GothamBold
    cancelBtn.BorderSizePixel = 0
    cancelBtn.AutoButtonColor = false
    cancelBtn.ZIndex = 601
    cancelBtn.Parent = addFrame
    corner(cancelBtn, 6)
    stroke(cancelBtn, C.red, 1)

    saveBtn.MouseButton1Click:Connect(function()
        local newApi = {
            name = inputs["Name"].Text,
            key = inputs["API Key"].Text,
            url = inputs["URL"].Text,
            model = inputs["Model"].Text,
            modelDisplay = inputs["Display Name"].Text,
        }
        if newApi.name ~= "" and newApi.url ~= "" and newApi.model ~= "" then
            table.insert(customAPIs, newApi)
            createAPIRow(newApi, true, #companyKeys + #customAPIs)
            addFrame:Destroy()
            refreshAPIDropdown()
        end
    end)

    cancelBtn.MouseButton1Click:Connect(function()
        addFrame:Destroy()
    end)
end)

local chatHistory = {}
local layoutOrder = 0
local isWaiting = false

local function addChatBubble(text, isUser)
    layoutOrder = layoutOrder + 1
    local bubble = Instance.new("Frame")
    bubble.Size = UDim2.new(1, 0, 0, 0)
    bubble.AutomaticSize = Enum.AutomaticSize.Y
    bubble.BackgroundTransparency = 1
    bubble.LayoutOrder = layoutOrder
    bubble.Parent = chatScroll

    local inner = Instance.new("Frame")
    inner.Size = UDim2.new(0.92, 0, 0, 0)
    inner.AutomaticSize = Enum.AutomaticSize.Y
    inner.Position = UDim2.new(isUser and 0.08 or 0, 0, 0, 0)
    inner.BackgroundColor3 = isUser and C.surfaceHi or Color3.fromRGB(0, 60, 30)
    inner.BackgroundTransparency = isUser and 0.3 or 0.2
    inner.BorderSizePixel = 0
    inner.Parent = bubble
    corner(inner, 8)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -12, 0, 0)
    lbl.AutomaticSize = Enum.AutomaticSize.Y
    lbl.Position = UDim2.new(0, 6, 0, 6)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = isUser and C.text or C.green
    lbl.TextSize = isMobile and 14 or 12
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true
    lbl.Parent = inner

    local pad = Instance.new("UIPadding", inner)
    pad.PaddingBottom = UDim.new(0, 6)

    if autoScroll then
        task.delay(0.05, function()
            chatScroll.CanvasPosition = Vector2.new(0, chatScroll.AbsoluteCanvasSize.Y)
        end)
    end
    return bubble
end

local function extractCodeBlocks(text)
    local blocks = {}
    for block in text:gmatch("```lua\n(.-)\n```") do
        table.insert(blocks, block)
    end
    if #blocks == 0 then
        for block in text:gmatch("```(.-)```") do
            table.insert(blocks, block)
        end
    end
    return blocks
end

local function stripComments(code)
    code = code:gsub("%-%-%[%[.-%]%]", "")
    code = code:gsub("%-%-[^\n]*", "")
    code = code:gsub("\n%s*\n", "\n")
    code = code:gsub("^%s*\n", "")
    code = code:gsub("\n%s*$", "")
    return code
end

local function scanWorkspace()
    local lines = {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        table.insert(lines, obj:GetFullName() .. " [" .. obj.ClassName .. "]")
        if #lines >= 100 then break end
    end
    return table.concat(lines, "\n")
end

local function scanPlayers()
    local lines = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        local char = plr.Character
        local pos = "N/A"
        if char and char:FindFirstChild("HumanoidRootPart") then
            pos = tostring(math.floor(char.HumanoidRootPart.Position.X)) .. "," .. tostring(math.floor(char.HumanoidRootPart.Position.Y)) .. "," .. tostring(math.floor(char.HumanoidRootPart.Position.Z))
        end
        table.insert(lines, plr.Name .. " | " .. pos)
    end
    return table.concat(lines, "\n")
end

local function readScripts()
    local lines = {}
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("LocalScript") or obj:IsA("ModuleScript") or obj:IsA("Script") then
            local src = "-- unavailable"
            pcall(function()
                if decompile then
                    src = decompile(obj)
                end
            end)
            table.insert(lines, "-- " .. obj:GetFullName() .. "\n" .. src)
            if #lines >= 3 then break end
        end
    end
    return table.concat(lines, "\n\n")
end

local function getConsoleContext()
    if not Tools.ConsoleCapture then return "" end
    local lines = {}
    for i = math.max(1, #consoleLines - 10), #consoleLines do
        local lbl = consoleLines[i]
        if lbl then
            table.insert(lines, lbl.Text)
        end
    end
    if #lines == 0 then return "" end
    return "[CONSOLE OUTPUT]\n" .. table.concat(lines, "\n")
end

local function buildContext()
    local ctx = {}
    if Tools.ScanWorkspace then
        table.insert(ctx, "[WORKSPACE SCAN]\n" .. scanWorkspace())
    end
    if Tools.SpyPlayers then
        table.insert(ctx, "[PLAYER DATA]\n" .. scanPlayers())
    end
    if Tools.ScriptReader then
        table.insert(ctx, "[SCRIPT SOURCES]\n" .. readScripts())
    end
    local consoleCtx = getConsoleContext()
    if consoleCtx ~= "" then
        table.insert(ctx, consoleCtx)
    end
    return table.concat(ctx, "\n\n")
end

local function makeRequest(messages)
    local ok, res = pcall(function()
        local bodyData = {
            model = currentAPI.model,
            messages = messages,
            temperature = temperature,
            max_tokens = maxTokens
        }

        local format = currentAPI.format or "openai"
        local body

        if format == "anthropic" then
            local sysMsg = ""
            local anthropicMsgs = {}
            for _, m in ipairs(messages) do
                if m.role == "system" then
                    sysMsg = m.content
                else
                    table.insert(anthropicMsgs, {role = m.role, content = m.content})
                end
            end
            body = HttpService:JSONEncode({
                model = currentAPI.model,
                max_tokens = maxTokens,
                temperature = temperature,
                system = sysMsg,
                messages = anthropicMsgs
            })
        elseif format == "google" then
            local contents = {}
            for _, m in ipairs(messages) do
                if m.role ~= "system" then
                    local role = m.role == "user" and "user" or "model"
                    table.insert(contents, {role = role, parts = {{text = m.content}}})
                end
            end
            body = HttpService:JSONEncode({
                contents = contents,
                generationConfig = {
                    temperature = temperature,
                    maxOutputTokens = maxTokens
                }
            })
        elseif format == "cohere" then
            local cohereMsgs = {}
            for _, m in ipairs(messages) do
                if m.role ~= "system" then
                    table.insert(cohereMsgs, {
                        role = m.role == "user" and "USER" or "CHATBOT",
                        message = m.content
                    })
                end
            end
            body = HttpService:JSONEncode({
                model = currentAPI.model,
                message = cohereMsgs[#cohereMsgs] and cohereMsgs[#cohereMsgs].message or "",
                chat_history = #cohereMsgs > 1 and {table.unpack(cohereMsgs, 1, #cohereMsgs - 1)} or nil,
                temperature = temperature,
                max_tokens = maxTokens
            })
        elseif format == "qwen" then
            local qwenInput = {}
            for _, m in ipairs(messages) do
                if m.role ~= "system" then
                    table.insert(qwenInput, {role = m.role, content = m.content})
                end
            end
            body = HttpService:JSONEncode({
                model = currentAPI.model,
                input = {messages = qwenInput},
                parameters = {
                    temperature = temperature,
                    max_tokens = maxTokens
                }
            })
        elseif format == "ollama" then
            local ollamaPrompt = ""
            for _, m in ipairs(messages) do
                ollamaPrompt = ollamaPrompt .. m.role .. ": " .. m.content .. "\n"
            end
            body = HttpService:JSONEncode({
                model = currentAPI.model,
                prompt = ollamaPrompt,
                stream = false,
                options = {
                    temperature = temperature,
                    num_predict = maxTokens
                }
            })
        else
            body = HttpService:JSONEncode(bodyData)
        end

        local reqFunc = request or http_request or syn and syn.request
        if not reqFunc then
            return nil
        end

        local headers = {
            ["Content-Type"] = "application/json",
        }

        if format == "anthropic" then
            headers["x-api-key"] = currentAPI.key
            headers["anthropic-version"] = "2023-06-01"
        elseif format == "google" then
            headers["x-goog-api-key"] = currentAPI.key
        elseif format == "qwen" then
            headers["Authorization"] = "Bearer " .. currentAPI.key
        elseif format == "cohere" then
            headers["Authorization"] = "Bearer " .. currentAPI.key
        else
            headers["Authorization"] = "Bearer " .. currentAPI.key
        end

        if currentAPI.url:find("openrouter") then
            headers["HTTP-Referer"] = "https://roblox.com"
            headers["X-Title"] = "ZB.ai"
        end

        local fullUrl = currentAPI.url
        if format == "google" then
            fullUrl = currentAPI.url .. currentAPI.model .. ":generateContent"
        end

        local response = reqFunc({
            Url = fullUrl,
            Method = "POST",
            Headers = headers,
            Body = body
        })

        local parsed = HttpService:JSONDecode(response.Body)

        if format == "google" then
            if parsed.candidates and parsed.candidates[1] and parsed.candidates[1].content then
                return {
                    choices = {{
                        message = {
                            content = parsed.candidates[1].content.parts[1].text
                        }
                    }}
                }
            end
        elseif format == "anthropic" then
            if parsed.content and parsed.content[1] then
                return {
                    choices = {{
                        message = {
                            content = parsed.content[1].text
                        }
                    }}
                }
            end
        elseif format == "cohere" then
            if parsed.text then
                return {
                    choices = {{
                        message = {
                            content = parsed.text
                        }
                    }}
                }
            end
        elseif format == "qwen" then
            if parsed.output and parsed.output.choices and parsed.output.choices[1] then
                return {
                    choices = {{
                        message = {
                            content = parsed.output.choices[1].message.content
                        }
                    }}
                }
            end
        elseif format == "ollama" then
            if parsed.response then
                return {
                    choices = {{
                        message = {
                            content = parsed.response
                        }
                    }}
                }
            end
        end

        return parsed
    end)
    if ok and res then
        return res
    end
    return nil
end

local function sendMessage()
    if isWaiting then return end
    local text = inputBox.Text
    if text == "" then return end
    inputBox.Text = ""
    isWaiting = true
    sendBtn.ImageTransparency = 0.7
    addChatBubble(text, true)

    typingIndicator.Visible = true
    typingIndicator.LayoutOrder = layoutOrder + 1

    local sysPrompt = "You are ZB.ai, expert Roblox Lua dev. Output ONLY clean code. ZERO comments. ZERO explanations inside code blocks. Use minimal variable names. Wrap code in ```lua. Be concise."
    local ctx = buildContext()
    if ctx ~= "" then
        sysPrompt = sysPrompt .. "\n\nCONTEXT:\n" .. ctx
    end

    local msgs = {
        {role = "system", content = sysPrompt},
    }
    for _, h in ipairs(chatHistory) do
        table.insert(msgs, h)
    end
    table.insert(msgs, {role = "user", content = text})

    task.spawn(function()
        local startTime = tick()
        local res = makeRequest(msgs)
        local elapsed = tick() - startTime

        typingIndicator.Visible = false
        isWaiting = false
        sendBtn.ImageTransparency = 0

        if res and res.choices and res.choices[1] and res.choices[1].message then
            local aiText = res.choices[1].message.content
            table.insert(chatHistory, {role = "user", content = text})
            table.insert(chatHistory, {role = "assistant", content = aiText})
            if #chatHistory > 10 then
                table.remove(chatHistory, 1)
                table.remove(chatHistory, 1)
            end
            addChatBubble(aiText .. "\n\n[ " .. string.format("%.1f", elapsed) .. "s | " .. currentAPI.modelDisplay .. " ]", false)

            local codeBlocks = extractCodeBlocks(aiText)
            for i, block in ipairs(codeBlocks) do
                codeBlocks[i] = stripComments(block)
            end
            if #codeBlocks > 0 and Tools.AutoInject then
                for _, code in ipairs(codeBlocks) do
                    pcall(function()
                        loadstring(code)()
                    end)
                end
            elseif #codeBlocks > 0 and not Tools.AutoInject then
                local injectBtn = Instance.new("ImageButton")
                injectBtn.Size = UDim2.new(0, isMobile and 44 or 36, 0, isMobile and 44 or 36)
                injectBtn.Position = UDim2.new(0, 0, 0, 0)
                injectBtn.BackgroundColor3 = Color3.fromRGB(0, 60, 30)
                injectBtn.BackgroundTransparency = 0.2
                injectBtn.Image = ICONS.inject
                injectBtn.ImageColor3 = C.green
                injectBtn.ImageTransparency = 0
                injectBtn.ScaleType = Enum.ScaleType.Fit
                injectBtn.BorderSizePixel = 0
                injectBtn.AutoButtonColor = false
                injectBtn.Parent = chatScroll
                injectBtn.LayoutOrder = layoutOrder + 1
                corner(injectBtn, 6)
                stroke(injectBtn, C.green, 1)
                layoutOrder = layoutOrder + 1

                injectBtn.MouseButton1Click:Connect(function()
                    for _, code in ipairs(codeBlocks) do
                        pcall(function()
                            loadstring(code)()
                        end)
                    end
                    injectBtn:Destroy()
                end)
            end
        else
            addChatBubble("Failed [" .. string.format("%.1f", elapsed) .. "s]. Check API key/URL or try faster model.", false)
        end
    end)
end

sendBtn.MouseButton1Click:Connect(sendMessage)
inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        sendMessage()
    end
end)

local toggleBtn = Instance.new("ImageButton")
toggleBtn.Name = "ZombieAIToggle"
toggleBtn.Size = UDim2.new(0, isMobile and 56 or 44, 0, isMobile and 56 or 44)
toggleBtn.Position = UDim2.new(1, -72, 1, -72)
toggleBtn.AnchorPoint = Vector2.new(1, 1)
toggleBtn.BackgroundColor3 = C.surface
toggleBtn.BackgroundTransparency = 0.2
toggleBtn.Image = ICONS.logo
toggleBtn.ImageColor3 = C.accent
toggleBtn.ImageTransparency = 0.3
toggleBtn.ScaleType = Enum.ScaleType.Fit
toggleBtn.Parent = sg
corner(toggleBtn, 999)
stroke(toggleBtn, C.accent, 2)
toggleBtn.Visible = false

local function openUI()
    mainFrame.Visible = true
    toggleBtn.Visible = false
end

local function closeUI()
    mainFrame.Visible = false
    toggleBtn.Visible = true
    tw(toggleBtn, TIF, {BackgroundTransparency = 0.2, ImageTransparency = 0.3})
end

minimizeBtn.MouseButton1Click:Connect(closeUI)
toggleBtn.MouseButton1Click:Connect(openUI)

UserInputService.InputBegan:Connect(function(inp, gpe)
    if inp.UserInputType ~= Enum.UserInputType.Keyboard or gpe then return end
    if inp.KeyCode == Enum.KeyCode.RightControl then
        if mainFrame.Visible then closeUI() else openUI() end
    end
end)

switchTab("chat")
