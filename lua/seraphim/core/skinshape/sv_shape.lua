local meta = FindMetaTable( "Player" )
local obsessions = {}
Seraphim = Seraphim or {}
Seraphim.hooks = Seraphim.hooks or {}
util.AddNetworkString("yayo_YouAreObsession")
util.AddNetworkString("yayo_ShapeNewObsession")
util.AddNetworkString("yayo_ObsessionComplete")
util.AddNetworkString("yayo_bsessionFailed")

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
    obsessions[self] = {}
    onObsRequested( self, target )

    self:SetNWEntity("obsessionTarget", target )
    self:SetNWBool("hasObsession", true)
end

function meta:abortObsession()
    print(self:Nick() .. " has died and aborted their obsession!")
    local check = self:GetNWEntity("obsessionTarget")
    print(check:Nick() .. " was the obsession!")
    if not obsessions[self] then print (self:Nick() .. " does not have an obsession!") return end

    hook.Call("onObsessionFailed", Seraphim.hooks, self, self:getObsessionTarget())
    self:finishObsession()
end

function meta:finishObsession()
    obsessions[self] = nil
    self:SetNWBool("hasObsession", false)
end
function onObsRequested( shape, target )
    print("onObsRequested " .. target:Nick())
    net.Start("yayo_YouAreObsession")
    net.Send(target)

    print("onObsRequested shape " .. shape:Nick())
    net.Start("yayo_ShapeNewObsession")
        net.WriteEntity(target)
    net.Send(shape)

    print( shape:Nick() .. " has requested an obsession on " .. target:Nick() .. " !")

end
function onObsCompleted( shape, target )
    print( shape:Nick() .. " has completed their obsession on " .. target:Nick() .. " !")
    net.Start("yayo_ObsessionComplete")
    net.Broadcast()

    shape:SetNWFloat("lastObsession", CurTime())
    shape:finishObsession()
end

function onObsFailed( shape, target )
    net.Start("yayo_ObsessionFailed")
        net.WriteEntity("shape")
        net.WriteEntity("shape")
        net.WriteEntity("shape")
    net.Broadcast()
end

hook.Add("PlayerDeath", "yayo.ObsessionFinished", function(victim, inflictor, attacker)
    if obsessions[victim] then -- player was shape
        victim:abortObsession()
    end
    if IsValid(attacker) and attacker:IsPlayer() and obsessions[attacker] and attacker:getObsessionTarget() == victim then
            onObsCompleted(attacker, victim)
    end
end)

