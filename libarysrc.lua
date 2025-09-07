-- STARHUB UI Library
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Library Class
local Library = {}
Library.__index = Library

-- Global variables
local Windows = {}
local CurrentWindow = nil
local CurrentTab = nil
local Sections = {left = {}, right = {}}
local SectionCount = {left = 0, right = 0}

-- Utility functions
local function createInstance(className, properties)
    local instance = Instance.new(className)
    for property, value in pairs(properties) do
        instance[property] = value
    end
    return instance
end

local function tweenProperty(object, property, targetValue, duration, easingStyle)
    local tweenInfo = TweenInfo.new(duration or 0.2, easingStyle or Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, {[property] = targetValue})
    tween:Play()
    return tween
end

-- Library Constructor
function Library.new(config)
    local self = setmetatable({}, Library)
    
    -- Create the main ScreenGui
    self.ScreenGui = createInstance("ScreenGui", {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    })
    
    -- Create main frame
    self.MainFrame = createInstance("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Name = "MainFrame",
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 720, 0, 550),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(12, 12, 12),
        Parent = self.ScreenGui
    })
    
    createInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = self.MainFrame
    })
    
    self.Windows = {}
    self.CurrentWindow = nil
    self.CurrentTab = nil
    self.Sections = {left = {}, right = {}}
    self.SectionCount = {left = 0, right = 0}
    
    -- Setup UI toggle
    self:setupUIToggle()
    
    return self
end

-- Setup UI Toggle functionality
function Library:setupUIToggle()
    local isUIVisible = true
    
    local function toggleUI()
        isUIVisible = not isUIVisible
        self.ScreenGui.Enabled = isUIVisible
    end
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.Insert then
            toggleUI()
        end
    end)
end

-- CreateWindow method
function Library:CreateWindow(config)
    local window = {}
    window.config = config or {}
    window.tabs = {}
    window.currentTab = nil
    
    -- Create container
    window.container = createInstance("Frame", {
        Name = "Container",
        Position = UDim2.new(0.02857903391122818, 0, 0.056512895971536636, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 678, 0, 505),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(11, 11, 11),
        Parent = self.MainFrame
    })
    
    createInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = window.container
    })
    
    -- Create top bar
    window.topBar = self:createTopBar()
    
    -- Create header for tabs
    window.header = self:createHeader()
    
    table.insert(self.Windows, window)
    self.CurrentWindow = window
    
    return window
end

-- Create top bar
function Library:createTopBar()
    local topBar = createInstance("Frame", {
        Name = "Top_Bar",
        Position = UDim2.new(0.04027777910232544, 0, 0.07454545795917511, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 660, 0, 65),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(12, 12, 12),
        Parent = self.MainFrame
    })
    
    createInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = topBar
    })
    
    -- Library name
    local libraryName = createInstance("TextLabel", {
        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Text = "STARHUB",
        Name = "Libary_Name",
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 1, 0, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.03999999910593033, 11, 0.3919999897480011, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.XY,
        TextSize = 21,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = topBar
    })
    
    return topBar
end

-- Create header for tabs
function Library:createHeader()
    local header = createInstance("Frame", {
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, 0, 0.5, 0),
        Name = "Header",
        Size = UDim2.new(0, 508, 0, 65),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = self.CurrentWindow.topBar
    })
    
    createInstance("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDim.new(0, 2),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = header
    })
    
    createInstance("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 20),
        Parent = header
    })
    
    return header
end

-- Window:CreateTab method
function Library:CreateTab(config)
    local tab = {}
    tab.config = config or {}
    tab.sections = {left = {}, right = {}}
    tab.sectionCount = {left = 0, right = 0}
    
    -- Create tab button
    tab.button = createInstance("Frame", {
        Name = "Tab",
        Position = UDim2.new(1.0347222089767456, 0, 0.3054545521736145, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 95, 0, 42),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(16, 16, 16),
        Parent = self.CurrentWindow.header
    })
    
    createInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = tab.button
    })
    
    -- Tab icon
    local tabIcon = createInstance("ImageLabel", {
        ImageColor3 = Color3.fromRGB(115, 58, 173),
        ScaleType = Enum.ScaleType.Fit,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Name = "Tab_Icon",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = config.icon and "rbxassetid://" .. config.icon or "rbxassetid://133833791023200",
        BackgroundTransparency = 1,
        Position = UDim2.new(0.25789472460746765, 0, 0.5, 0),
        Size = UDim2.new(0, 20, 0, 20),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = tab.button
    })
    
    -- Tab name
    local tabName = createInstance("TextLabel", {
        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
        TextColor3 = Color3.fromRGB(115, 58, 173),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = config.TabText or "Tab",
        Name = "Tab_Name",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0, 1, 0, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(2.0999999046325684, 0, 0.4749999940395355, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.XY,
        TextSize = 18,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = tabIcon
    })
    
    -- Tab click functionality
    tab.button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self:switchToTab(tab)
        end
    end)
    
    table.insert(self.CurrentWindow.tabs, tab)
    if not self.CurrentWindow.currentTab then
        self.CurrentWindow.currentTab = tab
        self:switchToTab(tab)
    end
    
    return tab
