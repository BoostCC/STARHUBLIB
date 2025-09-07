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

local Section_Left = Instance.new("Frame")
Section_Left.Size = UDim2.new(0, 318, 0, 411)
Section_Left.Name = "Section_Left"
Section_Left.ClipsDescendants = true
Section_Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
Section_Left.Position = UDim2.new(0.019436366856098175, 0, 0.17085854709148407, 0)
Section_Left.BorderSizePixel = 0
Section_Left.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
Section_Left.Parent = Container

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Section_Left

local Shadow = Instance.new("Frame")
Shadow.BackgroundTransparency = 0.8999999761581421
Shadow.Name = "Shadow"
Shadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
Shadow.Size = UDim2.new(0, 318, 0, 40)
Shadow.BorderSizePixel = 0
Shadow.BackgroundColor3 = Color3.fromRGB(170, 85, 255)
Shadow.Parent = Section_Left

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
Section_Name.Text = "Aim"
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

local Left_Container = Instance.new("ScrollingFrame")
Left_Container.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
Left_Container.Active = true
Left_Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
Left_Container.ScrollBarThickness = 0
Left_Container.AnchorPoint = Vector2.new(0.5, 1)
Left_Container.BackgroundTransparency = 1
Left_Container.Position = UDim2.new(0.5, 0, 0.985401451587677, 0)
Left_Container.Name = "Left_Container"
Left_Container.Size = UDim2.new(0, 318, 0, 365)
Left_Container.BorderSizePixel = 0
Left_Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Left_Container.Parent = Section_Left

local Left_UIListLayout = Instance.new("UIListLayout")
Left_UIListLayout.Padding = UDim.new(0, 12)
Left_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
Left_UIListLayout.Parent = Left_Container

local Slider_Component = Instance.new("Frame")
Slider_Component.Name = "Slider_Component"
Slider_Component.BackgroundTransparency = 1
Slider_Component.Position = UDim2.new(0, 0, 0.09732360392808914, 0)
Slider_Component.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider_Component.Size = UDim2.new(0, 318, 0, 40)
Slider_Component.BorderSizePixel = 0
Slider_Component.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Slider_Component.Parent = Left_Container

local Slider_BG = Instance.new("Frame")
Slider_BG.AnchorPoint = Vector2.new(0.5, 0.5)
Slider_BG.Name = "Slider_BG"
Slider_BG.Position = UDim2.new(0.4887655973434448, 0, 0.6625000238418579, 0)
Slider_BG.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider_BG.Size = UDim2.new(0, 278, 0, 3)
Slider_BG.BorderSizePixel = 0
Slider_BG.BackgroundColor3 = Color3.fromRGB(53, 27, 81)
Slider_BG.Parent = Slider_Component

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 30)
UICorner.Parent = Slider_BG

local Progress_Bar = Instance.new("Frame")
Progress_Bar.AnchorPoint = Vector2.new(0, 0.5)
Progress_Bar.Name = "Progress_Bar"
Progress_Bar.Position = UDim2.new(0, 0, 0.5, 0)
Progress_Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
Progress_Bar.Size = UDim2.new(0, 150, 0, 3)
Progress_Bar.BorderSizePixel = 0
Progress_Bar.BackgroundColor3 = Color3.fromRGB(115, 58, 173)
Progress_Bar.Parent = Slider_BG

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 30)
UICorner.Parent = Progress_Bar

local Pointer = Instance.new("Frame")
Pointer.AnchorPoint = Vector2.new(1, 0.5)
Pointer.Name = "Pointer"
Pointer.Position = UDim2.new(1, 0, 0.5, 0)
Pointer.BorderColor3 = Color3.fromRGB(0, 0, 0)
Pointer.Size = UDim2.new(0, 15, 0, 15)
Pointer.BorderSizePixel = 0
Pointer.BackgroundColor3 = Color3.fromRGB(155, 77, 255)
Pointer.Parent = Progress_Bar

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 30)
UICorner.Parent = Pointer

local Slider_Name = Instance.new("TextLabel")
Slider_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Slider_Name.TextColor3 = Color3.fromRGB(52, 52, 52)
Slider_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider_Name.Name = "Slider_Name"
Slider_Name.AnchorPoint = Vector2.new(0.5, 0.5)
Slider_Name.Size = UDim2.new(0, 1, 0, 1)
Slider_Name.BackgroundTransparency = 1
Slider_Name.Position = UDim2.new(0.10100000351667404, 0, 0.2199999988079071, 0)
Slider_Name.BorderSizePixel = 0
Slider_Name.AutomaticSize = Enum.AutomaticSize.XY
Slider_Name.TextSize = 16
Slider_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Slider_Name.Parent = Slider_Component

