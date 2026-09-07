local ZIndex = {}
ZIndex.Flags = {}
ZIndex.Windows = {}

ZIndex.Icons = {
    Home = "rbxassetid://7733960981",
    Settings = "rbxassetid://7734053495",
    User = "rbxassetid://7733955740",
    Sword = "rbxassetid://7733970061",
    Shop = "rbxassetid://7733970549",
    Star = "rbxassetid://7733976015",
    Zap = "rbxassetid://7733977244",
    Target = "rbxassetid://7733964640",
    Code = "rbxassetid://7733954760",
    Info = "rbxassetid://7733956813",
}

ZIndex.Theme = {
    Background = Color3.fromRGB(20, 20, 28),
    BackgroundTransparency = 0.25,
    Topbar = Color3.fromRGB(25, 25, 35),
    TopbarTransparency = 0.15,
    Accent = Color3.fromRGB(99, 102, 241),
    AccentDark = Color3.fromRGB(79, 82, 221),
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(160, 160, 175),
    Element = Color3.fromRGB(30, 30, 42),
    ElementTransparency = 0.3,
    ElementHover = Color3.fromRGB(40, 40, 55),
    ToggleOn = Color3.fromRGB(99, 102, 241),
    ToggleOff = Color3.fromRGB(55, 55, 70),
    Success = Color3.fromRGB(67, 181, 129),
    Error = Color3.fromRGB(237, 66, 69),
    Warning = Color3.fromRGB(250, 166, 26),
}

local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function Tween(obj, props, duration, easing, direction)
    duration = duration or 0.3
    easing = easing or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    TweenService:Create(obj, TweenInfo.new(duration, easing, direction), props):Play()
end

local function RoundCorners(obj, radius)
    radius = radius or 8
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = obj
    return corner
end

local function AddStroke(obj, color, thickness)
    thickness = thickness or 1
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(60, 60, 80)
    stroke.Thickness = thickness
    stroke.Transparency = 0.5
    stroke.Parent = obj
    return stroke
end

function ZIndex:Notify(data)
    data = data or {}
    local title = data.Title or "Notification"
    local content = data.Content or ""
    local duration = data.Duration or 4
    local icon = data.Icon or ""

    local gui = player:WaitForChild("PlayerGui")
    local notifContainer = gui:FindFirstChild("ZIndexNotifications")
    if not notifContainer then
        notifContainer = Instance.new("ScreenGui")
        notifContainer.Name = "ZIndexNotifications"
        notifContainer.ResetOnSpawn = false
        notifContainer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        notifContainer.DisplayOrder = 999999
        pcall(function() notifContainer.Parent = CoreGui end)
        if not notifContainer.Parent then
            notifContainer.Parent = gui
        end
    end

    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 300, 0, 70)
    notif.Position = UDim2.new(1, 20, 0.85, 0)
    notif.BackgroundColor3 = ZIndex.Theme.Background
    notif.BackgroundTransparency = 0.15
    notif.BorderSizePixel = 0
    notif.Parent = notifContainer
    notif.ZIndex = 100

    RoundCorners(notif, 16)
    AddStroke(notif, Color3.fromRGB(80, 80, 110), 1)

    local iconLabel = Instance.new("ImageLabel")
    iconLabel.Size = UDim2.new(0, 32, 0, 32)
    iconLabel.Position = UDim2.new(0, 14, 0.5, -16)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Image = icon
    iconLabel.ImageColor3 = ZIndex.Theme.Accent
    iconLabel.Parent = notif

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -60, 0, 18)
    titleLbl.Position = UDim2.new(0, 54, 0, 10)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = title
    titleLbl.TextColor3 = ZIndex.Theme.Text
    titleLbl.TextSize = 14
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = notif

    local contentLbl = Instance.new("TextLabel")
    contentLbl.Size = UDim2.new(1, -60, 0, 30)
    contentLbl.Position = UDim2.new(0, 54, 0, 28)
    contentLbl.BackgroundTransparency = 1
    contentLbl.Text = content
    contentLbl.TextColor3 = ZIndex.Theme.TextDark
    contentLbl.TextSize = 12
    contentLbl.Font = Enum.Font.Gotham
    contentLbl.TextXAlignment = Enum.TextXAlignment.Left
    contentLbl.TextWrapped = true
    contentLbl.Parent = notif

    Tween(notif, {Position = UDim2.new(1, -320, 0.85, 0)}, 0.4)

    task.delay(duration, function()
        Tween(notif, {Position = UDim2.new(1, 20, 0.85, 0)}, 0.4)
        task.wait(0.4)
        notif:Destroy()
    end)
