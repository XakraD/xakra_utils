local VORPcore = exports.vorp_core:GetCore()

-- CHANGE JOBS
local MenuData = exports.vorp_menu:GetMenuData()

local DataLocation

local MenuPrompt
local Prompts = GetRandomIntInRange(0, 0xffffff)

CreateThread(function()
    MenuPrompt = PromptRegisterBegin()
    PromptSetControlAction(MenuPrompt, 0xA1ABB953)
    local VarString = CreateVarString(10, 'LITERAL_STRING', Config.StrKey)
    PromptSetText(MenuPrompt, VarString)
    PromptSetEnabled(MenuPrompt, true)
    PromptSetVisible(MenuPrompt, true)
	PromptSetHoldMode(MenuPrompt, 1000)
	PromptSetGroup(MenuPrompt, Prompts)
	PromptRegisterEnd(MenuPrompt)
end)

CreateThread(function()
    if Config.ChangeJobs then
        repeat Wait(1000) until LocalPlayer.state.Character

        for i, v in pairs(Config.ListPlacesJob) do
            if v.enable_blip then
                v.BlipHandle = BlipAddForCoords(1664425300, v.coords)
                SetBlipSprite(v.BlipHandle, v.sprite, 1)
                SetBlipName(v.BlipHandle , v.name)
            end
        end

        while true do
            local t = 500

            local pcoords = GetEntityCoords(PlayerPedId())

            for _, v in pairs(Config.ListPlacesJob) do
                local dist = GetDistanceBetweenCoords(pcoords, v.coords, true)
                
                if not DataLocation and dist < 6.0 then
                    t = 0

                    DrawMarker(0x94FDAE17, v.coords.x, v.coords.y, v.coords.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.4, 0, 128, 0, 30, 0, 0, 2, 0, 0, 0, 0)

                    if dist < 2 then
                        local VarString = CreateVarString(10, 'LITERAL_STRING', v.name)
                        PromptSetActiveGroupThisFrame(Prompts, VarString)

                        if PromptHasHoldModeCompleted(MenuPrompt) then
                            if Config.PlayersJobList[LocalPlayer.state.Character.CharId] then
                                DataLocation = v
                                JobMenu(v)

                            else
                                VORPcore.NotifyObjective(Config.StrNoJob, 4000)
                            end

                            Wait(500)
                        end
                    end
                end
            end 

            Wait(t)
        end
    end
end)

function JobMenu()
    MenuData.CloseAll()

    TaskStandStill(PlayerPedId(), -1)
    FreezeEntityPosition(PlayerPedId(), true)

    local elements = {}

    for i, v in pairs(Config.PlayersJobList[LocalPlayer.state.Character.CharId]) do
        elements[#elements + 1] = {
            label = v.label,
            value = v,
            -- desc = '',
        }
    end

    MenuData.Open('default', GetCurrentResourceName(), 'JobMenu', {
        title = DataLocation.name,
        subtext = Config.StrSubTitle,
        align = 'top-left',
        elements = elements,

    }, function(data, menu)
        if data.current.value then
            TriggerServerEvent("xakra_utils:update_job", data.current.value)
        end

        menu.close()
        ClearPedTasks(PlayerPedId())
        FreezeEntityPosition(PlayerPedId(), false)
        DataLocation = nil

    end, function(data, menu)
        menu.close()
        ClearPedTasks(PlayerPedId())
        FreezeEntityPosition(PlayerPedId(), false)
        DataLocation = nil
    end)
end

-- CHANGE PED
RegisterNetEvent('xakra_utils:set_ped')
AddEventHandler('xakra_utils:set_ped', function(ped)
    local model = joaat(ped.model)

    if IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(100)
        end
        
        SetPlayerModel(PlayerId(), model, false)

        if ped.outfit then
            SetPedOutfitPreset(PlayerPedId(), ped.outfit)
        else
            SetRandomOutfitVariation(PlayerPedId(), true)  
        end

        SetModelAsNoLongerNeeded(model)
    end
end)

-- USE INDIAN PIPE
local pipe

