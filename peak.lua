
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

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
local Notifications = {}
local AccentColor = Color3.fromRGB(125, 69, 220)

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
local function CreateNotification(icon, title, description, time)
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 300, 0, 60)
    notification.Position = UDim2.new(1, -320, 0, 10 + (#Notifications * 70))
    notification.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    notification.BorderSizePixel = 0
    notification.Parent = game.CoreGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notification
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = AccentColor
    stroke.Thickness = 1
    stroke.Parent = notification
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 30, 0, 30)
    iconLabel.Position = UDim2.new(0, 10, 0.5, -15)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon or "🔔"
    iconLabel.TextColor3 = AccentColor
    iconLabel.TextSize = 16
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Parent = notification
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -50, 0, 20)
    titleLabel.Position = UDim2.new(0, 50, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notification
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -50, 0, 20)
    descLabel.Position = UDim2.new(0, 50, 0, 30)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = description
    descLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    descLabel.TextSize = 12
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = notification
    
    table.insert(Notifications, notification)
    
    task.spawn(function()
        task.wait(time or 3)
        local tween = TweenService:Create(notification, TweenInfo.new(0.3), {Position = UDim2.new(1, 0, 0, notification.Position.Y.Offset)})
        tween:Play()
        tween.Completed:Connect(function()
            notification:Destroy()
            table.remove(Notifications, table.find(Notifications, notification))
        end)
    end)
end

local function CreateNewText(text)
    return text
end

-- Window creation function
function libary:CreateWindow(config)
    local config = config or {}
    local libary_config = config.libary_config or {}
    
    -- Create main screen gui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CharlieWareUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.CoreGui
    
    -- Create main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 563, 0, 400)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame
    
    -- Create header
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 40)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    header.BorderSizePixel = 0
    header.Parent = mainFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 8)
    headerCorner.Parent = header
    
    -- Library name
    local libName = Instance.new("TextLabel")
    libName.Name = "Libary_Name"
    libName.Size = UDim2.new(0, 200, 1, 0)
    libName.Position = UDim2.new(0, 12, 0, 0)
    libName.BackgroundTransparency = 1
    libName.Text = libary_config.Libary_Name or "CharlieWare"
    libName.TextColor3 = Color3.fromRGB(255, 255, 255)
    libName.TextSize = 15
    libName.Font = Enum.Font.GothamBold
    libName.TextXAlignment = Enum.TextXAlignment.Left
    libName.Parent = header
    
    -- Tab container
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(0, 300, 1, 0)
    tabContainer.Position = UDim2.new(1, -312, 0, 0)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = header
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.Parent = tabContainer
    
    -- Content area
    local contentArea = Instance.new("ScrollingFrame")
    contentArea.Name = "ContentArea"
    contentArea.Size = UDim2.new(1, -24, 1, -68)
    contentArea.Position = UDim2.new(0, 12, 0, 52)
    contentArea.BackgroundTransparency = 1
    contentArea.BorderSizePixel = 0
    contentArea.ScrollBarThickness = 4
    contentArea.ScrollBarImageColor3 = AccentColor
    contentArea.Parent = mainFrame
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.FillDirection = Enum.FillDirection.Horizontal
    contentLayout.Padding = UDim.new(0, 16)
    contentLayout.Parent = contentArea
    
    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingTop = UDim.new(0, 12)
    contentPadding.PaddingLeft = UDim.new(0, 12)
    contentPadding.Parent = contentArea
    
    -- Footer
    local footer = Instance.new("Frame")
    footer.Name = "Footer"
    footer.Size = UDim2.new(1, 0, 0, 28)
    footer.Position = UDim2.new(0, 0, 1, -28)
    footer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    footer.BorderSizePixel = 0
    footer.Parent = mainFrame
    
    local footerCorner = Instance.new("UICorner")
    footerCorner.CornerRadius = UDim.new(0, 8)
    footerCorner.Parent = footer
    
    local footerText = Instance.new("TextLabel")
    footerText.Name = "FooterText"
    footerText.Size = UDim2.new(0, 200, 1, 0)
    footerText.Position = UDim2.new(0, 12, 0, 0)
    footerText.BackgroundTransparency = 1
    footerText.Text = libary_config.Footer_Left_Text or "CharlieWare"
    footerText.TextColor3 = Color3.fromRGB(255, 255, 255)
    footerText.TextSize = 12
    footerText.Font = Enum.Font.Gotham
    footerText.TextXAlignment = Enum.TextXAlignment.Left
    footerText.Parent = footer
    
    -- Make draggable
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Toggle visibility
    local visible = true
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode[libary_config.interface_keybind or "Insert"] then
            visible = not visible
            mainFrame.Visible = visible
        end
    end)
    
    local window = {
        _screenGui = screenGui,
        _mainFrame = mainFrame,
        _contentArea = contentArea,
        _tabContainer = tabContainer,
        _tabs = {},
        _currentTab = nil
    }
    
    setmetatable(window, Window)
    table.insert(Windows, window)
    CurrentWindow = window
    
    return window
end


local Window = {}
Window.__index = Window

local Tab = {}
Tab.__index = Tab


local Section = {}
Section.__index = Section

local MainFrame = Instance.new("Frame")
MainFrame.ClipsDescendants = true
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Name = "MainFrame"
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 563, 0, 400)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Parent = game.StarterGui.ReCreations.Interfaces.Charlieware.ScreenGui.BG_BLUR

