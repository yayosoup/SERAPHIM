local PANEL = {}
yayo.crafting.Tabs = {
    {
        title = "blue",
        icon = Material("dconfig/job.png"),
        callback = function()
            yayo.crafting.OpenRecipe( "blue" )
        end,
    },
    {
        title = "red",
        icon = Material("dconfig/shipment.png"),
        callback = function()
            yayo.crafting.OpenRecipe( "red" )
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

    self.tabs = {}
    self:GetParent().page = self:GetParent().page or 1
    for k,tabData in ipairs( yayo.crafting.recipes ) do
        local tab = self.scroll:Add( "DButton" )
        tab:Dock( TOP )
        tab:SetText( tabData.name )

        tab.DoClick = function()
            if self:GetParent().page == k then return end
            yayo.crafting.ClearBody()
            tabData.callback()
            -- if tabData is close then playsound close
            self:GetParent().page = k
        end
    end

    timer.Simple(
        .5,
        function()
            yayo.crafting.Tabs[self:GetParent().page].callback()
        end
    )

end

function PANEL:OnMouseWheeled( scrollDelta )
    local curPage = self:GetParent().page
    local newPage = curPage - scrollDelta
    if not yayo.crafting.Tabs[nextPage] or nextPage == table.Count( yayo.crafting.Tabs ) then return end
    self.tabs[curPage].fade = 1
    self:GetParent().page = newPage
    DCONFIG2.PlaySound( "click" )
    timer.Create(
        "updatePage",
        .15,
        1,
        function()
            yayo.crafting.ClearBody()
            print("hello bro")
        end
    )
end

function PANEL:Paint(w, h)
    draw.RoundedBoxEx(20, 0, 0, w, h, yayo_util.Config.BackgroundItemPanel, true, false, true, false)
end

derma.DefineControl( "YCRAFTNav", "Yayo Craft Nav", PANEL , "DPanel" )