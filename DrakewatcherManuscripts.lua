DrakewatcherManuscripts = LibStub("AceAddon-3.0"):NewAddon("DrakewatcherManuscripts", "AceEvent-3.0")

-- WoW Apis
local CreateFrame, GetScreenWidth, GetScreenHeight = CreateFrame, GetScreenWidth, GetScreenHeight
local GetAddonMetadata = GetAddOnMetadata

-- Drake Data
local DWMS_DRAKE_DATA = {
    DWMS_PROTODRAKE,
    DWMS_VELOCIDRAKE,
    DWMS_HIGHLAND_DRAKE,
    DWMS_WYLDERDRAKE,
    DWMS_SLITHERDRAKE,
}

SLASH_DRAKEWATCHERMANUSCRIPTS1 = "/dwms"
SLASH_DRAKEWATCHERMANUSCRIPTS2 = "/drakewatchermanuscripts"
SLASH_DRAKEWATCHERMANUSCRIPTS3 = "/dwmanuscripts"
SlashCmdList["DRAKEWATCHERMANUSCRIPTS"] = function()
    DrakewatcherManuscripts:ToggleFrame()
end

-- Initialize addon
function DrakewatcherManuscripts:OnInitialize()
    -- Register options
    self.db = LibStub("AceDB-3.0"):New("DrakewatcherManuscriptsDB", DEFAULT_CONFIG, true)
end

function DrakewatcherManuscripts:CreateFrame()
    if self.frame then
        return
    end

    local db = self.db.global
    local frameWidth, frameHeight = 650, 500
    local f = CreateFrame("Frame", "DrakewatcherManuscripts", UIParent, "PortraitFrameTemplate")
    f:SetScript("OnHide", function()
        self.frameShown = false
    end)

    f:EnableMouse(true)
    f:SetMovable(true)
    f:SetResizable(true)
    f:SetFrameStrata("DIALOG")
    f:SetTitle(GetAddonMetadata("DrakewatcherManuscripts", "Title"))
    f:SetPortraitToAsset(GetAddonMetadata("DrakewatcherManuscripts", "IconTexture"))
    -- get addon info
    f.window = "default"

    -- position the frame
    local xOffset, yOffset = db.frame.xOffset, db.frame.yOffset
    if not (xOffset and yOffset) then
        xOffset = GetScreenWidth() / 2
        yOffset = GetScreenHeight() - frameHeight / 2
    end

    f:SetPoint("TOP", UIParent, "BOTTOMLEFT", xOffset, yOffset)
    f:Hide()
    f:SetSize(frameWidth, frameHeight)

    f:SetClampedToScreen(true)
    local w, h = f:GetSize()
    local l, r, t, b = w / 4, -w / 4, 0, h - 22
    f:SetClampRectInsets(l, r, t, b)

    local function saveWindowDrag()
        local newXOffset = f:GetRight() - (f:GetWidth() / 2)
        local newYOffset = f:GetTop()
        db.frame = db.frame or {}
        db.frame.xOffset = newXOffset
        db.frame.yOffset = newYOffset
    end

    if not f.TitleContainer then
        f.TitleContainer = CreateFrame("Frame", nil, f)
        f.TitleContainer:SetAllPoints(f.TitleBg)
    end

    f.TitleContainer:SetScript("OnMouseDown", function()
        f:StartMoving()
    end)
    f.TitleContainer:SetScript("OnMouseUp", function()
        f:StopMovingOrSizing()
        saveWindowDrag()
    end)

    local tabs = {}
    -- tabs
    for i, v in ipairs(DWMS_DRAKE_DATA) do
        local button = CreateFrame("Button", "$parentTab" .. i, f, "PanelTopTabButtonTemplate", i)
        if i > 1 then
            button:SetPoint("LEFT", "$parentTab" .. (i-1), "RIGHT", -16, 0);
        else
            button:SetPoint("TOPLEFT", f, "TOPLEFT", 58, -28)
        end
        button:SetText(v.name)
        button:SetScript("OnClick", function()
            PanelTemplates_SetTab(f, i)
        end)
        tabs[i] = button
        PanelTemplates_SetNumTabs(f, i);
    end
    PanelTemplates_SetTab(f, 1)

    self.frame = f
end

function DrakewatcherManuscripts:ToggleFrame()
    if not self.frame then
        self:CreateFrame()
    end

    if self.frame:IsShown() then
        self.frame:Hide()
    else
        self.frame:Show()
    end
end

function DrakewatcherManuscripts:OnEnable()
    -- Register events
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function DrakewatcherManuscripts:PLAYER_ENTERING_WORLD()
    self:ToggleFrame()
end


function DwMs_OnAddonCompartmentClick()
    DrakewatcherManuscripts:ToggleFrame()
end