end

-- Switch to tab method
function Library:switchToTab(tab)
    -- Hide current tab sections
    if self.CurrentWindow.currentTab then
        for _, section in pairs(self.CurrentWindow.currentTab.sections.left) do
            if section.container then
                section.container.Visible = false
            end
        end
        for _, section in pairs(self.CurrentWindow.currentTab.sections.right) do
            if section.container then
                section.container.Visible = false
            end
        end
    end
    
    -- Show new tab sections
    self.CurrentWindow.currentTab = tab
    for _, section in pairs(tab.sections.left) do
        if section.container then
            section.container.Visible = true
        end
    end
    for _, section in pairs(tab.sections.right) do
        if section.container then
            section.container.Visible = true
        end
    end
    
    -- Update tab button colors
    for _, t in pairs(self.CurrentWindow.tabs) do
        if t.button then
            t.button.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
            if t.button:FindFirstChild("Tab_Icon") then
                t.button.Tab_Icon.ImageColor3 = Color3.fromRGB(58, 58, 58)
            end
        end
    end
    
    if tab.button then
        tab.button.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
        if tab.button:FindFirstChild("Tab_Icon") then
            tab.button.Tab_Icon.ImageColor3 = Color3.fromRGB(115, 58, 173)
        end
    end
end

-- Tab:CreateSection method
function Library:CreateSection(config)
    local section = {}
    section.config = config or {}
    section.position = config.position or "left"
    section.components = {}
    
    -- Create section container
    section.container = createInstance("Frame", {
        Size = UDim2.new(0, 318, 0, 411),
        Name = "Section_" .. section.position:gsub("^%l", string.upper),
        ClipsDescendants = true,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Position = section.position == "left" and UDim2.new(0.019436366856098175, 0, 0.17085854709148407, 0) or UDim2.new(0.5120617151260376, 0, 0.17085854709148407, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(16, 16, 16),
        Parent = self.CurrentWindow.container
    })
    
    createInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = section.container
    })
    
    -- Create shadow/header
    local shadow = createInstance("Frame", {
        BackgroundTransparency = 0.8999999761581421,
        Name = "Shadow",
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 318, 0, 40),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(170, 85, 255),
        Parent = section.container
    })
    
    createInstance("UIGradient", {
        Rotation = 7,
        Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.69, 1),
            NumberSequenceKeypoint.new(0.697, 0.981249988079071),
            NumberSequenceKeypoint.new(0.706, 0.949999988079071),
            NumberSequenceKeypoint.new(1, 0.987500011920929)
        },
        Parent = shadow
    })
    
    -- Section name
    local sectionName = createInstance("TextLabel", {
        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
        TextColor3 = Color3.fromRGB(115, 58, 173),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = config.SectionText or "Section",
        Name = "Section_Name",
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 1, 0, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0.5, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.XY,
        TextSize = 16,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = shadow
    })
    
    -- Create scrolling container
    section.scrollingContainer = createInstance("ScrollingFrame", {
        ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
        Active = true,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        ScrollBarThickness = 0,
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.985401451587677, 0),
        Name = section.position:gsub("^%l", string.upper) .. "_Container",
        Size = UDim2.new(0, 318, 0, 365),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = section.container
    })
    
    createInstance("UIListLayout", {
        Padding = UDim.new(0, 12),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = section.scrollingContainer
    })
    
    createInstance("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        Parent = section.scrollingContainer
    })
    
    -- Add to current tab
    table.insert(self.CurrentWindow.currentTab.sections[section.position], section)
    self.CurrentWindow.currentTab.sectionCount[section.position] = self.CurrentWindow.currentTab.sectionCount[section.position] + 1
    
    return section