RegisterNetEvent('xakra_utils:pipepeace')
AddEventHandler('xakra_utils:pipepeace', function() 
    FPrompt(Config.FPrompt, 0x3B24C470, false)
    LMPrompt(Config.LMPrompt, 0x07B8BEAF, false)
    EPrompt(Config.EPrompt, 0xD51B784F, false)
    ExecuteCommand('close')

    -- local male = IsPedMale(PlayerPedId())
    pipe = CreateObject(joaat('p_peacepipe01x'), GetEntityCoords(PlayerPedId(), true), true, true, true)
    local righthand = GetEntityBoneIndexByName(PlayerPedId(), 'SKEL_R_Finger13')

    AttachEntityToEntity(pipe, PlayerPedId(), righthand, -0.06, -0.05, 0.211, -167.0, 26.0, -10.0, true, true, false, false, 1, true)
    
    Anim(PlayerPedId(),'amb_rest@world_human_smoking@male_b@base','base',-1, 31)
    
    repeat Wait(0) until IsEntityPlayingAnim(PlayerPedId(),"amb_rest@world_human_smoking@male_b@base","base", 3)

    if proppromptdisplayed == false then
        PromptSetEnabled(PropPrompt, true)
        PromptSetVisible(PropPrompt, true)
        PromptSetEnabled(UsePrompt, true)
        PromptSetVisible(UsePrompt, true)
        PromptSetEnabled(ChangeStance, true)
        PromptSetVisible(ChangeStance, true)
        proppromptdisplayed = true
	end

    while IsEntityPlayingAnim(PlayerPedId(), 'amb_rest@world_human_smoking@male_b@base','base', 3) do
		if UiPromptHasStandardModeCompleted(PropPrompt) then
            PromptSetEnabled(PropPrompt, false)
            PromptSetVisible(PropPrompt, false)
            PromptSetEnabled(UsePrompt, false)
            PromptSetVisible(UsePrompt, false)
            PromptSetEnabled(ChangeStance, false)
            PromptSetVisible(ChangeStance, false)
            proppromptdisplayed = false

            Anim(PlayerPedId(), 'amb_wander@code_human_smoking_wander@male_b@trans', 'pipe_trans_nopipe', -1, 30)
            Wait(6066)
            
            break
		end
        
        if UiPromptHasStandardModeCompleted(ChangeStance) then
            DisablePrompts(false)

            Anim(PlayerPedId(), 'amb_rest@world_human_smoking@pipe@proper@male_d@wip_base', 'wip_base', -1, 30)
            Wait(5000)
            Anim(PlayerPedId(), 'amb_rest@world_human_smoking@male_b@base','base', -1, 31)

            DisablePrompts(true)
        end

        if UiPromptHasStandardModeCompleted(UsePrompt) then
            DisablePrompts(false)

            Anim(PlayerPedId(), 'amb_rest@world_human_smoking@male_b@idle_a','idle_a', -1, 30, 0)
            Wait(22600)
            Anim(PlayerPedId(), 'amb_rest@world_human_smoking@male_b@base','base', -1, 31, 0)

            DisablePrompts(true)
        end

        Wait(0)
    end

    UiPromptDelete(ChangeStance)
    UiPromptDelete(UsePrompt)
    UiPromptDelete(PropPrompt)

    proppromptdisplayed = false

    if pipe and DoesEntityExist(pipe) then
        DeleteEntity(pipe)
    end

    RemoveAnimDict('amb_wander@code_human_smoking_wander@male_b@trans')
    RemoveAnimDict('amb_rest@world_human_smoking@male_b@base')
    RemoveAnimDict('amb_rest@world_human_smoking@pipe@proper@male_d@wip_base')
    RemoveAnimDict('amb_rest@world_human_smoking@male_b@idle_a')
    RemoveAnimDict('amb_rest@world_human_smoking@male_b@idle_b')
    
    ClearPedSecondaryTask(PlayerPedId())
    ClearPedTasks(PlayerPedId())
end)

function Anim(entity, animDict, animName, duration, flag, introtiming, exittiming)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)

        local t = 500

        while not HasAnimDictLoaded(animDict) and t > 0 do
            t = t - 1
            Wait(0)
        end
    end

    TaskPlayAnim(entity or PlayerPedId(), animDict, animName, tonumber(introtiming) or 1.0, tonumber(exittiming) or 1.0, duration or -1, flag or 1, 1, false, false, false, 0, true)
    -- RemoveAnimDict(animDict)

    repeat Wait(0) until IsEntityPlayingAnim(entity or PlayerPedId(), animDict, animName, 3)
end

function DisablePrompts(enable)
    PromptSetEnabled(PropPrompt, enable)
    PromptSetEnabled(UsePrompt, enable)
    PromptSetEnabled(ChangeStance, enable)
end

function FPrompt(text, button, hold)
    proppromptdisplayed=false
    PropPrompt=nil
    local str = text or 'Put Away'
    local buttonhash = button or 0x3B24C470
    local holdbutton = hold or false
    PropPrompt = PromptRegisterBegin()
    PromptSetControlAction(PropPrompt, buttonhash)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(PropPrompt, str)
    PromptSetEnabled(PropPrompt, false)
    PromptSetVisible(PropPrompt, false)
    UiPromptSetStandardMode(PropPrompt, holdbutton)
    PromptRegisterEnd(PropPrompt)
end

function LMPrompt(text, button, hold)
    UsePrompt=nil
    local str = text or 'Use'
    local buttonhash = button or 0x07B8BEAF
    local holdbutton = hold or false
    UsePrompt = PromptRegisterBegin()
    PromptSetControlAction(UsePrompt, buttonhash)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(UsePrompt, str)
    PromptSetEnabled(UsePrompt, false)
    PromptSetVisible(UsePrompt, false)
    UiPromptSetStandardMode(UsePrompt, holdbutton)
    PromptRegisterEnd(UsePrompt)
end

function EPrompt(text, button, hold)
    ChangeStance=nil
    local str = text or 'Use'
    local buttonhash = button or 0xD51B784F
    local holdbutton = hold or false
    ChangeStance = PromptRegisterBegin()
    PromptSetControlAction(ChangeStance, buttonhash)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(ChangeStance, str)
    PromptSetEnabled(ChangeStance, false)
    PromptSetVisible(ChangeStance, false)
    UiPromptSetStandardMode(ChangeStance, holdbutton)
    PromptRegisterEnd(ChangeStance)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        UiPromptDelete(ChangeStance)
        UiPromptDelete(UsePrompt)
        UiPromptDelete(PropPrompt)

        if pipe and DoesEntityExist(pipe) then
            DeleteEntity(pipe)
        end

        if Config.ChangeJobs then
            for i, v in pairs(Config.ListPlacesJob) do
                if v.BlipHandle then
                    RemoveBlip(v.BlipHandle)
                end
            end	
        end

        if DataLocation then
            MenuData.CloseAll()
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(PlayerPedId(), false)
        end
	end
end)