local Header = Instance.new("Frame")
Header.AnchorPoint = Vector2.new(0.5, 0)
Header.Name = "Header"
Header.Position = UDim2.new(0.5, 0, 0, 0)
Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
Header.Size = UDim2.new(0, 563, 0, 40)
Header.BorderSizePixel = 0
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Header.Parent = MainFrame

local Libary_Name = Instance.new("TextLabel")
Libary_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Libary_Name.TextStrokeTransparency = 0.800000011920929
Libary_Name.AnchorPoint = Vector2.new(0, 0.5)
Libary_Name.TextSize = 15
Libary_Name.Size = UDim2.new(0, 1, 0, 1)
Libary_Name.RichText = true
Libary_Name.TextColor3 = Color3.fromRGB(255, 255, 255)
Libary_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Libary_Name.Text = 'examplelibary<font color="#7D45DC">.rbx</font>'
Libary_Name.Name = "Libary_Name"
Libary_Name.BackgroundTransparency = 1
Libary_Name.Position = UDim2.new(0, 12, 0.5, 0)
Libary_Name.TextWrapped = true
Libary_Name.BorderSizePixel = 0
Libary_Name.AutomaticSize = Enum.AutomaticSize.XY
Libary_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Libary_Name.Parent = Header

local Container = Instance.new("Frame")
Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
Container.AnchorPoint = Vector2.new(1, 0.5)
Container.BackgroundTransparency = 12
Container.Position = UDim2.new(1, 0, 0.5, 0)
Container.Name = "Container"
Container.Size = UDim2.new(0, 425, 0, 40)
Container.BorderSizePixel = 0
Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container.Parent = Header

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout.Padding = UDim.new(0, 18)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Container

local Tab = Instance.new("Frame")
Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab.Name = "Tab"
Tab.BackgroundTransparency = 1
Tab.Position = UDim2.new(0.12941177189350128, 0, 0, 0)
Tab.Size = UDim2.new(0, 47, 0, 40)
Tab.BorderSizePixel = 0
Tab.AutomaticSize = Enum.AutomaticSize.X
Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tab.Parent = Container

local Inline = Instance.new("Frame")
Inline.AnchorPoint = Vector2.new(0, 1)
Inline.Name = "Inline"
Inline.Position = UDim2.new(0, 0, 1, 0)
Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inline.Size = UDim2.new(1, 1, 0, 4)
Inline.BorderSizePixel = 0
Inline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Inline.Parent = Tab

local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = 90
UIGradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.436, 0.6625000238418579),
	NumberSequenceKeypoint.new(1, 0)
}
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 69, 220)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 69, 220))
}
UIGradient.Parent = Inline

local Tab_Name = Instance.new("TextLabel")
Tab_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Tab_Name.TextStrokeTransparency = 0.8999999761581421
Tab_Name.AnchorPoint = Vector2.new(0.5, 0.5)
Tab_Name.TextSize = 15
Tab_Name.Size = UDim2.new(0, 1, 0, 1)
Tab_Name.RichText = true
Tab_Name.TextColor3 = Color3.fromRGB(125, 69, 220)
Tab_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab_Name.Text = "Home"
Tab_Name.Name = "Tab_Name"
Tab_Name.BackgroundTransparency = 1
Tab_Name.Position = UDim2.new(0.5, 0, 0.5, 0)
Tab_Name.TextWrapped = true
Tab_Name.BorderSizePixel = 0
Tab_Name.AutomaticSize = Enum.AutomaticSize.XY
Tab_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tab_Name.Parent = Tab

local Tab = Instance.new("Frame")
Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab.Name = "Tab"
Tab.BackgroundTransparency = 1
Tab.Position = UDim2.new(0.12941177189350128, 0, 0, 0)
Tab.Size = UDim2.new(0, 47, 0, 40)
Tab.BorderSizePixel = 0
Tab.AutomaticSize = Enum.AutomaticSize.X
Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tab.Parent = Container

local Tab_Name = Instance.new("TextLabel")
Tab_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Tab_Name.TextStrokeTransparency = 0.8999999761581421
Tab_Name.AnchorPoint = Vector2.new(0.5, 0.5)
Tab_Name.TextSize = 15
Tab_Name.Size = UDim2.new(0, 1, 0, 1)
Tab_Name.RichText = true
Tab_Name.TextColor3 = Color3.fromRGB(169, 169, 169)
Tab_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab_Name.Text = "Settings"
Tab_Name.Name = "Tab_Name"
Tab_Name.BackgroundTransparency = 1
Tab_Name.Position = UDim2.new(0.5, 0, 0.5, 0)
Tab_Name.TextWrapped = true
Tab_Name.BorderSizePixel = 0
Tab_Name.AutomaticSize = Enum.AutomaticSize.XY
Tab_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tab_Name.Parent = Tab

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingRight = UDim.new(0, 12)
UIPadding.Parent = Container

local Footer = Instance.new("Frame")
Footer.AnchorPoint = Vector2.new(0.5, 1)
Footer.Name = "Footer"
Footer.Position = UDim2.new(0.5, 0, 0.9999998211860657, 0)
Footer.BorderColor3 = Color3.fromRGB(0, 0, 0)
Footer.Size = UDim2.new(0, 563, 0, 28)
Footer.BorderSizePixel = 0
Footer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Footer.Parent = MainFrame

