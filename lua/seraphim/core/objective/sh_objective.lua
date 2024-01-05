local meta = FindMetaTable("Player")
util.AddNetworkString("sendMission")

function meta:loadKillCount()
    local killCount = self:GetPData("killCount")
    if killCount == nil then
        self:SetPData("killCount", "0")
        self:SetNWInt("killCount", 0)
    else
        self:SetNWInt("killCount", tonumber(killCount))
    end
    return self:GetNWInt("killCount")
end