end

-- Section:CreateToggle method
function Library:CreateToggle(config)
    local toggle = {}
    toggle.config = config or {}
    toggle.value = false
    toggle.callback = config.Callback or function() end
    
    -- Create toggle component
    toggle.component = createInstance("Frame", {
        BackgroundTransparency = 1,
        Name = "Toggle_Component",
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 318, 0, 20),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = self.scrollingContainer
    })
    
    -- Create toggle button
    toggle.button = createInstance("Frame", {
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 15, 0.5, 0),
        Name = "Toggle",
        Size = UDim2.new(0, 20, 0, 20),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = toggle.component
    })
    
    createInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = toggle.button
    })
    
    createInstance("UIStroke", {
        Color = Color3.fromRGB(33, 33, 33),
        Parent = toggle.button
    })
    
    -- Toggle text
    local toggleText = createInstance("TextLabel", {
        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = config.ToggleText or "Toggle",
        Name = "Toggle_Text",
        Size = UDim2.new(0, 1, 0, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(1.8179999589920044, -2, 0.07500000298023224, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.XY,
        TextSize = 16,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = toggle.button
    })
    
    -- Toggle fill
    toggle.fill = createInstance("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Name = "Toggle_Fill",
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 20, 0, 20),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(155, 77, 255),
        Parent = toggle.button
    })
    
    createInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = toggle.fill
    })
    
    -- Check icon
    local checkIcon = createInstance("ImageLabel", {
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Name = "Check_Icon",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = "rbxassetid://139958444428790",
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 13, 0, 15),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = toggle.fill
    })
    
    -- Toggle functionality
    toggle.button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggle.value = not toggle.value
            toggle.fill.Visible = toggle.value
            checkIcon.Visible = toggle.value
            toggle.callback(toggle.value)
        end
    end)
    
    -- Initially hide the fill
    toggle.fill.Visible = false
    checkIcon.Visible = false
    
    return toggle
end

-- Section:CreateSlider method
function Library:CreateSlider(config)
    local slider = {}
    slider.config = config or {}
    slider.min = config.Min or 0
    slider.max = config.Max or 100
    slider.value = config.Value or slider.min
    slider.callback = config.Callback or function() end
    
    -- Create slider component
    slider.component = createInstance("Frame", {
        Name = "Slider_Component",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.09732360392808914, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 318, 0, 40),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = self.scrollingContainer
    })
    
    -- Slider name
    local sliderName = createInstance("TextLabel", {
        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
        TextColor3 = Color3.fromRGB(52, 52, 52),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = config.SliderText or "Slider",
        Name = "Slider_Name",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0, 1, 0, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.10100000351667404, 0, 0.2199999988079071, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.XY,
        TextSize = 16,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = slider.component
    })
    
    -- Slider value display
    slider.valueLabel = createInstance("TextLabel", {
        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
        TextColor3 = Color3.fromRGB(52, 52, 52),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = tostring(slider.value),
        Name = "Slider_Value",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0, 1, 0, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.8589999675750732, 0, 0.21999970078468323, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.XY,
        TextSize = 16,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = slider.component
    })
    
    createInstance("UIPadding", {
        PaddingRight = UDim.new(0, 4),
        Parent = slider.valueLabel
    })
    
    -- Slider background
    slider.bg = createInstance("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Name = "Slider_BG",
        Position = UDim2.new(0.4887655973434448, 0, 0.6625000238418579, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 278, 0, 3),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(53, 27, 81),
        Parent = slider.component
    })
    
    createInstance("UICorner", {
        CornerRadius = UDim.new(0, 30),
        Parent = slider.bg
    })
    
    -- Progress bar
    slider.progressBar = createInstance("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Name = "Progress_Bar",
        Position = UDim2.new(0, 0, 0.5, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 150, 0, 3),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(115, 58, 173),
        Parent = slider.bg
    })
    
    createInstance("UICorner", {
        CornerRadius = UDim.new(0, 30),
        Parent = slider.progressBar
    })
    
    -- Pointer
    slider.pointer = createInstance("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        Name = "Pointer",
        Position = UDim2.new(1, 0, 0.5, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 15, 0, 15),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(155, 77, 255),
        Parent = slider.progressBar
    })
    
    createInstance("UICorner", {
        CornerRadius = UDim.new(0, 30),
        Parent = slider.pointer
    })
    
    -- Slider functionality
    local isDragging = false
    local connection
    
    local function updateSlider(mouseX)
        local sliderBounds = slider.bg.AbsolutePosition.X
        local sliderWidth = slider.bg.AbsoluteSize.X
        local relativeX = math.clamp(mouseX - sliderBounds, 0, sliderWidth)
        local percentage = relativeX / sliderWidth
        slider.value = math.floor(slider.min + (slider.max - slider.min) * percentage)
        slider.valueLabel.Text = tostring(slider.value)
        slider.progressBar.Size = UDim2.new(percentage, 0, 0, 3)
        slider.callback(slider.value)
    end
    
    slider.bg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            updateSlider(input.Position.X)
        end
    end)
    
    connection = UserInputService.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input.Position.X)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)
    
    -- Initialize slider
    updateSlider(slider.bg.AbsolutePosition.X + (slider.bg.AbsoluteSize.X * ((slider.value - slider.min) / (slider.max - slider.min))))
    
    return slider
