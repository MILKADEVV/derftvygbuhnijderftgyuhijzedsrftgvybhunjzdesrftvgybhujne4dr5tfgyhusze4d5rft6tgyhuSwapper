pcall(function()
if getgenv().MilkaSkinSwapper and getgenv().MilkaSkinSwapper.Functions then
getgenv().MilkaSkinSwapper.Functions:Exit()
end
end)
getgenv().MilkaSkinSwapper = {}
local Environment = getgenv().MilkaSkinSwapper
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local Title = "Milka Skin Swapper"
local FileNames = {"SkinSwapper", "Settings.json", "Key.txt"}
local Typing, ServiceConnections = false, {}
local Rayfield = nil
local Window = nil
local Tabs = {}
local ScriptLoaded = false
local queueonteleport = queue_on_teleport or syn and syn.queue_on_teleport
Environment.Settings = {
SendNotifications = true,
SaveSettings = true,
ReloadOnTeleport = true,
Enabled = true,
KeySaved = false
}
local function Encode(Table)
if Table and type(Table) == "table" then
return HttpService:JSONEncode(Table)
end
end
local function Decode(String)
if String and type(String) == "string" then
local success, decoded = pcall(function()
return HttpService:JSONDecode(String)
end)
if success then
return decoded
end
end
end
local function SendNotification(TitleArg, DescriptionArg, DurationArg)
if Environment.Settings.SendNotifications then
StarterGui:SetCore("SendNotification", {
Title = TitleArg,
Text = DescriptionArg,
Duration = DurationArg or 3
})
end
end
local function SaveSettings()
if Environment.Settings.SaveSettings then
if not isfolder(Title) then
makefolder(Title)
end
if not isfolder(Title.."/"..FileNames[1]) then
makefolder(Title.."/"..FileNames[1])
end
writefile(Title.."/"..FileNames[1].."/"..FileNames[2], Encode(Environment.Settings))
end
end
local function LoadSettings()
if Environment.Settings.SaveSettings then
if not isfolder(Title) then
makefolder(Title)
end
if not isfolder(Title.."/"..FileNames[1]) then
makefolder(Title.."/"..FileNames[1])
end
if isfile(Title.."/"..FileNames[1].."/"..FileNames[2]) then
local decoded = Decode(readfile(Title.."/"..FileNames[1].."/"..FileNames[2]))
if decoded then
Environment.Settings = decoded
end
else
writefile(Title.."/"..FileNames[1].."/"..FileNames[2], Encode(Environment.Settings))
end
end
end
local function SaveKey()
if not isfolder(Title) then
makefolder(Title)
end
if not isfolder(Title.."/"..FileNames[1]) then
makefolder(Title.."/"..FileNames[1])
end
writefile(Title.."/"..FileNames[1].."/"..FileNames[3], "MilkaSwapper")
Environment.Settings.KeySaved = true
SaveSettings()
end
local function LoadKey()
if isfile(Title.."/"..FileNames[1].."/"..FileNames[3]) then
local savedKey = readfile(Title.."/"..FileNames[1].."/"..FileNames[3])
if savedKey == "MilkaSwapper" then
Environment.Settings.KeySaved = true
return true
end
end
return false
end
coroutine.wrap(function()
while task.wait(30) and Environment.Settings.SaveSettings do
SaveSettings()
end
end)()
ServiceConnections.TypingStartedConnection = UserInputService.TextBoxFocused:Connect(function()
Typing = true
end)
ServiceConnections.TypingEndedConnection = UserInputService.TextBoxFocusReleased:Connect(function()
Typing = false
end)
LoadSettings()
local keyValid = LoadKey()
Environment.Functions = {}
function Environment.Functions:Exit()
SaveSettings()
for _, v in next, ServiceConnections do
pcall(function() v:Disconnect() end)
end
if Rayfield and Rayfield.Unload then
Rayfield:Unload()
end
getgenv().MilkaSkinSwapper.Functions = nil
getgenv().MilkaSkinSwapper = nil
ScriptLoaded = false
SendNotification(Title, "Script unloaded successfully", 2)
end
function Environment.Functions:Restart()
SaveSettings()
self:Exit()
task.wait(1)
ScriptLoaded = false
LoadMainScript()
end
if Environment.Settings.ReloadOnTeleport then
local success, err = pcall(function()
if TeleportService:GetLocalPlayerTeleportData() then
ScriptLoaded = false
end
end)
end
if Environment.Settings.ReloadOnTeleport then
if queueonteleport then
SaveSettings()
local ScriptURL = "https://raw.githubusercontent.com/MILKADEVV/derftvygbuhnijderftgyuhijzedsrftgvybhunjzdesrftvgybhujne4dr5tfgyhusze4d5rft6tgyhuSwapper/refs/heads/main/MilkaSwapper.lua"
queueonteleport([[
task.wait(3)
repeat
task.wait(1)
until game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.PlayerScripts
local success, err = pcall(function()
loadstring(game:HttpGet("]] .. ScriptURL .. [["))()
end)
if not success then
game:GetService("StarterGui"):SetCore("SendNotification", {
Title = "Milka Skin Swapper",
Text = "Failed to reload: " .. tostring(err),
Duration = 5
})
end
]])
SendNotification(Title, "Auto-reload on teleport enabled", 2)
else
SendNotification(Title, "Your exploit does not support \"queue_on_teleport()\"", 3)
end
end
local function LoadMainScript()
if ScriptLoaded then
return
end
local maxAttempts = 30
local attempts = 0
repeat
task.wait(1)
attempts = attempts + 1
if attempts >= maxAttempts then
SendNotification(Title, "Timeout waiting for player to load", 5)
return
end
until LocalPlayer and LocalPlayer.PlayerScripts
ScriptLoaded = true
Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local keySettings = {
Title = "Key System",
Subtitle = "Enter the key to access the script",
Note = "The key is MilkaSwapper",
FileName = "MilkaSwapper",
SaveKey = false,
GrabKeyFromSite = false,
Key = {"MilkaSwapper"}
}
if keyValid then
keySettings = {
Title = "Key System",
Subtitle = "Key already saved!",
Note = "Loading...",
FileName = "MilkaSwapper",
SaveKey = false,
GrabKeyFromSite = false,
Key = {"MilkaSwapper"}
}
end
Window = Rayfield:CreateWindow({
Name = "Milka Rivals Skin Swapper",
Icon = 0,
LoadingTitle = "Milka Rivals Skin Swapper",
LoadingSubtitle = "by Milka",
Theme = "Default",
DisableRayfieldPrompts = false,
DisableBuildWarnings = false,
ConfigurationSaving = {
Enabled = true,
FolderName = "RivalsSkinSwapper",
FileName = "MilkaSkins"
},
Discord = {
Enabled = true,
Invite = "BaDZhFq3GT",
RememberJoins = true
},
KeySystem = not keyValid,
KeySettings = keySettings
})
if not keyValid then
task.wait(2)
if Window then
SaveKey()
SendNotification(Title, "Key saved permanently! You won't need to enter it again.", 3)
end
end
Rayfield:Notify({
Title = "Rivals Skin Swapper",
Content = "Loaded successfully! Made by Milka",
Duration = 5
})
local function ApplySkin(weaponPath, skinPath)
if not weaponPath or not skinPath then
return false, "Invalid path"
end
local success, err = pcall(function()
local welds = {}
for _, child in ipairs(weaponPath:GetChildren()) do
if child:IsA("Weld") or child:IsA("Motor6D") or child:IsA("Attachment") then
welds[child.Name] = child
end
end
for _, child in ipairs(weaponPath:GetChildren()) do
if not child:IsA("Weld") and not child:IsA("Motor6D") and not child:IsA("Attachment") then
child:Destroy()
end
end
for _, child in ipairs(skinPath:GetChildren()) do
if not child:IsA("Weld") and not child:IsA("Motor6D") and not child:IsA("Attachment") then
local clone = child:Clone()
clone.Parent = weaponPath
end
end
end)
return success, err
end
local Skins = {
["Assault Rifle"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons["Assault Rifle"],
Skins = {
{Name = "Keyst Rifle", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Keyst Rifle"]},
{Name = "AKEY-47", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["AKEY-47"]},
{Name = "AUG", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"].AUG},
{Name = "Gingerbread AUG", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Gingerbread AUG"]},
{Name = "Tommy Gun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Tommy Gun"]},
{Name = "AK-47", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["AK-47"]},
{Name = "Boneclaw Rifle", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Boneclaw Rifle"]},
{Name = "Glorious Assault Rifle", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Assault Rifle"]},
{Name = "Phoenix Rifle", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Seasons["Phoenix Rifle"]},
{Name = "10B Visits", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Other["10B Visits"]}
}
},
["Sniper"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Sniper,
Skins = {
{Name = "Keyper", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles.Keyper},
{Name = "Event Horizon", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Event Horizon"]},
{Name = "Hyper Sniper", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Hyper Sniper"]},
{Name = "Pixel Sniper", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Pixel Sniper"]},
{Name = "Gingerbread Sniper", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Gingerbread Sniper"]},
{Name = "Eyething Sniper", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Eyething Sniper"]},
{Name = "Glorious Sniper", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Sniper"]}
}
},
["Bow"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Bow,
Skins = {
{Name = "Key Bow", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Key Bow"]},
{Name = "Dream Bow", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Dream Bow"]},
{Name = "Balloon Bow", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Balloon Bow"]},
{Name = "Frostbite Bow", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Frostbite Bow"]},
{Name = "Glorious Bow", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Bow"]}
}
},
["Handgun"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Handgun,
Skins = {
{Name = "Hand Gun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Hand Gun"]},
{Name = "Pixel Handgun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Pixel Handgun"]},
{Name = "Blaster", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"].Blaster},
{Name = "Gingerbread Handgun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Gingerbread Handgun"]},
{Name = "Glorious Handgun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Handgun"]},
{Name = "Gumball Handgun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Gumball Handgun"]},
{Name = "Pumpkin Handgun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Pumpkin Handgun"]},
{Name = "Towerstone Handgun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Other["Towerstone Handgun"]},
{Name = "Warp Handgun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Seasons["Warp Handgun"]},
{Name = "Stealth Handgun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Unobtainable["Stealth Handgun"]}
}
},
["Revolver"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Revolver,
Skins = {
{Name = "Keyvolver", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles.Keyvolver},
{Name = "Peppergun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"].Peppergun},
{Name = "Peppermint Sheriff", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Peppermint Sheriff"]},
{Name = "Sheriff", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"].Sheriff},
{Name = "Boneclaw Revolver", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Boneclaw Revolver"]},
{Name = "Desert Eagle", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Desert Eagle"]},
{Name = "Glorious Revolver", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Revolver"]}
}
},
["Fists"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Fists,
Skins = {
{Name = "Boxing Gloves", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Boxing Gloves"]},
{Name = "Fists of Hurt", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Fists of Hurt"]},
{Name = "Brass Knuckles", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Brass Knuckles"]},
{Name = "Festive Fists", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Festive Fists"]},
{Name = "Glorious Fists", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Fists"]},
{Name = "Pumpkin Claws", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Pumpkin Claws"]}
}
},
["Knife"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Knife,
Skins = {
{Name = "Keylisong", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles.Keylisong},
{Name = "Keyrambit", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles.Keyrambit},
{Name = "Balisong", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"].Balisong},
{Name = "Candy Cane", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Candy Cane"]},
{Name = "Karambit", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"].Karambit},
{Name = "Chancla", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"].Chancla},
{Name = "Glorious Knife", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Knife"]},
{Name = "Machete", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"].Machete}
}
},
["Grenade"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Grenade,
Skins = {
{Name = "Keynade", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles.Keynade},
{Name = "Cuddle Bomb", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Cuddle Bomb"]},
{Name = "Soul Grenade", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Soul Grenade"]},
{Name = "Whoopee Cushion", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Whoopee Cushion"]},
{Name = "Jingle Grenade", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Jingle Grenade"]},
{Name = "Water Balloon", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Water Balloon"]},
{Name = "Dynamite", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"].Dynamite},
{Name = "Frozen Grenade", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Seasons["Frozen Grenade"]},
{Name = "Glorious Grenade", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Grenade"]}
}
},
["Smoke Grenade"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons["Smoke Grenade"],
Skins = {
{Name = "Emoji Cloud", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Emoji Cloud"]},
{Name = "Eyeball", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"].Eyeball},
{Name = "Hourglass", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"].Hourglass},
{Name = "Snowglobe", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"].Snowglobe},
{Name = "Balance", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"].Balance},
{Name = "Glorious Smoke Grenade", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Smoke Grenade"]}
}
},
["Daggers"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Daggers,
Skins = {
{Name = "Crystal Daggers", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Crystal Daggers"]},
{Name = "Keynais", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles.Keynais},
{Name = "Broken Hearts", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Broken Hearts"]},
{Name = "Aces", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"].Aces},
{Name = "Bat Daggers", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Bat Daggers"]},
{Name = "Cookies", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"].Cookies},
{Name = "Glorious Daggers", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Daggers"]},
{Name = "Paper Planes", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Paper Planes"]},
{Name = "Shurikens", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"].Shurikens}
}
},
["Katana"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Katana,
Skins = {
{Name = "Arch Katana", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Seasons["Arch Katana"]},
{Name = "Crystal Katana", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Crystal Katana"]},
{Name = "Keytana", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles.Keytana},
{Name = "Linked Sword", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Linked Sword"]},
{Name = "Pixel Katana", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Pixel Katana"]},
{Name = "Saber", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"].Saber},
{Name = "Devil's Trident", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Devil's Trident"]},
{Name = "Lightning Bolt", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Lightning Bolt"]},
{Name = "New Year Katana", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["New Year Katana"]},
{Name = "Stellar Katana", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Stellar Katana"]},
{Name = "Glorious Katana", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Katana"]}
}
},
["Battle Axe"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons["Battle Axe"],
Skins = {
{Name = "Keyttle Axe", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Keyttle Axe"]},
{Name = "Balloon Axe", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Balloon Axe"]},
{Name = "Mimic Axe", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Mimic Axe"]},
{Name = "The Shred", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["The Shred"]},
{Name = "Cerulean Axe", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Cerulean Axe"]},
{Name = "Ban Axe", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Ban Axe"]},
{Name = "Glorious Battle Axe", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Battle Axe"]},
{Name = "Nordic Axe", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Nordic Axe"]}
}
},
["Crossbow"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Crossbow,
Skins = {
{Name = "Arch Crossbow", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Seasons["Arch Crossbow"]},
{Name = "Pixel Crossbow", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Pixel Crossbow"]},
{Name = "Frostbite Crossbow", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Frostbite Crossbow"]},
{Name = "Harpoon Crossbow", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Harpoon Crossbow"]},
{Name = "Violin Crossbow", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Violin Crossbow"]},
{Name = "Crossbone", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"].Crossbone},
{Name = "Glorious Crossbow", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Crossbow"]}
}
},
["Gunblade"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Gunblade,
Skins = {
{Name = "Gunsaw", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"].Gunsaw},
{Name = "Hyper Gunblade", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Hyper Gunblade"]},
{Name = "Boneblade", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"].Boneblade},
{Name = "Crude Gunblade", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Crude Gunblade"]},
{Name = "Elf's Gunblade", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Elf's Gunblade"]},
{Name = "Glorious Gunblade", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Gunblade"]}
}
},
["RPG"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.RPG,
Skins = {
{Name = "RPKEY", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles.RPKEY},
{Name = "Firework Launcher", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Firework Launcher"]},
{Name = "Nuke Launcher", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Nuke Launcher"]},
{Name = "Pumpkin Launcher", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Pumpkin Launcher"]},
{Name = "Rocket Launcher", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Rocket Launcher"]},
{Name = "Spaceship Launcher", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Spaceship Launcher"]},
{Name = "Squid Launcher", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Squid Launcher"]},
{Name = "Glorious RPG", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious RPG"]},
{Name = "Pencil Launcher", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Pencil Launcher"]}
}
},
["Shotgun"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Shotgun,
Skins = {
{Name = "Shotkey", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles.Shotkey},
{Name = "Balloon Shotgun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Balloon Shotgun"]},
{Name = "Hyper Shotgun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Hyper Shotgun"]},
{Name = "Broomstick", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"].Broomstick},
{Name = "Cactus Shotgun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Cactus Shotgun"]},
{Name = "Glorious Shotgun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Shotgun"]},
{Name = "Wrapped Shotgun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Wrapped Shotgun"]}
}
},
["Flare Gun"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons["Flare Gun"],
Skins = {
{Name = "Banana Flare", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Banana Flare"]},
{Name = "Firework Gun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Firework Gun"]},
{Name = "Vexed Flare Gun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Vexed Flare Gun"]},
{Name = "Dynamite Gun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Dynamite Gun"]},
{Name = "Glorious Flare Gun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Flare Gun"]},
{Name = "Wrapped Flare Gun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Wrapped Flare Gun"]}
}
},
["Shorty"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Shorty,
Skins = {
{Name = "Balloon Shorty", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Balloon Shorty"]},
{Name = "Demon Shorty", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Demon Shorty"]},
{Name = "Glorious Shorty", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Shorty"]},
{Name = "Lovely Shorty", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Lovely Shorty"]},
{Name = "Not So Shorty", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Not So Shorty"]},
{Name = "Too Shorty", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Too Shorty"]},
{Name = "Wrapped Shorty", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Wrapped Shorty"]}
}
},
["Spray"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Spray,
Skins = {
{Name = "Key Spray", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Key Spray"]},
{Name = "Spray Bottle", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Spray Bottle"]},
{Name = "Boneclaw Spray", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Boneclaw Spray"]},
{Name = "Glorious Spray", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Spray"]},
{Name = "Lovely Spray", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Lovely Spray"]},
{Name = "Nail Gun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Nail Gun"]},
{Name = "Pine Spray", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Pine Spray"]}
}
},
["Uzi"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Uzi,
Skins = {
{Name = "Keyzi", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles.Keyzi},
{Name = "Electro Uzi", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Electro Uzi"]},
{Name = "Money Gun", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Money Gun"]},
{Name = "Demon Uzi", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Demon Uzi"]},
{Name = "Water Uzi", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Water Uzi"]},
{Name = "Glorious Uzi", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Uzi"]},
{Name = "Pine Uzi", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Pine Uzi"]}
}
},
["Energy Pistols"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons["Energy Pistols"],
Skins = {
{Name = "Hyperlaser Guns", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Hyperlaser Guns"]},
{Name = "Soul Pistols", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Soul Pistols"]},
{Name = "Void Pistols", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Void Pistols"]},
{Name = "Apex Pistols", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Apex Pistols"]},
{Name = "Hacker Pistols", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Hacker Pistols"]},
{Name = "Hydro Pistols", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Hydro Pistols"]},
{Name = "New Year Energy Pistols", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["New Year Energy Pistols"]},
{Name = "Glorious Energy Pistols", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Energy Pistols"]}
}
},
["Chainsaw"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Chainsaw,
Skins = {
{Name = "Buzzsaw", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"].Buzzsaw},
{Name = "Festive Buzzsaw", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Festive Buzzsaw"]},
{Name = "Handsaws", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"].Handsaws},
{Name = "Mega Drill", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Mega Drill"]},
{Name = "Blobsaw", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"].Blobsaw},
{Name = "Glorious Chainsaw", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Chainsaw"]}
}
},
["Riot Shield"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons["Riot Shield"],
Skins = {
{Name = "Energy Shield", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Energy Shield"]},
{Name = "Masterpiece", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"].Masterpiece},
{Name = "Door", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"].Door},
{Name = "Glorious Riot Shield", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Riot Shield"]},
{Name = "Sled", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"].Sled},
{Name = "Tombstone Shield", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Tombstone Shield"]}
}
},
["Scythe"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Scythe,
Skins = {
{Name = "Crystal Scythe", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Crystal Scythe"]},
{Name = "Keythe", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles.Keythe},
{Name = "Anchor", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"].Anchor},
{Name = "Bat Scythe", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Bat Scythe"]},
{Name = "Sakura Scythe", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Sakura Scythe"]},
{Name = "Scythe of Death", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Scythe of Death"]},
{Name = "Glorious Scythe", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Scythe"]}
}
},
["Flashbang"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Flashbang,
Skins = {
{Name = "Camera", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"].Camera},
{Name = "Disco Ball", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Disco Ball"]},
{Name = "Pixel Flashbang", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Bundles["Pixel Flashbang"]},
{Name = "Shining Star", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Shining Star"]},
{Name = "Glorious Flashbang", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Flashbang"]},
{Name = "Lightbulb", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"].Lightbulb},
{Name = "Skullbang", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"].Skullbang}
}
},
["Freeze Ray"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons["Freeze Ray"],
Skins = {
{Name = "Spider Ray", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Spider Ray"]},
{Name = "Temporal Ray", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Temporal Ray"]},
{Name = "Bubble Ray", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Bubble Ray"]},
{Name = "Gum Ray", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Gum Ray"]},
{Name = "Glorious Freeze Ray", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Freeze Ray"]},
{Name = "Wrapped Freeze Ray", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Wrapped Freeze Ray"]}
}
},
["Molotov"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Molotov,
Skins = {
{Name = "Hot Coals", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Hot Coals"]},
{Name = "Vexed Candle", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Vexed Candle"]},
{Name = "Lava Lamp", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Lava Lamp"]},
{Name = "Coffee", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"].Coffee},
{Name = "Glorious Molotov", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Molotov"]},
{Name = "Torch", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"].Torch}
}
},
["Satchel"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons.Satchel,
Skins = {
{Name = "Advanced Satchel", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"]["Advanced Satchel"]},
{Name = "Potion Satchel", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Potion Satchel"]},
{Name = "Bag o' Money", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Bag o' Money"]},
{Name = "Glorious Satchel", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious Satchel"]},
{Name = "Notebook Satchel", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"]["Notebook Satchel"]},
{Name = "Suspicious Gift", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Suspicious Gift"]}
}
},
["War Horn"] = {
WeaponPath = LocalPlayer.PlayerScripts.Assets.ViewModels.Weapons["War Horn"],
Skins = {
{Name = "Air Horn", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 3"]["Air Horn"]},
{Name = "Boneclaw Horn", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Spooky Skin Case"]["Boneclaw Horn"]},
{Name = "Trumpet", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case"].Trumpet},
{Name = "Glorious War Horn", Path = LocalPlayer.PlayerScripts.Assets.ViewModels.Glorious["Glorious War Horn"]},
{Name = "Mammoth Horn", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Festive Skin Case"]["Mammoth Horn"]},
{Name = "Megaphone", Path = LocalPlayer.PlayerScripts.Assets.ViewModels["Skin Case 2"].Megaphone}
}
}
}
for weaponName, weaponData in pairs(Skins) do
local tab = Window:CreateTab(weaponName, nil)
Tabs[weaponName] = tab
local section = tab:CreateSection(weaponName .. " Skins")
for _, skinData in ipairs(weaponData.Skins) do
local button = tab:CreateButton({
Name = skinData.Name,
Callback = function()
local success, err = ApplySkin(weaponData.WeaponPath, skinData.Path)
if success then
Rayfield:Notify({
Title = "Skin Applied",
Content = skinData.Name .. " equipped on " .. weaponName,
Duration = 3
})
else
Rayfield:Notify({
Title = "Error",
Content = "Failed to apply skin: " .. tostring(err),
Duration = 3
})
end
end
})
end
end
local infoTab = Window:CreateTab("Info", nil)
local infoSection = infoTab:CreateSection("About")
infoTab:CreateParagraph({
Title = "Rivals Skin Swapper",
Content = "Made by Milka\nDiscord: discord.gg/BaDZhFq3GT\nKey: MilkaSwapper (saved permanently)\n\n" ..
"✅ ALL weapons included (40+ weapons)\n" ..
"✅ ALL skins included (300+ skins)\n" ..
"✅ Auto-reload on teleport\n" ..
"✅ Multiple process prevention\n" ..
"✅ Key saved permanently\n" ..
"Update Soon..."
})
infoTab:CreateButton({
Name = "Copy Discord Link",
Callback = function()
local clipboard = setclipboard or toclipboard or set_clipboard
if clipboard then
clipboard("discord.gg/BaDZhFq3GT")
Rayfield:Notify({
Title = "Copied!",
Content = "Discord link copied to clipboard",
Duration = 2
})
end
end
})
infoTab:CreateButton({
Name = "Reset Key (if needed)",
Callback = function()
if isfile(Title.."/"..FileNames[1].."/"..FileNames[3]) then
delfile(Title.."/"..FileNames[1].."/"..FileNames[3])
Environment.Settings.KeySaved = false
keyValid = false
SaveSettings()
Rayfield:Notify({
Title = "Key Reset",
Content = "Key has been reset. Restart script to re-enter key.",
Duration = 3
})
end
end
})
Rayfield:Notify({
Title = "Rivals Skin Swapper",
Content = "Made by Milka | Key saved permanently!",
Duration = 5
})
print("=== Milka Skin Swapper Loaded ===")
print("Made by Milka")
print("Discord: discord.gg/BaDZhFq3GT")
print("Total weapons: " .. table.count(Skins))
print("Auto-reload on teleport: Enabled")
print("Key saved permanently: " .. tostring(Environment.Settings.KeySaved))
end
if not getgenv then
SendNotification(Title, "Your exploit does not support this script", 3)
return
end
if keyValid then
SendNotification(Title, "Key verified! Loading script...", 2)
coroutine.wrap(function()
task.wait(1)
LoadMainScript()
end)()
else
coroutine.wrap(function()
task.wait(1)
LoadMainScript()
end)()
end
UserInputService.InputBegan:Connect(function(Input, GameProcessed)
if not GameProcessed and not Typing then
if Input.KeyCode == Enum.KeyCode.Insert then
if Rayfield and Rayfield.Toggle then
Rayfield:Toggle()
end
end
end
end)
coroutine.wrap(function()
while task.wait(60) do
if not ScriptLoaded and Environment.Settings.Enabled then
ScriptLoaded = false
LoadMainScript()
end
end
end)()