end

function ZIndex:CreateWindow(data)
    data = data or {}
    local title = data.Name or "ZIndex"

    local gui = Instance.new("ScreenGui")
    gui.Name = "ZIndex_" .. HttpService:GenerateGUID(false)
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.DisplayOrder = 99999

    pcall(function() gui.Parent = CoreGui end)
    if not gui.Parent then
        gui.Parent = player:WaitForChild("PlayerGui")
    end

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0, 520, 0, 380)
    main.Position = UDim2.new(0.5, -260, 0.5, -190)
    main.BackgroundColor3 = ZIndex.Theme.Background
    main.BackgroundTransparency = ZIndex.Theme.BackgroundTransparency
    main.BorderSizePixel = 0
    main.Active = true
    main.Draggable = true
    main.ClipsDescendants = true
    main.Parent = gui
    main.ZIndex = 10

    RoundCorners(main, 20)
    AddStroke(main, Color3.fromRGB(70, 70, 95), 1)

    local topbar = Instance.new("Frame")
    topbar.Name = "Topbar"
    topbar.Size = UDim2.new(1, 0, 0, 44)
    topbar.BackgroundColor3 = ZIndex.Theme.Topbar
    topbar.BackgroundTransparency = ZIndex.Theme.TopbarTransparency
    topbar.BorderSizePixel = 0
    topbar.Parent = main
    topbar.ZIndex = 11

    RoundCorners(topbar, 20)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Name = "Title"
    titleLbl.Size = UDim2.new(0, 200, 1, 0)
    titleLbl.Position = UDim2.new(0, 18, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = title
    titleLbl.TextColor3 = ZIndex.Theme.Text
    titleLbl.TextSize = 16
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = topbar
    titleLbl.ZIndex = 12

    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "Close"
    closeBtn.Size = UDim2.new(0, 28, 0, 28)
    closeBtn.Position = UDim2.new(1, -38, 0, 8)
    closeBtn.BackgroundColor3 = ZIndex.Theme.Error
    closeBtn.Text = ""
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = topbar
    closeBtn.ZIndex = 12

    RoundCorners(closeBtn, 14)

    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Name = "Minimize"
    minimizeBtn.Size = UDim2.new(0, 28, 0, 28)
    minimizeBtn.Position = UDim2.new(1, -72, 0, 8)
    minimizeBtn.BackgroundColor3 = ZIndex.Theme.Warning
    minimizeBtn.Text = ""
    minimizeBtn.AutoButtonColor = false
    minimizeBtn.Parent = topbar
    minimizeBtn.ZIndex = 12

    RoundCorners(minimizeBtn, 14)

    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(0, 140, 1, -44)
    tabContainer.Position = UDim2.new(0, 0, 0, 44)
    tabContainer.BackgroundColor3 = ZIndex.Theme.Topbar
    tabContainer.BackgroundTransparency = ZIndex.Theme.TopbarTransparency
    tabContainer.BorderSizePixel = 0
    tabContainer.Parent = main
    tabContainer.ZIndex = 11

    local tabList = Instance.new("ScrollingFrame")
    tabList.Name = "TabList"
    tabList.Size = UDim2.new(1, -12, 1, -20)
    tabList.Position = UDim2.new(0, 6, 0, 10)
    tabList.BackgroundTransparency = 1
    tabList.ScrollBarThickness = 0
    tabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabList.Parent = tabContainer
    tabList.ZIndex = 11

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 6)
    tabLayout.Parent = tabList

    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "Content"
    contentContainer.Size = UDim2.new(1, -140, 1, -44)
    contentContainer.Position = UDim2.new(0, 140, 0, 44)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Parent = main
    contentContainer.ZIndex = 11

    local window = {
        Gui = gui,
        Main = main,
        TabContainer = tabContainer,
        TabList = tabList,
        Content = contentContainer,
        Tabs = {},
        CurrentTab = nil,
    }

    closeBtn.MouseButton1Click:Connect(function()
        Tween(main, {Size = UDim2.new(0, 520, 0, 0)}, 0.3)
        task.wait(0.3)
        gui:Destroy()
    end)

    local minimized = false
    minimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Tween(main, {Size = UDim2.new(0, 520, 0, 44)}, 0.3)
        else
            Tween(main, {Size = UDim2.new(0, 520, 0, 380)}, 0.3)
        end
    end)

    table.insert(ZIndex.Windows, window)
    return window
