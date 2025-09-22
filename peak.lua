local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local libary = {}
local Windows = {}
local CurrentWindow = nil
local CurrentTab = nil
local Sections = {left = {}, right = {}}
local Dragging = false
local DragStart = nil
local DragStartPosition = nil
local libary_footer_text = {}
local libary_bottom_text = {}

local libary_config = {
    ToggleState = {},
    SliderProgress = {},
    TextInputValue = {},
    DropdownSelectedValues = {},
    DropdownValue = {},
    ConfigName = {},
    KeybindValue = {},
    ColorPickerValue = {},
}

-- Utility functions
local function createInstance(className, properties)
    local instance = Instance.new(className)
    for property, value in pairs(properties) do
        instance[property] = value
    end
    return instance
end

local function tweenProperty(instance, property, targetValue, duration, easingStyle)
    local tweenInfo = TweenInfo.new(duration or 0.2, easingStyle or Enum.EasingStyle.Quart)
    local tween = TweenService:Create(instance, tweenInfo, {[property] = targetValue})
    tween:Play()
    return tween
end

-- Window Class
local Window = {}
Window.__index = Window

function Window.new(config)
    local self = setmetatable({}, Window)
    self.config = config or {}
    self.tabs = {}
    self.sections = {}
    self.currentTab = nil
    self.mainFrame = nil
    self.header = nil
    self.footer = nil
    self.page = nil
    self.container = nil
    self.tabContainer = nil
    self.footerContainer = nil
    self.dragging = false
    self.dragStart = nil
    self.dragStartPosition = nil
    
    self:CreateWindow()
    return self
end

function Window:CreateWindow()
    -- Create main frame
    self.mainFrame = createInstance("Frame", {
        Name = "MainFrame",
        Size = UDim2.new(0, 563, 0, 400),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = game.Players.LocalPlayer.PlayerGui
    })
    
    -- Create header
    self.header = createInstance("Frame", {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderSizePixel = 0,
        Parent = self.mainFrame
    })
    
    -- Create library name
    local libName = createInstance("TextLabel", {
        Name = "Libary_Name",
        Size = UDim2.new(0, 1, 0, 1),
        Position = UDim2.new(0, 12, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        Text = self.config.Libary_Name or "Library",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 15,
        Font = Enum.Font.Gotham,
        RichText = true,
        AutomaticSize = Enum.AutomaticSize.XY,
        Parent = self.header
    })
    
    -- Create tab container
    self.tabContainer = createInstance("Frame", {
        Name = "TabContainer",
        Size = UDim2.new(0, 425, 1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Parent = self.header
    })
    
    local tabListLayout = createInstance("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDim.new(0, 18),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = self.tabContainer
    })
    
    local tabPadding = createInstance("UIPadding", {
        PaddingRight = UDim.new(0, 12),
        Parent = self.tabContainer
    })
    
    -- Create page container
    self.page = createInstance("Frame", {
        Name = "Page",
        Size = UDim2.new(1, 0, 0, 360),
        Position = UDim2.new(0, 0, 1, 0),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundTransparency = 1,
        Parent = self.mainFrame
    })
    
    self.container = createInstance("ScrollingFrame", {
        Name = "Container",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Color3.fromRGB(125, 69, 220),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Parent = self.page
    })
    
    local containerListLayout = createInstance("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 16),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = self.container
    })
    
    local containerPadding = createInstance("UIPadding", {
        PaddingTop = UDim.new(0, 12),
        PaddingLeft = UDim.new(0, 12),
        Parent = self.container
    })
    
    -- Create footer
    self.footer = createInstance("Frame", {
        Name = "Footer",
        Size = UDim2.new(1, 0, 0, 28),
        Position = UDim2.new(0, 0, 1, 0),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        BorderSizePixel = 0,
        Parent = self.mainFrame
    })
    
    -- Footer left text
    local footerLeft = createInstance("TextLabel", {
        Name = "FooterLeft",
        Size = UDim2.new(0, 1, 0, 1),
        Position = UDim2.new(0, 12, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1,
        Text = self.config.Footer_Left_Text or "Library",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 15,
        Font = Enum.Font.Gotham,
        RichText = true,
        AutomaticSize = Enum.AutomaticSize.XY,
        Parent = self.footer
    })
    
    -- Footer right container
    self.footerContainer = createInstance("Frame", {
        Name = "FooterContainer",
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY,
        Parent = self.footer
    })
    
    local footerListLayout = createInstance("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDim.new(0, 12),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = self.footerContainer
    })
    
    local footerPadding = createInstance("UIPadding", {
        PaddingTop = UDim.new(0, 6),
        PaddingRight = UDim.new(0, 12),
        Parent = self.footerContainer
    })
    
    -- Add footer text elements
    if self.config.libary_bottom_text then
        for _, textConfig in pairs(self.config.libary_bottom_text) do
            local footerText = createInstance("TextLabel", {
                Size = UDim2.new(0, 1, 0, 1),
                BackgroundTransparency = 1,
                Text = textConfig,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 15,
                Font = Enum.Font.Gotham,
                RichText = true,
                AutomaticSize = Enum.AutomaticSize.XY,
                Parent = self.footerContainer
            })
        end
    end
    
    -- Make window draggable
    self:SetupDragging()
    
    -- Setup keybind
    if self.config.interface_keybind then
        self:SetupKeybind(self.config.interface_keybind)
    end
