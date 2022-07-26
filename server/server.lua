
local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VORP = exports.vorp_inventory:vorp_inventoryApi()

if Config.PlayersPed then
    RegisterCommand('ped', function(source, args)
        local _source = source
        local name = GetPlayerName(_source)
        local User = VorpCore.getUser(_source).getUsedCharacter
        local charid =  User.charIdentifier
        if Config.PlayersPedList[charid] then
            TriggerClientEvent("xakra_utils:set_ped",_source, Config.PlayersPedList[charid])
        end
        
    end)
end

RegisterServerEvent("xakra_utils:player_job")
AddEventHandler("xakra_utils:player_job", function()
    local _source = source
    local User = VorpCore.getUser(_source).getUsedCharacter
    local charid =  User.charIdentifier

    TriggerClientEvent("xakra_utils:open_menu",_source,charid,_source)
end)

RegisterServerEvent("xakra_utils:update_job")
AddEventHandler("xakra_utils:update_job", function(jobname,jobgrade,player_source)
    TriggerEvent("vorp:setJob", player_source, jobname, jobgrade)
end)

if Config.Pipepeace then
    VORP.RegisterUsableItem("pipepeace", function(data)
        TriggerClientEvent('xakra_utils:pipepeace', data.source)
        VORP.CloseInv(data.source)   -- Cerrar inventario.
    end)
end

