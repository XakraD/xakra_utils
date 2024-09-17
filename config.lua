Config = {}

-- true(active)/false(disabled)
Config.Pipepeace = true -- Use item pipepeace
Config.PlayersPed = true -- Users will be able to use the /ped function
Config.ChangeJobs = true -- Users will be able to change jobs

------------------ LIST PLAYERS PED ------------------
-- [CHARIDENTIFIER] = { model = "model_ped", outfit = number or false }
Config.PlayersPedList = {
    [1] = { model = "CS_oddfellowspinhead", outfit = 2 }, -- Example 1
    -- [2] = { model = "RCSP_ODDFELLOWS_MALES_01", outfit = false }, -- Example 2
}

------------------ CHANGE JOB ------------------
Config.StrKey = "Abrir" -- Text that shows to open the menu
Config.StrNoJob = "No tienes ningún trabajo asigando" -- Text that is displayed when you do not have any jobs in the list
Config.StrSetJob1 = "Se te ha asignado el trabajo ~COLOR_GREEN~" -- Text when assigning work 1/2
Config.StrSetJob2 = "~COLOR_WHITE~ de nivel ~COLOR_GREEN~" -- Text when assigning work 2/2
Config.StrSubTitle = "Elige el trabajo" -- Menu subtitle
Config.FPrompt = 'Put Away'
Config.LMPrompt = 'Use'
Config.EPrompt = 'Pose'


-- list of places to change jobs
Config.ListPlacesJob = {
    { -- Example Rhodes office poster
        name = 'Cartel de trabajos',
        enable_blip = true, -- true(active)/false(disabled)
        sprite = 587827268, -- What blip to show
        coords = vector3(1353.11, -1305.61, 76.9),
    },

    { -- Example Saint Denis office poster (blip disabled)
        name = 'Cartel de trabajos',
        enable_blip = false,
        sprite = 587827268, -- What blip to show
        coords = vector3(2514.61, -1320.65, 48.70),
    },
}

------------------ PLAYER JOB LIST ------------------
-- [CHARIDENTIFIER] = {jobname="NAME_JOB", jobgrade=NUM_GRADE}
Config.PlayersJobList = {
    [1] = { -- Example 1
        { label = 'Doctor', jobname= "doctor", jobgrade = 3 },
        { label = 'Workshop', jobname= "workshop", jobgrade = 1 },
        { label = 'Barman', jobname= "barman", jobgrade = 1 },
    },

    -- [2] = { -- Example 2
    --     { jobname="periodist", jobgrade = 2},
    --     { jobname="miner", jobgrade = 0},
    -- },
}
