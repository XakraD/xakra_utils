local player_charid
local player_source
-- CHANGE JOBS
Citizen.CreateThread(function()
    if Config.ChangeJobs then
        for i, location in pairs(Config.ListPlacesJob) do
            if location.enable_blip then
                Config.ListPlacesJob[i].BlipHandle = N_0x554d9d53f696d002(1664425300, location.coords.x, location.coords.y, location.coords.z)
                SetBlipSprite(Config.ListPlacesJob[i].BlipHandle , Config.JobBlip.sprite, 1)
                SetBlipScale(Config.ListPlacesJob[i].BlipHandle , 0.2)
                Citizen.InvokeNative(0x9CB1A1623062F402, Config.ListPlacesJob[i].BlipHandle , Config.JobBlip.name)
            end
        end
    end
end)
Citizen.CreateThread(function()
    if Config.ChangeJobs then
        while true do
            local pcoords = GetEntityCoords(PlayerPedId())
            for _, location in pairs(Config.ListPlacesJob) do
                local dist = GetDistanceBetweenCoords(pcoords, location.coords, 1)
                if dist < 6.0 then
                    Citizen.InvokeNative(0x2A32FAA57B937173, 0x94FDAE17, location.coords.x, location.coords.y, location.coords.z-1.2, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.4, 0, 128, 0, 30, 0, 0, 2, 0, 0, 0, 0)
                end
            end 
            Citizen.Wait(10)
        end
    end
end)

RegisterNetEvent('xakra_utils:open_menu')
AddEventHandler('xakra_utils:open_menu', function(charid,source)
    player_source = source
    player_charid = charid
    WarMenu.OpenMenu('change_jobs')
end)

Citizen.CreateThread(function()
    WarMenu.CreateMenu('change_jobs', Config.StrTitle)
    WarMenu.SetSubTitle('change_jobs', Config.StrSubTitle)
    while true do
        local t = 4
        if WarMenu.IsMenuOpened('change_jobs') then
            if Config.PlayersJobList[player_charid] then
                for i, jobs in pairs(Config.PlayersJobList[player_charid]) do
                    if WarMenu.Button(jobs.jobname) then
                        TriggerServerEvent("xakra_utils:update_job",jobs.jobname,jobs.jobgrade,player_source)
                        TriggerEvent("vorp:TipRight", Config.StrSetJob1..jobs.jobname..Config.StrSetJob2..jobs.jobgrade, 6000)
                        WarMenu.CloseMenu()
                    end
                end
            else
                TriggerEvent("vorp:TipRight", Config.StrNoJob, 6000)
                WarMenu.CloseMenu()
            end
            WarMenu.Display()
        else
            t = 500
        end
        Citizen.Wait(t)
    end
end)

Citizen.CreateThread(function()
    if Config.ChangeJobs then
        while true do
            for _, location in pairs(Config.ListPlacesJob) do
                local pcoords = GetEntityCoords(PlayerPedId())
                local dist = GetDistanceBetweenCoords(pcoords, location.coords, 1)
            
                if dist < 1.0 then
                    TriggerEvent("enter:menu")
                    if IsControlPressed(0,0x018C47CF) then
                        TriggerServerEvent("xakra_utils:player_job")
                    end
                end          
                Citizen.Wait(10)
            end
        end
    end
end)

RegisterNetEvent('enter:menu')
AddEventHandler('enter:menu', function()
    SetTextScale(0.5, 0.5)
    local msg = Config.StrPressKey
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())

    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
  end)

-- CHANGE PED
RegisterNetEvent("xakra_utils:set_ped")
AddEventHandler("xakra_utils:set_ped", function(ped)
    local model = GetHashKey(ped.model)
    local player = PlayerId()

    if IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(100)
        end
        
        Citizen.InvokeNative(0xED40380076A31506, player, model, false)

        if ped.outfit then
            SetPedOutfitPreset(PlayerPedId(), ped.outfit)
            SetModelAsNoLongerNeeded(model)
        else
            Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
            SetModelAsNoLongerNeeded(model)
        end
    end
end)