local footer_left_label = Instance.new("TextLabel")
footer_left_label.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
footer_left_label.TextStrokeTransparency = 0.800000011920929
footer_left_label.AnchorPoint = Vector2.new(0, 0.5)
footer_left_label.TextSize = 15
footer_left_label.Size = UDim2.new(0, 1, 0, 1)
footer_left_label.RichText = true
footer_left_label.TextColor3 = Color3.fromRGB(255, 255, 255)
footer_left_label.BorderColor3 = Color3.fromRGB(0, 0, 0)
footer_left_label.Text = "gamename"
footer_left_label.Name = "footer_left_label"
footer_left_label.BackgroundTransparency = 1
footer_left_label.Position = UDim2.new(0, 12, 0.5, 0)
footer_left_label.TextWrapped = true
footer_left_label.BorderSizePixel = 0
footer_left_label.AutomaticSize = Enum.AutomaticSize.XY
footer_left_label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
footer_left_label.Parent = Footer

local Container = Instance.new("Frame")
Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
Container.AnchorPoint = Vector2.new(1, 0.5)
Container.Name = "Container"
Container.BackgroundTransparency = 12
Container.Position = UDim2.new(1, 0, 0.5000065565109253, 0)
Container.Size = UDim2.new(0, 105, 0, 28)
Container.BorderSizePixel = 0
Container.AutomaticSize = Enum.AutomaticSize.XY
Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container.Parent = Footer

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout.Padding = UDim.new(0, 12)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Container

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 6)
UIPadding.PaddingRight = UDim.new(0, 12)
UIPadding.Parent = Container

local footer_text = Instance.new("TextLabel")
footer_text.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
footer_text.TextStrokeTransparency = 0.800000011920929
footer_text.AnchorPoint = Vector2.new(1, 0.5)
footer_text.TextSize = 15
footer_text.Size = UDim2.new(0, 1, 0, 1)
footer_text.RichText = true
footer_text.TextColor3 = Color3.fromRGB(255, 255, 255)
footer_text.BorderColor3 = Color3.fromRGB(0, 0, 0)
footer_text.Text = "uptime:0:00"
footer_text.Name = "footer_text"
footer_text.BackgroundTransparency = 1
footer_text.Position = UDim2.new(0.3552631437778473, -90, -3.299999952316284, 0)
footer_text.TextWrapped = true
footer_text.BorderSizePixel = 0
footer_text.AutomaticSize = Enum.AutomaticSize.XY
footer_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
footer_text.Parent = Container

local Page = Instance.new("Frame")
Page.BorderColor3 = Color3.fromRGB(0, 0, 0)
Page.AnchorPoint = Vector2.new(0.5, 1)
Page.BackgroundTransparency = 1
Page.Position = UDim2.new(0.5, 0, 1, 0)
Page.Name = "Page"
Page.Size = UDim2.new(0, 563, 0, 360)
Page.BorderSizePixel = 0
Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Page.Parent = MainFrame

local Container = Instance.new("ScrollingFrame")
Container.ScrollBarImageColor3 = Color3.fromRGB(125, 69, 220)
Container.MidImage = "rbxassetid://78742712038042"

Container.Active = true
Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
Container.Name = "Container"

Container.Size = UDim2.new(0, 563, 0, 334)
Container.TopImage = ""

Container.BackgroundTransparency = 1
Container.BottomImage = ""
Container.BorderSizePixel = 0
Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container.Parent = Page

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Wraps = true
UIListLayout.Padding = UDim.new(0, 16)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.Parent = Container

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 12)
UIPadding.PaddingLeft = UDim.new(0, 12)
UIPadding.Parent = Container

local Section_Left = Instance.new("Frame")
Section_Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
Section_Left.Name = "Section_Left"
Section_Left.BackgroundTransparency = 1
Section_Left.Position = UDim2.new(0.021314388141036034, 0, 0.03055555559694767, 0)
Section_Left.Size = UDim2.new(0, 260, 0, 60)
Section_Left.BorderSizePixel = 0
Section_Left.AutomaticSize = Enum.AutomaticSize.Y
Section_Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Section_Left.Parent = Container

local Header = Instance.new("Frame")
Header.AnchorPoint = Vector2.new(0.5, 0)
Header.Name = "Header"
Header.Position = UDim2.new(0.5, 0, 0, 0)
Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
Header.Size = UDim2.new(0, 260, 0, 32)
Header.BorderSizePixel = 0
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Header.Parent = Section_Left

local Inline = Instance.new("Frame")
Inline.AnchorPoint = Vector2.new(0, 1)
Inline.Name = "Inline"
Inline.Position = UDim2.new(0, 0, 1, 0)
Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inline.Size = UDim2.new(1, 1, 0, 4)
Inline.BorderSizePixel = 0
Inline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Inline.Parent = Header

local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = 90
UIGradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.436, 0.6625000238418579),
	NumberSequenceKeypoint.new(1, 0)
}
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 69, 220)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 69, 220))
}
UIGradient.Parent = Inline

local Holder = Instance.new("Frame")
Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Holder.AnchorPoint = Vector2.new(0.5, 0)
Holder.Name = "Holder"
Holder.BackgroundTransparency = 1
Holder.Position = UDim2.new(0.5004807710647583, 0, 1, 0)
Holder.Size = UDim2.new(0, 1, 0, 1)
Holder.BorderSizePixel = 0
Holder.AutomaticSize = Enum.AutomaticSize.XY
Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Holder.Parent = Header

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Holder

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingBottom = UDim.new(0, 35)
UIPadding.PaddingTop = UDim.new(0, 4)
UIPadding.Parent = Holder

