local meta = FindMetaTable( "Player" )
local OBESSSION_COOLDOWN = 120

function meta:isShape()
    if self:Team() == TEAM_SKINSHAPE then
        return true
    else
        return false
    end
end
function meta:hasObsession()
    return self:getDarkRPVar("obsession") or false
end
function meta:getObsessionTarget()
    return self:getDarkRPVar("hasObsession") or false
end

function meta:canRequestObsession()
    if not self:isShape() then return false end
    if self:hasObsession() then return false end
    if IsValid( self ) and (self:GetNWFloat("lastObsession", 0) - OBESSSION_COOLDOWN) > CurTime() then return false end

    return true
end