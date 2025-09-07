-- STARHUB UI Library
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Library = {}
local Windows = {}
local CurrentWindow = nil
local CurrentTab = nil
local Sections = {left = {}, right = {}}
local SectionCount = {left = 0, right = 0}
local ActiveKeybinds = {}
local Dragging = false
local DragStart = nil
local DragStartPosition = nil
local GlobalTabInlineIndicator = nil

-- Create the main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Name = "MainFrame"
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.Size = UDim2.new(0, 720, 0, 550)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = MainFrame

local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Position = UDim2.new(0.02857903391122818, 0, 0.056512895971536636, 0)
Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
Container.Size = UDim2.new(0, 678, 0, 505)
Container.BorderSizePixel = 0
Container.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
Container.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Container

local Top_Bar = Instance.new("Frame")
Top_Bar.Name = "Top_Bar"
Top_Bar.Position = UDim2.new(0.04027777910232544, 0, 0.07454545795917511, 0)
Top_Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
Top_Bar.Size = UDim2.new(0, 660, 0, 65)
Top_Bar.BorderSizePixel = 0
Top_Bar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Top_Bar.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Top_Bar

local Libary_Name = Instance.new("TextLabel")
Libary_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
Libary_Name.TextColor3 = Color3.fromRGB(255, 255, 255)
Libary_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Libary_Name.Text = "STARHUB"
Libary_Name.Name = "Libary_Name"
Libary_Name.AnchorPoint = Vector2.new(0, 0.5)
Libary_Name.Size = UDim2.new(0, 1, 0, 1)
Libary_Name.BackgroundTransparency = 1
Libary_Name.Position = UDim2.new(0.03999999910593033, 11, 0.3919999897480011, 0)
Libary_Name.BorderSizePixel = 0
Libary_Name.AutomaticSize = Enum.AutomaticSize.XY
Libary_Name.TextSize = 21
Libary_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Libary_Name.Parent = Top_Bar

local Libary_Icon = Instance.new("ImageLabel")
Libary_Icon.ImageColor3 = Color3.fromRGB(170, 85, 255)
Libary_Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
Libary_Icon.Name = "Libary_Icon"
Libary_Icon.Image = "rbxassetid://132964100967987"
Libary_Icon.BackgroundTransparency = 1
Libary_Icon.Position = UDim2.new(-0.2936060428619385, 0, 0, 0)

Libary_Icon.Size = UDim2.new(0, 20, 0, 20)
Libary_Icon.BorderSizePixel = 0
Libary_Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Libary_Icon.Parent = Libary_Name

local Build_Date = Instance.new("TextLabel")
Build_Date.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
Build_Date.TextColor3 = Color3.fromRGB(64, 64, 63)
Build_Date.BorderColor3 = Color3.fromRGB(0, 0, 0)
Build_Date.Text = "Build date: 4 Febuary"
Build_Date.Name = "Build_Date"
Build_Date.AnchorPoint = Vector2.new(0, 0.5)
Build_Date.Size = UDim2.new(0, 1, 0, 1)
Build_Date.BackgroundTransparency = 1
Build_Date.Position = UDim2.new(0.0020000000949949026, 11, 0.6650000214576721, 0)
Build_Date.BorderSizePixel = 0
Build_Date.AutomaticSize = Enum.AutomaticSize.XY
Build_Date.TextSize = 14
Build_Date.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Build_Date.Parent = Top_Bar


local Header = Instance.new("Frame")
Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
Header.AnchorPoint = Vector2.new(1, 0.5)
Header.BackgroundTransparency = 1
Header.Position = UDim2.new(1, 0, 0.5, 0)
Header.Name = "Header"
Header.Size = UDim2.new(0, 508, 0, 65)
Header.BorderSizePixel = 0
Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Header.Parent = Top_Bar

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout.Padding = UDim.new(0, 2)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Header

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 10)
UIPadding.PaddingRight = UDim.new(0, 20)
UIPadding.Parent = Header

-- Create global tab inline indicator
GlobalTabInlineIndicator = Instance.new("Frame")
GlobalTabInlineIndicator.AnchorPoint = Vector2.new(0.5, 1)
GlobalTabInlineIndicator.Name = "Inline"
GlobalTabInlineIndicator.Position = UDim2.new(0.5, 0, 1, 0)
GlobalTabInlineIndicator.BorderColor3 = Color3.fromRGB(0, 0, 0)
GlobalTabInlineIndicator.Size = UDim2.new(0, 52, 0, 2)
GlobalTabInlineIndicator.BorderSizePixel = 0
GlobalTabInlineIndicator.BackgroundColor3 = Color3.fromRGB(115, 58, 173)
GlobalTabInlineIndicator.Visible = false
GlobalTabInlineIndicator.Parent = Header

local inlineCorner = Instance.new("UICorner")
inlineCorner.CornerRadius = UDim.new(0, 30)
inlineCorner.Parent = GlobalTabInlineIndicator


local UIScale = Instance.new("UIScale")
UIScale.Parent = MainFrame

local Current_Tab_Icon = Instance.new("ImageLabel")
Current_Tab_Icon.ImageColor3 = Color3.fromRGB(58, 58, 58)
Current_Tab_Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
Current_Tab_Icon.Name = "Current_Tab_Icon"
Current_Tab_Icon.Image = "rbxassetid://74403797129667"
Current_Tab_Icon.BackgroundTransparency = 1
Current_Tab_Icon.Position = UDim2.new(0.031999967992305756, 0, 0.01890907995402813, 0)

Current_Tab_Icon.Size = UDim2.new(0, 25, 0, 20)
Current_Tab_Icon.BorderSizePixel = 0
Current_Tab_Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Current_Tab_Icon.Parent = MainFrame

local Current_Tab_Value = Instance.new("TextLabel")
Current_Tab_Value.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
Current_Tab_Value.TextColor3 = Color3.fromRGB(58, 58, 58)
Current_Tab_Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
Current_Tab_Value.Text = "main"
Current_Tab_Value.Name = "Current_Tab_Value"
Current_Tab_Value.AnchorPoint = Vector2.new(0, 0.5)
Current_Tab_Value.Size = UDim2.new(0, 1, 0, 1)
Current_Tab_Value.BackgroundTransparency = 1
Current_Tab_Value.Position = UDim2.new(0.0555555559694767, 11, 0.03590909019112587, 0)
Current_Tab_Value.BorderSizePixel = 0
Current_Tab_Value.AutomaticSize = Enum.AutomaticSize.XY
Current_Tab_Value.TextSize = 14
Current_Tab_Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Current_Tab_Value.Parent = MainFrame