end

function ZIndex:CreateTab(window, data)
    data = data or {}
    local name = data.Name or "Tab"
    local icon = data.Icon or ""

    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = name
    tabBtn.Size = UDim2.new(1, 0, 0, 38)
    tabBtn.BackgroundColor3 = ZIndex.Theme.Element
    tabBtn.BackgroundTransparency = ZIndex.Theme.ElementTransparency
    tabBtn.Text = ""
    tabBtn.AutoButtonColor = false
    tabBtn.Parent = window.TabList
    tabBtn.ZIndex = 12

    RoundCorners(tabBtn, 19)
    AddStroke(tabBtn, Color3.fromRGB(55, 55, 75), 1)

    local iconImg = Instance.new("ImageLabel")
    iconImg.Size = UDim2.new(0, 18, 0, 18)
    iconImg.Position = UDim2.new(0, 12, 0.5, -9)
    iconImg.BackgroundTransparency = 1
    iconImg.Image = icon
    iconImg.ImageColor3 = ZIndex.Theme.TextDark
    iconImg.Parent = tabBtn
    iconImg.ZIndex = 13

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, -38, 1, 0)
    nameLbl.Position = UDim2.new(0, 34, 0, 0)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = name
    nameLbl.TextColor3 = ZIndex.Theme.TextDark
    nameLbl.TextSize = 13
    nameLbl.Font = Enum.Font.GothamMedium
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.Parent = tabBtn
    nameLbl.ZIndex = 13

    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Name = name .. "Content"
    tabContent.Size = UDim2.new(1, -16, 1, -16)
    tabContent.Position = UDim2.new(0, 8, 0, 8)
    tabContent.BackgroundTransparency = 1
    tabContent.ScrollBarThickness = 3
    tabContent.ScrollBarImageColor3 = ZIndex.Theme.Accent
    tabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContent.Visible = false
    tabContent.Parent = window.Content
    tabContent.ZIndex = 12

    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 8)
    contentLayout.Parent = tabContent

    local tab = {
        Button = tabBtn,
        Content = tabContent,
        Icon = iconImg,
        Label = nameLbl,
        Elements = {},
    }

    tabBtn.MouseButton1Click:Connect(function()
        if window.CurrentTab then
            window.CurrentTab.Content.Visible = false
            Tween(window.CurrentTab.Button, {BackgroundTransparency = ZIndex.Theme.ElementTransparency}, 0.2)
            window.CurrentTab.Icon.ImageColor3 = ZIndex.Theme.TextDark
            window.CurrentTab.Label.TextColor3 = ZIndex.Theme.TextDark
        end
        window.CurrentTab = tab
        tabContent.Visible = true
        Tween(tabBtn, {BackgroundTransparency = 0.05}, 0.2)
        iconImg.ImageColor3 = ZIndex.Theme.Text
        nameLbl.TextColor3 = ZIndex.Theme.Text
    end)

    tabBtn.MouseEnter:Connect(function()
        if window.CurrentTab ~= tab then
            Tween(tabBtn, {BackgroundTransparency = 0.15}, 0.15)
        end
    end)

    tabBtn.MouseLeave:Connect(function()
        if window.CurrentTab ~= tab then
            Tween(tabBtn, {BackgroundTransparency = ZIndex.Theme.ElementTransparency}, 0.15)
        end
    end)

    table.insert(window.Tabs, tab)
    if #window.Tabs == 1 then
        tabBtn.MouseButton1Click:Fire()
    end

    return tabContent
end

