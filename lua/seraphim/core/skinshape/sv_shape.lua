local meta = FindMetaTable( "Player" )
local obsessions = {}


util.AddNetworkString("yayo.YouAreObsession")
util.AddNetworkString("yayo.ShapeNewObsession")
util.AddNetworkString("yayo.ObsessionComplete")
util.AddNetworkString("yayo.ObsessionFailed")

function meta:requestObsession()
    if hits[self] then print(self:Nick() .. " already has an obsession!") end

    self:setObsessionTarget( target )

    -- maybe onObsessionCompleted?
end

function meta:setObsessionTarget( target )
    if not hits[self] then print (self:Nick() .. " does not have an obsession!") end

    self:setSelfDarkRPVar("obsessionTarget", target )
    self:setDarkRPVar("hasHit", target and true or nil )
end

function meta:abortObsession()
    if not hits[self] then print (self:Nick() .. " does not have an obsession!") end

    self:finishObsession()
end

function meta:finishObsession()
    self:setObsessionTarget(nil)
    obsessions[self] = nil
end

hook.Add("PlayerDeath", "yayo.ObsessionFinished", function(victim, inflictor, attacker)
    if obsessions[ply] then -- player was shape
        -- end obsession if player was shape
    end

end)