local Section_Name = Instance.new("TextLabel")
Section_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Section_Name.TextColor3 = Color3.fromRGB(125, 69, 220)
Section_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Section_Name.Text = "ExampleSection"
Section_Name.Name = "Section_Name"
Section_Name.TextStrokeTransparency = 0.8500000238418579
Section_Name.AnchorPoint = Vector2.new(0.5, 0.5)
Section_Name.Size = UDim2.new(0, 1, 0, 1)
Section_Name.BackgroundTransparency = 1
Section_Name.Position = UDim2.new(0.5, 0, 0.5, 0)
Section_Name.BorderSizePixel = 0
Section_Name.AutomaticSize = Enum.AutomaticSize.XY
Section_Name.TextSize = 14
Section_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Section_Name.Parent = Header

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(35, 35, 35)
UIStroke.Parent = Section_Left

local Section_Left = Instance.new("Frame")
Section_Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
Section_Left.Name = "Section_Left"
Section_Left.BackgroundTransparency = 1
Section_Left.Position = UDim2.new(0.021314388141036034, 0, 0.03055555559694767, 0)
Section_Left.Size = UDim2.new(0, 260, 0, 60)
Section_Left.BorderSizePixel = 0
Section_Left.AutomaticSize = Enum.AutomaticSize.Y
Section_Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Section_Left.Parent = Container

local Header = Instance.new("Frame")
Header.AnchorPoint = Vector2.new(0.5, 0)
Header.Name = "Header"
Header.Position = UDim2.new(0.5, 0, 0, 0)
Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
Header.Size = UDim2.new(0, 260, 0, 32)
Header.BorderSizePixel = 0
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Header.Parent = Section_Left

local Inline = Instance.new("Frame")
Inline.AnchorPoint = Vector2.new(0, 1)
Inline.Name = "Inline"
Inline.Position = UDim2.new(0, 0, 1, 0)
Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inline.Size = UDim2.new(1, 1, 0, 4)
Inline.BorderSizePixel = 0
Inline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Inline.Parent = Header

local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = 90
UIGradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.436, 0.6625000238418579),
	NumberSequenceKeypoint.new(1, 0)
}
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 69, 220)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 69, 220))
}
UIGradient.Parent = Inline

local Holder = Instance.new("Frame")
Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Holder.AnchorPoint = Vector2.new(0.5, 0)
Holder.Name = "Holder"
Holder.BackgroundTransparency = 1
Holder.Position = UDim2.new(0.5004807710647583, 0, 1, 0)
Holder.Size = UDim2.new(0, 1, 0, 1)
Holder.BorderSizePixel = 0
Holder.AutomaticSize = Enum.AutomaticSize.XY
Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Holder.Parent = Header

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Holder

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingBottom = UDim.new(0, 35)
UIPadding.PaddingTop = UDim.new(0, 4)
UIPadding.Parent = Holder

local Section_Name = Instance.new("TextLabel")
Section_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Section_Name.TextColor3 = Color3.fromRGB(125, 69, 220)
Section_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Section_Name.Text = "ExampleSection"
Section_Name.Name = "Section_Name"
Section_Name.TextStrokeTransparency = 0.8500000238418579
Section_Name.AnchorPoint = Vector2.new(0.5, 0.5)
Section_Name.Size = UDim2.new(0, 1, 0, 1)
Section_Name.BackgroundTransparency = 1
Section_Name.Position = UDim2.new(0.5, 0, 0.5, 0)
Section_Name.BorderSizePixel = 0
Section_Name.AutomaticSize = Enum.AutomaticSize.XY
Section_Name.TextSize = 14
Section_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Section_Name.Parent = Header

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(35, 35, 35)
UIStroke.Parent = Section_Left

local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Position = UDim2.new(0, 0, 0.8083333373069763, 0)
Shadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
Shadow.Size = UDim2.new(0, 563, 0, 44)
Shadow.BorderSizePixel = 0
Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Shadow.Parent = Page

local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = 90
UIGradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.212, 0.668749988079071),
	NumberSequenceKeypoint.new(0.666, 0.22499996423721313),
	NumberSequenceKeypoint.new(1, 0)
}
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
}
UIGradient.Parent = Shadow

local Inline = Instance.new("Frame")
Inline.AnchorPoint = Vector2.new(0.5, 1)
Inline.Name = "Inline"
Inline.Position = UDim2.new(0.5, 0, 1.0681846141815186, 0)
Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inline.Size = UDim2.new(1, 1, 0.06818459182977676, 1)
Inline.BorderSizePixel = 0
Inline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Inline.Parent = Shadow

local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = -90
UIGradient.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.394, 1),
	NumberSequenceKeypoint.new(0.596, 0.6812499761581421),
	NumberSequenceKeypoint.new(1, 0)
}
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(117, 65, 204)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(117, 65, 204))
}
UIGradient.Parent = Inline