function ZIndex:CreateToggle(tab, data)
    data = data or {}
    local name = data.Name or "Toggle"
    local default = data.Default or false
    local callback = data.Callback or function() end
    local flag = data.Flag

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.BackgroundColor3 = ZIndex.Theme.Element
    frame.BackgroundTransparency = ZIndex.Theme.ElementTransparency
    frame.BorderSizePixel = 0
    frame.Parent = tab
    frame.ZIndex = 13

    RoundCorners(frame, 12)
    AddStroke(frame, Color3.fromRGB(55, 55, 75), 1)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = ZIndex.Theme.Text
    label.TextSize = 13
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    label.ZIndex = 14

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 46, 0, 24)
    toggle.Position = UDim2.new(1, -56, 0.5, -12)
    toggle.BackgroundColor3 = default and ZIndex.Theme.ToggleOn or ZIndex.Theme.ToggleOff
    toggle.Text = ""
    toggle.AutoButtonColor = false
    toggle.Parent = frame
    toggle.ZIndex = 14

    RoundCorners(toggle, 12)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = default and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = toggle
    knob.ZIndex = 15

    RoundCorners(knob, 10)

    local enabled = default
    toggle.MouseButton1Click:Connect(function()
        enabled = not enabled
        local targetPos = enabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10)
        local targetColor = enabled and ZIndex.Theme.ToggleOn or ZIndex.Theme.ToggleOff
        Tween(knob, {Position = targetPos}, 0.2)
        Tween(toggle, {BackgroundColor3 = targetColor}, 0.2)
        if flag then ZIndex.Flags[flag] = enabled end
        callback(enabled)
    end)

    if flag then ZIndex.Flags[flag] = enabled end

    return {
        Set = function(v)
            enabled = v
            local targetPos = enabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10)
            local targetColor = enabled and ZIndex.Theme.ToggleOn or ZIndex.Theme.ToggleOff
            knob.Position = targetPos
            toggle.BackgroundColor3 = targetColor
            if flag then ZIndex.Flags[flag] = enabled end
            callback(enabled)
        end,
        Get = function() return enabled end,
    }
end

function ZIndex:CreateButton(tab, data)
    data = data or {}
    local name = data.Name or "Button"
    local callback = data.Callback or function() end

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 38)
    btn.BackgroundColor3 = ZIndex.Theme.Accent
    btn.BackgroundTransparency = 0.1
    btn.Text = name
    btn.TextColor3 = ZIndex.Theme.Text
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamMedium
    btn.AutoButtonColor = false
    btn.Parent = tab
    btn.ZIndex = 13

    RoundCorners(btn, 12)
    AddStroke(btn, Color3.fromRGB(120, 120, 255), 1)

    btn.MouseEnter:Connect(function()
        Tween(btn, {BackgroundColor3 = ZIndex.Theme.AccentDark}, 0.15)
    end)

    btn.MouseLeave:Connect(function()
        Tween(btn, {BackgroundColor3 = ZIndex.Theme.Accent}, 0.15)
    end)

    btn.MouseButton1Click:Connect(function()
        Tween(btn, {Size = UDim2.new(1, -14, 0, 36)}, 0.1)
        task.wait(0.1)
        Tween(btn, {Size = UDim2.new(1, -10, 0, 38)}, 0.1)
        callback()
    end)

    return btn
end

