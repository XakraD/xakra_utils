
local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)
         
RegisterCommand('ped', function(source, args)
    local _source = source
    local name = GetPlayerName(_source)
    local User = VorpCore.getUser(_source).getUsedCharacter
    local charid =  User.charIdentifier
    if Config.PlayersList[charid] then
        TriggerClientEvent("xakra_ped:set_ped",_source, Config.PlayersList[charid])
    end
    
end)