end

function Window:SetupDragging()
    local header = self.header
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.dragging = true
            self.dragStart = input.Position
            self.dragStartPosition = self.mainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if self.dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - self.dragStart
            self.mainFrame.Position = self.dragStartPosition + UDim2.new(0, delta.X, 0, delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.dragging = false
        end
    end)
end

function Window:SetupKeybind(keybind)
    local keyCode = Enum.KeyCode[keybind] or Enum.KeyCode.Insert
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == keyCode then
            self.mainFrame.Visible = not self.mainFrame.Visible
        end
    end)
end

-- Tab Class
local Tab = {}
Tab.__index = Tab

function Tab.new(window, config)
    local self = setmetatable({}, Tab)
    self.window = window
    self.config = config or {}
    self.sections = {}
    self.frame = nil
    self.button = nil
    self.isActive = false
    
    self:CreateTab()
    return self
end

function Tab:CreateTab()
    -- Create tab button
    self.button = createInstance("Frame", {
        Name = "Tab",
        Size = UDim2.new(0, 47, 1, 0),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.X,
        Parent = self.window.tabContainer
    })
    
    -- Tab underline
    local inline = createInstance("Frame", {
        Name = "Inline",
        Size = UDim2.new(1, 1, 0, 4),
        Position = UDim2.new(0, 0, 1, 0),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Color3.fromRGB(125, 69, 220),
        BorderSizePixel = 0,
        Parent = self.button
    })
    
    local gradient = createInstance("UIGradient", {
        Rotation = 90,
        Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.436, 0.6625000238418579),
            NumberSequenceKeypoint.new(1, 0)
        },
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 69, 220)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 69, 220))
        },
        Parent = inline
    })
    
    -- Tab text
    local tabName = createInstance("TextLabel", {
        Name = "Tab_Name",
        Size = UDim2.new(0, 1, 0, 1),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Text = self.config.TabText or "Tab",
        TextColor3 = Color3.fromRGB(169, 169, 169),
        TextSize = 15,
        Font = Enum.Font.Gotham,
        RichText = true,
        AutomaticSize = Enum.AutomaticSize.XY,
        Parent = self.button
    })
    
    -- Tab click handler
    self.button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self:SetActive(true)
        end
    end)
    
    -- Add to window tabs
    table.insert(self.window.tabs, self)
    
    -- Set as active if it's the first tab
    if #self.window.tabs == 1 then
        self:SetActive(true)
    end
end

