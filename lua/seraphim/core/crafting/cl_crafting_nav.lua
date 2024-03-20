local PANEL = {}
yayo.crafting.Tabs = {
    {
        title = "Jobs",
        icon = Material("dconfig/job.png"),
        callback = function()
            DCONFIG2.OpenEditor("jobs")
        end,
    },
    {
        title = "Shipments",
        icon = Material("dconfig/shipment.png"),
        callback = function()
            DCONFIG2.OpenEditor("shipments")
        end,
    },
    {
        title = "Entities",
        icon = Material("dconfig/entity.png"),
        callback = function()
            DCONFIG2.OpenEditor("entities")
        end,
    },
    {
        title = "Ammo",
        icon = Material("dconfig/ammo.png", "smooth"),
        callback = function()
            DCONFIG2.OpenEditor("ammo")
        end,
    },
    {
        title = "Categories",
        icon = Material("dconfig/category.png"),
        callback = function()
            DCONFIG2.OpenEditor("categories")
        end,
    },
    {
        title = "Door Groups",
        icon = Material("dconfig/door.png"),
        callback = function()
            DCONFIG2.OpenEditor("doorgroups")
        end,
    },
    {
        title = "DarkRP Settings",
        icon = Material("dconfig/settings.png"),
        callback = function()
            DCONFIG2.OpenEditor("settings")
        end,
    },
    {
        title = "DConfig Settings",
        icon = Material("dconfig/wrench.png"),
        callback = function()
            DCONFIG2.OpenEditor("dconfig")
        end,
    },
    {
        title = "Statistics",
        icon = Material("dconfig/stats.png"),
        callback = function()
            DCONFIG2.OpenStats()
        end,
    },
    {
        title = "Data",
        icon = Material("dconfig/data.png"),
        callback = function()
            DCONFIG2.OpenData()
        end,
    },
    {
        title = "Credits",
        icon = Material("dconfig/credits.png"),
        callback = function()
            DCONFIG2.OpenCredits()
        end,
    },
    {
        title = "Close",
        icon = Material("dconfig/close.png"),
        callback = function()
            DCONFIG2.Close()
        end,
    },
}

function PANEL:Init()
    self.scroll = self:Add("YCRAFTScrollBar")
    self.scroll:Dock( FILL )

    for k,tabData in ipairs( yayo.crafting.Tabs ) do
        local tab = self.scroll:Add( "DButton" )
        tab:Dock( TOP )
        tab:SetText( "good morning" )
    end

end
function PANEL:Paint(w, h)
    draw.RoundedBoxEx(20, 0, 0, w, h, yayo_util.Config.BackgroundItemPanel, true, false, true, false)
end

derma.DefineControl( "YCRAFTNav", "Yayo Craft Nav", PANEL , "DPanel" )