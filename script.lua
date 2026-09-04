--// FFH4X - nFXNOBRU1
--// LocalScript em:
--// StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--==================================================
-- CONFIG
--==================================================

local Aimbot = false
local BoxESP = false
local LineESP = false
local HealthESP = false
local Noclip = false
local Spin = false
local FPSBoost = false

local FOV = 180
local SpinSpeed = 35

local CurrentTarget = nil

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "FFH4X_nFXNOBRU1"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = LP:WaitForChild("PlayerGui")

local function Corner(obj, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius)
	c.Parent = obj
end

local function RGB()
	return Color3.fromHSV((tick() * 0.18) % 1, 1, 1)
end

--==================================================
-- BOTÃO FLUTUANTE
--==================================================

local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.fromOffset(58, 58)
OpenButton.Position = UDim2.fromOffset(20, 300)
OpenButton.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
OpenButton.Text = "F"
OpenButton.TextColor3 = Color3.new(1, 1, 1)
OpenButton.TextSize = 25
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Parent = Gui

Corner(OpenButton, 50)

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Thickness = 3
OpenStroke.Parent = OpenButton

--==================================================
-- MENU
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(340, 520)
Main.Position = UDim2.new(0.5, -170, 0.5, -260)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Main.BorderSizePixel = 0
Main.Parent = Gui

Corner(Main, 16)

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Parent = Main

--==================================================
-- CABEÇALHO
--==================================================

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, -10, 0, 65)
Header.Position = UDim2.fromOffset(5, 5)
Header.BackgroundTransparency = 1
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -55, 1, 0)
Title.Position = UDim2.fromOffset(10, 0)
Title.BackgroundTransparency = 1
Title.Text = "FFH4X - nFXNOBRU1"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(42, 42)
Close.Position = UDim2.new(1, -47, 0, 10)
Close.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Close.Text = "×"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.TextSize = 26
Close.Font = Enum.Font.GothamBold
Close.Parent = Header

Corner(Close, 9)

--==================================================
-- ÁREA DOS BOTÕES
--==================================================

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -80)
Scroll.Position = UDim2.fromOffset(10, 70)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 4
Scroll.CanvasSize = UDim2.fromOffset(0, 650)
Scroll.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 8)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.Parent = Scroll

--==================================================
-- TOGGLE
--==================================================

local function CreateToggle(text, callback)

	local Button = Instance.new("TextButton")

	Button.Size = UDim2.fromOffset(300, 42)
	Button.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
	Button.Text = text .. "  [OFF]"
	Button.TextColor3 = Color3.new(1, 1, 1)
	Button.TextSize = 14
	Button.Font = Enum.Font.GothamBold
	Button.Parent = Scroll

	Corner(Button, 9)

	local enabled = false

	Button.MouseButton1Click:Connect(function()

		enabled = not enabled

		if enabled then
			Button.Text = text .. "  [ON]"
			Button.BackgroundColor3 = Color3.fromRGB(30, 125, 65)
		else
			Button.Text = text .. "  [OFF]"
			Button.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
		end

		callback(enabled)
	end)

	return Button
end

--==================================================
-- RECURSOS
--==================================================

CreateToggle("🔥 AIMBOT RAGE", function(v)

	Aimbot = v

	if not v then
		CurrentTarget = nil
	end
end)

CreateToggle("📦 ESP BOX", function(v)
	BoxESP = v
end)

CreateToggle("📏 ESP LINE", function(v)
	LineESP = v
end)

CreateToggle("❤️ ESP VIDA", function(v)
	HealthESP = v
end)

CreateToggle("🌀 SPIN", function(v)
	Spin = v
end)

CreateToggle("👻 NOCLIP", function(v)
	Noclip = v
end)

