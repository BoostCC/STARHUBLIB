-- STARHUB UI Library
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Library = {}
Library.Accent = Color3.fromRGB(155, 77, 255)
Library.AccentTransparent = Color3.fromRGB(155, 77, 255)
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
local BlockDragging = false
local ModalOverlay = nil
local PopupOpenCount = 0

-- Create the main ScreenGui in CoreGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Modal overlay to capture outside clicks and block dragging when popups are open
ModalOverlay = Instance.new("TextButton")
ModalOverlay.Name = "ModalOverlay"
ModalOverlay.BackgroundTransparency = 1
ModalOverlay.Text = ""
ModalOverlay.AutoButtonColor = false
ModalOverlay.Visible = false
ModalOverlay.Size = UDim2.fromScale(1, 1)
ModalOverlay.Position = UDim2.fromOffset(0, 0)
ModalOverlay.ZIndex = 999
ModalOverlay.Parent = ScreenGui

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
Libary_Icon.ImageColor3 = Library.Accent
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
GlobalTabInlineIndicator.Size = UDim2.new(0.64, 0, 0, 3)
GlobalTabInlineIndicator.BorderSizePixel = 0
GlobalTabInlineIndicator.BackgroundColor3 = Library.Accent
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

ScreenGui.Enabled = true
MainFrame.Visible = true

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
        if input.UserInputType == Enum.UserInputType.MouseButton1 and not BlockDragging then
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
    
    -- Create watermark with cheat name
    Library:CreateWatermark(config.library_config and config.library_config.Cheat_Name)
    
    -- Set up UI toggle keybind (only affects main UI, not notifications)
    if config.library_config and config.library_config.interface_keybind then
        local keybind = config.library_config.interface_keybind
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode[keybind] then
                MainFrame.Visible = not MainFrame.Visible
            end
        end)
    else
        -- Default Insert key
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Insert then
                MainFrame.Visible = not MainFrame.Visible
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
    
    function window:CreateDropdown(config)
        return Library:CreateDropdown(config)
    end
    
    function window:CreateKeybind(config)
        return Library:CreateKeybind(config)
    end
    
    function window:CreateColorpicker(config)
        return Library:CreateColorpicker(config)
    end
    
    table.insert(Windows, window)
    CurrentWindow = window
    
    return window
end

-- Accent color API
function Library:SetAccentColor(color, alpha)
    -- fallback to default if not provided
    Library.Accent = color or Library.Accent or Color3.fromRGB(155, 77, 255)
    local a = alpha
    -- Update inline and headings
    if GlobalTabInlineIndicator then
        GlobalTabInlineIndicator.BackgroundColor3 = Library.Accent
    end
    if Build_Date then
        -- no-op; sample place if we later tint other elements
    end

    -- Update library icon
    if Libary_Icon then
        Libary_Icon.ImageColor3 = Library.Accent
    end
    
    -- Update watermark elements
    if Watermark_Icon then
        Watermark_Icon.ImageColor3 = Library.Accent
    end
    if Watermark_Inline then
        Watermark_Inline.BackgroundColor3 = Library.Accent
    end

    -- Sweep through UI and update common accent elements
    if ScreenGui then
        -- Update active tab icon/text immediately
        if CurrentTab and CurrentTab.tabFrame then
            local icon = CurrentTab.tabFrame:FindFirstChild("Tab_Icon")
            local text = icon and icon:FindFirstChild("Tab_Name")
            if icon then icon.ImageColor3 = Library.Accent end
            if text then text.TextColor3 = Library.Accent end
        end

        for _, inst in ipairs(ScreenGui:GetDescendants()) do
            if inst:IsA("Frame") then
                if inst.Name == "Progress_Bar" or inst.Name == "Pointer" then
                    inst.BackgroundColor3 = Library.Accent
                elseif inst.Name == "Slider_BG" then
                    inst.BackgroundColor3 = Library.Accent
                    inst.BackgroundTransparency = 0.75
                elseif inst.Name == "Toggle_Fill" then
                    inst.BackgroundColor3 = Library.Accent
                elseif inst.Name == "Inline" then
                    inst.BackgroundColor3 = Library.Accent
                elseif inst.Name == "Shadow" then
                    inst.BackgroundColor3 = Library.Accent
                end
            elseif inst:IsA("ImageLabel") then
                if inst.Name == "Check_Icon" then
                    if not inst:GetAttribute("ForceWhite") then
                        inst.ImageColor3 = Library.Accent
                    end
                elseif inst.Name == "Libary_Icon" then
                    inst.ImageColor3 = Library.Accent
                end
            elseif inst:IsA("TextLabel") then
                -- Section headers live under the shadow frame
                if inst.Parent and inst.Parent.Name == "Shadow" then
                    inst.TextColor3 = Library.Accent
                end
            elseif inst:IsA("TextBox") then
                if inst:GetAttribute("ActiveInput") then
                    inst.TextColor3 = Library.Accent
                    local stroke = inst:FindFirstChildOfClass("UIStroke")
                    if stroke then
                        -- ensure no border is shown
                        stroke.Transparency = 1
                    end
                else
                    local stroke = inst:FindFirstChildOfClass("UIStroke")
                    if stroke then stroke.Transparency = 1 end
                end
            end
        end
        -- For dropdown active text, ensure selected options are refreshed
        for _, container in ipairs(ScreenGui:GetDescendants()) do
            if container:IsA("Frame") and container.Name == "Dropdown_Container" then
                for _, item in ipairs(container:GetChildren()) do
                    if item:IsA("Frame") then
                        local check = item:FindFirstChild("Check_Icon")
                        local label = item:FindFirstChild("TextLabel")
                        if check and label and check:IsA("ImageLabel") and label:IsA("TextLabel") then
                            if check.ImageTransparency == 0 then
                                label.TextColor3 = Library.Accent
                                check.ImageColor3 = Library.Accent
                            end
                        end
                    end
                end
            end
        end
    end
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
        tabFrame = nil,
        tabContainer = nil
    }
    
    -- Create tab container per requested design
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "Tab_Container"
    tabContainer.BackgroundTransparency = 1
    tabContainer.Size = UDim2.new(0, 100, 0, 55)
    tabContainer.BorderSizePixel = 0
    tabContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    tabContainer.Parent = Header
    
    -- Create tab frame inside container
    local tabFrame = Instance.new("Frame")
    tabFrame.AnchorPoint = Vector2.new(0.5, 0)
    tabFrame.Name = "Tab"
    tabFrame.Position = UDim2.new(0.5, 0, 0, 0)
    tabFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    tabFrame.Size = UDim2.new(0, 95, 0, 42)
    tabFrame.BorderSizePixel = 0
    tabFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    tabFrame.BackgroundTransparency = 1 -- start inactive
    tabFrame.Parent = tabContainer
    
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

    -- Click functionality on entire container
    local tabButton = Instance.new("TextButton")
    tabButton.BackgroundTransparency = 1
    tabButton.Size = UDim2.new(1, 0, 1, 0)
    tabButton.Text = ""
    tabButton.Parent = tabContainer
    
    tabButton.MouseButton1Click:Connect(function()
        Library:SwitchTab(tab)
    end)
    
    -- Store references
    tab.tabFrame = tabFrame
    tab.tabContainer = tabContainer
    
    
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
    
    function tab:CreateDropdown(config)
        return Library:CreateDropdown(config)
    end
    
    function tab:CreateKeybind(config)
        return Library:CreateKeybind(config)
    end
    
    function tab:CreateColorpicker(config)
        return Library:CreateColorpicker(config)
    end
    
    table.insert(CurrentWindow.tabs, tab)
    return tab
end