function Tab:CreateSection(config)
    local config = config or {}
    local sectionText = config.SectionText or "Section"
    local position = config.position or "left"
    
    local section = Instance.new("Frame")
    section.Name = "Section_" .. sectionText
    section.Size = UDim2.new(0, 260, 0, 100)
    section.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    section.BorderSizePixel = 0
    section.Parent = self._content
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 8)
    sectionCorner.Parent = section
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(35, 35, 35)
    stroke.Thickness = 1
    stroke.Parent = section
    
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 32)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    header.BorderSizePixel = 0
    header.Parent = section
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 8)
    headerCorner.Parent = header
    
    local sectionName = Instance.new("TextLabel")
    sectionName.Name = "SectionName"
    sectionName.Size = UDim2.new(1, -20, 1, 0)
    sectionName.Position = UDim2.new(0, 10, 0, 0)
    sectionName.BackgroundTransparency = 1
    sectionName.Text = sectionText
    sectionName.TextColor3 = AccentColor
    sectionName.TextSize = 14
    sectionName.Font = Enum.Font.GothamBold
    sectionName.TextXAlignment = Enum.TextXAlignment.Left
    sectionName.Parent = header
    
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -20, 1, -40)
    content.Position = UDim2.new(0, 10, 0, 40)
    content.BackgroundTransparency = 1
    content.Parent = section
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 8)
    contentLayout.Parent = content
    
    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingTop = UDim.new(0, 8)
    contentPadding.PaddingBottom = UDim.new(0, 8)
    contentPadding.Parent = content
    
    local sectionObj = {
        _frame = section,
        _content = content,
        _name = sectionText
    }
    
    setmetatable(sectionObj, Section)
    table.insert(self._sections, sectionObj)
    
    return sectionObj
end

function Window:CreateTab(config)
    local config = config or {}
    local tabText = config.TabText or "Tab"
    
    local tabButton = Instance.new("TextButton")
    tabButton.Name = "Tab_" .. tabText
    tabButton.Size = UDim2.new(0, 60, 1, 0)
    tabButton.BackgroundTransparency = 1
    tabButton.Text = tabText
    tabButton.TextColor3 = Color3.fromRGB(169, 169, 169)
    tabButton.TextSize = 14
    tabButton.Font = Enum.Font.Gotham
    tabButton.Parent = self._tabContainer
    
    local tabContent = Instance.new("Frame")
    tabContent.Name = "TabContent_" .. tabText
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.Parent = self._contentArea
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.Padding = UDim.new(0, 16)
    tabLayout.Parent = tabContent
    
    local tab = {
        _button = tabButton,
        _content = tabContent,
        _name = tabText,
        _sections = {}
    }
    
    setmetatable(tab, Tab)
    table.insert(self._tabs, tab)
    
    -- Tab switching
    tabButton.MouseButton1Click:Connect(function()
        for _, otherTab in pairs(self._tabs) do
            otherTab._content.Visible = false
            otherTab._button.TextColor3 = Color3.fromRGB(169, 169, 169)
        end
        tabContent.Visible = true
        tabButton.TextColor3 = AccentColor
        self._currentTab = tab
    end)
    
    -- Make first tab active
    if #self._tabs == 1 then
        tabContent.Visible = true
        tabButton.TextColor3 = AccentColor
        self._currentTab = tab
    end
    
    return tab
end

function Section:CreateToggle(config)
    local config = config or {}
    local toggleText = config.ToggleText or "Toggle"
    local callback = config.Callback or function() end
    
    local toggle = Instance.new("Frame")
    toggle.Name = "Toggle_" .. toggleText
    toggle.Size = UDim2.new(1, 0, 0, 30)
    toggle.BackgroundTransparency = 1
    toggle.Parent = self._content
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 50, 0, 20)
    toggleButton.Position = UDim2.new(1, -60, 0, 5)
    toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = ""
    toggleButton.Parent = toggle
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 10)
    toggleCorner.Parent = toggleButton
    
    local toggleSlider = Instance.new("Frame")
    toggleSlider.Name = "ToggleSlider"
    toggleSlider.Size = UDim2.new(0, 16, 0, 16)
    toggleSlider.Position = UDim2.new(0, 2, 0, 2)
    toggleSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleSlider.BorderSizePixel = 0
    toggleSlider.Parent = toggleButton
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 8)
    sliderCorner.Parent = toggleSlider
    
    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Name = "ToggleLabel"
    toggleLabel.Size = UDim2.new(1, -70, 1, 0)
    toggleLabel.Position = UDim2.new(0, 0, 0, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = toggleText
    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleLabel.TextSize = 14
    toggleLabel.Font = Enum.Font.Gotham
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.Parent = toggle
    
    local state = false
    
    local function updateToggle()
        if state then
            toggleButton.BackgroundColor3 = AccentColor
            TweenService:Create(toggleSlider, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0, 2)}):Play()
        else
            toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            TweenService:Create(toggleSlider, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2)}):Play()
        end
    end
    
    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        updateToggle()
        callback(state)
    end)
    
    return {
        SetState = function(newState)
            state = newState
            updateToggle()
        end,
        GetState = function()
            return state
        end
    }
end

function libary:CreateNewText(text)
    return CreateNewText(text)
end

function libary:CreateNotification(config)
    local config = config or {}
    CreateNotification(config.Icon, config.NotiTitle, config.NotiDescription, config.Time)
end

