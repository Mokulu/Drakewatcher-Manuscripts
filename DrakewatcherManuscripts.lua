DrakewatcherManuscripts = LibStub("AceAddon-3.0"):NewAddon("DrakewatcherManuscripts", "AceEvent-3.0")
local AceGUI = LibStub("AceGUI-3.0")

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
    local frameWidth, frameHeight = 880, 650
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
    self.frame = f

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

    -- progress bar
    local progressBar = CreateFrame("Frame", nil, f, "TooltipBackdropTemplate")
    progressBar:SetBackdropBorderColor(0.5,0.5,0.5)
    progressBar:SetSize(120,20)
    progressBar:SetPoint("CENTER", f, "TOP", 0, -42)
    progressBar.bar = CreateFrame("StatusBar", nil, progressBar)
    progressBar.bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
    progressBar.bar:SetStatusBarColor(0.1, 1, 0.1)
    progressBar.bar:SetPoint("TOPLEFT", 5, -5)
    progressBar.bar:SetPoint("BOTTOMRIGHT", -5, 5)
    progressBar.text = progressBar.bar:CreateFontString()
    progressBar.text:SetFontObject(GameFontNormal)
    progressBar.text:SetTextColor(1,1,1)
    progressBar.text:SetTextScale(0.8)
    progressBar.text:SetPoint("CENTER")
    progressBar.text:SetJustifyH("CENTER")
    progressBar.text:SetJustifyV("CENTER")

    f.progressBar = progressBar

    -- copying mixins to statusbar
    Mixin(progressBar.bar,SmoothStatusBarMixin)

    -- using mixin methods
    local owned, total = countManuscripts()
    progressBar.bar:SetMinMaxSmoothedValue(0, total)
    progressBar.bar:SetSmoothedValue(owned)
    progressBar.text:SetText(owned.."/"..total)

    local tabs = {}
    _self = self
    -- tabs
    for i, v in ipairs(DWMS_DRAKE_DATA) do
        local button = CreateFrame("Button", "$parentTab" .. i, f, "PanelTopTabButtonTemplate", i)
        if i > 1 then
            button:SetPoint("LEFT", "$parentTab" .. (i-1), "RIGHT", -16, 0);
        else
            button:SetPoint("TOPLEFT", f, "TOPLEFT", 6, -50)
        end
        button:SetText(v.name)
        button:SetScript("OnClick", function()
            _self:SelectTab(i)
        end)
        tabs[i] = button
        PanelTemplates_SetNumTabs(f, i);
    end
    f.tabs = tabs

    -- content windows
    local contentWindows = {}
    for i in ipairs(DWMS_DRAKE_DATA) do
        local contentWindow = AceGUI:Create("InlineGroup")
        contentWindow:SetLayout("Fill")
        contentWindow.frame:SetParent(f)
        contentWindow.frame:SetPoint("TOPLEFT", f, "TOPLEFT", 4, -62)
        contentWindow.frame:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -4, 4)
        contentWindows[i] = contentWindow
    end
    f.contentWindows = contentWindows
    self:SelectTab(1)

    -- insert into special frames table
    _G["DrakewatcherManuscriptsFrame"] = f
    tinsert(UISpecialFrames, "DrakewatcherManuscriptsFrame")
end

function DrakewatcherManuscripts:DrawTab(tabIndex)
    local contentWindow = self.frame.contentWindows[tabIndex]
    local frame = AceGUI:Create("ScrollFrame")
    frame:SetLayout("Flow")
    frame:SetFullWidth(true)
    contentWindow:AddChild(frame)
    contentWindow.scrollFrame = frame

    for catName, cat in pairs(DWMS_DRAKE_DATA[tabIndex]) do
        if catName ~= "name" then
            local label = AceGUI:Create("Label")
            label:SetText(catName)
            label:SetFontObject(GameFontNormalLarge)
            label:SetColor(0.4, 0.73, 1)
            label:SetFullWidth(true)
            frame:AddChild(label)

            -- loop 10 times
            for _, manuscript in ipairs(cat) do
                self:DrawItemFrame(frame, manuscript)
            end
        end
    end
end

function drawItemIcon(itemFrame, isObtained, itemName, itemQuality, itemIcon)
    local nameProps = { strsplit(":", itemName) }
    local r, g, b = GetItemQualityColor(itemQuality)

    local iconFrame = AceGUI:Create("Icon")
    itemFrame:AddChild(iconFrame)
    iconFrame:SetImage(itemIcon)
    iconFrame:SetImageSize(32, 32)
    iconFrame:SetWidth(40)
    iconFrame:SetHeight(40)

    local nameFrame = AceGUI:Create("Label")
    nameFrame:SetFontObject(GameFontNormal)
    itemFrame:AddChild(nameFrame)
    nameFrame:SetText(nameProps[2] or itemName)
    nameFrame:SetColor(r, g, b)
    iconFrame:SetDisabled(not isObtained)
end

function DrakewatcherManuscripts:DrawItemFrame(frame, manuscript)
    local itemFrame = AceGUI:Create("InlineGroup")

    local itemName, _, itemQuality, _, _, _, _, _, _, itemIcon = GetItemInfo(manuscript.itemId)
    local isObtained = C_QuestLog.IsQuestFlaggedCompleted(manuscript.questId)
    if not itemName then
        local item = Item:CreateFromItemID(manuscript.itemId)
        item:ContinueOnItemLoad(function()
            drawItemIcon(itemFrame, isObtained, item:GetItemName(), item:GetItemQuality(), item:GetItemIcon())
        end)
    else
        drawItemIcon(itemFrame, isObtained, itemName, itemQuality, itemIcon)
    end

    itemFrame:SetLayout("Flow")
    itemFrame:SetWidth(270)
    frame:AddChild(itemFrame)
end

function DrakewatcherManuscripts:SelectTab(tabIndex)
    PanelTemplates_SetTab(self.frame, tabIndex)
    for i, v in ipairs(self.frame.contentWindows) do
        if i == tabIndex then
            self:DrawTab(tabIndex)
            v.frame:Show()

            C_Timer.After(0.1, function()
                v:DoLayout()
            end)
        else
            v.frame:Hide()
            v:ReleaseChildren()
        end
    end
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

function countManuscripts()
    local owned, total = 0, 0
    for _, drake in ipairs(DWMS_DRAKE_DATA) do
        for k, cats in pairs(drake) do
            if k ~= "name" then
                for _, manuscript in ipairs(cats) do
                    owned = owned + (C_QuestLog.IsQuestFlaggedCompleted(manuscript.questId) and 1 or 0)
                    total = total + 1
                end
            end
        end
    end
    return owned, total
end

function DwMs_OnAddonCompartmentClick()
    DrakewatcherManuscripts:ToggleFrame()
end