end

-- Section:CreateTextInput method
function Library:CreateTextInput(config)
    local textInput = {}
    textInput.config = config or {}
    textInput.value = ""
    textInput.callback = config.Callback or function() end
    
    -- Create text input component
    textInput.component = createInstance("Frame", {
        Name = "TextInput_Component",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.09732360392808914, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 318, 0, 40),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = self.scrollingContainer
    })
    
    -- Text input field
    textInput.input = createInstance("TextLabel", {
        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
        TextColor3 = Color3.fromRGB(109, 109, 109),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = config.TextInputText or "Enter text...",
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 279, 0, 40),
        Name = "Text_Input",
        TextXAlignment = Enum.TextXAlignment.Left,
        Position = UDim2.new(0.04492206871509552, 0, 0.5, 0),
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(24, 24, 24),
        Parent = textInput.component
    })
    
    createInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = textInput.input
    })
    
    createInstance("UIPadding", {
        PaddingLeft = UDim.new(0, 12),
        Parent = textInput.input
    })
    
    -- Text input functionality
    local isFocused = false
    
    textInput.input.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isFocused = true
            textInput.input.Text = ""
            textInput.input.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if isFocused then
            if input.KeyCode == Enum.KeyCode.Return then
                isFocused = false
                textInput.value = textInput.input.Text
                textInput.callback(textInput.value)
                if textInput.value == "" then
                    textInput.input.Text = config.TextInputText or "Enter text..."
                    textInput.input.TextColor3 = Color3.fromRGB(109, 109, 109)
                end
            elseif input.KeyCode == Enum.KeyCode.Escape then
                isFocused = false
                textInput.input.Text = textInput.value == "" and (config.TextInputText or "Enter text...") or textInput.value
                textInput.input.TextColor3 = textInput.value == "" and Color3.fromRGB(109, 109, 109) or Color3.fromRGB(255, 255, 255)
            end
        end
    end)
    
    return textInput
end

-- Section:CreateKeybind method
function Library:CreateKeybind(config)
    local keybind = {}
    keybind.config = config or {}
    keybind.value = "None"
    keybind.callback = config.Callback or function() end
    keybind.isListening = false
    
    -- Create keybind component
    keybind.component = createInstance("Frame", {
        BackgroundTransparency = 1,
        Name = "Keybind_Component",
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 318, 0, 20),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = self.scrollingContainer
    })
    
    -- Keybind text
    local keybindText = createInstance("TextLabel", {
        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
        TextColor3 = Color3.fromRGB(52, 52, 52),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = config.KeybindText or "Keybind",
        Name = "Toggle_Text",
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 1, 0, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.044025156646966934, 0, 0.5, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.XY,
        TextSize = 16,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = keybind.component
    })
    
    -- Keybind button
    keybind.button = createInstance("TextButton", {
        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = keybind.value,
        AnchorPoint = Vector2.new(1, 0.5),
        Size = UDim2.new(0, 1, 0, 1),
        Name = "Keybind_Button",
        Position = UDim2.new(0.9150943160057068, 0, 0.5, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.XY,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(23, 23, 23),
        Parent = keybind.component
    })
    
    createInstance("UIPadding", {
        PaddingTop = UDim.new(0, 6),
        PaddingBottom = UDim.new(0, 6),
        PaddingRight = UDim.new(0, 6),
        PaddingLeft = UDim.new(0, 6),
        Parent = keybind.button
    })
    
    createInstance("UICorner", {
        CornerRadius = UDim.new(0, 3),
        Parent = keybind.button
    })
    
    -- Keybind functionality
    keybind.button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            keybind.isListening = true
            keybind.button.Text = "..."
            keybind.button.BackgroundColor3 = Color3.fromRGB(115, 58, 173)
        end
    end)
    
    local keybindConnection
    keybindConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if keybind.isListening and not gameProcessed then
            local keyName = input.KeyCode.Name
            if keyName ~= "Unknown" then
                keybind.value = keyName
                keybind.button.Text = keyName
                keybind.button.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                keybind.isListening = false
                keybind.callback(keyName)
                keybindConnection:Disconnect()
            end
        end
    end)
    
    return keybind