function Tab:SetActive(active)
    if self.isActive == active then return end
    
    self.isActive = active
    
    if active then
        -- Deactivate other tabs
        for _, tab in pairs(self.window.tabs) do
            if tab ~= self then
                tab:SetActive(false)
            end
        end
        
        -- Update tab appearance
        local tabName = self.button:FindFirstChild("Tab_Name")
        if tabName then
            tabName.TextColor3 = Color3.fromRGB(125, 69, 220)
        end
        
        -- Show/hide content
        if self.frame then
            self.frame.Visible = true
        end
        
        self.window.currentTab = self
    else
        -- Update tab appearance
        local tabName = self.button:FindFirstChild("Tab_Name")
        if tabName then
            tabName.TextColor3 = Color3.fromRGB(169, 169, 169)
        end
        
        -- Hide content
        if self.frame then
            self.frame.Visible = false
        end
    end
end

-- Section Class
local Section = {}
Section.__index = Section

function Section.new(parent, config)
    local self = setmetatable({}, Section)
    self.parent = parent
    self.config = config or {}
    self.controls = {}
    self.frame = nil
    self.header = nil
    self.holder = nil
    
    self:CreateSection()
    return self
end

function Section:CreateSection()
    -- Create section frame
    self.frame = createInstance("Frame", {
        Name = "Section_" .. (self.config.position or "left"),
        Size = UDim2.new(0, 260, 0, 60),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = self.parent.container
    })
    
    -- Create section header
    self.header = createInstance("Frame", {
        Name = "Header",
        Size = UDim2.new(1, 0, 0, 32),
        Position = UDim2.new(0.5, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderSizePixel = 0,
        Parent = self.frame
    })
    
    -- Header underline
    local inline = createInstance("Frame", {
        Name = "Inline",
        Size = UDim2.new(1, 1, 0, 4),
        Position = UDim2.new(0, 0, 1, 0),
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Color3.fromRGB(125, 69, 220),
        BorderSizePixel = 0,
        Parent = self.header
    })
    
    local gradient = createInstance("UIGradient", {
        Rotation = 90,
        Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.436, 0.6625000238418579),
            NumberSequenceKeypoint.new(1, 0)
        },
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 69, 220)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 69, 220))
        },
        Parent = inline
    })
    
    -- Section name
    local sectionName = createInstance("TextLabel", {
        Name = "Section_Name",
        Size = UDim2.new(0, 1, 0, 1),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Text = self.config.SectionText or "Section",
        TextColor3 = Color3.fromRGB(125, 69, 220),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        RichText = true,
        AutomaticSize = Enum.AutomaticSize.XY,
        Parent = self.header
    })
    
    -- Create holder for controls
    self.holder = createInstance("Frame", {
        Name = "Holder",
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0.5, 0, 1, 0),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = self.frame
    })
    
    local holderListLayout = createInstance("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = self.holder
    })
    
    local holderPadding = createInstance("UIPadding", {
        PaddingTop = UDim.new(0, 4),
        PaddingBottom = UDim.new(0, 35),
        Parent = self.holder
    })
    
    -- Add stroke
    local stroke = createInstance("UIStroke", {
        Color = Color3.fromRGB(35, 35, 35),
        Parent = self.frame
    })
end

