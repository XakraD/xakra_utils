Config = {}

-- true(active)/false(disabled)
Config.Pipepeace = true -- Use item pipepeace
Config.PlayersPed = true -- Users will be able to use the /ped function
Config.ChangeJobs = true -- Users will be able to change jobs

------------------ LIST PLAYERS PED ------------------
-- [CHARIDENTIFIER] = "NAME_MODEL"
Config.PlayersPedList = {
    [630] = "CS_oddfellowspinhead", -- Example 1
    [631] = "RCSP_ODDFELLOWS_MALES_01", -- Example 2
}

------------------ CHANGE JOB ------------------
Config.StrPressKey = "Pulsa [E] para abrir el menú" -- Text that shows to open the menu
Config.StrNoJob = "No tienes ningún trabajo asigando" -- Text that is displayed when you do not have any jobs in the list
Config.StrSetJob1 = "Set ha asignado el trabajo " -- Text when assigning work 1/2
Config.StrSetJob2 = " de nivel " -- Text when assigning work 2/2

Config.StrTitle = "Cambio de trabajo" -- Menu title
Config.StrSubTitle = "Elige el trabajo" -- Menu subtitle

-- Config blip
Config.JobBlip = {
    name = "Cartel de trabajos", -- Name for blip
    sprite = 587827268, -- What blip to show
}

-- list of places to change jobs
Config.ListPlacesJob = {
    pos1 = { -- Example Rhodes office poster
        enable_blip = true, -- true(active)/false(disabled)
        coords = vector3(1353.13, -1305.15, 77.09),
    },

    pos2 = { -- Example Saint Denis office poster (blip disabled)
        enable_blip = false,
        coords = vector3(2514.61, -1320.65, 48.72),
    },
}

------------------ PLAYER JOB LIST ------------------
-- [CHARIDENTIFIER] = {jobname="NAME_JOB", jobgrade=NUM_GRADE}
Config.PlayersJobList = {
    [630] = { -- Example 1
        {jobname="doctor", jobgrade=3},
        {jobname="workshop_cart", jobgrade=0},
        {jobname="barman", jobgrade=1},
    },

    [631] = { -- Example 2
        {jobname="periodist", jobgrade=2},
        {jobname="miner", jobgrade=0},
    },
}
