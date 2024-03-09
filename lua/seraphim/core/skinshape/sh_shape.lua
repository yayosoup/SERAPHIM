local meta = FindMetaTable( "Player" )
local OBSESSION_COOLDOWN = 120

function meta:isShape()
    if self:Team() == TEAM_SKINSHAPE then
        return true
    else
        return false
    end
end
function meta:hasObsession()
    return self:GetNWBool("hasObsession") or false
end
function meta:getObsessionTarget()
    return self:GetNWEntity("obsessionTarget") or false
end

function meta:canRequestObsession()
    if not self:isShape() then return false end
    if self:hasObsession() then return false end
    if IsValid(self) and (CurTime() - self:GetNWFloat("lastObsession", 0)) < OBSESSION_COOLDOWN then
    print("You have to wait! " .. math.floor(OBSESSION_COOLDOWN - (CurTime() - self:GetNWFloat("lastObsession", 0)))) return false end

    return true
end