local Slider_Value = Instance.new("TextLabel")
Slider_Value.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Slider_Value.TextColor3 = Color3.fromRGB(52, 52, 52)
Slider_Value.BorderColor3 = Color3.fromRGB(0, 0, 0)
Slider_Value.Text = "1.00%"
Slider_Value.Name = "Slider_Value"
Slider_Value.AnchorPoint = Vector2.new(0.5, 0.5)
Slider_Value.Size = UDim2.new(0, 1, 0, 1)
Slider_Value.BackgroundTransparency = 1
Slider_Value.Position = UDim2.new(0.8589999675750732, 0, 0.21999970078468323, 0)
Slider_Value.BorderSizePixel = 0
Slider_Value.AutomaticSize = Enum.AutomaticSize.XY
Slider_Value.TextSize = 16
Slider_Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Slider_Value.Parent = Slider_Component

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingRight = UDim.new(0, 4)
UIPadding.Parent = Slider_Value

local Toggle_Component = Instance.new("Frame")
Toggle_Component.BackgroundTransparency = 1
Toggle_Component.Name = "Toggle_Component"
Toggle_Component.BorderColor3 = Color3.fromRGB(0, 0, 0)
Toggle_Component.Size = UDim2.new(0, 318, 0, 20)
Toggle_Component.BorderSizePixel = 0
Toggle_Component.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Component.Parent = Left_Container

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
Toggle_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
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

local Dropdown_Component = Instance.new("Frame")
Dropdown_Component.Name = "Dropdown_Component"
Dropdown_Component.BackgroundTransparency = 1
Dropdown_Component.Position = UDim2.new(0, 0, 0.09732360392808914, 0)
Dropdown_Component.BorderColor3 = Color3.fromRGB(0, 0, 0)
Dropdown_Component.Size = UDim2.new(0, 318, 0, 40)
Dropdown_Component.BorderSizePixel = 0
Dropdown_Component.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Dropdown_Component.Parent = Right_Container

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
Dropdown_Value.Text = "Example"
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

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 12)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Right_Container

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 10)
UIPadding.Parent = Right_Container

local Colorpicker_Component = Instance.new("Frame")
Colorpicker_Component.Name = "Colorpicker_Component"
Colorpicker_Component.BackgroundTransparency = 1
Colorpicker_Component.Position = UDim2.new(0, 0, 0.5633803009986877, 0)
Colorpicker_Component.BorderColor3 = Color3.fromRGB(0, 0, 0)
Colorpicker_Component.Size = UDim2.new(0, 318, 0, 30)
Colorpicker_Component.BorderSizePixel = 0
Colorpicker_Component.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Colorpicker_Component.Parent = Right_Container

local Colorpicker_Text = Instance.new("TextLabel")
Colorpicker_Text.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
Colorpicker_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
Colorpicker_Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
Colorpicker_Text.Text = "Example Colorpicker"
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
Color_Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Color_Frame.Parent = Colorpicker_Component

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Color_Frame

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

local Inline = Instance.new("Frame")
Inline.AnchorPoint = Vector2.new(0.5, 1)
Inline.Name = "Inline"
Inline.Position = UDim2.new(0.7507575750350952, 0, 1, 0)
Inline.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inline.Size = UDim2.new(0, 65, 0, 4)
Inline.BorderSizePixel = 0
Inline.BackgroundColor3 = Color3.fromRGB(115, 58, 173)
Inline.Parent = Top_Bar

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 30)
UICorner.Parent = Inline

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

local Tab = Instance.new("Frame")
Tab.Name = "Tab"
Tab.Position = UDim2.new(1.0347222089767456, 0, 0.3054545521736145, 0)
Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab.Size = UDim2.new(0, 95, 0, 42)
Tab.BorderSizePixel = 0
Tab.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
Tab.Parent = Header

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Tab

local Tab_Icon = Instance.new("ImageLabel")
Tab_Icon.ImageColor3 = Color3.fromRGB(115, 58, 173)
Tab_Icon.ScaleType = Enum.ScaleType.Fit
Tab_Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab_Icon.Name = "Tab_Icon"
Tab_Icon.AnchorPoint = Vector2.new(0.5, 0.5)
Tab_Icon.Image = "rbxassetid://133833791023200"
Tab_Icon.BackgroundTransparency = 1
Tab_Icon.Position = UDim2.new(0.25789472460746765, 0, 0.5, 0)

Tab_Icon.Size = UDim2.new(0, 20, 0, 20)
Tab_Icon.BorderSizePixel = 0
Tab_Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tab_Icon.Parent = Tab