-- UI Control Methods for Section
function Section:CreateToggle(config)
    local toggle = {
        config = config or {},
        value = false,
        frame = nil,
        button = nil,
        indicator = nil,
        label = nil
    }
    
    -- Create toggle frame
    toggle.frame = createInstance("Frame", {
        Name = "Toggle",
        Size = UDim2.new(1, -20, 0, 30),
        BackgroundTransparency = 1,
        Parent = self.holder
    })
    
    -- Toggle label
    toggle.label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, -50, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = toggle.config.ToggleText or "Toggle",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = toggle.frame
    })
    
    -- Toggle button
    toggle.button = createInstance("Frame", {
        Name = "Button",
        Size = UDim2.new(0, 40, 0, 20),
        Position = UDim2.new(1, -40, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        BorderSizePixel = 0,
        Parent = toggle.frame
    })
    
    local buttonCorner = createInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = toggle.button
    })
    
    -- Toggle indicator
    toggle.indicator = createInstance("Frame", {
        Name = "Indicator",
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 2, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(125, 69, 220),
        BorderSizePixel = 0,
        Parent = toggle.button
    })
    
    local indicatorCorner = createInstance("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = toggle.indicator
    })
    
    -- Toggle click handler
    toggle.button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggle.value = not toggle.value
            toggle:UpdateVisuals()
            if toggle.config.Callback then
                toggle.config.Callback(toggle.value)
            end
        end
    end)
    
    function toggle:UpdateVisuals()
        if self.value then
            tweenProperty(self.indicator, "Position", UDim2.new(1, -18, 0.5, 0), 0.2)
            tweenProperty(self.button, "BackgroundColor3", Color3.fromRGB(125, 69, 220), 0.2)
        else
            tweenProperty(self.indicator, "Position", UDim2.new(0, 2, 0.5, 0), 0.2)
            tweenProperty(self.button, "BackgroundColor3", Color3.fromRGB(35, 35, 35), 0.2)
        end
    end
    
    table.insert(self.controls, toggle)
    return toggle
end

function Section:CreateSlider(config)
    local slider = {
        config = config or {},
        value = config.Value or config.Min or 0,
        frame = nil,
        label = nil,
        valueLabel = nil,
        track = nil,
        fill = nil,
        handle = nil,
        dragging = false
    }
    
    -- Create slider frame
    slider.frame = createInstance("Frame", {
        Name = "Slider",
        Size = UDim2.new(1, -20, 0, 50),
        BackgroundTransparency = 1,
        Parent = self.holder
    })
    
    -- Slider label
    slider.label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = slider.config.SliderText or "Slider",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = slider.frame
    })
    
    -- Value label
    slider.valueLabel = createInstance("TextLabel", {
        Name = "ValueLabel",
        Size = UDim2.new(0, 50, 0, 20),
        Position = UDim2.new(1, -50, 0, 0),
        BackgroundTransparency = 1,
        Text = tostring(slider.value),
        TextColor3 = Color3.fromRGB(125, 69, 220),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = slider.frame
    })
    
    -- Slider track
    slider.track = createInstance("Frame", {
        Name = "Track",
        Size = UDim2.new(1, 0, 0, 6),
        Position = UDim2.new(0, 0, 1, -20),
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        BorderSizePixel = 0,
        Parent = slider.frame
    })
    
    local trackCorner = createInstance("UICorner", {
        CornerRadius = UDim.new(0, 3),
        Parent = slider.track
    })
    
    -- Slider fill
    slider.fill = createInstance("Frame", {
        Name = "Fill",
        Size = UDim2.new(0, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(125, 69, 220),
        BorderSizePixel = 0,
        Parent = slider.track
    })
    
    local fillCorner = createInstance("UICorner", {
        CornerRadius = UDim.new(0, 3),
        Parent = slider.fill
    })
    
    -- Slider handle
    slider.handle = createInstance("Frame", {
        Name = "Handle",
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0,
        Parent = slider.track
    })
    
    local handleCorner = createInstance("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = slider.handle
    })
    
    function slider:UpdateVisuals()
        local min = self.config.Min or 0
        local max = self.config.Max or 100
        local percentage = (self.value - min) / (max - min)
        
        self.fill.Size = UDim2.new(percentage, 0, 1, 0)
        self.handle.Position = UDim2.new(percentage, 0, 0.5, 0)
        self.valueLabel.Text = tostring(math.floor(self.value))
    end
    
    function slider:SetValue(value)
        local min = self.config.Min or 0
        local max = self.config.Max or 100
        self.value = math.clamp(value, min, max)
        self:UpdateVisuals()
    end
    
    -- Slider interaction
    slider.track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            slider.dragging = true
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if slider.dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local trackSize = slider.track.AbsoluteSize.X
            local trackPosition = slider.track.AbsolutePosition.X
            local mouseX = input.Position.X
            local percentage = math.clamp((mouseX - trackPosition) / trackSize, 0, 1)
            
            local min = slider.config.Min or 0
            local max = slider.config.Max or 100
            slider.value = min + (percentage * (max - min))
            slider:UpdateVisuals()
            
            if slider.config.Callback then
                slider.config.Callback(slider.value)
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            slider.dragging = false
        end
    end)
    
    slider:UpdateVisuals()
    table.insert(self.controls, slider)
    return slider