function Section:CreateDropdown(config)
    local config = config or {}
    local dropdownText = config.DropdownText or "Dropdown"
    local options = config.Options or {}
    local multiSelect = config.MultiSelect or false
    local default = config.Default or (multiSelect and {} or options[1])
    local callback = config.Callback or function() end
    
    local dropdown = Instance.new("Frame")
    dropdown.Name = "Dropdown_" .. dropdownText
    dropdown.Size = UDim2.new(1, 0, 0, 30)
    dropdown.BackgroundTransparency = 1
    dropdown.Parent = self._content
    
    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Name = "DropdownButton"
    dropdownButton.Size = UDim2.new(1, 0, 1, 0)
    dropdownButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    dropdownButton.BorderSizePixel = 0
    dropdownButton.Text = dropdownText .. ": " .. (multiSelect and table.concat(default, ", ") or tostring(default))
    dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownButton.TextSize = 14
    dropdownButton.Font = Enum.Font.Gotham
    dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
    dropdownButton.Parent = dropdown
    
    local dropdownCorner = Instance.new("UICorner")
    dropdownCorner.CornerRadius = UDim.new(0, 6)
    dropdownCorner.Parent = dropdownButton
    
    local dropdownPadding = Instance.new("UIPadding")
    dropdownPadding.PaddingLeft = UDim.new(0, 10)
    dropdownPadding.PaddingRight = UDim.new(0, 10)
    dropdownPadding.Parent = dropdownButton
    
    local dropdownArrow = Instance.new("TextLabel")
    dropdownArrow.Name = "DropdownArrow"
    dropdownArrow.Size = UDim2.new(0, 20, 1, 0)
    dropdownArrow.Position = UDim2.new(1, -30, 0, 0)
    dropdownArrow.BackgroundTransparency = 1
    dropdownArrow.Text = "▼"
    dropdownArrow.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownArrow.TextSize = 12
    dropdownArrow.Font = Enum.Font.Gotham
    dropdownArrow.Parent = dropdownButton
    
    local dropdownList = Instance.new("Frame")
    dropdownList.Name = "DropdownList"
    dropdownList.Size = UDim2.new(1, 0, 0, 0)
    dropdownList.Position = UDim2.new(0, 0, 1, 5)
    dropdownList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    dropdownList.BorderSizePixel = 0
    dropdownList.Visible = false
    dropdownList.Parent = dropdown
    
    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 6)
    listCorner.Parent = dropdownList
    
    local listStroke = Instance.new("UIStroke")
    listStroke.Color = Color3.fromRGB(50, 50, 50)
    listStroke.Thickness = 1
    listStroke.Parent = dropdownList
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = dropdownList
    
    local listPadding = Instance.new("UIPadding")
    listPadding.PaddingTop = UDim.new(0, 5)
    listPadding.PaddingBottom = UDim.new(0, 5)
    listPadding.Parent = dropdownList
    
    local selectedValues = multiSelect and default or {default}
    local isOpen = false
    
    local function updateDropdown()
        local displayText = multiSelect and table.concat(selectedValues, ", ") or tostring(selectedValues[1] or "")
        dropdownButton.Text = dropdownText .. ": " .. displayText
    end
    
    local function toggleDropdown()
        isOpen = not isOpen
        dropdownList.Visible = isOpen
        dropdownArrow.Text = isOpen and "▲" or "▼"
        
        if isOpen then
            dropdownList.Size = UDim2.new(1, 0, 0, #options * 25 + 10)
        end
    end
    
    -- Create option buttons
    for i, option in pairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Name = "Option_" .. option
        optionButton.Size = UDim2.new(1, -10, 0, 20)
        optionButton.BackgroundTransparency = 1
        optionButton.Text = option
        optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        optionButton.TextSize = 12
        optionButton.Font = Enum.Font.Gotham
        optionButton.TextXAlignment = Enum.TextXAlignment.Left
        optionButton.Parent = dropdownList
        
        local optionPadding = Instance.new("UIPadding")
        optionPadding.PaddingLeft = UDim.new(0, 10)
        optionPadding.Parent = optionButton
        
        optionButton.MouseButton1Click:Connect(function()
            if multiSelect then
                local index = table.find(selectedValues, option)
                if index then
                    table.remove(selectedValues, index)
                else
                    table.insert(selectedValues, option)
                end
            else
                selectedValues = {option}
                toggleDropdown()
            end
            updateDropdown()
            callback(multiSelect and selectedValues or selectedValues[1])
        end)
    end
    
    dropdownButton.MouseButton1Click:Connect(toggleDropdown)
    
    updateDropdown()
    
    return {
        SetValue = function(newValue)
            if multiSelect then
                selectedValues = newValue or {}
            else
                selectedValues = {newValue}
            end
            updateDropdown()
        end,
        GetValue = function()
            return multiSelect and selectedValues or selectedValues[1]
        end
    }
end

function Section:CreateSlider(config)
    local config = config or {}
    local sliderText = config.SliderText or "Slider"
    local min = config.Min or 0
    local max = config.Max or 100
    local value = config.Value or min
    local callback = config.Callback or function() end
    
    local slider = Instance.new("Frame")
    slider.Name = "Slider_" .. sliderText
    slider.Size = UDim2.new(1, 0, 0, 40)
    slider.BackgroundTransparency = 1
    slider.Parent = self._content
    
    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Name = "SliderLabel"
    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
    sliderLabel.Position = UDim2.new(0, 0, 0, 0)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = sliderText .. ": " .. value
    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderLabel.TextSize = 14
    sliderLabel.Font = Enum.Font.Gotham
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    sliderLabel.Parent = slider
    
    local sliderTrack = Instance.new("Frame")
    sliderTrack.Name = "SliderTrack"
    sliderTrack.Size = UDim2.new(1, 0, 0, 4)
    sliderTrack.Position = UDim2.new(0, 0, 0, 25)
    sliderTrack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderTrack.BorderSizePixel = 0
    sliderTrack.Parent = slider
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 2)
    trackCorner.Parent = sliderTrack
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "SliderFill"
    sliderFill.Size = UDim2.new(0, 0, 1, 0)
    sliderFill.Position = UDim2.new(0, 0, 0, 0)
    sliderFill.BackgroundColor3 = AccentColor
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderTrack
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 2)
    fillCorner.Parent = sliderFill
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Name = "SliderButton"
    sliderButton.Size = UDim2.new(0, 16, 0, 16)
    sliderButton.Position = UDim2.new(0, -8, 0, -6)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.BorderSizePixel = 0
    sliderButton.Text = ""
    sliderButton.Parent = sliderTrack
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = sliderButton
    
    local currentValue = value
    local dragging = false
    
    local function updateSlider()
        local percentage = (currentValue - min) / (max - min)
        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        sliderButton.Position = UDim2.new(percentage, -8, 0, -6)
        sliderLabel.Text = sliderText .. ": " .. math.floor(currentValue)
    end
    
    sliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = input.Position.X
            local trackPos = sliderTrack.AbsolutePosition.X
            local trackSize = sliderTrack.AbsoluteSize.X
            local percentage = math.clamp((mousePos - trackPos) / trackSize, 0, 1)
            currentValue = math.floor(min + percentage * (max - min))
            updateSlider()
            callback(currentValue)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    updateSlider()
    
    return {
        SetValue = function(newValue)
            currentValue = math.clamp(newValue, min, max)
            updateSlider()
        end,
        GetValue = function()
            return currentValue
        end
    }
