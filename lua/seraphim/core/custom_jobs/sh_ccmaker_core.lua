CCMaker = CCMaker or {}
CCMaker.Config = CCMaker.Config or {}

local GM = GM or GAMEMODE
local function declareTeamCommand( CTeam )
    local k = 0
    for num,v in ipairs( RPExtraTeams ) do
        if v.command == CTeam.command then
            k = num
        end
    end

    local ran = false

    local chatcommandCondition = function( ply )
        local plyTeam = ply:Team()
        if CTeam.admin == 1 and not ply:IsAdmin() or CTeam.admin and not ply:IsSuperAdmin() then return false end
    end
end

function addTeamCommands( CTeam, max )
    if CLIENT then return end


end


function DarkRP.createJobCCMaker( Name, CustomTeam )
    if not CustomTeam.teamKey then
        CustomTeam.teamKey = #RPExtraTeams + 1
    end

    CustomTeam.name = Name
    CustomTeam.default = DarkRP.DARKRP_LOADING


    CustomTeam.team = CustomTeam.teamKey
    CustomTeam.salary = math.floor( CustomTeam.salary or 45 )
    CustomTeam.customCheck = CustomTeam.customCheck and fp{ DarkRP.simplerrRun, CustomTeam.customCheck }
    
    DarkRP.addToCategory( CustomTeam, "jobs", CustomTeam.category )

    local Team = CustomTeam.teamKey
    team.SetUp( Team, Name, CustomTeam.color )
    timer.Simple(
        0,
        function()
            declareTeamCommands( CustomTeam )
            addTeamCommands( CustomTeam, CustomTeam.max )
        end
    )

    return Team
end