local Tab_Name = Instance.new("TextLabel")
Tab_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
Tab_Name.TextColor3 = Color3.fromRGB(115, 58, 173)
Tab_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab_Name.Text = "Aim"
Tab_Name.Name = "Tab_Name"
Tab_Name.AnchorPoint = Vector2.new(0.5, 0.5)
Tab_Name.Size = UDim2.new(0, 1, 0, 1)
Tab_Name.BackgroundTransparency = 1
Tab_Name.Position = UDim2.new(2.0999999046325684, 0, 0.4749999940395355, 0)
Tab_Name.BorderSizePixel = 0
Tab_Name.AutomaticSize = Enum.AutomaticSize.XY
Tab_Name.TextSize = 18
Tab_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tab_Name.Parent = Tab_Icon

local Tab = Instance.new("Frame")
Tab.Name = "Tab"
Tab.BackgroundTransparency = 1
Tab.Position = UDim2.new(1.0347222089767456, 0, 0.3054545521736145, 0)
Tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab.Size = UDim2.new(0, 95, 0, 42)
Tab.BorderSizePixel = 0
Tab.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
Tab.Parent = Header

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = Tab

local Tab_Icon = Instance.new("ImageLabel")
Tab_Icon.ImageColor3 = Color3.fromRGB(58, 58, 58)
Tab_Icon.ScaleType = Enum.ScaleType.Fit
Tab_Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab_Icon.Name = "Tab_Icon"
Tab_Icon.AnchorPoint = Vector2.new(0.5, 0.5)
Tab_Icon.Image = "rbxassetid://133833791023200"
Tab_Icon.BackgroundTransparency = 1
Tab_Icon.Position = UDim2.new(0.25789472460746765, 0, 0.5, 0)

Tab_Icon.Size = UDim2.new(0, 20, 0, 20)
Tab_Icon.BorderSizePixel = 0
Tab_Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tab_Icon.Parent = Tab

local Tab_Name = Instance.new("TextLabel")
Tab_Name.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
Tab_Name.TextColor3 = Color3.fromRGB(58, 58, 58)
Tab_Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab_Name.Text = "Aim"
Tab_Name.Name = "Tab_Name"
Tab_Name.AnchorPoint = Vector2.new(0.5, 0.5)
Tab_Name.Size = UDim2.new(0, 1, 0, 1)
Tab_Name.BackgroundTransparency = 1
Tab_Name.Position = UDim2.new(2.0999999046325684, 0, 0.4749999940395355, 0)
Tab_Name.BorderSizePixel = 0
Tab_Name.AutomaticSize = Enum.AutomaticSize.XY
Tab_Name.TextSize = 18
Tab_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tab_Name.Parent = Tab_Icon

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
    
    -- Set up UI toggle keybind
    if config.library_config and config.library_config.interface_keybind then
        local keybind = config.library_config.interface_keybind
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode[keybind] then
                ScreenGui.Enabled = not ScreenGui.Enabled
            end
        end)
    else
        -- Default Insert key
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Insert then
                ScreenGui.Enabled = not ScreenGui.Enabled
            end
        end)
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
        components = {}
    }
    
    -- Create tab button
    local tabFrame = Instance.new("Frame")
    tabFrame.Name = "Tab_" .. config.TabText
    tabFrame.Size = UDim2.new(0, 95, 0, 42)
    tabFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    tabFrame.Parent = Header
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 4)
    tabCorner.Parent = tabFrame
    
    local tabIcon = Instance.new("ImageLabel")
    tabIcon.ImageColor3 = Color3.fromRGB(58, 58, 58)
    tabIcon.ScaleType = Enum.ScaleType.Fit
    tabIcon.Image = config.icon or "rbxassetid://133833791023200"
    tabIcon.BackgroundTransparency = 1
    tabIcon.Size = UDim2.new(0, 20, 0, 20)
    tabIcon.Position = UDim2.new(0.25789472460746765, 0, 0.5, 0)
    tabIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    tabIcon.Parent = tabFrame
    
    local tabName = Instance.new("TextLabel")
    tabName.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
    tabName.TextColor3 = Color3.fromRGB(58, 58, 58)
    tabName.Text = config.TabText or "Tab"
    tabName.BackgroundTransparency = 1
    tabName.Size = UDim2.new(0, 1, 0, 1)
    tabName.Position = UDim2.new(2.0999999046325684, 0, 0.4749999940395355, 0)
    tabName.AnchorPoint = Vector2.new(0.5, 0.5)
    tabName.AutomaticSize = Enum.AutomaticSize.XY
    tabName.TextSize = 18
    tabName.Parent = tabIcon
    
    -- Tab click functionality
    local tabButton = Instance.new("TextButton")
    tabButton.BackgroundTransparency = 1
    tabButton.Size = UDim2.new(1, 0, 1, 0)
    tabButton.Parent = tabFrame
    
    tabButton.MouseButton1Click:Connect(function()
        -- Switch to this tab
        Library:SwitchTab(tab)
    end)
    
    -- Set as current tab if it's the first one
    if #CurrentWindow.tabs == 0 then
        Library:SwitchTab(tab)
    end
    
    table.insert(CurrentWindow.tabs, tab)
    return tab