CreateToggle("⚡ FPS BOOST", function(v)

	FPSBoost = v

	if v then

		Lighting.GlobalShadows = false

		for _, obj in ipairs(workspace:GetDescendants()) do

			if obj:IsA("ParticleEmitter")
				or obj:IsA("Trail")
				or obj:IsA("Beam")
				or obj:IsA("Smoke")
				or obj:IsA("Fire")
				or obj:IsA("Sparkles") then

				obj.Enabled = false
			end
		end
	end
end)

--==================================================
-- FOV
--==================================================

local FOVLabel = Instance.new("TextLabel")
FOVLabel.Size = UDim2.fromOffset(300, 32)
FOVLabel.BackgroundTransparency = 1
FOVLabel.Text = "FOV: 180"
FOVLabel.TextColor3 = Color3.new(1, 1, 1)
FOVLabel.TextSize = 14
FOVLabel.Font = Enum.Font.GothamBold
FOVLabel.Parent = Scroll

local FOVButton = Instance.new("TextButton")
FOVButton.Size = UDim2.fromOffset(300, 40)
FOVButton.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
FOVButton.Text = "ALTERAR FOV"
FOVButton.TextColor3 = Color3.new(1, 1, 1)
FOVButton.TextSize = 14
FOVButton.Font = Enum.Font.GothamBold
FOVButton.Parent = Scroll

Corner(FOVButton, 9)

FOVButton.MouseButton1Click:Connect(function()

	FOV += 25

	if FOV > 500 then
		FOV = 50
	end

	FOVLabel.Text = "FOV: " .. FOV
end)

--==================================================
-- CÍRCULO DO FOV
--==================================================

local FOVCircle = Instance.new("Frame")
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.Position = UDim2.fromScale(0.5, 0.5)
FOVCircle.BackgroundTransparency = 1
FOVCircle.Parent = Gui

Corner(FOVCircle, 100)

local FOVStroke = Instance.new("UIStroke")
FOVStroke.Thickness = 2
FOVStroke.Parent = FOVCircle

--==================================================
-- ESP SEM HIGHLIGHT
--==================================================

local ESP = {}

local function CreateESP(player)

	if player == LP then
		return
	end

	local Holder = Instance.new("ScreenGui")
	Holder.Name = "ESP_" .. player.Name
	Holder.IgnoreGuiInset = true
	Holder.ResetOnSpawn = false
	Holder.Parent = Gui

	local Box = Instance.new("Frame")
	Box.BackgroundTransparency = 1
	Box.BorderSizePixel = 0
	Box.Visible = false
	Box.Parent = Holder

	local Top = Instance.new("Frame")
	local Bottom = Instance.new("Frame")
	local Left = Instance.new("Frame")
	local Right = Instance.new("Frame")

	for _, obj in ipairs({
		Top,
		Bottom,
		Left,
		Right
	}) do
		obj.BorderSizePixel = 0
		obj.Parent = Box
	end

	local Line = Instance.new("Frame")
	Line.AnchorPoint = Vector2.new(0, 0.5)
	Line.BorderSizePixel = 0
	Line.Visible = false
	Line.Parent = Holder

	local HealthBack = Instance.new("Frame")
	HealthBack.BorderSizePixel = 0
	HealthBack.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	HealthBack.Visible = false
	HealthBack.Parent = Holder

	local Health = Instance.new("Frame")
	Health.BorderSizePixel = 0
	Health.AnchorPoint = Vector2.new(0, 1)
	Health.Parent = HealthBack

	ESP[player] = {
		Holder = Holder,
		Box = Box,
		Top = Top,
		Bottom = Bottom,
		Left = Left,
		Right = Right,
		Line = Line,
		HealthBack = HealthBack,
		Health = Health
	}
end

for _, player in ipairs(Players:GetPlayers()) do
	CreateESP(player)
end

Players.PlayerAdded:Connect(CreateESP)

Players.PlayerRemoving:Connect(function(player)

	if CurrentTarget
		and player.Character
		and CurrentTarget:IsDescendantOf(player.Character) then

		CurrentTarget = nil
	end

	if ESP[player] then
		ESP[player].Holder:Destroy()
		ESP[player] = nil
	end
end)

