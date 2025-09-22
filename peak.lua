
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

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


local Window = {}
Window.__index = Window

local Tab = {}
Tab.__index = Tab


local Section = {}
Section.__index = Section


local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CharliewareUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.ClipsDescendants = true
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Name = "MainFrame"
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 563, 0, 400)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Parent = ScreenGui

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


local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local isVisible = true

local function toggleUI()
    isVisible = not isVisible
    local targetTransparency = isVisible and 0 or 1
    local targetSize = isVisible and UDim2.new(0, 563, 0, 400) or UDim2.new(0, 0, 0, 0)
    
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    local tween1 = TweenService:Create(MainFrame, tweenInfo, {
        Size = targetSize,
        BackgroundTransparency = targetTransparency
    })
    
    tween1:Play()
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Insert then
        toggleUI()
    end
end)

-- Window Creation Function
function libary:CreateWindow(config)
    local window = {}
    setmetatable(window, Window)
    
    -- Store window configuration
    window.config = config or {}
    window.tabs = {}
    window.sections = {left = {}, right = {}}
    
    -- Add window to global windows table
    table.insert(Windows, window)
    
    return window
end

-- Tab Creation Function
function Window:CreateTab(options)
    local tab = {}
    setmetatable(tab, Tab)
    
    tab.text = options.TabText or "Tab"
    tab.sections = {left = {}, right = {}}
    tab.window = self
    
    -- Add tab to window's tabs
    table.insert(self.tabs, tab)
    
    return tab
end

-- Section Creation Function
function Window:CreateSection(options)
    local section = {}
    setmetatable(section, Section)
    
    section.text = options.SectionText or "Section"
    section.position = options.position or "left"
    section.window = self
    
    -- Add section to appropriate position
    table.insert(self.sections[section.position], section)
    
    return section
end

-- Section Creation for Tabs
function Tab:CreateSection(options)
    local section = {}
    setmetatable(section, Section)
    
    section.text = options.SectionText or "Section"
    section.position = options.position or "left"
    section.tab = self
    section.window = self.window
    
    -- Add section to tab's sections
    table.insert(self.sections[section.position], section)
    
    return section
end

-- Placeholder functions for UI elements (no implementation yet)
function Section:CreateToggle(options)
    print("CreateToggle called with:", options.ToggleText)
    -- TODO: Implement toggle creation
    return {}
end

function Section:CreateSlider(options)
    print("CreateSlider called with:", options.SliderText)
    -- TODO: Implement slider creation
    return {}
end

function Section:CreateLabel(options)
    print("CreateLabel called with:", options.LabelText)
    -- TODO: Implement label creation
    return {}
end

function Section:CreateTextInput(options)
    print("CreateTextInput called with:", options.TextInputText)
    -- TODO: Implement text input creation
    return {}
end

function Section:CreateDropdown(options)
    print("CreateDropdown called with:", options.DropdownText)
    -- TODO: Implement dropdown creation
    return {}
end

function Section:CreateButton(options)
    print("CreateButton called with:", options.ButtonText)
    -- TODO: Implement button creation
    return {}
end

function Section:CreateKeybind(options)
    print("CreateKeybind called with:", options.KeybindText)
    -- TODO: Implement keybind creation
    return {}
end

function Section:CreateColorpicker(options)
    print("CreateColorpicker called with:", options.ColorpickerText)
    -- TODO: Implement colorpicker creation
    return {}
end

function Section:CreateToggleWithKeybind(options)
    print("CreateToggleWithKeybind called with:", options.ToggleText)
    -- TODO: Implement toggle with keybind creation
    return {}
end

function Section:AddColorToggle(options)
    print("AddColorToggle called with:", options.Text)
    -- TODO: Implement color toggle creation
    return {}
end

function Section:CreateConfig(options)
    print("CreateConfig called with:", options.Text)
    -- TODO: Implement config creation
    return {}
end

-- Return the library
return libary