end

function Section:CreateDropdown(config)
    local dropdown = {
        config = config or {},
        value = config.Default or (config.Options and config.Options[1]) or "Option",
        frame = nil,
        label = nil,
        button = nil,
        valueLabel = nil,
        list = nil,
        isOpen = false,
        options = config.Options or {"Option 1", "Option 2", "Option 3"}
    }
    
    -- Create dropdown frame
    dropdown.frame = createInstance("Frame", {
        Name = "Dropdown",
        Size = UDim2.new(1, -20, 0, 30),
        BackgroundTransparency = 1,
        Parent = self.holder
    })
    
    -- Dropdown label
    dropdown.label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = dropdown.config.DropdownText or "Dropdown",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = dropdown.frame
    })
    
    -- Dropdown button
    dropdown.button = createInstance("Frame", {
        Name = "Button",
        Size = UDim2.new(1, 0, 0, 25),
        Position = UDim2.new(0, 0, 1, -25),
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        BorderSizePixel = 0,
        Parent = dropdown.frame
    })
    
    local buttonCorner = createInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = dropdown.button
    })
    
    -- Value label
    dropdown.valueLabel = createInstance("TextLabel", {
        Name = "ValueLabel",
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = dropdown.value,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = dropdown.button
    })
    
    -- Arrow
    local arrow = createInstance("TextLabel", {
        Name = "Arrow",
        Size = UDim2.new(0, 20, 1, 0),
        Position = UDim2.new(1, -20, 0, 0),
        BackgroundTransparency = 1,
        Text = "▼",
        TextColor3 = Color3.fromRGB(125, 69, 220),
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = dropdown.button
    })
    
    -- Dropdown list
    dropdown.list = createInstance("Frame", {
        Name = "List",
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderSizePixel = 0,
        Visible = false,
        Parent = dropdown.frame
    })
    
    local listCorner = createInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = dropdown.list
    })
    
    local listLayout = createInstance("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = dropdown.list
    })
    
    local listPadding = createInstance("UIPadding", {
        PaddingTop = UDim.new(0, 4),
        PaddingBottom = UDim.new(0, 4),
        Parent = dropdown.list
    })
    
    function dropdown:CreateOptions()
        for i, option in pairs(self.options) do
            local optionButton = createInstance("Frame", {
                Name = "Option_" .. i,
                Size = UDim2.new(1, -8, 0, 20),
                BackgroundTransparency = 1,
                Parent = self.list
            })
            
            local optionLabel = createInstance("TextLabel", {
                Name = "Label",
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0, 8, 0, 0),
                BackgroundTransparency = 1,
                Text = option,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = optionButton
            })
            
            optionButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    self.value = option
                    self.valueLabel.Text = option
                    self:Toggle()
                    if self.config.Callback then
                        self.config.Callback(option)
                    end
                end
            end)
        end
    end
    
    function dropdown:Toggle()
        self.isOpen = not self.isOpen
        self.list.Visible = self.isOpen
        
        if self.isOpen then
            self.list.Size = UDim2.new(1, 0, 0, #self.options * 20 + 8)
        else
            self.list.Size = UDim2.new(1, 0, 0, 0)
        end
    end
    
    -- Button click handler
    dropdown.button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dropdown:Toggle()
        end
    end)
    
    dropdown:CreateOptions()
    table.insert(self.controls, dropdown)
    return dropdown
end