-- USE INDIAN PIPE
RegisterNetEvent('xakra_utils:pipepeace')
AddEventHandler('xakra_utils:pipepeace', function() 
    FPrompt("Put Away", 0x3B24C470, false)
    LMPrompt("Use", 0x07B8BEAF, false)
    EPrompt("Pose", 0xD51B784F, false)
    ExecuteCommand('close')
    local ped = PlayerPedId()
    local male = IsPedMale(ped)
    local x,y,z = table.unpack(GetEntityCoords(ped, true))
    local pipe = CreateObject(GetHashKey("p_peacepipe01x"), x, y, z + 0.2, true, true, true)
    local righthand = GetEntityBoneIndexByName(ped, "SKEL_R_Finger13")
                                            -- del y atras//derech izquier//arriba abajo
    -- AttachEntityToEntity(pipe, ped, righthand, -0.13, -0.025, 0.18, -170.0, 20.0, -15.0, true, true, false, false, 1, true)
    AttachEntityToEntity(pipe, ped, righthand, -0.06, -0.025, 0.15, -170.0, 20.0, -22.0, true, true, false, false, 1, true)
    Anim(ped,"script_story@ntv1@ig@ig_8","ig8_loop_p_peacepipe02",-1,30)
    Wait(9000)
    Anim(ped,"amb_rest@world_human_smoking@male_b@base","base",-1,31)

    while not IsEntityPlayingAnim(ped,"amb_rest@world_human_smoking@male_b@base","base", 3) do
        Wait(100)
    end

    if proppromptdisplayed == false then
        PromptSetEnabled(PropPrompt, true)
        PromptSetVisible(PropPrompt, true)
        PromptSetEnabled(UsePrompt, true)
        PromptSetVisible(UsePrompt, true)
        PromptSetEnabled(ChangeStance, true)
        PromptSetVisible(ChangeStance, true)
        proppromptdisplayed = true
	end

    while IsEntityPlayingAnim(ped, "amb_rest@world_human_smoking@male_b@base","base", 3) do

        Wait(5)
		if IsControlJustReleased(0, 0x3B24C470) then
            PromptSetEnabled(PropPrompt, false)
            PromptSetVisible(PropPrompt, false)
            PromptSetEnabled(UsePrompt, false)
            PromptSetVisible(UsePrompt, false)
            PromptSetEnabled(ChangeStance, false)
            PromptSetVisible(ChangeStance, false)
            proppromptdisplayed = false

            Anim(ped, "amb_wander@code_human_smoking_wander@male_b@trans", "pipe_trans_nopipe", -1, 30)
            Wait(6066)
            DeleteEntity(pipe)
            ClearPedSecondaryTask(ped)
            ClearPedTasks(ped)
            Wait(10)
		end
        
        if IsControlJustReleased(0, 0xD51B784F) then
            Anim(ped, "amb_rest@world_human_smoking@pipe@proper@male_d@wip_base", "wip_base", -1, 30)
            Wait(5000)
            Anim(ped, "amb_rest@world_human_smoking@male_b@base","base", -1, 31)
            Wait(100)
        end

        if IsControlJustReleased(0, 0x07B8BEAF) then
            Wait(500)
            if IsControlPressed(0, 0x07B8BEAF) then
                Anim(ped, "amb_rest@world_human_smoking@male_b@idle_b","idle_d", -1, 30, 0)
                Wait(15599)
                Anim(ped, "amb_rest@world_human_smoking@male_b@base","base", -1, 31, 0)
                Wait(100)
            else
                Anim(ped, "amb_rest@world_human_smoking@male_b@idle_a","idle_a", -1, 30, 0)
                Wait(22600)
                Anim(ped, "amb_rest@world_human_smoking@male_b@base","base", -1, 31, 0)
                Wait(100)
            end
        end
    end

    PromptSetEnabled(PropPrompt, false)
    PromptSetVisible(PropPrompt, false)
    PromptSetEnabled(UsePrompt, false)
    PromptSetVisible(UsePrompt, false)
    PromptSetEnabled(ChangeStance, false)
    PromptSetVisible(ChangeStance, false)
    proppromptdisplayed = false

    DetachEntity(pipe, true, true)
    ClearPedSecondaryTask(ped)
    RemoveAnimDict("amb_wander@code_human_smoking_wander@male_b@trans")
    RemoveAnimDict("amb_rest@world_human_smoking@male_b@base")
    RemoveAnimDict("amb_rest@world_human_smoking@pipe@proper@male_d@wip_base")
    RemoveAnimDict("amb_rest@world_human_smoking@male_b@idle_a")
    RemoveAnimDict("amb_rest@world_human_smoking@male_b@idle_b")
    Wait(100)
    ClearPedTasks(ped)
end)

function Anim(actor, dict, body, duration, flags, introtiming, exittiming)
Citizen.CreateThread(function()
    RequestAnimDict(dict)
    local dur = duration or -1
    local flag = flags or 1
    local intro = tonumber(introtiming) or 1.0
    local exit = tonumber(exittiming) or 1.0
	timeout = 5
    while (not HasAnimDictLoaded(dict) and timeout>0) do
		timeout = timeout-1
        if timeout == 0 then 
            print("Animation Failed to Load")
		end
		Citizen.Wait(300)
    end
    TaskPlayAnim(actor, dict, body, intro, exit, dur, flag --[[1 for repeat--]], 1, false, false, false, 0, true)
    end)
end

function FPrompt(text, button, hold)
    Citizen.CreateThread(function()
        proppromptdisplayed=false
        PropPrompt=nil
        local str = text or "Put Away"
        local buttonhash = button or 0x3B24C470
        local holdbutton = hold or false
        PropPrompt = PromptRegisterBegin()
        PromptSetControlAction(PropPrompt, buttonhash)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(PropPrompt, str)
        PromptSetEnabled(PropPrompt, false)
        PromptSetVisible(PropPrompt, false)
        PromptSetHoldMode(PropPrompt, holdbutton)
        PromptRegisterEnd(PropPrompt)
    end)
end

function LMPrompt(text, button, hold)
    Citizen.CreateThread(function()
        UsePrompt=nil
        local str = text or "Use"
        local buttonhash = button or 0x07B8BEAF
        local holdbutton = hold or false
        UsePrompt = PromptRegisterBegin()
        PromptSetControlAction(UsePrompt, buttonhash)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(UsePrompt, str)
        PromptSetEnabled(UsePrompt, false)
        PromptSetVisible(UsePrompt, false)
        PromptSetHoldMode(UsePrompt, holdbutton)
        PromptRegisterEnd(UsePrompt)
    end)
end

function EPrompt(text, button, hold)
    Citizen.CreateThread(function()
        ChangeStance=nil
        local str = text or "Use"
        local buttonhash = button or 0xD51B784F
        local holdbutton = hold or false
        ChangeStance = PromptRegisterBegin()
        PromptSetControlAction(ChangeStance, buttonhash)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ChangeStance, str)
        PromptSetEnabled(ChangeStance, false)
        PromptSetVisible(ChangeStance, false)
        PromptSetHoldMode(ChangeStance, holdbutton)
        PromptRegisterEnd(ChangeStance)
    end)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        if Config.ChangeJobs then
            WarMenu.CloseMenu()
            for i, v in pairs(Config.ListPlacesJob) do
                if v.BlipHandle then
                    RemoveBlip(v.BlipHandle)
                end
            end	
        end
	end
end)