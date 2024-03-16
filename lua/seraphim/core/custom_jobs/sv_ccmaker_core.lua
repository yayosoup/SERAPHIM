-- table nets used to store all the net messages that will be used in the script
local nets = { "yayo_CCMaker_Open", "yayo_CCMaker_CreateJob"}
-- loop through the nets table and add the net messages to the server
for k,v in ipairs( nets ) do
    util.AddNetworkString( v )
end
-- PlayerSay hook used to open the ccmaker menu
hook.Add(
    "PlayerSay",
    "yayo_CCMaker_Open",
    function(ply, text)
    if string.lower( text ) == "!ccmaker" then
        net.Start( "yayo_CCMaker_Open" )
        net.Send( ply )
    end
end)