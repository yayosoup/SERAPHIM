local meta = FindMetaTable( "Player" )
local obsessions = {}
Seraphim = Seraphim or {}
Seraphim.hooks = Seraphim.hooks or {}
util.AddNetworkString("yayo.YouAreObsession")
util.AddNetworkString("yayo.ShapeNewObsession")
util.AddNetworkString("yayo.ObsessionComplete")
util.AddNetworkString("yayo.ObsessionFailed")

function meta:requestObsession()
    if obsessions[self] then print(self:Nick() .. " already has an obsession!") end
    local canRequest = self:canRequestObsession()

    if canRequest then
        self:setObsessionTarget( target )
     else
        print(self:Nick() .. " cannot request an obsession!")
    end

    -- maybe onObsessionCompleted?
end

function meta:setObsessionTarget( target )
    print("SetObsessionTarget")
    if not obsessions[self] then print (self:Nick() .. " does not have an obsession!") end
    local players = player.GetAll()
    for i = #players, 1, -1 do
        if players[i] == self then
            table.remove(players, i)
        end
    end

    if #players == 0 then
        print(self:Nick() .. " is the only player on the server!")
        return
    end

    target = players[math.random(#players)]

    self:SetNWEntity("obsessionTarget", target )
    self:SetNWBool("hasObsession", true)
end

function meta:abortObsession()

    local check = self:GetNWEntity("obsessionTarget")
    print(check:Nick() .. " was the obsession!")
    if not obsessions[self] then print (self:Nick() .. " does not have an obsession!") return end

    hook.Call("onObsessionFailed", Seraphim.hooks, self, self:getObsessionTarget())
    self:finishObsession()
end

function meta:finishObsession()
    self:setObsessionTarget(nil)
    obsessions[self] = nil
end
function OnObsAccepted ( shape, target )

end
function onObsCompleted( shape, target )
    net.Start("yayo.ObsessionComplete")
        net.WriteEntity("shape")
        net.WriteEntity("shape")
        net.WriteEntity("shape")
    net.Broadcast()

    shape:SetNWFloat("lastObsession", CurTime())
    shape:finishObsession()
end
function onObsFailed( shape, target )
    net.Start("yayo.ObsessionFailed")
        net.WriteEntity("shape")
        net.WriteEntity("shape")
        net.WriteEntity("shape")
    net.Broadcast()
end

hook.Add("PlayerDeath", "yayo.ObsessionFinished", function(victim, inflictor, attacker)
    victim:abortObsession()
    if obsessions[victim] then -- player was shape
        
    end

end)