function Library:SwitchTab(tab)
    -- Check if we're clicking the same tab
    local isSameTab = CurrentTab == tab
    
    if CurrentTab and not isSameTab then
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
    end
    
    CurrentTab = tab
    
    -- Show new tab sections with fast, clean slide-fade in
    for _, section in pairs(tab.sections.left) do
        if section.frame then
            section.frame.Visible = true
            section.frame.BackgroundTransparency = 1
            -- start slightly lower and faded
            section.frame.Position = section.targetPosition + UDim2.new(0, 0, 0, 10)
            local move = createTween(section.frame, {Position = section.targetPosition}, 0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local fade = createTween(section.frame, {BackgroundTransparency = 0}, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            move:Play(); fade:Play()
        end
    end
    for _, section in pairs(tab.sections.right) do
        if section.frame then
            section.frame.Visible = true
            section.frame.BackgroundTransparency = 1
            section.frame.Position = section.targetPosition + UDim2.new(0, 0, 0, 10)
            local move = createTween(section.frame, {Position = section.targetPosition}, 0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local fade = createTween(section.frame, {BackgroundTransparency = 0}, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            move:Play(); fade:Play()
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
                ImageColor3 = Library.Accent
            }, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            iconTween:Play()
            
            local textTween = createTween(text, {
                TextColor3 = Library.Accent
            }, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            textTween:Play()
        end
    end
    
    -- Move and animate global inline indicator anchored to the Tab_Container bottom center
    if GlobalTabInlineIndicator and tab.tabContainer then
        GlobalTabInlineIndicator.Parent = tab.tabContainer
        GlobalTabInlineIndicator.Visible = true
        -- reset start state every switch
        GlobalTabInlineIndicator.BackgroundTransparency = 1
        GlobalTabInlineIndicator.Position = UDim2.new(0.5, 0, 1, -6)
        GlobalTabInlineIndicator.Size = UDim2.new(0, 0, 0, 3)

        -- Defer one frame so Roblox registers initial state before tweens
        task.defer(function()
            local fadeIn = createTween(GlobalTabInlineIndicator, {
                BackgroundTransparency = 0
            }, 0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            fadeIn:Play()

            local slideDown = createTween(GlobalTabInlineIndicator, {
                Position = UDim2.new(0.5, 0, 1, 0)
            }, 0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            slideDown:Play()

            local grow = createTween(GlobalTabInlineIndicator, {
                Size = UDim2.new(1, 1, 0, 3)
            }, 0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            grow:Play()
        end)
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
    -- store target position for animations
    local targetPosition = sectionFrame.Position
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 4)
    sectionCorner.Parent = sectionFrame
    
    -- Create shadow header
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(0, 318, 0, 40)
    shadow.BackgroundColor3 = Library.Accent
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
    sectionName.TextColor3 = Library.Accent
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
    container.AutomaticCanvasSize = Enum.AutomaticSize.Y
    container.CanvasSize = UDim2.new(0, 0, 0, 0)
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
    
    function section:CreateDropdown(config)
        return Library:CreateDropdown(config, self)
    end
    
    function section:CreateKeybind(config)
        return Library:CreateKeybind(config, self)
    end
    
    function section:CreateColorpicker(config)
        return Library:CreateColorpicker(config, self)
    end
    
    
    section.frame = sectionFrame
    section.targetPosition = targetPosition
    
    -- If this section is created on the active tab, play the entry animation immediately
    if CurrentTab and table.find(CurrentTab.sections[position], section) == nil then
        -- ensure visibility and start state
        sectionFrame.Visible = true
        sectionFrame.BackgroundTransparency = 1
        sectionFrame.Position = targetPosition + UDim2.new(0, 0, 0, 10)
        task.defer(function()
            local move = createTween(sectionFrame, {Position = targetPosition}, 0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local fade = createTween(sectionFrame, {BackgroundTransparency = 0}, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            move:Play(); fade:Play()
        end)
    end
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
    toggleFill.BackgroundColor3 = Library.Accent
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
    checkIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    checkIcon:SetAttribute("ForceWhite", true)
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
    sliderBG.BackgroundColor3 = Library.Accent
    sliderBG.BackgroundTransparency = 0.75
    sliderBG.Parent = sliderFrame
    
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 30)
    bgCorner.Parent = sliderBG
    
    local progressBar = Instance.new("Frame")
    progressBar.Name = "Progress_Bar"
    progressBar.Size = UDim2.new(0, 0, 0, 3)
    progressBar.Position = UDim2.new(0, 0, 0.5, 0)
    progressBar.AnchorPoint = Vector2.new(0, 0.5)
    progressBar.BackgroundColor3 = Library.Accent
    progressBar.Parent = sliderBG
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 30)
    progressCorner.Parent = progressBar
    
    local pointer = Instance.new("Frame")
    pointer.Name = "Pointer"
    pointer.Size = UDim2.new(0, 15, 0, 15)
    pointer.Position = UDim2.new(1, 0, 0.5, 0)
    pointer.AnchorPoint = Vector2.new(1, 0.5)
    pointer.BackgroundColor3 = Library.Accent
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
        text = config.TextInputText or "Example",
        callback = config.Callback or function() end,
        value = ""
    }
    
    -- Create text input component
local TextInput_Component = Instance.new("Frame")
TextInput_Component.Name = "TextInput_Component"
TextInput_Component.BackgroundTransparency = 1
TextInput_Component.Position = UDim2.new(0, 0, 0.09732360392808914, 0)
TextInput_Component.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextInput_Component.Size = UDim2.new(0, 318, 0, 40)
TextInput_Component.BorderSizePixel = 0
TextInput_Component.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextInput_Component.Parent = container

    local Text_Input = Instance.new("TextBox")
Text_Input.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
Text_Input.TextColor3 = Color3.fromRGB(109, 109, 109)
Text_Input.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Text_Input.PlaceholderText = textInput.text
    Text_Input.Text = ""
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

    -- Text input functionality
    Text_Input.FocusLost:Connect(function(enterPressed)
        textInput.value = Text_Input.Text
        textInput.callback(Text_Input.Text)
        -- remove accent when not focused
        createTween(Text_Input, {TextColor3 = Color3.fromRGB(109, 109, 109)}, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out):Play()
        Text_Input:SetAttribute("ActiveInput", false)
    end)
    
    -- Focus gained animation (apply accent)
    Text_Input.Focused:Connect(function()
        createTween(Text_Input, {TextColor3 = Library.Accent}, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out):Play()
        Text_Input:SetAttribute("ActiveInput", true)
    end)
    
    table.insert(section.components, textInput)
    return textInput
end

function Library:CreateColorpicker(config, section)
    if not section then
        if not CurrentTab or not CurrentTab.sections.left[1] and not CurrentTab.sections.right[1] then
            error("No section created. Call CreateSection first.")
            return
        end
        section = CurrentTab.sections.left[1] or CurrentTab.sections.right[1]
    end
    
    local container = section.frame:FindFirstChild(section.position .. "_Container")
    
    local colorpicker = {
        text = config.ColorpickerText or "Example Colorpicker",
        value = config.defaultColor or Color3.fromRGB(255, 255, 255),
        callback = config.callback or config.Callback or function() end,
        isOpen = false
    }
    
    -- Component shell (matches provided spec)
    local Colorpicker_Component = Instance.new("Frame")
    Colorpicker_Component.Name = "Colorpicker_Component"
    Colorpicker_Component.BackgroundTransparency = 1
    Colorpicker_Component.Position = UDim2.new(0, 0, 0.5633803009986877, 0)
    Colorpicker_Component.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Colorpicker_Component.Size = UDim2.new(0, 318, 0, 30)
    Colorpicker_Component.BorderSizePixel = 0
    Colorpicker_Component.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Colorpicker_Component.Parent = container
    
    local Colorpicker_Text = Instance.new("TextLabel")
    Colorpicker_Text.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    Colorpicker_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
    Colorpicker_Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Colorpicker_Text.Text = colorpicker.text
    Colorpicker_Text.Name = "Colorpicker_Text"
    Colorpicker_Text.AnchorPoint = Vector2.new(0, 0.5)
    Colorpicker_Text.Size = UDim2.new(0, 1, 0, 1)
    Colorpicker_Text.BackgroundTransparency = 1
    Colorpicker_Text.Position = UDim2.new(0.044025156646966934, 0, 0.5, 0)
    Colorpicker_Text.BorderSizePixel = 0
    Colorpicker_Text.AutomaticSize = Enum.AutomaticSize.XY
    Colorpicker_Text.TextSize = 16
    Colorpicker_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Colorpicker_Text.Parent = Colorpicker_Component
    
    local Color_Frame = Instance.new("Frame")
    Color_Frame.AnchorPoint = Vector2.new(1, 0.5)
    Color_Frame.Name = "Color_Frame"
    Color_Frame.Position = UDim2.new(0.9245283007621765, 0, 0.5, 0)
    Color_Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Color_Frame.Size = UDim2.new(0, 40, 0, 20)
    Color_Frame.BorderSizePixel = 0
    Color_Frame.BackgroundColor3 = colorpicker.value
    Color_Frame.Parent = Colorpicker_Component
    
    local Color_Frame_UICorner = Instance.new("UICorner")
    Color_Frame_UICorner.CornerRadius = UDim.new(0, 4)
    Color_Frame_UICorner.Parent = Color_Frame
    
    -- Popup container for picker
    local PickerContainer = Instance.new("Frame")
    PickerContainer.Name = "PickerContainer"
    PickerContainer.AnchorPoint = Vector2.new(1, 0)
    PickerContainer.Position = UDim2.new(1, -10, 1, 6)
    PickerContainer.Size = UDim2.new(0, 225, 0, 190)
    PickerContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    PickerContainer.BorderSizePixel = 0
    PickerContainer.Visible = false
    PickerContainer.ZIndex = 1200
    PickerContainer.Parent = ScreenGui
    
    local pickerCorner = Instance.new("UICorner")
    pickerCorner.CornerRadius = UDim.new(0, 4)
    pickerCorner.Parent = PickerContainer
    
    -- SV square
    local SVFrame = Instance.new("Frame")
    SVFrame.Name = "SVFrame"
    SVFrame.Position = UDim2.new(0.035, 0, 0.075, 0)
    SVFrame.Size = UDim2.new(0, 169, 0, 169)
    SVFrame.BorderSizePixel = 0
    SVFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
    SVFrame.Parent = PickerContainer
    SVFrame.ZIndex = 1201
    
    local SVImage = Instance.new("ImageLabel")
    SVImage.Name = "SVImage"
    SVImage.BackgroundTransparency = 1
    SVImage.Size = UDim2.new(1, 0, 1, 0)
    SVImage.Image = "http://www.roblox.com/asset/?id=14684563800"
    SVImage.BorderSizePixel = 0
    SVImage.Parent = SVFrame
    SVImage.ZIndex = 1201
    
    local SVPicker = Instance.new("Frame")
    SVPicker.Name = "SVPicker"
    SVPicker.Size = UDim2.new(0, 10, 0, 10)
    SVPicker.AnchorPoint = Vector2.new(0.5, 0.5)
    SVPicker.Position = UDim2.new(0.5, 0, 0.5, 0)
    SVPicker.BackgroundTransparency = 1
    SVPicker.Parent = SVFrame
    SVPicker.ZIndex = 1202
    
    local SVPickerCorner = Instance.new("UICorner")
    SVPickerCorner.CornerRadius = UDim.new(0, 50)
    SVPickerCorner.Parent = SVPicker
    
    local SVPickerStroke = Instance.new("UIStroke")
    SVPickerStroke.Color = Color3.fromRGB(255, 255, 255)
    SVPickerStroke.Parent = SVPicker
    
    -- Hue bar
    local Hue = Instance.new("ImageButton")
    Hue.Name = "Hue"
    Hue.AnchorPoint = Vector2.new(0, 0.5)
    Hue.Position = UDim2.new(1.0094738006591797, 0, 0.49673840403556824, 0)
    Hue.Size = UDim2.new(0.1120000034570694, -1, 1.0479999780654907, -8)
    Hue.BorderSizePixel = 0
    Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Hue.Image = "http://www.roblox.com/asset/?id=14684557999"
    Hue.Parent = SVFrame
    Hue.ZIndex = 1201
    
    local HueStroke = Instance.new("UIStroke")
    HueStroke.Color = Color3.fromRGB(26, 26, 26)
    HueStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    HueStroke.Parent = Hue
    
    local HueDragger = Instance.new("ImageLabel")
    HueDragger.Name = "HueDragger"
    HueDragger.AnchorPoint = Vector2.new(0.5, 0)
    HueDragger.BackgroundTransparency = 1
    HueDragger.Image = "rbxassetid://107912043359755"
    HueDragger.Size = UDim2.new(0, 25, 0, 8)
    HueDragger.Position = UDim2.new(0.49999937415122986, 0, -0.02365296334028244, 0)
    HueDragger.Parent = Hue
    HueDragger.ZIndex = 1202
    
    -- Alpha slider (vertical) with checkers
    local Alpha = Instance.new("TextButton")
    Alpha.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    Alpha.TextColor3 = Color3.fromRGB(0, 0, 0)
    Alpha.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Alpha.Text = ""
    Alpha.AutoButtonColor = false
    Alpha.AnchorPoint = Vector2.new(1, 0.5)
    Alpha.Size = UDim2.new(0.9940828680992126, 0, 0.11366861313581467, -1)
    Alpha.Name = "Alpha"
    Alpha.Position = UDim2.new(1.6952662467956543, 0, 0.49112436175346375, 0)
    Alpha.Rotation = -90
    Alpha.BorderSizePixel = 0
    Alpha.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
    Alpha.Parent = SVFrame
    Alpha.ZIndex = 1201

    local Checkers = Instance.new("ImageLabel")
    Checkers.ScaleType = Enum.ScaleType.Tile
    Checkers.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Checkers.Name = "Checkers"
    Checkers.Size = UDim2.new(0.9940828680992126, 0, 1, 0)
    Checkers.AnchorPoint = Vector2.new(0.5, 0.5)
    Checkers.Image = "http://www.roblox.com/asset/?id=18274452449"
    Checkers.TileSize = UDim2.new(0, 18, 0, 18)
    Checkers.Position = UDim2.new(0.5, 0, 0.5, 0)
    Checkers.Rotation = -180
    Checkers.BorderSizePixel = 0
    Checkers.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Checkers.Parent = Alpha
    Checkers.ZIndex = 1201

    local UIGradientA = Instance.new("UIGradient")
    UIGradientA.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    }
    UIGradientA.Parent = Checkers

    local AlphaDragger = Instance.new("ImageLabel")
    AlphaDragger.BorderColor3 = Color3.fromRGB(0, 0, 0)
    AlphaDragger.Name = "Dragger"
    AlphaDragger.Size = UDim2.new(0, 25, 0, 8)
    AlphaDragger.AnchorPoint = Vector2.new(0.5, 0.5)
    AlphaDragger.Image = "rbxassetid://107912043359755"
    AlphaDragger.BackgroundTransparency = 1
    AlphaDragger.Position = UDim2.new(0.5, 0, 0.5, 0)
    AlphaDragger.Rotation = -90
    AlphaDragger.BorderSizePixel = 0
    AlphaDragger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    AlphaDragger.Parent = Checkers
    AlphaDragger.ZIndex = 1202

    local AlphaDraggerLine = Instance.new("Frame")
    AlphaDraggerLine.Name = "Dragger"
    AlphaDraggerLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
    AlphaDraggerLine.Size = UDim2.new(0, 1, 1, 0)
    AlphaDraggerLine.BorderSizePixel = 0
    AlphaDraggerLine.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
    AlphaDraggerLine.Parent = Alpha
    
    -- State
    local currentHue = 0
    local currentS, currentV = 1, 1
    local currentA = 1
    
    local function updateSVFrame()
        SVFrame.BackgroundColor3 = Color3.fromHSV(currentHue, 1, 1)
    end
    
    local function updateColor()
        local c = Color3.fromHSV(currentHue, currentS, currentV)
        colorpicker.value = c
        Color_Frame.BackgroundColor3 = c
        colorpicker.callback(c, currentA)
    end
    
    -- Open/close picker
    -- Only the color frame opens the picker (not the label)
    local openButton = Instance.new("TextButton")
    openButton.BackgroundTransparency = 1
    openButton.Size = UDim2.new(0, 40, 0, 20)
    openButton.Position = Color_Frame.Position
    openButton.AnchorPoint = Color_Frame.AnchorPoint
    openButton.Text = ""
    openButton.Parent = Colorpicker_Component
    openButton.ZIndex = 1203
    
    openButton.MouseButton1Click:Connect(function()
        colorpicker.isOpen = not colorpicker.isOpen
        PickerContainer.Visible = colorpicker.isOpen
        if colorpicker.isOpen then
            -- position popup relative to preview frame in screen space
            local absPos = Color_Frame.AbsolutePosition
            local absSize = Color_Frame.AbsoluteSize
            local x = absPos.X + absSize.X - 10
            local y = absPos.Y + absSize.Y + 6
            PickerContainer.Position = UDim2.fromOffset(x, y)
            PickerContainer.BackgroundTransparency = 1
            PickerContainer.Size = UDim2.new(0, 225, 0, 0)
            local fadeIn = createTween(PickerContainer, {BackgroundTransparency = 0}, 0.15)
            fadeIn:Play()
            local grow = createTween(PickerContainer, {Size = UDim2.new(0, 225, 0, 190)}, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            grow:Play()
            -- enable modal overlay to intercept clicks and block dragging
            PopupOpenCount = PopupOpenCount + 1
            ModalOverlay.Visible = true
            BlockDragging = true
        else
            local shrink = createTween(PickerContainer, {Size = UDim2.new(0, 225, 0, 0)}, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            shrink:Play()
            local fadeOut = createTween(PickerContainer, {BackgroundTransparency = 1}, 0.2)
            fadeOut:Play()
            shrink.Completed:Connect(function()
                PickerContainer.Visible = false
            end)
            PopupOpenCount = math.max(0, PopupOpenCount - 1)
            if PopupOpenCount == 0 then
                ModalOverlay.Visible = false
                BlockDragging = false
            end
        end
    end)

    -- Close when clicking outside the popup
    -- Close when clicking on the overlay (outside the popup)
    ModalOverlay.MouseButton1Click:Connect(function()
        if not colorpicker.isOpen then return end
        if draggingSV or draggingHue then return end
        colorpicker.isOpen = false
        local fadeOut = createTween(PickerContainer, {BackgroundTransparency = 1}, 0.15)
        fadeOut:Play()
        local shrink = createTween(PickerContainer, {Size = UDim2.new(0, 225, 0, 0)}, 0.15)
        shrink:Play()
        shrink.Completed:Connect(function()
            PickerContainer.Visible = false
        end)
        PopupOpenCount = math.max(0, PopupOpenCount - 1)
        if PopupOpenCount == 0 then
            ModalOverlay.Visible = false
            BlockDragging = false
        end
    end)
    
    -- Drag handling
    local draggingSV = false
    local draggingHue = false
    local draggingAlpha = false
    
    SVFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSV = true
            BlockDragging = true
            -- set initial pick on click
            local absPos = SVFrame.AbsolutePosition
            local absSize = SVFrame.AbsoluteSize
            local rx = math.clamp((input.Position.X - absPos.X) / absSize.X, 0, 1)
            local ry = math.clamp((input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
            currentS = 1 - rx
            currentV = 1 - ry
            SVPicker.Position = UDim2.new(rx, 0, ry, 0)
            updateColor()
        end
    end)
    Hue.MouseButton1Down:Connect(function(input)
        draggingHue = true
        BlockDragging = true
        -- set initial hue on click
        local absPos = Hue.AbsolutePosition
        local absSize = Hue.AbsoluteSize
        local ry = math.clamp((input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
        currentHue = ry
        HueDragger.Position = UDim2.new(0.5, 0, ry, 0)
        updateSVFrame()
        updateColor()
    end)
    
    -- Start drag when clicking alpha bar or its checker overlay
    Alpha.MouseButton1Down:Connect(function(input)
        draggingAlpha = true
        BlockDragging = true
        local absPos = Checkers.AbsolutePosition
        local absSize = Checkers.AbsoluteSize
        local ry = math.clamp((input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
        currentA = 1 - ry
        AlphaDragger.Position = UDim2.new(0.5, 0, ry, 0)
        updateColor()
    end)
    Checkers.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingAlpha = true
            BlockDragging = true
            local absPos = Checkers.AbsolutePosition
            local absSize = Checkers.AbsoluteSize
            local ry = math.clamp((input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
            currentA = 1 - ry
            AlphaDragger.Position = UDim2.new(0.5, 0, ry, 0)
            updateColor()
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSV = false
            draggingHue = false
            draggingAlpha = false
            BlockDragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
        if draggingSV then
            local absPos = SVFrame.AbsolutePosition
            local absSize = SVFrame.AbsoluteSize
            local rx = math.clamp((input.Position.X - absPos.X) / absSize.X, 0, 1)
            local ry = math.clamp((input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
            currentS = 1 - rx
            currentV = 1 - ry
            SVPicker.Position = UDim2.new(rx, 0, ry, 0)
            updateColor()
        end
        if draggingHue then
            local absPos = Hue.AbsolutePosition
            local absSize = Hue.AbsoluteSize
            local ry = math.clamp((input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
            currentHue = ry
            HueDragger.Position = UDim2.new(0.5, 0, ry, 0)
            updateSVFrame()
            updateColor()
        end
        if draggingAlpha then
            local absPos = Checkers.AbsolutePosition
            local absSize = Checkers.AbsoluteSize
            local ry = math.clamp((input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
            currentA = 1 - ry
            AlphaDragger.Position = UDim2.new(0.5, 0, ry, 0)
            updateColor()
        end
    end)
    
    -- Initialize
    do
        local h, s, v = colorpicker.value:ToHSV()
        currentHue, currentS, currentV = h, s, v
        updateSVFrame()
        SVPicker.Position = UDim2.new(currentS, 0, 1 - currentV, 0)
        HueDragger.Position = UDim2.new(0.5, 0, currentHue, 0)
        AlphaDragger.Position = UDim2.new(0.5, 0, 1 - currentA, 0)
        updateColor()
    end
    
    table.insert(section.components, colorpicker)
    return colorpicker
end

function Library:CreateDropdown(config, section)
    if not section then
        if not CurrentTab or not CurrentTab.sections.left[1] and not CurrentTab.sections.right[1] then
            error("No section created. Call CreateSection first.")
            return
        end
        section = CurrentTab.sections.left[1] or CurrentTab.sections.right[1]
    end
    
    local container = section.frame:FindFirstChild(section.position .. "_Container")
    
    local dropdown = {
        text = config.DropdownText or "Example",
        options = config.Options or {"Option 1", "Option 2", "Option 3"},
        callback = config.Callback or function() end,
        value = config.Default or config.Options[1] or "Option 1",
        isOpen = false,
        multiSelect = config.MultiSelect or false,
        selectedValues = config.MultiSelect and {} or nil
    }
    
    -- Initialize multi-select values
    if dropdown.multiSelect then
        if config.Default and type(config.Default) == "table" then
            dropdown.selectedValues = config.Default
        else
            dropdown.selectedValues = {}
        end
        -- Set initial display text for multi-select
        if #dropdown.selectedValues > 0 then
            dropdown.value = table.concat(dropdown.selectedValues, ", ")
        else
            dropdown.value = "Select Options"
        end
    end
    
    -- Create dropdown component
local Dropdown_Component = Instance.new("Frame")
Dropdown_Component.Name = "Dropdown_Component"
Dropdown_Component.BackgroundTransparency = 1
Dropdown_Component.Position = UDim2.new(0, 0, 0.09732360392808914, 0)
Dropdown_Component.BorderColor3 = Color3.fromRGB(0, 0, 0)
Dropdown_Component.Size = UDim2.new(0, 318, 0, 40)
Dropdown_Component.BorderSizePixel = 0
Dropdown_Component.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Dropdown_Component.Parent = container

local Dropdown = Instance.new("Frame")
Dropdown.AnchorPoint = Vector2.new(0.5, 0.5)
Dropdown.Name = "Dropdown"
Dropdown.Position = UDim2.new(0.4874213933944702, 0, 0.5, 0)
Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
Dropdown.Size = UDim2.new(0, 279, 0, 40)
Dropdown.BorderSizePixel = 0
Dropdown.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
Dropdown.Parent = Dropdown_Component

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Dropdown

local Dropdown_Value = Instance.new("TextLabel")
Dropdown_Value.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
Dropdown_Value.TextColor3 = Color3.fromRGB(109, 109, 109)
Dropdown_Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Dropdown_Value.Text = dropdown.value
Dropdown_Value.Name = "Dropdown_Value"
Dropdown_Value.Size = UDim2.new(0, 1, 0, 1)
Dropdown_Value.BackgroundTransparency = 1
Dropdown_Value.Position = UDim2.new(0.03831060975790024, 0, 0.32499998807907104, 0)
Dropdown_Value.BorderSizePixel = 0
Dropdown_Value.AutomaticSize = Enum.AutomaticSize.XY
Dropdown_Value.TextSize = 14
Dropdown_Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Dropdown_Value.Parent = Dropdown

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.ImageColor3 = Color3.fromRGB(109, 109, 109)
ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel.Image = "rbxassetid://95652893039727"
ImageLabel.BackgroundTransparency = 1
ImageLabel.Position = UDim2.new(0.8745519518852234, 0, 0.25, 0)
ImageLabel.Size = UDim2.new(0, 20, 0, 20)
ImageLabel.BorderSizePixel = 0
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.Parent = Dropdown
    
    -- Create dropdown container (initially hidden)
    local Dropdown_Container = Instance.new("Frame")
    Dropdown_Container.Size = UDim2.new(0, 279, 0, 0)
    Dropdown_Container.Name = "Dropdown_Container"
    Dropdown_Container.Position = UDim2.new(0.4874213933944702, 0, 0.5, 20)
    Dropdown_Container.AnchorPoint = Vector2.new(0.5, 0)
    Dropdown_Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Dropdown_Container.BorderSizePixel = 0
    Dropdown_Container.AutomaticSize = Enum.AutomaticSize.Y
    Dropdown_Container.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
    Dropdown_Container.Visible = false
    Dropdown_Container.BackgroundTransparency = 1
    Dropdown_Container.ZIndex = 1000
    Dropdown_Container.Parent = Dropdown_Component
    
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 4)
    containerCorner.Parent = Dropdown_Container

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Dropdown_Container
    
    local containerPadding = Instance.new("UIPadding")
    containerPadding.PaddingBottom = UDim.new(0, 8)
    containerPadding.PaddingTop = UDim.new(0, 5)
    containerPadding.Parent = Dropdown_Container
    
    -- Create option frames
    local optionFrames = {}
    for i, option in ipairs(dropdown.options) do
        local Frame = Instance.new("Frame")
        Frame.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
        Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Frame.Size = UDim2.new(0, 276, 0, 20)
        Frame.BorderSizePixel = 0
        Frame.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
        Frame.ZIndex = 1001
        Frame.Parent = Dropdown_Container
        
        local TextLabel = Instance.new("TextLabel")
        TextLabel.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        TextLabel.TextColor3 = Color3.fromRGB(52, 52, 52)
        TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel.Text = option
        TextLabel.AnchorPoint = Vector2.new(0, 0.5)
        TextLabel.Size = UDim2.new(0, 1, 0, 1)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Position = UDim2.new(0.03584229573607445, 0, 0.5, 0)
        TextLabel.BorderSizePixel = 0
        TextLabel.AutomaticSize = Enum.AutomaticSize.XY
        TextLabel.TextSize = 16
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.ZIndex = 1002
        TextLabel.Parent = Frame
        
        local Check_Icon = Instance.new("ImageLabel")
        Check_Icon.ImageColor3 = Library.Accent
        Check_Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Check_Icon.Name = "Check_Icon"
        Check_Icon.AnchorPoint = Vector2.new(0.5, 0.5)
        Check_Icon.Image = "rbxassetid://139958444428790"
        Check_Icon.BackgroundTransparency = 1
        Check_Icon.Position = UDim2.new(0.9070789217948914, 0, 0.5, 0)
        Check_Icon.Size = UDim2.new(0, 15, 0, 16)
        Check_Icon.BorderSizePixel = 0
        Check_Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Check_Icon.ZIndex = 1002
        Check_Icon.Parent = Frame
        
        -- Initially hide check icon and position it to the right
        Check_Icon.ImageTransparency = 1
        Check_Icon.Position = UDim2.new(1.2, 0, 0.5, 0)
        
        -- Click functionality for option
        local optionButton = Instance.new("TextButton")
        optionButton.BackgroundTransparency = 1
        optionButton.Size = UDim2.new(1, 0, 1, 0)
        optionButton.Text = ""
        optionButton.ZIndex = 1003
        optionButton.Parent = Frame
        
        optionButton.MouseButton1Click:Connect(function()
            if dropdown.multiSelect then
                -- Multi-select logic
                local isSelected = table.find(dropdown.selectedValues, option)
                
                if isSelected then
                    -- Remove from selection
                    table.remove(dropdown.selectedValues, isSelected)
                else
                    -- Add to selection
                    table.insert(dropdown.selectedValues, option)
                end
                
                -- Update display text
                if #dropdown.selectedValues > 0 then
                    dropdown.value = table.concat(dropdown.selectedValues, ", ")
                    Dropdown_Value.Text = dropdown.value
                else
                    dropdown.value = "Select Options"
                    Dropdown_Value.Text = dropdown.value
                end
                
                -- Update check icon for this option
                local checkIcon = Frame:FindFirstChild("Check_Icon")
                local textLabel = Frame:FindFirstChild("TextLabel")
                
                if isSelected then
                    -- Unselected - hide check icon with fast fade out
                    textLabel.TextColor3 = Color3.fromRGB(52, 52, 52)
                    
                    local slideOut = createTween(checkIcon, {
                        Position = UDim2.new(1.2, 0, 0.5, 0),
                        ImageTransparency = 1
                    }, 0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
                    slideOut:Play()
                else
                    -- Selected - show check icon with smooth animation
                    textLabel.TextColor3 = Library.Accent
                    
                    local slideIn = createTween(checkIcon, {
                        Position = UDim2.new(0.9070789217948914, 0, 0.5, 0),
                        ImageTransparency = 0
                    }, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                    slideIn:Play()
                end
                
                dropdown.callback(dropdown.selectedValues)
            else
                -- Single-select logic
                dropdown.value = option
                Dropdown_Value.Text = option
                
                -- Update all option frames
                for j, frame in ipairs(optionFrames) do
                    local checkIcon = frame:FindFirstChild("Check_Icon")
                    local textLabel = frame:FindFirstChild("TextLabel")
                    
                    if j == i then
                        -- Selected option - show check icon with smooth animation
                        textLabel.TextColor3 = Library.Accent
                        
                        -- Smooth slide in animation for check icon
                        local slideIn = createTween(checkIcon, {
                            Position = UDim2.new(0.9070789217948914, 0, 0.5, 0),
                            ImageTransparency = 0
                        }, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                        slideIn:Play()
                    else
                        -- Unselected option - hide check icon with fast fade out
                        textLabel.TextColor3 = Color3.fromRGB(52, 52, 52)
                        
                        -- Fast fade out and slide out animation
                        local slideOut = createTween(checkIcon, {
                            Position = UDim2.new(1.2, 0, 0.5, 0),
                            ImageTransparency = 1
                        }, 0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
                        slideOut:Play()
                    end
                end
                
                -- Close dropdown for single-select
                dropdown.isOpen = false
                Dropdown_Container.Size = UDim2.new(0, 279, 0, 0)
                Dropdown_Container.Visible = false
                
                -- Rotate arrow back
                local arrowTween = createTween(ImageLabel, {
                    Rotation = 0
                }, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                arrowTween:Play()
                
                -- Ensure overlay state resets so UI is usable again
                PopupOpenCount = math.max(0, PopupOpenCount - 1)
                if PopupOpenCount == 0 then
                    ModalOverlay.Visible = false
                    BlockDragging = false
                end
                if dropdown._overlayConn then dropdown._overlayConn:Disconnect() dropdown._overlayConn = nil end
                
                dropdown.callback(option)
            end
        end)
        
        table.insert(optionFrames, Frame)
    end
    
    -- Set initial selected options
    if dropdown.multiSelect then
        for i, option in ipairs(dropdown.options) do
            if table.find(dropdown.selectedValues, option) then
                local frame = optionFrames[i]
                local checkIcon = frame:FindFirstChild("Check_Icon")
                local textLabel = frame:FindFirstChild("TextLabel")
                
                textLabel.TextColor3 = Library.Accent
                checkIcon.Position = UDim2.new(0.9070789217948914, 0, 0.5, 0)
                checkIcon.ImageTransparency = 0
            end
        end
    else
        if dropdown.value then
            for i, option in ipairs(dropdown.options) do
                if option == dropdown.value then
                    local frame = optionFrames[i]
                    local checkIcon = frame:FindFirstChild("Check_Icon")
                    local textLabel = frame:FindFirstChild("TextLabel")
                    
                    textLabel.TextColor3 = Library.Accent
                    checkIcon.Position = UDim2.new(0.9070789217948914, 0, 0.5, 0)
                    checkIcon.ImageTransparency = 0
                end
            end
        end
    end
    
    -- Click functionality for dropdown button
    local dropdownButton = Instance.new("TextButton")
    dropdownButton.BackgroundTransparency = 1
    dropdownButton.Size = UDim2.new(1, 0, 1, 0)
    dropdownButton.Text = ""
    dropdownButton.Parent = Dropdown_Component
    
    dropdownButton.MouseButton1Click:Connect(function()
        dropdown.isOpen = not dropdown.isOpen
        
        if dropdown.isOpen then
            -- Open dropdown with ultra-smooth animation
            Dropdown_Container.Visible = true
            Dropdown_Container.Size = UDim2.new(0, 279, 0, 0)
            Dropdown_Container.BackgroundTransparency = 1
            PopupOpenCount = PopupOpenCount + 1
            ModalOverlay.Visible = true
            BlockDragging = true
            
            -- Fade in background first
            local fadeIn = createTween(Dropdown_Container, {
                BackgroundTransparency = 0
            }, 0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            fadeIn:Play()
            
            -- Then expand size with smooth easing
            local openTween = createTween(Dropdown_Container, {
                Size = UDim2.new(0, 279, 0, #dropdown.options * 20 + 13)
            }, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            openTween:Play()
            
            -- Rotate arrow with smooth easing
            local arrowTween = createTween(ImageLabel, {
                Rotation = 180
            }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            arrowTween:Play()
            -- Allow clicking overlay to close dropdown
            if dropdown._overlayConn then dropdown._overlayConn:Disconnect() dropdown._overlayConn = nil end
            dropdown._overlayConn = ModalOverlay.MouseButton1Click:Connect(function()
                if not dropdown.isOpen then return end
                dropdown.isOpen = false
                local closeTween = createTween(Dropdown_Container, { Size = UDim2.new(0, 279, 0, 0) }, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)
                closeTween:Play()
                local fadeOut2 = createTween(Dropdown_Container, { BackgroundTransparency = 1 }, 0.2)
                fadeOut2:Play()
                closeTween.Completed:Connect(function()
                    Dropdown_Container.Visible = false
                    PopupOpenCount = math.max(0, PopupOpenCount - 1)
                    if PopupOpenCount == 0 then
                        ModalOverlay.Visible = false
                        BlockDragging = false
                    end
                end)
                local arrowBack = createTween(ImageLabel, { Rotation = 0 }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                arrowBack:Play()
                if dropdown._overlayConn then dropdown._overlayConn:Disconnect() dropdown._overlayConn = nil end
            end)
        else
            -- Close dropdown with ultra-smooth animation
            local closeTween = createTween(Dropdown_Container, {
                Size = UDim2.new(0, 279, 0, 0)
            }, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            closeTween:Play()
            
            -- Fade out background
            local fadeOut = createTween(Dropdown_Container, {
                BackgroundTransparency = 1
            }, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
            fadeOut:Play()
            
            closeTween.Completed:Connect(function()
                Dropdown_Container.Visible = false
                PopupOpenCount = math.max(0, PopupOpenCount - 1)
                if PopupOpenCount == 0 then
                    ModalOverlay.Visible = false
                    BlockDragging = false
                end
            end)
            
            -- Rotate arrow back with smooth easing
            local arrowTween = createTween(ImageLabel, {
                Rotation = 0
            }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            arrowTween:Play()
            if dropdown._overlayConn then dropdown._overlayConn:Disconnect() dropdown._overlayConn = nil end
        end
    end)
    
    table.insert(section.components, dropdown)
    return dropdown
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
            local listeningTween = createTween(keybindButton, {TextColor3 = Library.Accent}, 0.2)
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

-- Watermark System
local Watermark_Frame = nil
local WatermarkScreenGui = nil
local WatermarkEnabled = true
local WatermarkDragging = false
local Watermark_Icon = nil
local Watermark_Inline = nil

function Library:CreateWatermark(cheatName)
    if Watermark_Frame then return end
    
    -- Create a separate ScreenGui for watermark
    WatermarkScreenGui = Instance.new("ScreenGui")
    WatermarkScreenGui.Name = "WatermarkScreenGui"
    WatermarkScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    WatermarkScreenGui.ResetOnSpawn = false
    WatermarkScreenGui.Parent = game:GetService("CoreGui")
    
    -- Create watermark frame
    Watermark_Frame = Instance.new("Frame")
    Watermark_Frame.Size = UDim2.new(0, 150, 0, 45)
    Watermark_Frame.Name = "Watermark_Frame"
    Watermark_Frame.Position = UDim2.new(0.011217948980629444, 0, 0.014925372786819935, 0)
    Watermark_Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Watermark_Frame.BorderSizePixel = 0
    Watermark_Frame.AutomaticSize = Enum.AutomaticSize.XY
    Watermark_Frame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Watermark_Frame.Visible = WatermarkEnabled
    Watermark_Frame.Parent = WatermarkScreenGui
    
    -- Add corner radius
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Watermark_Frame
    
    -- Create library name label
    local Libary_Name = Instance.new("TextLabel")
    Libary_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
    Libary_Name.TextColor3 = Color3.fromRGB(255, 255, 255)
    Libary_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Libary_Name.Text = cheatName or "STARHUB" -- Use provided cheat name or default
    Libary_Name.Name = "Libary_Name"
    Libary_Name.AnchorPoint = Vector2.new(0, 0.5)
    Libary_Name.Size = UDim2.new(0, 1, 0, 1)
    Libary_Name.BackgroundTransparency = 1
    Libary_Name.Position = UDim2.new(0, 48, 0.5, 0)
    Libary_Name.BorderSizePixel = 0
    Libary_Name.AutomaticSize = Enum.AutomaticSize.XY
    Libary_Name.TextSize = 21
    Libary_Name.TextXAlignment = Enum.TextXAlignment.Left
    Libary_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Libary_Name.Parent = Watermark_Frame
    
    -- Create library icon
    Watermark_Icon = Instance.new("ImageLabel")
    Watermark_Icon.ImageColor3 = Library.Accent
    Watermark_Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Watermark_Icon.Name = "Watermark_Icon"
    Watermark_Icon.AnchorPoint = Vector2.new(0.5, 0.5)
    Watermark_Icon.Image = "rbxassetid://132964100967987"
    Watermark_Icon.BackgroundTransparency = 1
    Watermark_Icon.Position = UDim2.new(0.17633333802223206, 1, 0.4620000123977661, 0)
    Watermark_Icon.Size = UDim2.new(0, 20, 0, 20)
    Watermark_Icon.BorderSizePixel = 0
    Watermark_Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Watermark_Icon.Parent = Watermark_Frame
    
    -- Create inline accent
    Watermark_Inline = Instance.new("Frame")
    Watermark_Inline.BorderColor3 = Library.Accent
    Watermark_Inline.AnchorPoint = Vector2.new(0, 1)
    Watermark_Inline.Name = "Inline"
    Watermark_Inline.Position = UDim2.new(0, 0, 1, 0)
    Watermark_Inline.Size = UDim2.new(1, 1, 0, 4)
    Watermark_Inline.BorderSizePixel = 0
    Watermark_Inline.AutomaticSize = Enum.AutomaticSize.XY
    Watermark_Inline.BackgroundColor3 = Library.Accent
    Watermark_Inline.Parent = Watermark_Frame
    
    -- Add corner radius to inline
    local InlineCorner = Instance.new("UICorner")
    InlineCorner.CornerRadius = UDim.new(0, 6)
    InlineCorner.Parent = Watermark_Inline
    
    -- Make watermark draggable when menu is open
    local dragConnection
    local function updateDragging()
        if dragConnection then
            dragConnection:Disconnect()
            dragConnection = nil
        end
        
        if MainFrame.Visible and WatermarkEnabled then
            -- Enable dragging when menu is open
            dragConnection = makeDraggable(Watermark_Frame)
        end
    end
    
    -- Update dragging state when main frame visibility changes
    MainFrame:GetPropertyChangedSignal("Visible"):Connect(updateDragging)
    updateDragging() -- Initial setup
    
    -- Auto-scale width based on text content
    local function updateWatermarkSize()
        if not Watermark_Frame or not WatermarkEnabled then return end
        
        -- Get text bounds
        local textBounds = Libary_Name.TextBounds
        local iconWidth = 20
        local padding = 24 -- 12px on each side
        local minWidth = 120
        local maxWidth = 300
        
        local calculatedWidth = math.max(minWidth, math.min(maxWidth, textBounds.X + iconWidth + padding))
        
        -- Update frame size
        Watermark_Frame.Size = UDim2.new(0, calculatedWidth, 0, 45)
        
        -- Check if watermark is going out of screen bounds
        local screenSize = game:GetService("GuiService"):GetGuiInset()
        local watermarkPos = Watermark_Frame.AbsolutePosition
        local watermarkSize = Watermark_Frame.AbsoluteSize
        
        if watermarkPos.X + watermarkSize.X > workspace.CurrentCamera.ViewportSize.X - 10 then
            -- Move watermark to left side if it's going out of bounds
            Watermark_Frame.Position = UDim2.new(0, 10, 0, watermarkPos.Y)
        end
    end
    
    -- Update size when text changes
    Libary_Name:GetPropertyChangedSignal("Text"):Connect(updateWatermarkSize)
    updateWatermarkSize() -- Initial sizing
    
    return Watermark_Frame
end

function Library:ToggleWatermark(enabled)
    WatermarkEnabled = enabled
    if Watermark_Frame then
        Watermark_Frame.Visible = enabled
    end
end


-- Notification System
local NotificationContainer = nil
local NotificationScreenGui = nil
local ActiveNotifications = {}

function Library:CreateNotification(config)
    local notification = {
        text = config.Text or "Notification",
        type = config.Type or "success", -- success, warning, error, custom
        duration = config.Duration or 5,
        color = config.Color or nil, -- Custom color for custom type
        callback = config.Callback or function() end,
        onClose = config.OnClose or function() end,
        frame = nil,
        progressBar = nil,
        textLabel = nil,
        isClosing = false
    }
    
    -- Create notification container if it doesn't exist (separate from main UI)
    if not NotificationContainer then
        -- Create a separate ScreenGui just for notifications
        NotificationScreenGui = Instance.new("ScreenGui")
        NotificationScreenGui.Name = "NotificationScreenGui"
        NotificationScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
        NotificationScreenGui.ResetOnSpawn = false
        NotificationScreenGui.Parent = game:GetService("CoreGui")
        
        NotificationContainer = Instance.new("Frame")
        NotificationContainer.Name = "NotificationContainer"
        NotificationContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
        NotificationContainer.Size = UDim2.new(0, 1, 0, 1)
        NotificationContainer.BorderSizePixel = 0
        NotificationContainer.BackgroundTransparency = 1
        NotificationContainer.Position = UDim2.new(0.8169070482254028, 0, 0.014925372786819935, 0)
        NotificationContainer.AutomaticSize = Enum.AutomaticSize.XY
        NotificationContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationContainer.Visible = true -- Always visible, independent of main UI
        NotificationContainer.Parent = NotificationScreenGui
        
        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Padding = UDim.new(0, 4)
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Parent = NotificationContainer
    end
    
    -- Determine colors based on type with better contrast
    local backgroundColor, textColor, progressColor
    if notification.type == "success" then
        backgroundColor = Color3.fromRGB(15, 15, 15)
        textColor = Color3.fromRGB(1, 255, 141)
        progressColor = Color3.fromRGB(1, 255, 141)
    elseif notification.type == "warning" then
        backgroundColor = Color3.fromRGB(15, 15, 15)
        textColor = Color3.fromRGB(255, 193, 7)
        progressColor = Color3.fromRGB(255, 193, 7)
    elseif notification.type == "error" then
        backgroundColor = Color3.fromRGB(15, 15, 15)
        textColor = Color3.fromRGB(220, 53, 69)
        progressColor = Color3.fromRGB(220, 53, 69)
    elseif notification.type == "custom" and notification.color then
        backgroundColor = Color3.fromRGB(15, 15, 15)
        textColor = notification.color
        progressColor = notification.color
    else
        -- Default to success if custom type without color
        backgroundColor = Color3.fromRGB(15, 15, 15)
        textColor = Color3.fromRGB(1, 255, 141)
        progressColor = Color3.fromRGB(1, 255, 141)
    end
    
    -- Create notification frame with fixed sizing
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Name = "Notification_Frame"
    notificationFrame.Position = UDim2.new(0, 0, 0.8371886014938354, 0)
    notificationFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    notificationFrame.Size = UDim2.new(0, 300, 0, 60) -- Fixed size
    notificationFrame.BorderSizePixel = 0
    notificationFrame.BackgroundColor3 = backgroundColor
    notificationFrame.Parent = NotificationContainer
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = notificationFrame
    
    -- Add subtle glow effect
    local glowEffect = Instance.new("UIStroke")
    glowEffect.Color = progressColor
    glowEffect.Transparency = 0.7
    glowEffect.Thickness = 1
    glowEffect.Parent = notificationFrame
    
    -- Progress background with proper positioning
    local progressBG = Instance.new("Frame")
    progressBG.Name = "Progress_BG"
    progressBG.AnchorPoint = Vector2.new(0, 1) -- Anchor to bottom
    progressBG.Position = UDim2.new(0, 12, 1, -8) -- 12px from left, 8px from bottom
    progressBG.BorderColor3 = Color3.fromRGB(0, 0, 0)
    progressBG.Size = UDim2.new(1, -24, 0, 4) -- Full width minus padding, 4px height
    progressBG.BorderSizePixel = 0
    progressBG.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    progressBG.Parent = notificationFrame
    
    local progressBGCorner = Instance.new("UICorner")
    progressBGCorner.CornerRadius = UDim.new(0, 50)
    progressBGCorner.Parent = progressBG
    
    -- Progress bar with proper sizing
    local progressBar = Instance.new("Frame")
    progressBar.AnchorPoint = Vector2.new(0, 0.5)
    progressBar.Name = "Progress_Bar"
    progressBar.Position = UDim2.new(0, 0, 0.5, 0)
    progressBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
    progressBar.Size = UDim2.new(0, 0, 1, 0) -- Start at 0 width, full height of progressBG
    progressBar.BorderSizePixel = 0
    progressBar.BackgroundColor3 = progressColor
    progressBar.Parent = progressBG
    
    local progressBarCorner = Instance.new("UICorner")
    progressBarCorner.CornerRadius = UDim.new(0, 50)
    progressBarCorner.Parent = progressBar
    
    -- Add gradient for better visual appeal
    local progressGradient = Instance.new("UIGradient")
    if notification.type == "success" then
        progressGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(1, 255, 141)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 98, 54))
        }
    elseif notification.type == "warning" then
        progressGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 193, 7)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 152, 0))
        }
    elseif notification.type == "error" then
        progressGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 53, 69)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(183, 28, 28))
        }
    elseif notification.type == "custom" and notification.color then
        local h, s, v = notification.color:ToHSV()
        local darkerColor = Color3.fromHSV(h, s, math.max(0, v - 0.3))
        progressGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, notification.color),
            ColorSequenceKeypoint.new(1, darkerColor)
        }
    else
        progressGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(1, 255, 141)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 98, 54))
        }
    end
    progressGradient.Parent = progressBar
    
    -- Text label with fixed sizing
    local textLabel = Instance.new("TextLabel")
    textLabel.RichText = true
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    
    -- Format text with type prefix
    local typePrefix = ""
    if notification.type == "success" then
        typePrefix = '<font color="#01ff8d">SUCCESS</font> '
    elseif notification.type == "warning" then
        typePrefix = '<font color="#ffc107">WARNING</font> '
    elseif notification.type == "error" then
        typePrefix = '<font color="#dc3545">ERROR</font> '
    elseif notification.type == "custom" and notification.color then
        local hexColor = string.format("#%02x%02x%02x", 
            math.floor(notification.color.R * 255),
            math.floor(notification.color.G * 255),
            math.floor(notification.color.B * 255)
        )
        typePrefix = '<font color="' .. hexColor .. '">CUSTOM</font> '
    else
        typePrefix = '<font color="#01ff8d">SUCCESS</font> '
    end
    
    textLabel.Text = typePrefix .. notification.text
    textLabel.Size = UDim2.new(1, -24, 0, 40) -- Fixed height, full width minus padding
    textLabel.AnchorPoint = Vector2.new(0, 0)
    textLabel.BorderSizePixel = 0
    textLabel.BackgroundTransparency = 1
    textLabel.Position = UDim2.new(0, 12, 0, 10) -- 12px padding from left, 10px from top
    textLabel.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    textLabel.TextSize = 14
    textLabel.TextWrapped = true -- Allow text wrapping
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Parent = notificationFrame
    
    -- Store references
    notification.frame = notificationFrame
    notification.progressBar = progressBar
    notification.textLabel = textLabel
    
    -- Add to active notifications
    table.insert(ActiveNotifications, notification)
    
    -- Simple appear animation
    notificationFrame.Size = UDim2.new(0, 0, 0, 60)
    notificationFrame.BackgroundTransparency = 1
    textLabel.TextTransparency = 1
    progressBar.Size = UDim2.new(0, 0, 1, 0) -- Start at 0 width
    progressBar.BackgroundTransparency = 0
    
    -- Simple slide in animation
    local slideIn = createTween(notificationFrame, {
        Size = UDim2.new(0, 300, 0, 60),
        BackgroundTransparency = 0
    }, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    slideIn:Play()
    
    local textFadeIn = createTween(textLabel, {
        TextTransparency = 0
    }, 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    textFadeIn:Play()
    
    -- Progress bar animation - moves from left to right
    local progressTween = createTween(progressBar, {
        Size = UDim2.new(1, 0, 1, 0) -- Full width of progressBG
    }, notification.duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    progressTween:Play()
    
    -- Auto-close after duration
    task.spawn(function()
        task.wait(notification.duration)
        if not notification.isClosing then
            Library:CloseNotification(notification)
        end
    end)
    
    -- Simple click to close functionality
    local clickButton = Instance.new("TextButton")
    clickButton.BackgroundTransparency = 1
    clickButton.Size = UDim2.new(1, 0, 1, 0)
    clickButton.Text = ""
    clickButton.Parent = notificationFrame
    
    clickButton.MouseButton1Click:Connect(function()
        if not notification.isClosing then
            notification.callback(notification)
            Library:CloseNotification(notification)
        end
    end)
    
    return notification
end

function Library:CloseNotification(notification)
    if notification.isClosing then return end
    notification.isClosing = true
    
    -- Call onClose callback
    notification.onClose(notification)
    
    -- Simple disappear animation
    local fadeOut = createTween(notification.frame, {
        Size = UDim2.new(0, 0, 0, 60),
        BackgroundTransparency = 1
    }, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
    fadeOut:Play()
    
    local textFadeOut = createTween(notification.textLabel, {
        TextTransparency = 1
    }, 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
    textFadeOut:Play()
    
    fadeOut.Completed:Connect(function()
        notification.frame:Destroy()
        -- Remove from active notifications
        for i, notif in ipairs(ActiveNotifications) do
            if notif == notification then
                table.remove(ActiveNotifications, i)
                break
            end
        end
    end)
end

function Library:CloseAllNotifications()
    for _, notification in ipairs(ActiveNotifications) do
        Library:CloseNotification(notification)
    end
end

-- Convenience methods for different notification types
function Library:NotifySuccess(text, duration, callback, onClose)
    return Library:CreateNotification({
        Text = text,
        Type = "success",
        Duration = duration or 5,
        Callback = callback or function() end,
        OnClose = onClose or function() end
    })
end

function Library:NotifyWarning(text, duration, callback, onClose)
    return Library:CreateNotification({
        Text = text,
        Type = "warning",
        Duration = duration or 5,
        Callback = callback or function() end,
        OnClose = onClose or function() end
    })
end

function Library:NotifyError(text, duration, callback, onClose)
    return Library:CreateNotification({
        Text = text,
        Type = "error",
        Duration = duration or 5,
        Callback = callback or function() end,
        OnClose = onClose or function() end
    })
end

function Library:NotifyCustom(text, color, duration, callback, onClose)
    return Library:CreateNotification({
        Text = text,
        Type = "custom",
        Color = color,
        Duration = duration or 5,
        Callback = callback or function() end,
        OnClose = onClose or function() end
    })
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
    Watermark_Frame = nil
    WatermarkScreenGui = nil
    WatermarkEnabled = true
    WatermarkDragging = false
    Watermark_Icon = nil
    Watermark_Inline = nil
    NotificationContainer = nil
    ActiveNotifications = {}
    
    -- Recreate the main ScreenGui in CoreGui
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("CoreGui")
    
    -- Recreate notification ScreenGui (separate from main UI)
    NotificationScreenGui = Instance.new("ScreenGui")
    NotificationScreenGui.Name = "NotificationScreenGui"
    NotificationScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    NotificationScreenGui.ResetOnSpawn = false
    NotificationScreenGui.Parent = game:GetService("CoreGui")
    
    -- Recreate watermark ScreenGui (separate from main UI)
    WatermarkScreenGui = Instance.new("ScreenGui")
    WatermarkScreenGui.Name = "WatermarkScreenGui"
    WatermarkScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    WatermarkScreenGui.ResetOnSpawn = false
    WatermarkScreenGui.Parent = game:GetService("CoreGui")
    
    -- Recreate Modal overlay
    ModalOverlay = Instance.new("TextButton")
    ModalOverlay.Name = "ModalOverlay"
    ModalOverlay.BackgroundTransparency = 1
    ModalOverlay.Text = ""
    ModalOverlay.AutoButtonColor = false
    ModalOverlay.Visible = false
    ModalOverlay.Size = UDim2.fromScale(1, 1)
    ModalOverlay.Position = UDim2.fromOffset(0, 0)
    ModalOverlay.ZIndex = 999
    ModalOverlay.Parent = ScreenGui
    
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


    local UIScale = Instance.new("UIScale")
    UIScale.Parent = MainFrame
    

    ScreenGui.Enabled = true
MainFrame.Visible = true

    -- Recreate notification container in separate ScreenGui
    NotificationContainer = Instance.new("Frame")
    NotificationContainer.Name = "NotificationContainer"
    NotificationContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    NotificationContainer.Size = UDim2.new(0, 1, 0, 1)
    NotificationContainer.BorderSizePixel = 0
    NotificationContainer.BackgroundTransparency = 1
    NotificationContainer.Position = UDim2.new(0.8169070482254028, 0, 0.014925372786819935, 0)
    NotificationContainer.AutomaticSize = Enum.AutomaticSize.XY
    NotificationContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NotificationContainer.Visible = true
    NotificationContainer.Parent = NotificationScreenGui
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 4)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = NotificationContainer

    -- Recreate watermark with cheat name
    Library:CreateWatermark(Libary_Name and Libary_Name.Text)

    makeDraggable(MainFrame)

    
    end


return Library