--==================================================
-- AIMBOT
--==================================================

local function IsTargetAlive(Head)

	if not Head then
		return false
	end

	if not Head.Parent then
		return false
	end

	local Character = Head.Parent
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return false
	end

	return Humanoid.Health > 0
end

local function GetTarget()

	if IsTargetAlive(CurrentTarget) then
		return CurrentTarget
	end

	CurrentTarget = nil

	local Target = nil
	local Closest = math.huge

	local Center = Vector2.new(
		Camera.ViewportSize.X / 2,
		Camera.ViewportSize.Y / 2
	)

	for _, player in ipairs(Players:GetPlayers()) do

		if player ~= LP and player.Character then

			local Head = player.Character:FindFirstChild("Head")
			local Humanoid = player.Character:FindFirstChildOfClass("Humanoid")

			if Head and Humanoid and Humanoid.Health > 0 then

				local Position, Visible =
					Camera:WorldToViewportPoint(Head.Position)

				if Visible and Position.Z > 0 then

					local Distance =
						(
							Vector2.new(Position.X, Position.Y)
							- Center
						).Magnitude

					if Distance <= FOV
						and Distance < Closest then

						Closest = Distance
						Target = Head
					end
				end
			end
		end
	end

	CurrentTarget = Target

	return CurrentTarget
end

--==================================================
-- LOOP
--==================================================