end

function Library:SwitchTab(tab)
    if CurrentTab then
        -- Hide current tab sections
        for _, section in pairs(CurrentTab.sections.left) do
            section.frame.Visible = false
        end
        for _, section in pairs(CurrentTab.sections.right) do
            section.frame.Visible = false
        end
        
        -- Update tab appearance
        for _, tabFrame in pairs(Header:GetChildren()) do
            if tabFrame.Name:find("Tab_") then
                local icon = tabFrame:FindFirstChild("ImageLabel")
                local text = icon and icon:FindFirstChild("TextLabel")
                if icon and text then
                    icon.ImageColor3 = Color3.fromRGB(58, 58, 58)
                    text.TextColor3 = Color3.fromRGB(58, 58, 58)
                end
            end
        end
    end
    
    CurrentTab = tab
    
    -- Show new tab sections
    for _, section in pairs(tab.sections.left) do
        section.frame.Visible = true
    end
    for _, section in pairs(tab.sections.right) do
        section.frame.Visible = true
    end
    
    -- Update tab appearance
    for _, tabFrame in pairs(Header:GetChildren()) do
        if tabFrame.Name == "Tab_" .. tab.text then
            local icon = tabFrame:FindFirstChild("ImageLabel")
            local text = icon and icon:FindFirstChild("TextLabel")
            if icon and text then
                icon.ImageColor3 = Color3.fromRGB(115, 58, 173)
                text.TextColor3 = Color3.fromRGB(115, 58, 173)
            end
        end
    end
    
    -- Animate inline indicator
    local inlineTween = createTween(Inline, {Position = UDim2.new(0.7507575750350952, 0, 1, 0)}, 0.3)
    inlineTween:Play()
    
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
    
    section.frame = sectionFrame
    table.insert(CurrentTab.sections[position], section)
    
    return section
end

function Library:CreateToggle(config)
    if not CurrentTab or not CurrentTab.sections.left[1] and not CurrentTab.sections.right[1] then
        error("No section created. Call CreateSection first.")
        return
    end
    
    local section = CurrentTab.sections.left[1] or CurrentTab.sections.right[1]
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
    
    -- Click functionality
    local clickButton = Instance.new("TextButton")
    clickButton.BackgroundTransparency = 1
    clickButton.Size = UDim2.new(1, 0, 1, 0)
    clickButton.Parent = toggleFrame
    
    clickButton.MouseButton1Click:Connect(function()
        toggle.value = not toggle.value
        
        if toggle.value then
            -- Smooth grow animation
            local growTween = createTween(toggleFill, {Size = UDim2.new(0, 20, 0, 20)}, 0.2)
            growTween:Play()
            
            local iconTween = createTween(checkIcon, {ImageTransparency = 0}, 0.2)
            iconTween:Play()
        else
            -- Fast reverse effect
            local shrinkTween = createTween(toggleFill, {Size = UDim2.new(0, 0, 0, 0)}, 0.1)
            shrinkTween:Play()
            
            local iconTween = createTween(checkIcon, {ImageTransparency = 1}, 0.1)
            iconTween:Play()
        end
        
        toggle.callback(toggle.value)
    end)
    
    -- Initially hide the fill
    toggleFill.Size = UDim2.new(0, 0, 0, 0)
    checkIcon.ImageTransparency = 1
    
    table.insert(section.components, toggle)
    return toggle
end

function Library:CreateSlider(config)
    if not CurrentTab or not CurrentTab.sections.left[1] and not CurrentTab.sections.right[1] then
        error("No section created. Call CreateSection first.")
        return
    end
    
    local section = CurrentTab.sections.left[1] or CurrentTab.sections.right[1]
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

function Library:CreateTextInput(config)
    if not CurrentTab or not CurrentTab.sections.left[1] and not CurrentTab.sections.right[1] then
        error("No section created. Call CreateSection first.")
        return
    end
    
    local section = CurrentTab.sections.left[1] or CurrentTab.sections.right[1]
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

function Library:CreateKeybind(config)
    if not CurrentTab or not CurrentTab.sections.left[1] and not CurrentTab.sections.right[1] then
        error("No section created. Call CreateSection first.")
        return
    end
    
    local section = CurrentTab.sections.left[1] or CurrentTab.sections.right[1]
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
                if gameProcessed then return end
                
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    keybind.key = input.KeyCode.Name
                    keybindButton.Text = keybind.key
                    
                    -- Smooth animation back to normal
                    local normalTween = createTween(keybindButton, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
                    normalTween:Play()
                    
                    keybind.callback(keybind.key)
                    isListening = false
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    table.insert(section.components, keybind)
    return keybind
end

-- Return the library
return Library
