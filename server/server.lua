
local VORPcore = exports.vorp_core:GetCore()

if Config.PlayersPed then
    RegisterCommand('ped', function(source, args)
        local _source = source
        local User = VORPcore.getUser(_source).getUsedCharacter
        local charid =  User.charIdentifier
        if Config.PlayersPedList[charid] then
            TriggerClientEvent('xakra_utils:set_ped',_source, Config.PlayersPedList[charid])
        end
    end)
end

RegisterServerEvent('xakra_utils:update_job')
AddEventHandler('xakra_utils:update_job', function(data)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter

    Character.setJob(data.jobname)

    if data.jobgrade then
        Character.setJobGrade(data.jobgrade)
    end

    VORPcore.NotifyTip(_source, Config.StrSetJob1..data.label..Config.StrSetJob2..data.jobgrade,4000)
end)

if Config.Pipepeace then
    exports.vorp_inventory:registerUsableItem('pipepeace', function(data)
        TriggerClientEvent('xakra_utils:pipepeace', data.source)
        exports.vorp_inventory:closeInventory(data.source)
    end)
end