end

-- Section:CreateDropdown method (placeholder - just creates new instance)
function Library:CreateDropdown(config)
    local dropdown = {}
    dropdown.config = config or {}
    dropdown.value = config.Options and config.Options[1] or "Option 1"
    dropdown.callback = config.Callback or function() end
    
    -- Create dropdown component
    dropdown.component = createInstance("Frame", {
        Name = "Dropdown_Component",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.09732360392808914, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 318, 0, 40),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = self.scrollingContainer
    })
    
    -- Dropdown button
    dropdown.button = createInstance("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Name = "Dropdown",
        Position = UDim2.new(0.4874213933944702, 0, 0.5, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 279, 0, 40),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(23, 23, 23),
        Parent = dropdown.component
    })
    
    createInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = dropdown.button
    })
    
    -- Dropdown value
    dropdown.valueLabel = createInstance("TextLabel", {
        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
        TextColor3 = Color3.fromRGB(109, 109, 109),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = dropdown.value,
        Name = "Dropdown_Value",
        Size = UDim2.new(0, 1, 0, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.03831060975790024, 0, 0.32499998807907104, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.XY,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = dropdown.button
    })
    
    -- Dropdown arrow
    local arrow = createInstance("ImageLabel", {
        ImageColor3 = Color3.fromRGB(109, 109, 109),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Image = "rbxassetid://95652893039727",
        BackgroundTransparency = 1,
        Position = UDim2.new(0.8745519518852234, 0, 0.25, 0),
        Size = UDim2.new(0, 20, 0, 20),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = dropdown.button
    })
    
    -- Placeholder functionality - just calls callback
    dropdown.button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dropdown.callback(dropdown.value)
        end
    end)
    
    return dropdown
end

local Toggle_Fill = Instance.new("Frame")
Toggle_Fill.AnchorPoint = Vector2.new(0.5, 0.5)
Toggle_Fill.Name = "Toggle_Fill"
Toggle_Fill.Position = UDim2.new(0.5, 0, 0.5, 0)
Toggle_Fill.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle_Fill.Size = UDim2.new(0, 20, 0, 20)
Toggle_Fill.BorderSizePixel = 0
Toggle_Fill.BackgroundColor3 = Color3.fromRGB(155, 77, 255)
Toggle_Fill.Parent = Toggle

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = Toggle_Fill

local Check_Icon = Instance.new("ImageLabel")
Check_Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
Check_Icon.Name = "Check_Icon"
Check_Icon.AnchorPoint = Vector2.new(0.5, 0.5)
Check_Icon.Image = "rbxassetid://139958444428790"
Check_Icon.BackgroundTransparency = 1
Check_Icon.Position = UDim2.new(0.5, 0, 0.5, 0)

Check_Icon.Size = UDim2.new(0, 13, 0, 15)
Check_Icon.BorderSizePixel = 0
Check_Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Check_Icon.Parent = Toggle_Fill

local TextInput_Component = Instance.new("Frame")
TextInput_Component.Name = "TextInput_Component"
TextInput_Component.BackgroundTransparency = 1
TextInput_Component.Position = UDim2.new(0, 0, 0.09732360392808914, 0)
TextInput_Component.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextInput_Component.Size = UDim2.new(0, 318, 0, 40)
TextInput_Component.BorderSizePixel = 0
TextInput_Component.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextInput_Component.Parent = Left_Container