function Section:CreateLabel(config)
    local label = {
        config = config or {},
        frame = nil,
        label = nil
    }
    
    -- Create label frame
    label.frame = createInstance("Frame", {
        Name = "Label",
        Size = UDim2.new(1, -20, 0, 20),
        BackgroundTransparency = 1,
        Parent = self.holder
    })
    
    -- Label text
    label.label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = label.config.LabelText or "Label",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = label.frame
    })
    
    table.insert(self.controls, label)
    return label
end

function Section:CreateButton(config)
    local button = {
        config = config or {},
        frame = nil,
        button = nil,
        label = nil
    }
    
    -- Create button frame
    button.frame = createInstance("Frame", {
        Name = "Button",
        Size = UDim2.new(1, -20, 0, 30),
        BackgroundTransparency = 1,
        Parent = self.holder
    })
    
    -- Button
    button.button = createInstance("Frame", {
        Name = "Button",
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(125, 69, 220),
        BorderSizePixel = 0,
        Parent = button.frame
    })
    
    local buttonCorner = createInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = button.button
    })
    
    -- Button label
    button.label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = button.config.ButtonText or "Button",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Center,
        Parent = button.button
    })
    
    -- Button click handler
    button.button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if button.config.Callback then
                button.config.Callback()
            end
        end
    end)
    
    table.insert(self.controls, button)
    return button
end

function Section:CreateTextInput(config)
    local textInput = {
        config = config or {},
        value = config.Default or "",
        frame = nil,
        label = nil,
        input = nil,
        textBox = nil
    }
    
    -- Create text input frame
    textInput.frame = createInstance("Frame", {
        Name = "TextInput",
        Size = UDim2.new(1, -20, 0, 50),
        BackgroundTransparency = 1,
        Parent = self.holder
    })
    
    -- Text input label
    textInput.label = createInstance("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = textInput.config.TextInputText or "Text Input",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = textInput.frame
    })
    
    -- Text input box
    textInput.input = createInstance("Frame", {
        Name = "Input",
        Size = UDim2.new(1, 0, 0, 25),
        Position = UDim2.new(0, 0, 1, -25),
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        BorderSizePixel = 0,
        Parent = textInput.frame
    })
    
    local inputCorner = createInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = textInput.input
    })
    
    -- Text box
    textInput.textBox = createInstance("TextBox", {
        Name = "TextBox",
        Size = UDim2.new(1, -10, 1, 0),
        Position = UDim2.new(0, 5, 0, 0),
        BackgroundTransparency = 1,
        Text = textInput.value,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        PlaceholderText = textInput.config.Placeholder or "Enter text...",
        PlaceholderColor3 = Color3.fromRGB(169, 169, 169),
        Parent = textInput.input
    })
    
    -- Text changed handler
    textInput.textBox:GetPropertyChangedSignal("Text"):Connect(function()
        textInput.value = textInput.textBox.Text
        if textInput.config.Callback then
            textInput.config.Callback(textInput.value)
        end
    end)
    
    table.insert(self.controls, textInput)
    return textInput
end

-- Window methods
function Window:CreateTab(config)
    local tab = Tab.new(self, config)
    return tab
end

function Window:CreateSection(config)
    local section = Section.new(self, config)
    return section
end

-- Tab methods
function Tab:CreateSection(config)
    local section = Section.new(self, config)
    return section
end

-- Main library functions
function libary:CreateWindow(config)
    local window = Window.new(config)
    table.insert(Windows, window)
    return window
end

function libary:CreateNewText(text)
    return text
end

-- Set accent color function
function libary:SetAccentColor(color)
    -- This would update the accent color throughout the library
    -- Implementation would depend on how you want to handle color theming
end

-- Notification system
function libary:CreateNotification(config)
    local notification = {
        icon = config.Icon or "default",
        title = config.NotiTitle or "Notification",
        description = config.NotiDescription or "This is a notification.",
        time = config.Time or 3
    }
    
    -- Create notification UI here
    -- This is a placeholder implementation
    print("Notification:", notification.title, "-", notification.description)
end

-- Return the library
return libary
