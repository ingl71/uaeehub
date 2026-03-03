
local RanTimes = 0

local Connection = game:GetService("RunService").Heartbeat:Connect(function()
    RanTimes += 1
end)

repeat
    task.wait()
until RanTimes >= 2

Connection:Disconnect()

for i,v in pairs(game.CoreGui:GetChildren()) do
    if v.Name == "56rKeySystemUi" then
        v:Destroy()
    end
end

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local UICorner = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")
local TextBox = Instance.new("TextBox")
local UICorner_2 = Instance.new("UICorner")
local TextButton = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local TextButton_2 = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local TextLabel_2 = Instance.new("TextLabel")
local ImageButton = Instance.new("ImageButton")

ScreenGui.Name = "56rKeySystemUi"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(5,5,5)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.AnchorPoint = Vector2.new(0.5,0.5)
Frame.Position = UDim2.new(0.5,0,0.5,0)
Frame.Size = UDim2.new(0.25,0,0.25,0)

UIAspectRatioConstraint.Parent = Frame
UIAspectRatioConstraint.AspectRatio = 310/204

UICorner.CornerRadius = UDim.new(0.1,0)
UICorner.Parent = Frame

TextLabel.Parent = Frame
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0.32,0,0.12,0)
TextLabel.Size = UDim2.new(0.37,0,0.20,0)
TextLabel.Font = Enum.Font.Oswald
TextLabel.Text = "UAE HUB"
TextLabel.TextColor3 = Color3.fromRGB(255,255,255)
TextLabel.TextScaled = true

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
TextBox.BorderSizePixel = 0
TextBox.Position = UDim2.new(0.27,0,0.42,0)
TextBox.Size = UDim2.new(0.46,0,0.16,0)
TextBox.Font = Enum.Font.SourceSans
TextBox.Text = "Enter Your Key here"
TextBox.TextColor3 = Color3.fromRGB(255,255,255)
TextBox.TextScaled = true

UICorner_2.Parent = TextBox

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(33,141,0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.17,0,0.70,0)
TextButton.Size = UDim2.new(0.27,0,0.13,0)
TextButton.Font = Enum.Font.SourceSansBold
TextButton.Text = "Check Key"
TextButton.TextColor3 = Color3.fromRGB(255,255,255)
TextButton.TextScaled = true

UICorner_3.Parent = TextButton

TextButton_2.Parent = Frame
TextButton_2.BackgroundColor3 = Color3.fromRGB(0,3,165)
TextButton_2.BorderColor3 = Color3.fromRGB(255,255,255)
TextButton_2.Position = UDim2.new(0.56,0,0.70,0)
TextButton_2.Size = UDim2.new(0.27,0,0.13,0)
TextButton_2.Font = Enum.Font.SourceSansBold
TextButton_2.Text = "Get Key"
TextButton_2.TextColor3 = Color3.fromRGB(255,255,255)
TextButton_2.TextScaled = true

UICorner_4.Parent = TextButton_2

TextLabel_2.Parent = Frame
TextLabel_2.BackgroundTransparency = 1
TextLabel_2.Position = UDim2.new(0.07,0,0.88,0)
TextLabel_2.Size = UDim2.new(0.28,0,0.11,0)
TextLabel_2.Font = Enum.Font.GothamBold
TextLabel_2.Text = "Team - UAE HUB"
TextLabel_2.TextColor3 = Color3.fromRGB(255,255,255)
TextLabel_2.TextScaled = true

ImageButton.Parent = Frame
ImageButton.BackgroundTransparency = 1
ImageButton.Position = UDim2.new(0.88,0,0.05,0)
ImageButton.Size = UDim2.new(0.08,0,0.12,0)
ImageButton.Image = "rbxassetid://1249929622"

ImageButton.MouseButton1Click:Connect(function()
    Frame:TweenSize(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.5,true)
    wait(1)
    ScreenGui:Destroy()
end)

TextButton_2.MouseButton1Click:Connect(function()
    setclipboard("https://api.nebulauth.com/api/v1/checkpoints/hlprvrFnnN0WlKCJv_VQxanSMjeQZtFU1PKQXaCcaKY/1")
    TextButton_2.Text = "Copyed Link !"
end)

local NEBULAUTH_BASE_URL = "https://api.nebulauth.com"
local NEBULAUTH_API_TOKEN = "mk_at_vbC7tNGVdo-O1q3b8p75eu294duM8ZBN87boE2lgbvA"

local HttpService = game:GetService("HttpService")

local function nebulauth_verify_key(key)
    local body_obj = {
        key = key,
        requestId = HttpService:GenerateGUID(false),
    }
    local body_string = HttpService:JSONEncode(body_obj)

    local headers = {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bearer " .. NEBULAUTH_API_TOKEN,
    }

    local hwid = gethwid and gethwid()
    if hwid and hwid ~= "" then
        headers["X-Hwid"] = hwid
    end

    local res = request({
        Url = NEBULAUTH_BASE_URL .. "/api/v1/keys/verify",
        Method = "POST",
        Headers = headers,
        Body = body_string,
    })

    if not res then
        return nil, "No response"
    end

    local ok, data = pcall(function()
        return HttpService:JSONDecode(res.Body)
    end)

    if not ok then
        return nil, "Invalid JSON response"
    end

    return data, nil
end


TextButton.MouseButton1Click:Connect(function()
    getgenv().key = TextBox.Text


    local data, err = nebulauth_verify_key(getgenv().key)

    if err then
        error("verify failed: " .. tostring(err))
    elseif data and data.valid then
        TextBox.Text = "Verfiy Successfully!"
        wait(1)
        Frame:TweenSize(UDim2.new(0, 0, 0, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.5,true)
        ScreenGui:Destroy()
        wait(1)
        print("Verfiy Successfully")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/h8r-uae/UAE/refs/heads/main/Anime%20Fighting%20Simulator%3A%20Endless"))()        
    else
        error("key denied: " .. tostring(data and data.reason))
    end

end)