local Text_Input = Instance.new("TextLabel")
Text_Input.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
Text_Input.TextColor3 = Color3.fromRGB(109, 109, 109)
Text_Input.BorderColor3 = Color3.fromRGB(0, 0, 0)
Text_Input.Text = "Example"
Text_Input.AnchorPoint = Vector2.new(0, 0.5)
Text_Input.Size = UDim2.new(0, 279, 0, 40)
Text_Input.Name = "Text_Input"
Text_Input.TextXAlignment = Enum.TextXAlignment.Left
Text_Input.Position = UDim2.new(0.04492206871509552, 0, 0.5, 0)
Text_Input.BorderSizePixel = 0
Text_Input.TextSize = 14
Text_Input.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
Text_Input.Parent = TextInput_Component

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = Text_Input

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingLeft = UDim.new(0, 12)
UIPadding.Parent = Text_Input

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 10)
UIPadding.Parent = Left_Container

local Keybind_Component = Instance.new("Frame")
Keybind_Component.BackgroundTransparency = 1
Keybind_Component.Name = "Keybind_Component"
Keybind_Component.BorderColor3 = Color3.fromRGB(0, 0, 0)
Keybind_Component.Size = UDim2.new(0, 318, 0, 20)
Keybind_Component.BorderSizePixel = 0
Keybind_Component.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Keybind_Component.Parent = Left_Container

local Toggle_Text = Instance.new("TextLabel")
Toggle_Text.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Toggle_Text.TextColor3 = Color3.fromRGB(52, 52, 52)
Toggle_Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle_Text.Text = "ExampleKeybind"
Toggle_Text.Name = "Toggle_Text"
Toggle_Text.AnchorPoint = Vector2.new(0, 0.5)
Toggle_Text.Size = UDim2.new(0, 1, 0, 1)
Toggle_Text.BackgroundTransparency = 1
Toggle_Text.Position = UDim2.new(0.044025156646966934, 0, 0.5, 0)
Toggle_Text.BorderSizePixel = 0
Toggle_Text.AutomaticSize = Enum.AutomaticSize.XY
Toggle_Text.TextSize = 16
Toggle_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Text.Parent = Keybind_Component

local Keybind_Button = Instance.new("TextButton")
Keybind_Button.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Keybind_Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Keybind_Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
Keybind_Button.Text = "None"
Keybind_Button.AnchorPoint = Vector2.new(1, 0.5)
Keybind_Button.Size = UDim2.new(0, 1, 0, 1)
Keybind_Button.Name = "Keybind_Button"
Keybind_Button.Position = UDim2.new(0.9150943160057068, 0, 0.5, 0)
Keybind_Button.BorderSizePixel = 0
Keybind_Button.AutomaticSize = Enum.AutomaticSize.XY
Keybind_Button.TextSize = 14
Keybind_Button.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
Keybind_Button.Parent = Keybind_Component

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 6)
UIPadding.PaddingBottom = UDim.new(0, 6)
UIPadding.PaddingRight = UDim.new(0, 6)
UIPadding.PaddingLeft = UDim.new(0, 6)
UIPadding.Parent = Keybind_Button

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 3)
UICorner.Parent = Keybind_Button

local Section_Right = Instance.new("Frame")
Section_Right.Size = UDim2.new(0, 318, 0, 411)
Section_Right.Name = "Section_Right"
Section_Right.ClipsDescendants = true
Section_Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
Section_Right.Position = UDim2.new(0.5120617151260376, 0, 0.17085854709148407, 0)
Section_Right.BorderSizePixel = 0
Section_Right.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
Section_Right.Parent = Container

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Section_Right

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingLeft = UDim.new(0, 12)
UIPadding.Parent = Section_Right

local Shadow = Instance.new("Frame")
Shadow.BackgroundTransparency = 0.8999999761581421
Shadow.Name = "Shadow"
Shadow.AnchorPoint = Vector2.new(0, 0)
Shadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
Shadow.Size = UDim2.new(1, 0, 0, 40)
Shadow.Position = UDim2.new(0, -12, 0, 0)
Shadow.BorderSizePixel = 0
Shadow.BackgroundColor3 = Color3.fromRGB(170, 85, 255)
Shadow.Parent = Section_Right

local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = 7
UIGradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 0),
	NumberSequenceKeypoint.new(0.69, 1),
	NumberSequenceKeypoint.new(0.697, 0.981249988079071),
	NumberSequenceKeypoint.new(0.706, 0.949999988079071),
	NumberSequenceKeypoint.new(1, 0.987500011920929)
}
UIGradient.Parent = Shadow