-- Initial opening animation
ScreenGui.Enabled = true
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

local initialOpenTween = createTween(MainFrame, {
    Size = UDim2.new(0, 720, 0, 550),
    Position = UDim2.new(0.5, 0, 0.5, 0)
}, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
initialOpenTween:Play()

-- Animation Functions
local function createTween(object, properties, duration, easingStyle, easingDirection)
    return TweenService:Create(object, TweenInfo.new(duration, easingStyle or Enum.EasingStyle.Quart, easingDirection or Enum.EasingDirection.Out), properties)
end

-- Draggable Functionality
local function makeDraggable(frame)
    local dragToggle = nil
    local dragSpeed = 0.25
    local dragStart = nil
    local startPos = nil
    
    local function updateInput(input)
        local delta = input.Position - dragStart
        local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        local tween = createTween(frame, {Position = position}, 0.1)
        tween:Play()
    end
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragToggle = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragToggle then
            updateInput(input)
        end
    end)
end

-- Make main frame draggable
makeDraggable(MainFrame)

-- Library Methods
function Library:CreateWindow(config)
    local window = {
        config = config or {},
        tabs = {},
        currentTab = nil,
        sections = {left = {}, right = {}}
    }
    
    -- Update library name and icon if provided
    if config.library_config and config.library_config.Cheat_Name then
        Libary_Name.Text = config.library_config.Cheat_Name
    end
    
    if config.library_config and config.library_config.Cheat_Icon then
        Libary_Icon.Image = config.library_config.Cheat_Icon
    end
    
    -- Set up UI toggle keybind with smooth animations
    if config.library_config and config.library_config.interface_keybind then
        local keybind = config.library_config.interface_keybind
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode[keybind] then
                if ScreenGui.Enabled then
                    -- Close UI with smooth animation
                    local closeTween = createTween(MainFrame, {
                        Size = UDim2.new(0, 0, 0, 0),
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                    closeTween:Play()
                    
                    closeTween.Completed:Connect(function()
                        ScreenGui.Enabled = false
                        -- Reset size for next open
                        MainFrame.Size = UDim2.new(0, 720, 0, 550)
                    end)
                else
                    -- Open UI with smooth animation
                    ScreenGui.Enabled = true
                    MainFrame.Size = UDim2.new(0, 0, 0, 0)
                    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
                    
                    local openTween = createTween(MainFrame, {
                        Size = UDim2.new(0, 720, 0, 550),
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    }, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                    openTween:Play()
                end
            end
        end)
    else
        -- Default Insert key
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Insert then
                if ScreenGui.Enabled then
                    -- Close UI with smooth animation
                    local closeTween = createTween(MainFrame, {
                        Size = UDim2.new(0, 0, 0, 0),
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                    closeTween:Play()
                    
                    closeTween.Completed:Connect(function()
                        ScreenGui.Enabled = false
                        -- Reset size for next open
                        MainFrame.Size = UDim2.new(0, 720, 0, 550)
                    end)
                else
                    -- Open UI with smooth animation
                    ScreenGui.Enabled = true
                    MainFrame.Size = UDim2.new(0, 0, 0, 0)
                    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
                    
                    local openTween = createTween(MainFrame, {
                        Size = UDim2.new(0, 720, 0, 550),
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    }, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                    openTween:Play()
                end
            end
        end)
    end
    
    -- Add methods to window object
    function window:CreateTab(config)
        return Library:CreateTab(config)
    end
    
    function window:CreateSection(config)
        return Library:CreateSection(config)
    end
    
    function window:CreateToggle(config)
        return Library:CreateToggle(config)
    end
    
    function window:CreateSlider(config)
        return Library:CreateSlider(config)
    end
    
    function window:CreateTextInput(config)
        return Library:CreateTextInput(config)
    end
    
    function window:CreateKeybind(config)
        return Library:CreateKeybind(config)
    end
    
    table.insert(Windows, window)
    CurrentWindow = window
    
    return window
end

function Library:CreateTab(config)
    if not CurrentWindow then
        error("No window created. Call CreateWindow first.")
        return
    end
    
    local tab = {
        icon = config.icon or "rbxassetid://133833791023200",
        text = config.TabText or "Tab",
        sections = {left = {}, right = {}},
        components = {},
        tabFrame = nil
    }
    
    -- Create tab button
    local tabFrame = Instance.new("Frame")
    tabFrame.Name = "Tab_" .. config.TabText
    tabFrame.Size = UDim2.new(0, 95, 0, 42)
    tabFrame.BackgroundTransparency = 1 -- Start inactive (no background)
    tabFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    tabFrame.BorderSizePixel = 0
    tabFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    tabFrame.Parent = Header
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 4)
    tabCorner.Parent = tabFrame
    
    local tabIcon = Instance.new("ImageLabel")
    tabIcon.ImageColor3 = Color3.fromRGB(58, 58, 58) -- Start inactive (gray)
    tabIcon.ScaleType = Enum.ScaleType.Fit
    tabIcon.Image = config.icon or "rbxassetid://133833791023200"
    tabIcon.BackgroundTransparency = 1
    tabIcon.Size = UDim2.new(0, 20, 0, 20)
    tabIcon.Position = UDim2.new(0.25789472460746765, 0, 0.5, 0)
    tabIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    tabIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    tabIcon.Name = "Tab_Icon"
    tabIcon.BorderSizePixel = 0
    tabIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabIcon.Parent = tabFrame
    
    local tabName = Instance.new("TextLabel")
    tabName.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
    tabName.TextColor3 = Color3.fromRGB(58, 58, 58) -- Start inactive (gray)
    tabName.Text = config.TabText or "Tab"
    tabName.BackgroundTransparency = 1
    tabName.Size = UDim2.new(0, 1, 0, 1)
    tabName.Position = UDim2.new(2.0999999046325684, 0, 0.4749999940395355, 0)
    tabName.AnchorPoint = Vector2.new(0.5, 0.5)
    tabName.AutomaticSize = Enum.AutomaticSize.XY
    tabName.TextSize = 18
    tabName.BorderColor3 = Color3.fromRGB(0, 0, 0)
    tabName.Name = "Tab_Name"
    tabName.BorderSizePixel = 0
    tabName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabName.Parent = tabIcon
    
    -- Tab click functionality
    local tabButton = Instance.new("TextButton")
    tabButton.BackgroundTransparency = 1
    tabButton.Size = UDim2.new(1, 0, 1, 0)
    tabButton.Text = "" -- Remove default 'Button' text
    tabButton.Parent = tabFrame
    
    tabButton.MouseButton1Click:Connect(function()
        -- Switch to this tab
        Library:SwitchTab(tab)
    end)
    
    -- Store tab frame reference
    tab.tabFrame = tabFrame
    
    
    -- Set as current tab if it's the first one
    if #CurrentWindow.tabs == 0 then
        Library:SwitchTab(tab)
    end
    
    -- Add methods to tab object
    function tab:CreateSection(config)
        return Library:CreateSection(config)
    end
    
    function tab:CreateToggle(config)
        return Library:CreateToggle(config)
    end
    
    function tab:CreateSlider(config)
        return Library:CreateSlider(config)
    end
    
    function tab:CreateTextInput(config)
        return Library:CreateTextInput(config)
    end
    
    function tab:CreateKeybind(config)
        return Library:CreateKeybind(config)
    end
    
    table.insert(CurrentWindow.tabs, tab)
    return tab
end

function Library:SwitchTab(tab)
    if CurrentTab then
        -- Hide current tab sections with smooth fade
        for _, section in pairs(CurrentTab.sections.left) do
            if section.frame then
                local fadeOut = createTween(section.frame, {
                    BackgroundTransparency = 1
                }, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
                fadeOut:Play()
                fadeOut.Completed:Connect(function()
                    section.frame.Visible = false
                end)
            end
        end
        for _, section in pairs(CurrentTab.sections.right) do
            if section.frame then
                local fadeOut = createTween(section.frame, {
                    BackgroundTransparency = 1
                }, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
                fadeOut:Play()
                fadeOut.Completed:Connect(function()
                    section.frame.Visible = false
                end)
            end
        end
        
        -- Animate current tab to inactive with clean transition
        if CurrentTab.tabFrame then
            -- Smooth background fade out
            local bgTween = createTween(CurrentTab.tabFrame, {
                BackgroundTransparency = 1
            }, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            bgTween:Play()
            
            local icon = CurrentTab.tabFrame:FindFirstChild("Tab_Icon")
            local text = icon and icon:FindFirstChild("Tab_Name")
            if icon and text then
                -- Smooth color transition to gray
                local iconTween = createTween(icon, {
                    ImageColor3 = Color3.fromRGB(58, 58, 58)
                }, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                iconTween:Play()
                
                local textTween = createTween(text, {
                    TextColor3 = Color3.fromRGB(58, 58, 58)
                }, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                textTween:Play()
            end
        end
        
        -- Hide inline indicator with unique slide effect
        if CurrentTab.tabFrame then
            local currentInline = CurrentTab.tabFrame:FindFirstChild("Inline")
            if currentInline then
                local slideOut = createTween(currentInline, {
                    Position = UDim2.new(0.5, 0, 1, -10), -- Slide down and fade
                    Size = UDim2.new(0, 0, 0, 2)
                }, 0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
                slideOut:Play()
                
                slideOut.Completed:Connect(function()
                    currentInline.Visible = false
                end)
            end
        end
    end
    
    CurrentTab = tab
    
    -- Show new tab sections with elegant fade in
    for _, section in pairs(tab.sections.left) do
        if section.frame then
            section.frame.Visible = true
            section.frame.BackgroundTransparency = 1
            local sectionTween = createTween(section.frame, {
                BackgroundTransparency = 0
            }, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            sectionTween:Play()
        end
    end
    for _, section in pairs(tab.sections.right) do
        if section.frame then
            section.frame.Visible = true
            section.frame.BackgroundTransparency = 1
            local sectionTween = createTween(section.frame, {
                BackgroundTransparency = 0
            }, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            sectionTween:Play()
        end
    end
    
    -- Animate new tab to active with unique effects
    if tab.tabFrame then
        -- Start with clean state
        tab.tabFrame.BackgroundTransparency = 1
        tab.tabFrame.Size = UDim2.new(0, 95, 0, 42)
        
        -- Smooth background fade in
        local bgTween = createTween(tab.tabFrame, {
            BackgroundTransparency = 0
        }, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        bgTween:Play()
        
        local icon = tab.tabFrame:FindFirstChild("Tab_Icon")
        local text = icon and icon:FindFirstChild("Tab_Name")
        if icon and text then
            -- Start with gray and animate to purple
            icon.ImageColor3 = Color3.fromRGB(58, 58, 58)
            text.TextColor3 = Color3.fromRGB(58, 58, 58)
            
            -- Color transition with slight delay
            local iconTween = createTween(icon, {
                ImageColor3 = Color3.fromRGB(115, 58, 173)
            }, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            iconTween:Play()
            
            local textTween = createTween(text, {
                TextColor3 = Color3.fromRGB(115, 58, 173)
            }, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            textTween:Play()
        end
    end
    
    -- Create and animate inline indicator with unique effect
    if tab.tabFrame then
        -- Create inline indicator for this specific tab
        local inlineIndicator = tab.tabFrame:FindFirstChild("Inline")
        if not inlineIndicator then
            inlineIndicator = Instance.new("Frame")
            inlineIndicator.AnchorPoint = Vector2.new(0.5, 1)
            inlineIndicator.Name = "Inline"
            inlineIndicator.BorderColor3 = Color3.fromRGB(0, 0, 0)
            inlineIndicator.Size = UDim2.new(0, 52, 0, 2)
            inlineIndicator.BorderSizePixel = 0
            inlineIndicator.BackgroundColor3 = Color3.fromRGB(115, 58, 173)
            inlineIndicator.Parent = tab.tabFrame
            
            local inlineCorner = Instance.new("UICorner")
            inlineCorner.CornerRadius = UDim.new(0, 30)
            inlineCorner.Parent = inlineIndicator
        end
        
        -- Start animation from above
        inlineIndicator.Position = UDim2.new(0.5, 0, 1, -15)
        inlineIndicator.Size = UDim2.new(0, 0, 0, 2)
        inlineIndicator.Visible = true
        
        -- Unique slide-down and grow animation
        local slideDown = createTween(inlineIndicator, {
            Position = UDim2.new(0.5, 0, 1, 0)
        }, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        slideDown:Play()
        
        local growWidth = createTween(inlineIndicator, {
            Size = UDim2.new(0, 52, 0, 2)
        }, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        growWidth:Play()
    end
    
    -- Update current tab display
    Current_Tab_Value.Text = tab.text
end

function Library:CreateSection(config)
    if not CurrentTab then
        error("No tab created. Call CreateTab first.")
        return
    end
    
    local position = config.position or "left"
    local sectionText = config.SectionText or "Section"
    
    -- Check section limit
    if SectionCount[position] >= 1 then
        warn("Maximum 1 " .. position .. " section allowed per tab!")
        return nil
    end
    
    SectionCount[position] = SectionCount[position] + 1
    
    local section = {
        position = position,
        text = sectionText,
        components = {},
        frame = nil
    }
    
    -- Create section frame
    local sectionFrame = Instance.new("Frame")
    sectionFrame.Name = "Section_" .. position
    sectionFrame.Size = UDim2.new(0, 318, 0, 411)
    sectionFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    sectionFrame.Parent = Container
    
    if position == "left" then
        sectionFrame.Position = UDim2.new(0.019436366856098175, 0, 0.17085854709148407, 0)
    else
        sectionFrame.Position = UDim2.new(0.5120617151260376, 0, 0.17085854709148407, 0)
    end
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 4)
    sectionCorner.Parent = sectionFrame
    
    -- Create shadow header
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(0, 318, 0, 40)
    shadow.BackgroundColor3 = Color3.fromRGB(170, 85, 255)
    shadow.BackgroundTransparency = 0.9
    shadow.Parent = sectionFrame
    
    local shadowGradient = Instance.new("UIGradient")
    shadowGradient.Rotation = 7
    shadowGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.69, 1),
        NumberSequenceKeypoint.new(0.697, 0.981249988079071),
        NumberSequenceKeypoint.new(0.706, 0.949999988079071),
        NumberSequenceKeypoint.new(1, 0.987500011920929)
    }
    shadowGradient.Parent = shadow
    
    -- Section name
    local sectionName = Instance.new("TextLabel")
    sectionName.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
    sectionName.TextColor3 = Color3.fromRGB(115, 58, 173)
    sectionName.Text = sectionText
    sectionName.BackgroundTransparency = 1
    sectionName.Size = UDim2.new(0, 1, 0, 1)
    sectionName.Position = UDim2.new(0, 12, 0.5, 0)
    sectionName.AnchorPoint = Vector2.new(0, 0.5)
    sectionName.AutomaticSize = Enum.AutomaticSize.XY
    sectionName.TextSize = 16
    sectionName.Parent = shadow
    
    -- Container for components
    local container = Instance.new("ScrollingFrame")
    container.Name = position .. "_Container"
    container.Size = UDim2.new(0, 318, 0, 365)
    container.Position = UDim2.new(0.5, 0, 0.985401451587677, 0)
    container.AnchorPoint = Vector2.new(0.5, 1)
    container.BackgroundTransparency = 1
    container.ScrollBarThickness = 0
    container.Parent = sectionFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 12)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = container
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 10)
    padding.Parent = container
    
    -- Add methods to section object
    function section:CreateToggle(config)
        return Library:CreateToggle(config, self)
    end
    
    function section:CreateSlider(config)
        return Library:CreateSlider(config, self)
    end
    
    function section:CreateTextInput(config)
        return Library:CreateTextInput(config, self)
    end
    
    function section:CreateKeybind(config)
        return Library:CreateKeybind(config, self)
    end
    
    section.frame = sectionFrame
    table.insert(CurrentTab.sections[position], section)
    
    return section
end

function Library:CreateToggle(config, section)
    if not section then
        if not CurrentTab or not CurrentTab.sections.left[1] and not CurrentTab.sections.right[1] then
            error("No section created. Call CreateSection first.")
            return
        end
        section = CurrentTab.sections.left[1] or CurrentTab.sections.right[1]
    end
    
    local container = section.frame:FindFirstChild(section.position .. "_Container")
    
    local toggle = {
        text = config.ToggleText or "Toggle",
        callback = config.Callback or function() end,
        value = false
    }
    
    -- Create toggle component
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = "Toggle_Component"
    toggleFrame.Size = UDim2.new(0, 318, 0, 20)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = container
    
    local toggleButton = Instance.new("Frame")
    toggleButton.Name = "Toggle"
    toggleButton.Size = UDim2.new(0, 20, 0, 20)
    toggleButton.Position = UDim2.new(0, 15, 0.5, 0)
    toggleButton.AnchorPoint = Vector2.new(0, 0.5)
    toggleButton.BackgroundTransparency = 1
    toggleButton.Parent = toggleFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleButton
    
    local toggleStroke = Instance.new("UIStroke")
    toggleStroke.Color = Color3.fromRGB(33, 33, 33)
    toggleStroke.Parent = toggleButton
    
    local toggleFill = Instance.new("Frame")
    toggleFill.Name = "Toggle_Fill"
    toggleFill.Size = UDim2.new(0, 20, 0, 20)
    toggleFill.Position = UDim2.new(0.5, 0, 0.5, 0)
    toggleFill.AnchorPoint = Vector2.new(0.5, 0.5)
    toggleFill.BackgroundColor3 = Color3.fromRGB(155, 77, 255)
    toggleFill.Parent = toggleButton
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 6)
    fillCorner.Parent = toggleFill
    
    local checkIcon = Instance.new("ImageLabel")
    checkIcon.Name = "Check_Icon"
    checkIcon.Image = "rbxassetid://139958444428790"
    checkIcon.Size = UDim2.new(0, 13, 0, 15)
    checkIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    checkIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    checkIcon.BackgroundTransparency = 1
    checkIcon.Parent = toggleFill
    
    local toggleText = Instance.new("TextLabel")
    toggleText.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    toggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleText.Text = toggle.text
    toggleText.Size = UDim2.new(0, 1, 0, 1)
    toggleText.Position = UDim2.new(1.8179999589920044, -2, 0.07500000298023224, 0)
    toggleText.BackgroundTransparency = 1
    toggleText.AutomaticSize = Enum.AutomaticSize.XY
    toggleText.TextSize = 16
    toggleText.Parent = toggleButton
    
    -- Store inactive color
    local inactiveColor = Color3.fromRGB(52, 52, 52)
    local activeColor = Color3.fromRGB(255, 255, 255)
    
    -- Click functionality
    local clickButton = Instance.new("TextButton")
    clickButton.BackgroundTransparency = 1
    clickButton.Size = UDim2.new(1, 0, 1, 0)
    clickButton.Text = ""
    clickButton.Parent = toggleFrame
    
    clickButton.MouseButton1Click:Connect(function()
        toggle.value = not toggle.value
        
        if toggle.value then
            -- Smooth grow animation
            local growTween = createTween(toggleFill, {Size = UDim2.new(0, 20, 0, 20)}, 0.2)
            growTween:Play()
            
            local iconTween = createTween(checkIcon, {ImageTransparency = 0}, 0.2)
            iconTween:Play()
            
            -- Set active color
            local colorTween = createTween(toggleText, {TextColor3 = activeColor}, 0.2)
            colorTween:Play()
        else
            -- Fast reverse effect
            local shrinkTween = createTween(toggleFill, {Size = UDim2.new(0, 0, 0, 0)}, 0.1)
            shrinkTween:Play()
            
            local iconTween = createTween(checkIcon, {ImageTransparency = 1}, 0.1)
            iconTween:Play()
            
            -- Set inactive color
            local colorTween = createTween(toggleText, {TextColor3 = inactiveColor}, 0.1)
            colorTween:Play()
        end
        
        toggle.callback(toggle.value)
    end)
    
    -- Initially hide the fill and set inactive color
    toggleFill.Size = UDim2.new(0, 0, 0, 0)
    checkIcon.ImageTransparency = 1
    toggleText.TextColor3 = inactiveColor
    
    table.insert(section.components, toggle)
    return toggle
end

function Library:CreateSlider(config, section)
    if not section then
        if not CurrentTab or not CurrentTab.sections.left[1] and not CurrentTab.sections.right[1] then
            error("No section created. Call CreateSection first.")
            return
        end
        section = CurrentTab.sections.left[1] or CurrentTab.sections.right[1]
    end
    
    local container = section.frame:FindFirstChild(section.position .. "_Container")
    
    local slider = {
        text = config.SliderText or "Slider",
        min = config.Min or 0,
        max = config.Max or 100,
        value = config.Value or 50,
        callback = config.Callback or function() end
    }
    
    -- Create slider component
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = "Slider_Component"
    sliderFrame.Size = UDim2.new(0, 318, 0, 40)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = container
    
    local sliderBG = Instance.new("Frame")
    sliderBG.Name = "Slider_BG"
    sliderBG.Size = UDim2.new(0, 278, 0, 3)
    sliderBG.Position = UDim2.new(0.4887655973434448, 0, 0.6625000238418579, 0)
    sliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
    sliderBG.BackgroundColor3 = Color3.fromRGB(53, 27, 81)
    sliderBG.Parent = sliderFrame
    
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 30)
    bgCorner.Parent = sliderBG
    
    local progressBar = Instance.new("Frame")
    progressBar.Name = "Progress_Bar"
    progressBar.Size = UDim2.new(0, 0, 0, 3)
    progressBar.Position = UDim2.new(0, 0, 0.5, 0)
    progressBar.AnchorPoint = Vector2.new(0, 0.5)
    progressBar.BackgroundColor3 = Color3.fromRGB(115, 58, 173)
    progressBar.Parent = sliderBG
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 30)
    progressCorner.Parent = progressBar
    
    local pointer = Instance.new("Frame")
    pointer.Name = "Pointer"
    pointer.Size = UDim2.new(0, 15, 0, 15)
    pointer.Position = UDim2.new(1, 0, 0.5, 0)
    pointer.AnchorPoint = Vector2.new(1, 0.5)
    pointer.BackgroundColor3 = Color3.fromRGB(155, 77, 255)
    pointer.Parent = progressBar
    
    local pointerCorner = Instance.new("UICorner")
    pointerCorner.CornerRadius = UDim.new(0, 30)
    pointerCorner.Parent = pointer
    
    local sliderName = Instance.new("TextLabel")
    sliderName.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    sliderName.TextColor3 = Color3.fromRGB(52, 52, 52)
    sliderName.Text = slider.text
    sliderName.Size = UDim2.new(0, 1, 0, 1)
    sliderName.Position = UDim2.new(0.10100000351667404, 0, 0.2199999988079071, 0)
    sliderName.AnchorPoint = Vector2.new(0.5, 0.5)
    sliderName.BackgroundTransparency = 1
    sliderName.AutomaticSize = Enum.AutomaticSize.XY
    sliderName.TextSize = 16
    sliderName.Parent = sliderFrame
    
    local sliderValue = Instance.new("TextLabel")
    sliderValue.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    sliderValue.TextColor3 = Color3.fromRGB(52, 52, 52)
    sliderValue.Text = string.format("%.2f", slider.value)
    sliderValue.Size = UDim2.new(0, 1, 0, 1)
    sliderValue.Position = UDim2.new(0.8589999675750732, 0, 0.21999970078468323, 0)
    sliderValue.AnchorPoint = Vector2.new(0.5, 0.5)
    sliderValue.BackgroundTransparency = 1
    sliderValue.AutomaticSize = Enum.AutomaticSize.XY
    sliderValue.TextSize = 16
    sliderValue.Parent = sliderFrame
    
    local valuePadding = Instance.new("UIPadding")
    valuePadding.PaddingRight = UDim.new(0, 4)
    valuePadding.Parent = sliderValue
    
    -- Slider functionality
    local sliderButton = Instance.new("TextButton")
    sliderButton.BackgroundTransparency = 1
    sliderButton.Size = UDim2.new(1, 0, 1, 0)
    sliderButton.Text = ""
    sliderButton.Parent = sliderFrame
    
    local isDragging = false
    
    sliderButton.MouseButton1Down:Connect(function()
        isDragging = true
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouseX = input.Position.X
            local sliderX = sliderBG.AbsolutePosition.X
            local sliderWidth = sliderBG.AbsoluteSize.X
            
            local relativeX = math.clamp(mouseX - sliderX, 0, sliderWidth)
            local percentage = relativeX / sliderWidth
            
            slider.value = math.clamp(slider.min + (slider.max - slider.min) * percentage, slider.min, slider.max)
            
            -- Update visual
            local progressWidth = sliderWidth * percentage
            progressBar.Size = UDim2.new(0, progressWidth, 0, 3)
            sliderValue.Text = string.format("%.2f", slider.value)
            
            -- Heartbeat pulse animation
            local pulseTween = createTween(sliderValue, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.1)
            pulseTween:Play()
            
            pulseTween.Completed:Connect(function()
                local reverseTween = createTween(sliderValue, {TextColor3 = Color3.fromRGB(52, 52, 52)}, 0.1)
                reverseTween:Play()
            end)
            
            slider.callback(slider.value)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)
    
    -- Set initial value
    local initialPercentage = (slider.value - slider.min) / (slider.max - slider.min)
    progressBar.Size = UDim2.new(0, 278 * initialPercentage, 0, 3)
    
    table.insert(section.components, slider)
    return slider
end

function Library:CreateTextInput(config, section)
    if not section then
        if not CurrentTab or not CurrentTab.sections.left[1] and not CurrentTab.sections.right[1] then
            error("No section created. Call CreateSection first.")
            return
        end
        section = CurrentTab.sections.left[1] or CurrentTab.sections.right[1]
    end
    
    local container = section.frame:FindFirstChild(section.position .. "_Container")
    
    local textInput = {
        text = config.TextInputText or "Text Input",
        callback = config.Callback or function() end,
        value = ""
    }
    
    -- Create text input component
    local inputFrame = Instance.new("Frame")
    inputFrame.Name = "TextInput_Component"
    inputFrame.Size = UDim2.new(0, 318, 0, 40)
    inputFrame.BackgroundTransparency = 1
    inputFrame.Parent = container
    
    local textInputBox = Instance.new("TextLabel")
    textInputBox.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
    textInputBox.TextColor3 = Color3.fromRGB(109, 109, 109)
    textInputBox.Text = textInput.text
    textInputBox.Size = UDim2.new(0, 279, 0, 40)
    textInputBox.Position = UDim2.new(0.04492206871509552, 0, 0.5, 0)
    textInputBox.AnchorPoint = Vector2.new(0, 0.5)
    textInputBox.TextXAlignment = Enum.TextXAlignment.Left
    textInputBox.TextSize = 14
    textInputBox.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    textInputBox.Parent = inputFrame
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 6)
    inputCorner.Parent = textInputBox
    
    local inputPadding = Instance.new("UIPadding")
    inputPadding.PaddingLeft = UDim.new(0, 12)
    inputPadding.Parent = textInputBox
    
    -- Click to edit functionality
    local clickButton = Instance.new("TextButton")
    clickButton.BackgroundTransparency = 1
    clickButton.Size = UDim2.new(1, 0, 1, 0)
    clickButton.Text = ""
    clickButton.Parent = inputFrame
    
    clickButton.MouseButton1Click:Connect(function()
        local newText = game:GetService("TextService"):GetStringAsync(textInput.text, textInputBox.TextBounds.X, textInputBox.Font, textInputBox.TextSize)
        -- In a real implementation, you'd use a proper text input dialog
        -- For now, we'll simulate it
        textInput.value = newText
        textInputBox.Text = newText
        textInput.callback(newText)
    end)
    
    table.insert(section.components, textInput)
    return textInput
end

function Library:CreateKeybind(config, section)
    if not section then
        if not CurrentTab or not CurrentTab.sections.left[1] and not CurrentTab.sections.right[1] then
            error("No section created. Call CreateSection first.")
            return
        end
        section = CurrentTab.sections.left[1] or CurrentTab.sections.right[1]
    end
    
    local container = section.frame:FindFirstChild(section.position .. "_Container")
    
    local keybind = {
        text = config.KeybindText or "Keybind",
        callback = config.Callback or function() end,
        key = "None"
    }
    
    -- Create keybind component
    local keybindFrame = Instance.new("Frame")
    keybindFrame.Name = "Keybind_Component"
    keybindFrame.Size = UDim2.new(0, 318, 0, 20)
    keybindFrame.BackgroundTransparency = 1
    keybindFrame.Parent = container
    
    local keybindText = Instance.new("TextLabel")
    keybindText.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    keybindText.TextColor3 = Color3.fromRGB(52, 52, 52)
    keybindText.Text = keybind.text
    keybindText.Size = UDim2.new(0, 1, 0, 1)
    keybindText.Position = UDim2.new(0.044025156646966934, 0, 0.5, 0)
    keybindText.AnchorPoint = Vector2.new(0, 0.5)
    keybindText.BackgroundTransparency = 1
    keybindText.AutomaticSize = Enum.AutomaticSize.XY
    keybindText.TextSize = 16
    keybindText.Parent = keybindFrame
    
    local keybindButton = Instance.new("TextButton")
    keybindButton.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    keybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    keybindButton.Text = keybind.key
    keybindButton.Size = UDim2.new(0, 1, 0, 1)
    keybindButton.Position = UDim2.new(0.9150943160057068, 0, 0.5, 0)
    keybindButton.AnchorPoint = Vector2.new(1, 0.5)
    keybindButton.AutomaticSize = Enum.AutomaticSize.XY
    keybindButton.TextSize = 14
    keybindButton.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
    keybindButton.Parent = keybindFrame
    
    local buttonPadding = Instance.new("UIPadding")
    buttonPadding.PaddingTop = UDim.new(0, 6)
    buttonPadding.PaddingBottom = UDim.new(0, 6)
    buttonPadding.PaddingRight = UDim.new(0, 6)
    buttonPadding.PaddingLeft = UDim.new(0, 6)
    buttonPadding.Parent = keybindButton
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 3)
    buttonCorner.Parent = keybindButton
    
    local isListening = false
    
    keybindButton.MouseButton1Click:Connect(function()
        if not isListening then
            isListening = true
            keybindButton.Text = "..."
            
            -- Smooth animation for listening state
            local listeningTween = createTween(keybindButton, {TextColor3 = Color3.fromRGB(115, 58, 173)}, 0.2)
            listeningTween:Play()
            
            -- Listen for key input
            local connection
            connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                local keyName = nil
                
                -- Handle keyboard input (including shift keys)
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    local keyCode = input.KeyCode
                    
                    -- Skip WASD movement keys
                    if keyCode == Enum.KeyCode.W or keyCode == Enum.KeyCode.A or 
                       keyCode == Enum.KeyCode.S or keyCode == Enum.KeyCode.D then
                        return
                    end
                    
                    -- Simplify keyboard key names
                    if keyCode == Enum.KeyCode.LeftShift then
                        keyName = "LShift"
                    elseif keyCode == Enum.KeyCode.RightShift then
                        keyName = "RShift"
                    elseif keyCode == Enum.KeyCode.LeftControl then
                        keyName = "LCtrl"
                    elseif keyCode == Enum.KeyCode.RightControl then
                        keyName = "RCtrl"
                    elseif keyCode == Enum.KeyCode.LeftAlt then
                        keyName = "LAlt"
                    elseif keyCode == Enum.KeyCode.RightAlt then
                        keyName = "RAlt"
                    elseif keyCode == Enum.KeyCode.Return then
                        keyName = "Enter"
                    elseif keyCode == Enum.KeyCode.Escape then
                        keyName = "Esc"
                    elseif keyCode == Enum.KeyCode.Backspace then
                        keyName = "Back"
                    elseif keyCode == Enum.KeyCode.Tab then
                        keyName = "Tab"
                    elseif keyCode == Enum.KeyCode.Space then
                        keyName = "Space"
                    else
                        keyName = keyCode.Name
                    end
                end
                
                -- Handle mouse input
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    keyName = "LMB"
                elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                    keyName = "RMB"
                elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
                    keyName = "MMB"
                end
                
                -- Handle gamepad input (controller buttons)
                if input.UserInputType == Enum.UserInputType.Gamepad1 then
                    local gamepad = input.KeyCode
                    -- Skip movement stick inputs
                    if gamepad == Enum.KeyCode.Thumbstick1 or gamepad == Enum.KeyCode.Thumbstick2 or
                       gamepad == Enum.KeyCode.DPadLeft or gamepad == Enum.KeyCode.DPadRight or
                       gamepad == Enum.KeyCode.DPadUp or gamepad == Enum.KeyCode.DPadDown then
                        return
                    end
                    
                    -- Simplify gamepad button names
                    if gamepad == Enum.KeyCode.ButtonA then
                        keyName = "A"
                    elseif gamepad == Enum.KeyCode.ButtonB then
                        keyName = "B"
                    elseif gamepad == Enum.KeyCode.ButtonX then
                        keyName = "X"
                    elseif gamepad == Enum.KeyCode.ButtonY then
                        keyName = "Y"
                    elseif gamepad == Enum.KeyCode.ButtonStart then
                        keyName = "Start"
                    elseif gamepad == Enum.KeyCode.ButtonSelect then
                        keyName = "Select"
                    elseif gamepad == Enum.KeyCode.ButtonL1 then
                        keyName = "LB"
                    elseif gamepad == Enum.KeyCode.ButtonR1 then
                        keyName = "RB"
                    elseif gamepad == Enum.KeyCode.ButtonL2 then
                        keyName = "LT"
                    elseif gamepad == Enum.KeyCode.ButtonR2 then
                        keyName = "RT"
                    elseif gamepad == Enum.KeyCode.ButtonL3 then
                        keyName = "LS"
                    elseif gamepad == Enum.KeyCode.ButtonR3 then
                        keyName = "RS"
                    else
                        keyName = gamepad.Name
                    end
                elseif input.UserInputType == Enum.UserInputType.Gamepad2 then
                    local gamepad = input.KeyCode
                    if gamepad == Enum.KeyCode.Thumbstick1 or gamepad == Enum.KeyCode.Thumbstick2 or
                       gamepad == Enum.KeyCode.DPadLeft or gamepad == Enum.KeyCode.DPadRight or
                       gamepad == Enum.KeyCode.DPadUp or gamepad == Enum.KeyCode.DPadDown then
                        return
                    end
                    keyName = "P2_" .. gamepad.Name
                elseif input.UserInputType == Enum.UserInputType.Gamepad3 then
                    local gamepad = input.KeyCode
                    if gamepad == Enum.KeyCode.Thumbstick1 or gamepad == Enum.KeyCode.Thumbstick2 or
                       gamepad == Enum.KeyCode.DPadLeft or gamepad == Enum.KeyCode.DPadRight or
                       gamepad == Enum.KeyCode.DPadUp or gamepad == Enum.KeyCode.DPadDown then
                        return
                    end
                    keyName = "P3_" .. gamepad.Name
                elseif input.UserInputType == Enum.UserInputType.Gamepad4 then
                    local gamepad = input.KeyCode
                    if gamepad == Enum.KeyCode.Thumbstick1 or gamepad == Enum.KeyCode.Thumbstick2 or
                       gamepad == Enum.KeyCode.DPadLeft or gamepad == Enum.KeyCode.DPadRight or
                       gamepad == Enum.KeyCode.DPadUp or gamepad == Enum.KeyCode.DPadDown then
                        return
                    end
                    keyName = "P4_" .. gamepad.Name
                elseif input.UserInputType == Enum.UserInputType.Gamepad5 then
                    local gamepad = input.KeyCode
                    if gamepad == Enum.KeyCode.Thumbstick1 or gamepad == Enum.KeyCode.Thumbstick2 or
                       gamepad == Enum.KeyCode.DPadLeft or gamepad == Enum.KeyCode.DPadRight or
                       gamepad == Enum.KeyCode.DPadUp or gamepad == Enum.KeyCode.DPadDown then
                        return
                    end
                    keyName = "P5_" .. gamepad.Name
                elseif input.UserInputType == Enum.UserInputType.Gamepad6 then
                    local gamepad = input.KeyCode
                    if gamepad == Enum.KeyCode.Thumbstick1 or gamepad == Enum.KeyCode.Thumbstick2 or
                       gamepad == Enum.KeyCode.DPadLeft or gamepad == Enum.KeyCode.DPadRight or
                       gamepad == Enum.KeyCode.DPadUp or gamepad == Enum.KeyCode.DPadDown then
                        return
                    end
                    keyName = "P6_" .. gamepad.Name
                elseif input.UserInputType == Enum.UserInputType.Gamepad7 then
                    local gamepad = input.KeyCode
                    if gamepad == Enum.KeyCode.Thumbstick1 or gamepad == Enum.KeyCode.Thumbstick2 or
                       gamepad == Enum.KeyCode.DPadLeft or gamepad == Enum.KeyCode.DPadRight or
                       gamepad == Enum.KeyCode.DPadUp or gamepad == Enum.KeyCode.DPadDown then
                        return
                    end
                    keyName = "P7_" .. gamepad.Name
                elseif input.UserInputType == Enum.UserInputType.Gamepad8 then
                    local gamepad = input.KeyCode
                    if gamepad == Enum.KeyCode.Thumbstick1 or gamepad == Enum.KeyCode.Thumbstick2 or
                       gamepad == Enum.KeyCode.DPadLeft or gamepad == Enum.KeyCode.DPadRight or
                       gamepad == Enum.KeyCode.DPadUp or gamepad == Enum.KeyCode.DPadDown then
                        return
                    end
                    keyName = "P8_" .. gamepad.Name
                end
                
                -- If we got a valid key, set it
                if keyName then
                    keybind.key = keyName
                    keybindButton.Text = keyName
                    
                    -- Smooth animation back to normal
                    local normalTween = createTween(keybindButton, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
                    normalTween:Play()
                    
                    keybind.callback(keyName)
                    isListening = false
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    table.insert(section.components, keybind)
    return keybind
end

-- Reload function to unload old UI and load new one
function Library:Reload()
    -- Destroy existing UI
    if ScreenGui then
        ScreenGui:Destroy()
    end
    
    -- Reset global variables
    Windows = {}
    CurrentWindow = nil
    CurrentTab = nil
    Sections = {left = {}, right = {}}
    SectionCount = {left = 0, right = 0}
    ActiveKeybinds = {}
    Dragging = false
    DragStart = nil
    DragStartPosition = nil
    GlobalTabInlineIndicator = nil
    
    -- Recreate the main ScreenGui
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Recreate MainFrame
    MainFrame = Instance.new("Frame")
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Name = "MainFrame"
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.Size = UDim2.new(0, 720, 0, 550)
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = MainFrame
    
    -- Recreate Container
    Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Position = UDim2.new(0.02857903391122818, 0, 0.056512895971536636, 0)
    Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Container.Size = UDim2.new(0, 678, 0, 505)
    Container.BorderSizePixel = 0
    Container.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
    Container.Parent = MainFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Container
    
    -- Recreate Top_Bar
    Top_Bar = Instance.new("Frame")
    Top_Bar.Name = "Top_Bar"
    Top_Bar.Position = UDim2.new(0.04027777910232544, 0, 0.07454545795917511, 0)
    Top_Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Top_Bar.Size = UDim2.new(0, 660, 0, 65)
    Top_Bar.BorderSizePixel = 0
    Top_Bar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Top_Bar.Parent = MainFrame
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Top_Bar
    
    -- Recreate library name and icon
    Libary_Name = Instance.new("TextLabel")
    Libary_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
    Libary_Name.TextColor3 = Color3.fromRGB(255, 255, 255)
    Libary_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Libary_Name.Text = "STARHUB"
    Libary_Name.Name = "Libary_Name"
    Libary_Name.AnchorPoint = Vector2.new(0, 0.5)
    Libary_Name.Size = UDim2.new(0, 1, 0, 1)
    Libary_Name.BackgroundTransparency = 1
    Libary_Name.Position = UDim2.new(0.03999999910593033, 11, 0.3919999897480011, 0)
    Libary_Name.BorderSizePixel = 0
    Libary_Name.AutomaticSize = Enum.AutomaticSize.XY
    Libary_Name.TextSize = 21
    Libary_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Libary_Name.Parent = Top_Bar
    
    Libary_Icon = Instance.new("ImageLabel")
    Libary_Icon.ImageColor3 = Color3.fromRGB(170, 85, 255)
    Libary_Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Libary_Icon.Name = "Libary_Icon"
    Libary_Icon.Image = "rbxassetid://132964100967987"
    Libary_Icon.BackgroundTransparency = 1
    Libary_Icon.Position = UDim2.new(-0.2936060428619385, 0, 0, 0)
    Libary_Icon.Size = UDim2.new(0, 20, 0, 20)
    Libary_Icon.BorderSizePixel = 0
    Libary_Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Libary_Icon.Parent = Libary_Name
    
    -- Recreate build date
    Build_Date = Instance.new("TextLabel")
    Build_Date.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
    Build_Date.TextColor3 = Color3.fromRGB(64, 64, 63)
    Build_Date.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Build_Date.Text = "Build date: 4 Febuary"
    Build_Date.Name = "Build_Date"
    Build_Date.AnchorPoint = Vector2.new(0, 0.5)
    Build_Date.Size = UDim2.new(0, 1, 0, 1)
    Build_Date.BackgroundTransparency = 1
    Build_Date.Position = UDim2.new(0.0020000000949949026, 11, 0.6650000214576721, 0)
    Build_Date.BorderSizePixel = 0
    Build_Date.AutomaticSize = Enum.AutomaticSize.XY
    Build_Date.TextSize = 14
    Build_Date.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Build_Date.Parent = Top_Bar
    
    -- Recreate Header
    Header = Instance.new("Frame")
    Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Header.AnchorPoint = Vector2.new(1, 0.5)
    Header.BackgroundTransparency = 1
    Header.Position = UDim2.new(1, 0, 0.5, 0)
    Header.Name = "Header"
    Header.Size = UDim2.new(0, 508, 0, 65)
    Header.BorderSizePixel = 0
    Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Header.Parent = Top_Bar
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    UIListLayout.Padding = UDim.new(0, 2)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Header
    
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 10)
    UIPadding.PaddingRight = UDim.new(0, 20)
    UIPadding.Parent = Header
    
    -- Recreate current tab display
    Current_Tab_Icon = Instance.new("ImageLabel")
    Current_Tab_Icon.ImageColor3 = Color3.fromRGB(58, 58, 58)
    Current_Tab_Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Current_Tab_Icon.Name = "Current_Tab_Icon"
    Current_Tab_Icon.Image = "rbxassetid://74403797129667"
    Current_Tab_Icon.BackgroundTransparency = 1
    Current_Tab_Icon.Position = UDim2.new(0.031999967992305756, 0, 0.01890907995402813, 0)
    Current_Tab_Icon.Size = UDim2.new(0, 25, 0, 20)
    Current_Tab_Icon.BorderSizePixel = 0
    Current_Tab_Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Current_Tab_Icon.Parent = MainFrame
    
    Current_Tab_Value = Instance.new("TextLabel")
    Current_Tab_Value.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
    Current_Tab_Value.TextColor3 = Color3.fromRGB(58, 58, 58)
    Current_Tab_Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Current_Tab_Value.Text = "main"
    Current_Tab_Value.Name = "Current_Tab_Value"
    Current_Tab_Value.AnchorPoint = Vector2.new(0, 0.5)
    Current_Tab_Value.Size = UDim2.new(0, 1, 0, 1)
    Current_Tab_Value.BackgroundTransparency = 1
    Current_Tab_Value.Position = UDim2.new(0.0555555559694767, 11, 0.03590909019112587, 0)
    Current_Tab_Value.BorderSizePixel = 0
    Current_Tab_Value.AutomaticSize = Enum.AutomaticSize.XY
    Current_Tab_Value.TextSize = 14
    Current_Tab_Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Current_Tab_Value.Parent = MainFrame
    
    -- Recreate UIScale
    local UIScale = Instance.new("UIScale")
    UIScale.Parent = MainFrame
    
    -- Re-enable the UI with opening animation
    ScreenGui.Enabled = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    local reloadOpenTween = createTween(MainFrame, {
        Size = UDim2.new(0, 720, 0, 550),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    reloadOpenTween:Play()
    
    -- Re-make draggable
    makeDraggable(MainFrame)
    
    print("UI Reloaded successfully!")
end

-- Return the library
return Library