function ZIndex:CreateSlider(tab, data)
    data = data or {}
    local name = data.Name or "Slider"
    local min = data.Min or 0
    local max = data.Max or 100
    local default = data.Default or min
    local callback = data.Callback or function() end
    local flag = data.Flag

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 52)
    frame.BackgroundColor3 = ZIndex.Theme.Element
    frame.BackgroundTransparency = ZIndex.Theme.ElementTransparency
    frame.BorderSizePixel = 0
    frame.Parent = tab
    frame.ZIndex = 13

    RoundCorners(frame, 12)
    AddStroke(frame, Color3.fromRGB(55, 55, 75), 1)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 0, 20)
    label.Position = UDim2.new(0, 14, 0, 6)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = ZIndex.Theme.Text
    label.TextSize = 13
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    label.ZIndex = 14

    local valueLbl = Instance.new("TextLabel")
    valueLbl.Size = UDim2.new(0, 60, 0, 20)
    valueLbl.Position = UDim2.new(1, -70, 0, 6)
    valueLbl.BackgroundTransparency = 1
    valueLbl.Text = tostring(default)
    valueLbl.TextColor3 = ZIndex.Theme.Accent
    valueLbl.TextSize = 13
    valueLbl.Font = Enum.Font.GothamBold
    valueLbl.TextXAlignment = Enum.TextXAlignment.Right
    valueLbl.Parent = frame
    valueLbl.ZIndex = 14

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -28, 0, 6)
    track.Position = UDim2.new(0, 14, 0, 34)
    track.BackgroundColor3 = ZIndex.Theme.ToggleOff
    track.BorderSizePixel = 0
    track.Parent = frame
    track.ZIndex = 14

    RoundCorners(track, 3)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = ZIndex.Theme.Accent
    fill.BorderSizePixel = 0
    fill.Parent = track
    fill.ZIndex = 15

    RoundCorners(fill, 3)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = track
    knob.ZIndex = 16

    RoundCorners(knob, 8)

    local dragging = false
    local currentValue = default

    local function UpdateValue(input)
        local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        currentValue = math.floor(min + pos * (max - min))
        fill.Size = UDim2.new(pos, 0, 1, 0)
        knob.Position = UDim2.new(pos, -8, 0.5, -8)
        valueLbl.Text = tostring(currentValue)
        if flag then ZIndex.Flags[flag] = currentValue end
        callback(currentValue)
    end

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            UpdateValue(input)
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateValue(input)
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    if flag then ZIndex.Flags[flag] = currentValue end

    return {
        Set = function(v)
            v = math.clamp(v, min, max)
            currentValue = v
            local pos = (v - min) / (max - min)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            knob.Position = UDim2.new(pos, -8, 0.5, -8)
            valueLbl.Text = tostring(v)
            if flag then ZIndex.Flags[flag] = currentValue end
            callback(currentValue)
        end,
        Get = function() return currentValue end,
    }
end