local Section_Name = Instance.new("TextLabel")
Section_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
Section_Name.TextColor3 = Color3.fromRGB(115, 58, 173)
Section_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Section_Name.Text = "ExampleTab"
Section_Name.Name = "Section_Name"
Section_Name.AnchorPoint = Vector2.new(0, 0.5)
Section_Name.Size = UDim2.new(0, 1, 0, 1)
Section_Name.BackgroundTransparency = 1
Section_Name.Position = UDim2.new(0, 12, 0.5, 0)
Section_Name.BorderSizePixel = 0
Section_Name.AutomaticSize = Enum.AutomaticSize.XY
Section_Name.TextSize = 16
Section_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Section_Name.Parent = Shadow

local Right_Container = Instance.new("ScrollingFrame")
Right_Container.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
Right_Container.Active = true
Right_Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
Right_Container.ScrollBarThickness = 0
Right_Container.AnchorPoint = Vector2.new(0.5, 1)
Right_Container.BackgroundTransparency = 1
Right_Container.Position = UDim2.new(0.5, 0, 0.985401451587677, 0)
Right_Container.Name = "Right_Container"
Right_Container.Size = UDim2.new(0, 318, 0, 365)
Right_Container.BorderSizePixel = 0
Right_Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Right_Container.Parent = Section_Right

local Right_UIListLayout = Instance.new("UIListLayout")
Right_UIListLayout.Padding = UDim.new(0, 12)
Right_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
Right_UIListLayout.Parent = Right_Container

local Toggle_Component = Instance.new("Frame")
Toggle_Component.Name = "Toggle_Component"
Toggle_Component.BackgroundTransparency = 1
Toggle_Component.Position = UDim2.new(0, 0, 0.0986301377415657, 0)
Toggle_Component.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle_Component.Size = UDim2.new(0, 318, 0, 20)
Toggle_Component.BorderSizePixel = 0
Toggle_Component.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Component.Parent = Right_Container

local Toggle = Instance.new("Frame")
Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle.AnchorPoint = Vector2.new(0, 0.5)
Toggle.BackgroundTransparency = 1
Toggle.Position = UDim2.new(0, 15, 0.5, 0)
Toggle.Name = "Toggle"
Toggle.Size = UDim2.new(0, 20, 0, 20)
Toggle.BorderSizePixel = 0
Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle.Parent = Toggle_Component

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = Toggle

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(33, 33, 33)
UIStroke.Parent = Toggle

local Toggle_Text = Instance.new("TextLabel")
Toggle_Text.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Toggle_Text.TextColor3 = Color3.fromRGB(52, 52, 52)
Toggle_Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle_Text.Text = "ExampleToggle"
Toggle_Text.Name = "Toggle_Text"
Toggle_Text.Size = UDim2.new(0, 1, 0, 1)
Toggle_Text.BackgroundTransparency = 1
Toggle_Text.Position = UDim2.new(1.8179999589920044, -2, 0.07500000298023224, 0)
Toggle_Text.BorderSizePixel = 0
Toggle_Text.AutomaticSize = Enum.AutomaticSize.XY
Toggle_Text.TextSize = 16
Toggle_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Text.Parent = Toggle

-- Section:CreateColorPicker method (placeholder - just creates new instance)
function Library:CreateColorPicker(config)
    local colorPicker = {}
    colorPicker.config = config or {}
    colorPicker.value = Color3.fromRGB(255, 255, 255)
    colorPicker.callback = config.Callback or function() end
    
    -- Create color picker component
    colorPicker.component = createInstance("Frame", {
        Name = "Colorpicker_Component",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0.5633803009986877, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 318, 0, 30),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = self.scrollingContainer
    })
    
    -- Color picker text
    local colorPickerText = createInstance("TextLabel", {
        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Text = config.ColorPickerText or "Color Picker",
        Name = "Colorpicker_Text",
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 1, 0, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.044025156646966934, 0, 0.5, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.XY,
        TextSize = 16,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Parent = colorPicker.component
    })
    
    -- Color frame
    colorPicker.colorFrame = createInstance("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        Name = "Color_Frame",
        Position = UDim2.new(0.9245283007621765, 0, 0.5, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.new(0, 40, 0, 20),
        BorderSizePixel = 0,
        BackgroundColor3 = colorPicker.value,
        Parent = colorPicker.component
    })
    
    createInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = colorPicker.colorFrame
    })
    
    -- Placeholder functionality - just calls callback
    colorPicker.colorFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            colorPicker.callback(colorPicker.value)
        end
    end)
    
    return colorPicker
end

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library

-- Return the Library
return Library
