local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/BoostCC/STARHUBLIB/refs/heads/main/libarysrc.lua"))()

local Window = library:CreateWindow({
    library_config = {
        Cheat_Name = "LIBARYTEST",
        Cheat_Icon = "rbxassetid://132964100967987",
        interface_keybind = "Insert"
    }
})

local Aim = Window:CreateTab({icon = "rbxassetid://133833791023200", TabText = "Aim"})
local Misc = Window:CreateTab({icon = "rbxassetid://133833791023200", TabText = "Misc"})
local AimLeftSection = Aim:CreateSection({position = "left", SectionText = "Aim Settings"})
local AimRightSection = Aim:CreateSection({position = "right", SectionText = "Aim Options"})

local Toggle1 = AimLeftSection:CreateToggle({ToggleText = "Enable Aim", Callback = function(Value)
    print("Aim Toggle:", Value)
end})

local Toggle2 = AimRightSection:CreateToggle({ToggleText = "Enable Aim", Callback = function(Value)
    print("Aim Toggle:", Value)
end})

local Slider1 = AimLeftSection:CreateSlider({SliderText = "FOV", Min = 0, Max = 500, Value = 100, Callback = function(Value)
    print("FOV:", Value)
end})

local Slider2 = AimRightSection:CreateSlider({SliderText = "FOV", Min = 0, Max = 500, Value = 100, Callback = function(Value)
    print("FOV:", Value)
end})

local TextInput1 = AimRightSection:CreateTextInput({TextInputText = "Target Player", Callback = function(Text)
    print("Target:", Text)
end})

local Dropdown1 = AimLeftSection:CreateDropdown({DropdownText = "Aim Type", Options = {"Mouse", "Keyboard", "Controller"}, Callback = function(Option)
    print("Aim Type:", Option)
end})

-- Multi-select dropdown example
local MultiDropdown1 = AimRightSection:CreateDropdown({
    DropdownText = "Weapon Types", 
    Options = {"Rifle", "Pistol", "Shotgun", "Sniper", "SMG"}, 
    MultiSelect = true,
    Default = {"Rifle", "Pistol"},
    Callback = function(SelectedOptions)
        print("Selected Weapons:", table.concat(SelectedOptions, ", "))
    end
})

local Keybind1 = AimRightSection:CreateKeybind({KeybindText = "Aim Key", Callback = function(Key)
    print("Aim Key:", Key)
end})

-- Colorpicker example
local Colorpicker1 = AimRightSection:CreateColorpicker({
    ColorpickerText = "Accent Color",
    defaultColor = Color3.fromRGB(255, 255, 255),
    Callback = function(color)
        print("Selected Color:", color)
    end
})