RunService.RenderStepped:Connect(function()

	Camera = workspace.CurrentCamera

	local Color = RGB()

	MainStroke.Color = Color
	OpenStroke.Color = Color
	FOVStroke.Color = Color

	FOVCircle.Size =
		UDim2.fromOffset(
			FOV * 2,
			FOV * 2
		)

	--==================================================
	-- AIMBOT
	--==================================================

	if Aimbot then

		local Target = GetTarget()

		if Target and IsTargetAlive(Target) then

			Camera.CFrame =
				CFrame.lookAt(
					Camera.CFrame.Position,
					Target.Position
				)
		end
	end

	--==================================================
	-- NOCLIP
	--==================================================

	if Noclip and LP.Character then

		for _, part in ipairs(
			LP.Character:GetDescendants()
		) do

			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end

	--==================================================
	-- SPIN
	--==================================================

	if Spin and LP.Character then

		local Root =
			LP.Character:FindFirstChild(
				"HumanoidRootPart"
			)

		if Root then

			Root.CFrame =
				Root.CFrame *
				CFrame.Angles(
					0,
					math.rad(SpinSpeed),
					0
				)
		end
	end

	--==================================================
	-- ESP
	--==================================================

	for player, data in pairs(ESP) do

		local Character = player.Character

		local Root =
			Character
			and Character:FindFirstChild(
				"HumanoidRootPart"
			)

		local Head =
			Character
			and Character:FindFirstChild("Head")

		local Humanoid =
			Character
			and Character:FindFirstChildOfClass(
				"Humanoid"
			)

		if Root
			and Head
			and Humanoid
			and Humanoid.Health > 0 then

			local Position, Visible =
				Camera:WorldToViewportPoint(
					Root.Position
				)

			-- Usa Head + Root para calcular a caixa.
			-- Isso evita a Box aparecer embaixo do mapa.

			local TopPosition =
				Camera:WorldToViewportPoint(
					Head.Position +
					Vector3.new(0, 0.5, 0)
				)

			local BottomPosition =
				Camera:WorldToViewportPoint(
					Root.Position -
					Vector3.new(0, 2.5, 0)
				)

			if Visible
				and Position.Z > 0
				and TopPosition.Z > 0
				and BottomPosition.Z > 0 then

				local TopY = math.min(
					TopPosition.Y,
					BottomPosition.Y
				)

				local BottomY = math.max(
					TopPosition.Y,
					BottomPosition.Y
				)

				local Height =
					math.max(
						BottomY - TopY,
						20
					)

				local Width =
					math.max(
						Height * 0.55,
						15
					)

				local X =
					Position.X -
					Width / 2

				local Y =
					TopY

				--==================================================
				-- BOX RGB
				--==================================================

				data.Box.Visible = BoxESP

				data.Box.Position =
					UDim2.fromOffset(
						X,
						Y
					)

				data.Box.Size =
					UDim2.fromOffset(
						Width,
						Height
					)

				for _, part in ipairs({
					data.Top,
					data.Bottom,
					data.Left,
					data.Right
				}) do

					part.BackgroundColor3 = Color
				end

				data.Top.Position =
					UDim2.fromOffset(0, 0)

				data.Top.Size =
					UDim2.fromOffset(
						Width,
						2
					)

				data.Bottom.Position =
					UDim2.fromOffset(
						0,
						Height - 2
					)

				data.Bottom.Size =
					UDim2.fromOffset(
						Width,
						2
					)

				data.Left.Position =
					UDim2.fromOffset(0, 0)

				data.Left.Size =
					UDim2.fromOffset(
						2,
						Height
					)

				data.Right.Position =
					UDim2.fromOffset(
						Width - 2,
						0
					)

				data.Right.Size =
					UDim2.fromOffset(
						2,
						Height
					)

				--==================================================
				-- LINE RGB
				--==================================================

				data.Line.Visible = LineESP

				if LineESP then

					local Start =
						Vector2.new(
							Camera.ViewportSize.X / 2,
							Camera.ViewportSize.Y
						)

					local End =
						Vector2.new(
							Position.X,
							Position.Y
						)

					local Delta =
						End - Start

					data.Line.Position =
						UDim2.fromOffset(
							Start.X,
							Start.Y
						)

					data.Line.Size =
						UDim2.fromOffset(
							Delta.Magnitude,
							2
						)

					data.Line.Rotation =
						math.deg(
							math.atan2(
								Delta.Y,
								Delta.X
							)
						)

					data.Line.BackgroundColor3 = Color
				end

				--==================================================
				-- VIDA
				--==================================================

				data.HealthBack.Visible =
					HealthESP

				if HealthESP then

					data.HealthBack.Position =
						UDim2.fromOffset(
							X - 7,
							Y
						)

					data.HealthBack.Size =
						UDim2.fromOffset(
							4,
							Height
						)

					local Percent =
						math.clamp(
							Humanoid.Health /
							Humanoid.MaxHealth,
							0,
							1
						)

					data.Health.Size =
						UDim2.new(
							1,
							0,
							Percent,
							0
						)

					data.Health.Position =
						UDim2.new(
							0,
							0,
							1,
							0
						)

					data.Health.BackgroundColor3 =
						Color3.fromHSV(
							Percent * 0.33,
							1,
							1
						)
				end

			else

				data.Box.Visible = false
				data.Line.Visible = false
				data.HealthBack.Visible = false
			end

		else

			data.Box.Visible = false
			data.Line.Visible = false
			data.HealthBack.Visible = false
		end
	end
end)

--==================================================
-- ABRIR / FECHAR
--==================================================

Close.MouseButton1Click:Connect(function()

	Main.Visible = false
	OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()

	Main.Visible = true
	OpenButton.Visible = false
end)

--==================================================
-- ARRASTAR MENU
--==================================================

local Dragging = false
local DragStart
local StartPosition

Header.InputBegan:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		Dragging = true
		DragStart = input.Position
		StartPosition = Main.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)

	if not Dragging then
		return
	end

	if input.UserInputType ==
		Enum.UserInputType.MouseMovement
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		local Delta =
			input.Position - DragStart

		Main.Position =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
	end
end)

UserInputService.InputEnded:Connect(function(input)

	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or input.UserInputType ==
		Enum.UserInputType.Touch then

		Dragging = false
	end
end)

print("FFH4X - nFXNOBRU1 carregado!")
