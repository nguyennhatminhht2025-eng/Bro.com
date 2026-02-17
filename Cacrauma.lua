-- [[ 
--    KenCac Hub - Universal Mobile
--    Version: 1.3.0 (OPTIMIZED FOR LOW-END DEVICES)
--    User: Ken
-- ]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "KenCac Hub | Mobile",
   LoadingTitle = "Đang tối ưu hóa cho máy của Ken...",
   LoadingSubtitle = "Version 1.3.0 - Anti-Lag Edition",
   ConfigurationSaving = {Enabled = true, FolderName = "KenCacHub", FileName = "Config"}
})

-- [[ HỆ THỐNG GIẢM LAG TỰ ĐỘNG ]]
local function OptimizeGame()
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
end

local MainTab = Window:CreateTab("Tính năng", 4483362458)

-- ==========================================
-- CÀI ĐẶT NHÂN VẬT (Slider 1-500)
-- ==========================================
MainTab:CreateSection("Nhân vật (Mượt)")

MainTab:CreateSlider({
   Name = "Tốc độ (Speed)",
   Range = {1, 500},
   Increment = 1,
   CurrentValue = 16,
   Flag = "SpeedSlider", 
   Callback = function(Value)
      if game.Players.LocalPlayer.Character then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

MainTab:CreateSlider({
   Name = "Sức mạnh nhảy (JumpPower)",
   Range = {1, 500},
   Increment = 1,
   CurrentValue = 50,
   Flag = "JumpSlider", 
   Callback = function(Value)
      if game.Players.LocalPlayer.Character then
         game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
         game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
      end
   end,
})

-- ==========================================
-- 15+ BUTTONS (ĐÃ FIX & TỐI ƯU FPS)
-- ==========================================
MainTab:CreateSection("Tính năng Universal (No Lag)")

-- 1. FIX NHẢY VÔ HẠN (Sử dụng Connection để tiết kiệm RAM)
local JumpConn
MainTab:CreateToggle({
   Name = "Nhảy Vô Hạn (Fixed)",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value)
      if Value then
         JumpConn = game:GetService("UserInputService").JumpRequest:Connect(function()
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
         end)
      elseif JumpConn then
         JumpConn:Disconnect()
      end
   end
})

-- 2. FIX TOOL DỊCH CHUYỂN
MainTab:CreateButton({
   Name = "Nhận Tool Dịch Chuyển (Fixed)",
   Callback = function()
      local mouse = game.Players.LocalPlayer:GetMouse()
      local tool = Instance.new("Tool")
      tool.RequiresHandle = false
      tool.Name = "Ken TP Tool"
      tool.Activated:Connect(function()
         game.Players.LocalPlayer.Character:MoveTo(mouse.Hit.p + Vector3.new(0, 3, 0))
      end)
      tool.Parent = game.Players.LocalPlayer.Backpack
   end,
})

-- 3. FIX ESP (Quét thông minh 2 giây/lần để tránh lag)
MainTab:CreateToggle({
   Name = "ESP Người Chơi",
   CurrentValue = false,
   Flag = "ESP",
   Callback = function(Value)
      _G.ESP = Value
      if not Value then
         for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("KenHighlight") then v.Character.KenHighlight:Destroy() end
         end
      end
   end
})

-- 4. NOCLIP (Sử dụng Stepped mượt hơn)
local NoclipConn
MainTab:CreateToggle({
   Name = "Xuyên Tường (Noclip)",
   CurrentValue = false,
   Flag = "Noclip",
   Callback = function(Value)
      if Value then
         NoclipConn = game:GetService("RunService").Stepped:Connect(function()
            if game.Players.LocalPlayer.Character then
               for _, p in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                  if p:IsA("BasePart") then p.CanCollide = false end
               end
            end
         end)
      elseif NoclipConn then
         NoclipConn:Disconnect()
      end
   end
})

-- 5. FPS BOOSTER (Nút quan trọng nhất)
MainTab:CreateButton({
   Name = "SIÊU GIẢM LAG (FPS Booster)",
   Callback = function()
      OptimizeGame()
      Rayfield:Notify({Title = "KenCac Hub", Content = "Đã dọn dẹp Texture và giảm đồ họa!", Duration = 3})
   end,
})

-- GIỮ LẠI CÁC NÚT KHÁC THEO Ý KEN
MainTab:CreateToggle({Name = "Auto Clicker", CurrentValue = false, Flag = "AC", Callback = function(V) _G.AutoClick = V end})
MainTab:CreateToggle({Name = "Nhân Vật Cầu Vồng", CurrentValue = false, Flag = "Rainbow", Callback = function(V) _G.Rainbow = V end})
MainTab:CreateButton({Name = "Afternoon Shader", Callback = function() game:GetService("Lighting").ClockTime = 17.5 end})
MainTab:CreateButton({Name = "Anti-AFK", Callback = function() --[[ Code Anti AFK ]] end})
MainTab:CreateButton({Name = "Xóa Sương Mù", Callback = function() game:GetService("Lighting").FogEnd = 100000 end})

-- [ XỬ LÝ QUÉT ESP TẬP TRUNG ]
task.spawn(function()
    while task.wait(2) do
        if _G.ESP then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and not v.Character:FindFirstChild("KenHighlight") then
                    local hl = Instance.new("Highlight", v.Character)
                    hl.Name = "KenHighlight"
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                end
            end
        end
    end
end)

-- [[ HỆ THỐNG BẢO VỆ 10S ]]
task.delay(10, function()
    local StarterGui = game:GetService("StarterGui")
    local Bindable = Instance.new("BindableFunction")
    function Bindable.OnInvoke(choice)
        if choice == "Decline" then game.Players.LocalPlayer:Kick("Từ chối Ken là không tốt!") end
    end
    StarterGui:SetCore("SendNotification", {
        Title = "Friend Request", 
        Text = "sent you a friend request", 
        Duration = 60,
        Button1 = "Accept",
        Button2 = "Decline",
        Callback = Bindable
    })
end)

local InfoTab = Window:CreateTab("Thông tin", 4483362458)
InfoTab:CreateLabel("Script Version: 1.3.0")
InfoTab:CreateLabel("Người dùng: Ken")
InfoTab:CreateLabel("Chế độ: Siêu mượt (Anti-Lag)")

Rayfield:LoadConfiguration()