function ZIndex:CreateDropdown(tab, data)
    data = data or {}
    local name = data.Name or "Dropdown"
    local values = data.Values or {}
    local default = data.Default or values[1]
    local callback = data.Callback or function() end
    local flag = data.Flag

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.BackgroundColor3 = ZIndex.Theme.Element
    frame.BackgroundTransparency = ZIndex.Theme.ElementTransparency
    frame.BorderSizePixel = 0
    frame.Parent = tab
    frame.ZIndex = 13

    RoundCorners(frame, 12)
    AddStroke(frame, Color3.fromRGB(55, 55, 75), 1)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 120, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = ZIndex.Theme.Text
    label.TextSize = 13
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    label.ZIndex = 14

    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(0, 160, 0, 28)
    dropdown.Position = UDim2.new(1, -172, 0.5, -14)
    dropdown.BackgroundColor3 = ZIndex.Theme.Topbar
    dropdown.BackgroundTransparency = 0.2
    dropdown.Text = default or "Select..."
    dropdown.TextColor3 = ZIndex.Theme.Text
    dropdown.TextSize = 12
    dropdown.Font = Enum.Font.Gotham
    dropdown.AutoButtonColor = false
    dropdown.Parent = frame
    dropdown.ZIndex = 14

    RoundCorners(dropdown, 8)
    AddStroke(dropdown, Color3.fromRGB(55, 55, 75), 1)

    local selected = default

    dropdown.MouseButton1Click:Connect(function()
        local menu = Instance.new("Frame")
        menu.Size = UDim2.new(0, 160, 0, math.min(#values * 28, 180))
        menu.Position = UDim2.new(0, 0, 1, 4)
        menu.BackgroundColor3 = ZIndex.Theme.Topbar
        menu.BackgroundTransparency = 0.1
        menu.BorderSizePixel = 0
        menu.ZIndex = 20
        menu.Parent = dropdown

        RoundCorners(menu, 12)
        AddStroke(menu, Color3.fromRGB(55, 55, 75), 1)

        local scroll = Instance.new("ScrollingFrame")
        scroll.Size = UDim2.new(1, -8, 1, -8)
        scroll.Position = UDim2.new(0, 4, 0, 4)
        scroll.BackgroundTransparency = 1
        scroll.ScrollBarThickness = 2
        scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        scroll.ZIndex = 21
        scroll.Parent = menu

        local list = Instance.new("UIListLayout")
        list.SortOrder = Enum.SortOrder.LayoutOrder
        list.Padding = UDim.new(0, 2)
        list.Parent = scroll

        for _, val in ipairs(values) do
            local opt = Instance.new("TextButton")
            opt.Size = UDim2.new(1, 0, 0, 26)
            opt.BackgroundColor3 = ZIndex.Theme.Element
            opt.BackgroundTransparency = 0.2
            opt.Text = val
            opt.TextColor3 = ZIndex.Theme.Text
            opt.TextSize = 11
            opt.Font = Enum.Font.Gotham
            opt.AutoButtonColor = false
            opt.ZIndex = 22
            opt.Parent = scroll

            RoundCorners(opt, 6)

            opt.MouseEnter:Connect(function()
                Tween(opt, {BackgroundTransparency = 0.05}, 0.15)
            end)
            opt.MouseLeave:Connect(function()
                Tween(opt, {BackgroundTransparency = 0.2}, 0.15)
            end)

            opt.MouseButton1Click:Connect(function()
                selected = val
                dropdown.Text = val
                if flag then ZIndex.Flags[flag] = selected end
                callback(selected)
                menu:Destroy()
            end)
        end

        task.delay(5, function()
            if menu then menu:Destroy() end
        end)
    end)

    if flag then ZIndex.Flags[flag] = selected end

    return {
        Set = function(v)
            selected = v
            dropdown.Text = v
            if flag then ZIndex.Flags[flag] = selected end
            callback(selected)
        end,
        Get = function() return selected end,
        Refresh = function(newValues)
            values = newValues
        end,
    }
end

function ZIndex:CreateInput(tab, data)
    data = data or {}
    local name = data.Name or "Input"
    local default = data.Default or ""
    local placeholder = data.Placeholder or "Enter text..."
    local callback = data.Callback or function() end
    local flag = data.Flag

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.BackgroundColor3 = ZIndex.Theme.Element
    frame.BackgroundTransparency = ZIndex.Theme.ElementTransparency
    frame.BorderSizePixel = 0
    frame.Parent = tab
    frame.ZIndex = 13

    RoundCorners(frame, 12)
    AddStroke(frame, Color3.fromRGB(55, 55, 75), 1)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 120, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = ZIndex.Theme.Text
    label.TextSize = 13
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    label.ZIndex = 14

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0, 160, 0, 28)
    input.Position = UDim2.new(1, -172, 0.5, -14)
    input.BackgroundColor3 = ZIndex.Theme.Topbar
    input.BackgroundTransparency = 0.2
    input.Text = default
    input.PlaceholderText = placeholder
    input.TextColor3 = ZIndex.Theme.Text
    input.PlaceholderColor3 = ZIndex.Theme.TextDark
    input.TextSize = 12
    input.Font = Enum.Font.Gotham
    input.ClearTextOnFocus = false
    input.Parent = frame
    input.ZIndex = 14

    RoundCorners(input, 8)
    AddStroke(input, Color3.fromRGB(55, 55, 75), 1)

    input.FocusLost:Connect(function(enterPressed)
        if flag then ZIndex.Flags[flag] = input.Text end
        callback(input.Text, enterPressed)
    end)

    if flag then ZIndex.Flags[flag] = default end

    return {
        Set = function(v)
            input.Text = tostring(v)
            if flag then ZIndex.Flags[flag] = input.Text end
            callback(input.Text, false)
        end,
        Get = function() return input.Text end,
    }
end

function ZIndex:CreateLabel(tab, data)
    data = data or {}
    local text = data.Text or "Label"

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 0, 28)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = ZIndex.Theme.TextDark
    lbl.TextSize = 12
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = tab
    lbl.ZIndex = 13

    return {
        Set = function(v) lbl.Text = v end,
        Get = function() return lbl.Text end,
    }
end

function ZIndex:CreateDivider(tab)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 1)
    frame.Position = UDim2.new(0, 10, 0, 0)
    frame.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    frame.Parent = tab
    frame.ZIndex = 13
end

return ZIndex
