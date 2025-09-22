
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
ScreenGui.Name = "CharlieWareUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CharlieWareUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

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




-- Function implementations
function Tab:CreateSection(config)
    local section = setmetatable({}, Section)
    section.config = config or {}
    section.position = config.position or "left"
    section.sectionText = config.SectionText or "Section"
    
    -- Create section UI elements
    local SectionFrame = Instance.new("Frame")
    SectionFrame.Name = "Section_" .. section.sectionText
    SectionFrame.Size = UDim2.new(0, 260, 0, 60)
    SectionFrame.BackgroundTransparency = 1
    SectionFrame.Parent = Container
    
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(0, 260, 0, 32)
    Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Header.Parent = SectionFrame
    
    local SectionName = Instance.new("TextLabel")
    SectionName.Text = section.sectionText
    SectionName.TextColor3 = Color3.fromRGB(125, 69, 220)
    SectionName.TextSize = 14
    SectionName.BackgroundTransparency = 1
    SectionName.Size = UDim2.new(1, 0, 1, 0)
    SectionName.Parent = Header
    
    local Holder = Instance.new("Frame")
    Holder.Name = "Holder"
    Holder.Size = UDim2.new(1, 0, 0, 1)
    Holder.BackgroundTransparency = 1
    Holder.Position = UDim2.new(0, 0, 1, 0)
    Holder.Parent = Header
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Holder
    
    section.frame = SectionFrame
    section.holder = Holder
    
    print("Created section:", section.sectionText, "at position:", section.position)
    
    return section
end

function Window:CreateTab(config)
    local tab = setmetatable({}, Tab)
    tab.config = config or {}
    tab.tabText = config.TabText or "Tab"
    tab.sections = {left = {}, right = {}}
    
    -- Create tab UI elements
    local TabFrame = Instance.new("Frame")
    TabFrame.Name = "Tab_" .. tab.tabText
    TabFrame.Size = UDim2.new(0, 47, 0, 40)
    TabFrame.BackgroundTransparency = 1
    TabFrame.Parent = Container
    
    local TabName = Instance.new("TextLabel")
    TabName.Text = tab.tabText
    TabName.TextColor3 = Color3.fromRGB(169, 169, 169)
    TabName.TextSize = 15
    TabName.BackgroundTransparency = 1
    TabName.Size = UDim2.new(1, 0, 1, 0)
    TabName.Parent = TabFrame
    
    tab.frame = TabFrame
    
    print("Created tab:", tab.tabText)
    
    return tab
end

function Window:CreateSection(config)
    local section = setmetatable({}, Section)
    section.config = config or {}
    section.position = config.position or "left"
    section.sectionText = config.SectionText or "Section"
    
    -- Create section UI elements
    local SectionFrame = Instance.new("Frame")
    SectionFrame.Name = "Section_" .. section.sectionText
    SectionFrame.Size = UDim2.new(0, 260, 0, 60)
    SectionFrame.BackgroundTransparency = 1
    SectionFrame.Parent = Container
    
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(0, 260, 0, 32)
    Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Header.Parent = SectionFrame
    
    local SectionName = Instance.new("TextLabel")
    SectionName.Text = section.sectionText
    SectionName.TextColor3 = Color3.fromRGB(125, 69, 220)
    SectionName.TextSize = 14
    SectionName.BackgroundTransparency = 1
    SectionName.Size = UDim2.new(1, 0, 1, 0)
    SectionName.Parent = Header
    
    local Holder = Instance.new("Frame")
    Holder.Name = "Holder"
    Holder.Size = UDim2.new(1, 0, 0, 1)
    Holder.BackgroundTransparency = 1
    Holder.Position = UDim2.new(0, 0, 1, 0)
    Holder.Parent = Header
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Holder
    
    section.frame = SectionFrame
    section.holder = Holder
    
    print("Created window section:", section.sectionText, "at position:", section.position)
    
    return section
end

function libary:CreateWindow(config)
    local window = setmetatable({}, Window)
    window.config = config or {}
    window.libaryName = config.Libary_Name or "Window"
    window.footerLeftText = config.Footer_Left_Text or "Game"
    window.interfaceKeybind = config.interface_keybind or "Insert"
    window.tabs = {}
    window.sections = {left = {}, right = {}}
    
    -- Update library name
    if Libary_Name then
        Libary_Name.Text = window.libaryName .. '<font color="#7D45DC">.rbx</font>'
    end
    
    -- Update footer text
    if footer_left_label then
        footer_left_label.Text = window.footerLeftText
    end
    
    print("Created window:", window.libaryName)
    
    return window