end

function Section:CreateKeybind(config)
    local config = config or {}
    local keybindText = config.KeybindText or "Keybind"
    local callback = config.Callback or function() end
    
    local keybind = Instance.new("Frame")
    keybind.Name = "Keybind_" .. keybindText
    keybind.Size = UDim2.new(1, 0, 0, 30)
    keybind.BackgroundTransparency = 1
    keybind.Parent = self._content
    
    local keybindLabel = Instance.new("TextLabel")
    keybindLabel.Name = "KeybindLabel"
    keybindLabel.Size = UDim2.new(1, -60, 1, 0)
    keybindLabel.Position = UDim2.new(0, 0, 0, 0)
    keybindLabel.BackgroundTransparency = 1
    keybindLabel.Text = keybindText
    keybindLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    keybindLabel.TextSize = 14
    keybindLabel.Font = Enum.Font.Gotham
    keybindLabel.TextXAlignment = Enum.TextXAlignment.Left
    keybindLabel.Parent = keybind
    
    local keybindButton = Instance.new("TextButton")
    keybindButton.Name = "KeybindButton"
    keybindButton.Size = UDim2.new(0, 50, 0, 20)
    keybindButton.Position = UDim2.new(1, -60, 0, 5)
    keybindButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    keybindButton.BorderSizePixel = 0
    keybindButton.Text = "None"
    keybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    keybindButton.TextSize = 12
    keybindButton.Font = Enum.Font.Gotham
    keybindButton.Parent = keybind
    
    local keybindCorner = Instance.new("UICorner")
    keybindCorner.CornerRadius = UDim.new(0, 6)
    keybindCorner.Parent = keybindButton
    
    local currentKey = nil
    local listening = false
    
    keybindButton.MouseButton1Click:Connect(function()
        listening = true
        keybindButton.Text = "..."
        keybindButton.BackgroundColor3 = AccentColor
    end)
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if listening and not gameProcessed then
            local key = input.KeyCode.Name
            currentKey = key
            keybindButton.Text = key
            keybindButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            listening = false
            callback(key)
        end
    end)
    
    return {
        SetKey = function(key)
            currentKey = key
            keybindButton.Text = key or "None"
        end,
        GetKey = function()
            return currentKey
        end
    }
end

function Section:CreateTextInput(config)
    local config = config or {}
    local textInputText = config.TextInputText or "Text Input"
    local callback = config.Callback or function() end
    
    local textInput = Instance.new("Frame")
    textInput.Name = "TextInput_" .. textInputText
    textInput.Size = UDim2.new(1, 0, 0, 30)
    textInput.BackgroundTransparency = 1
    textInput.Parent = self._content
    
    local inputLabel = Instance.new("TextLabel")
    inputLabel.Name = "InputLabel"
    inputLabel.Size = UDim2.new(1, 0, 0, 20)
    inputLabel.Position = UDim2.new(0, 0, 0, 0)
    inputLabel.BackgroundTransparency = 1
    inputLabel.Text = textInputText
    inputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputLabel.TextSize = 14
    inputLabel.Font = Enum.Font.Gotham
    inputLabel.TextXAlignment = Enum.TextXAlignment.Left
    inputLabel.Parent = textInput
    
    local inputBox = Instance.new("TextBox")
    inputBox.Name = "InputBox"
    inputBox.Size = UDim2.new(1, 0, 0, 25)
    inputBox.Position = UDim2.new(0, 0, 0, 20)
    inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    inputBox.BorderSizePixel = 0
    inputBox.Text = ""
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.TextSize = 14
    inputBox.Font = Enum.Font.Gotham
    inputBox.TextXAlignment = Enum.TextXAlignment.Left
    inputBox.PlaceholderText = "Enter text..."
    inputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    inputBox.Parent = textInput
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 6)
    inputCorner.Parent = inputBox
    
    local inputPadding = Instance.new("UIPadding")
    inputPadding.PaddingLeft = UDim.new(0, 10)
    inputPadding.PaddingRight = UDim.new(0, 10)
    inputPadding.Parent = inputBox
    
    inputBox.FocusLost:Connect(function()
        callback(inputBox.Text)
    end)
    
    return {
        SetText = function(text)
            inputBox.Text = text
        end,
        GetText = function()
            return inputBox.Text
        end
    }