end

-- Hide other components by making them return placeholder objects
function Tab:CreateToggle(config)
    local toggle = {}
    toggle.config = config or {}
    toggle.toggleText = config.ToggleText or "Toggle"
    toggle.callback = config.Callback or function() end
    toggle.value = false
    
    print("Toggle component hidden:", toggle.toggleText)
    
    return toggle
end

function Tab:CreateSlider(config)
    local slider = {}
    slider.config = config or {}
    slider.sliderText = config.SliderText or "Slider"
    slider.min = config.Min or 0
    slider.max = config.Max or 100
    slider.value = config.Value or slider.min
    slider.callback = config.Callback or function() end
    
    print("Slider component hidden:", slider.sliderText)
    
    return slider
end

function Tab:CreateLabel(config)
    local label = {}
    label.config = config or {}
    label.labelText = config.LabelText or "Label"
    
    print("Label component hidden:", label.labelText)
    
    return label
end

function Tab:CreateTextInput(config)
    local textInput = {}
    textInput.config = config or {}
    textInput.textInputText = config.TextInputText or "Text Input"
    textInput.callback = config.Callback or function() end
    textInput.value = ""
    
    print("TextInput component hidden:", textInput.textInputText)
    
    return textInput
end

function Tab:CreateDropdown(config)
    local dropdown = {}
    dropdown.config = config or {}
    dropdown.dropdownText = config.DropdownText or "Dropdown"
    dropdown.options = config.Options or {}
    dropdown.callback = config.Callback or function() end
    dropdown.value = nil
    
    print("Dropdown component hidden:", dropdown.dropdownText)
    
    return dropdown
end

function Tab:CreateKeybind(config)
    local keybind = {}
    keybind.config = config or {}
    keybind.keybindText = config.KeybindText or "Keybind"
    keybind.callback = config.Callback or function() end
    keybind.key = nil
    
    print("Keybind component hidden:", keybind.keybindText)
    
    return keybind
end

function Tab:CreateButton(config)
    local button = {}
    button.config = config or {}
    button.buttonText = config.ButtonText or "Button"
    button.callback = config.Callback or function() end
    
    print("Button component hidden:", button.buttonText)
    
    return button
end

function Tab:CreateColorpicker(config)
    local colorpicker = {}
    colorpicker.config = config or {}
    colorpicker.colorpickerText = config.ColorpickerText or "Color Picker"
    colorpicker.callback = config.Callback or function() end
    colorpicker.value = Color3.fromRGB(255, 255, 255)
    
    print("Colorpicker component hidden:", colorpicker.colorpickerText)
    
    return colorpicker
end

function Tab:CreateToggleWithKeybind(config)
    local toggleWithKeybind = {}
    toggleWithKeybind.config = config or {}
    toggleWithKeybind.toggleText = config.ToggleText or "Toggle with Keybind"
    toggleWithKeybind.callback = config.Callback or function() end
    toggleWithKeybind.value = false
    toggleWithKeybind.key = nil
    
    print("ToggleWithKeybind component hidden:", toggleWithKeybind.toggleText)
    
    return toggleWithKeybind
end

function Tab:AddColorToggle(config)
    local colorToggle = {}
    colorToggle.config = config or {}
    colorToggle.text = config.Text or "Color Toggle"
    colorToggle.defaultColor = config.DefaultColor or Color3.fromRGB(255, 255, 255)
    colorToggle.callback = config.Callback or function() end
    
    print("ColorToggle component hidden:", colorToggle.text)
    
    return colorToggle
end

function Tab:CreateConfig(config)
    local configManager = {}
    configManager.config = config or {}
    configManager.text = config.Text or "Config"
    configManager.callback = config.Callback or function() end
    
    print("Config component hidden:", configManager.text)
    
    return configManager
end

function libary:CreateNotification(config)
    local notification = {}
    notification.config = config or {}
    notification.icon = config.Icon or "default"
    notification.title = config.NotiTitle or "Notification"
    notification.description = config.NotiDescription or "Description"
    notification.time = config.Time or 3
    
    print("Notification component hidden:", notification.title)
    
    return notification
end

return libary