end

function Section:CreateButton(config)
    local config = config or {}
    local buttonText = config.ButtonText or "Button"
    local callback = config.Callback or function() end
    
    local button = Instance.new("TextButton")
    button.Name = "Button_" .. buttonText
    button.Size = UDim2.new(1, 0, 0, 30)
    button.BackgroundColor3 = AccentColor
    button.BorderSizePixel = 0
    button.Text = buttonText
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Parent = self._content
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    button.MouseButton1Click:Connect(callback)
    
    return button
end

function Section:CreateLabel(config)
    local config = config or {}
    local labelText = config.LabelText or "Label"
    
    local label = Instance.new("TextLabel")
    label.Name = "Label_" .. labelText
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = self._content
    
    return label
end

function Section:CreateColorpicker(config)
    local config = config or {}
    local colorpickerText = config.ColorpickerText or "Color Picker"
    local defaultColor = config.defaultColor or Color3.fromRGB(255, 255, 255)
    local callback = config.Callback or function() end
    
    local colorpicker = Instance.new("Frame")
    colorpicker.Name = "Colorpicker_" .. colorpickerText
    colorpicker.Size = UDim2.new(1, 0, 0, 30)
    colorpicker.BackgroundTransparency = 1
    colorpicker.Parent = self._content
    
    local colorpickerLabel = Instance.new("TextLabel")
    colorpickerLabel.Name = "ColorpickerLabel"
    colorpickerLabel.Size = UDim2.new(1, -60, 1, 0)
    colorpickerLabel.Position = UDim2.new(0, 0, 0, 0)
    colorpickerLabel.BackgroundTransparency = 1
    colorpickerLabel.Text = colorpickerText
    colorpickerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    colorpickerLabel.TextSize = 14
    colorpickerLabel.Font = Enum.Font.Gotham
    colorpickerLabel.TextXAlignment = Enum.TextXAlignment.Left
    colorpickerLabel.Parent = colorpicker
    
    local colorButton = Instance.new("TextButton")
    colorButton.Name = "ColorButton"
    colorButton.Size = UDim2.new(0, 50, 0, 20)
    colorButton.Position = UDim2.new(1, -60, 0, 5)
    colorButton.BackgroundColor3 = defaultColor
    colorButton.BorderSizePixel = 0
    colorButton.Text = ""
    colorButton.Parent = colorpicker
    
    local colorCorner = Instance.new("UICorner")
    colorCorner.CornerRadius = UDim.new(0, 6)
    colorCorner.Parent = colorButton
    
    local currentColor = defaultColor
    
    colorButton.MouseButton1Click:Connect(function()
        -- Simple color picker implementation
        local newColor = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
        currentColor = newColor
        colorButton.BackgroundColor3 = newColor
        callback(newColor)
    end)
    
    return {
        SetColor = function(color)
            currentColor = color
            colorButton.BackgroundColor3 = color
        end,
        GetColor = function()
            return currentColor
        end
    }
end

function Section:CreateToggleWithKeybind(config)
    local config = config or {}
    local toggleText = config.ToggleText or "Toggle"
    local callback = config.Callback or function() end
    
    local toggle = self:CreateToggle({
        ToggleText = toggleText,
        Callback = callback
    })
    
    local keybind = self:CreateKeybind({
        KeybindText = toggleText .. " Key",
        Callback = function(key)
            -- Store keybind for the toggle
            toggle.key = key
        end
    })
    
    return toggle
end

function Section:AddColorToggle(config)
    local config = config or {}
    local text = config.Text or "Color Toggle"
    local defaultColor = config.DefaultColor or Color3.fromRGB(255, 255, 255)
    local callback = config.Callback or function() end
    
    local toggle = self:CreateToggle({
        ToggleText = text,
        Callback = function(enabled)
            callback(enabled, toggle._color or defaultColor)
        end
    })
    
    local colorpicker = self:CreateColorpicker({
        ColorpickerText = text .. " Color",
        defaultColor = defaultColor,
        Callback = function(color)
            toggle._color = color
            if toggle.GetState and toggle.GetState() then
                callback(true, color)
            end
        end
    })
    
    return toggle
end

function Section:CreateConfig(config)
    local config = config or {}
    local text = config.Text or "Config"
    local callback = config.Callback or function() end
    
    local configButton = self:CreateButton({
        ButtonText = text,
        Callback = callback
    })
    
    return configButton
end

function libary:SetAccentColor(color)
    AccentColor = color
    -- Update all existing UI elements with new accent color
    for _, window in pairs(Windows) do
        -- Update window accent colors
    end
end

return libary

