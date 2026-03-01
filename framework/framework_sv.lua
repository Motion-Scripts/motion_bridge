local resourceName = GetCurrentResourceName()
if resourceName ~= "motion_bridge" then
    print("^1[ERROR]^7 Resource must be named 'motion_bridge' ")
    print("^1[ERROR]^7 Current name: '" .. resourceName .. "'")
    print("^1[ERROR]^7 Resource will now stop")
    return
end

exports('GetPlayerJob', function(playerId)
    if not playerId then return nil end

    local framework = Bridge.FRAMEWORK()

    -- ESX
    if framework == 'esx' then
        local ESX = exports['es_extended']:getSharedObject()
        local xPlayer = ESX.GetPlayerFromId(playerId)

        if not xPlayer or not xPlayer.job then return nil end

        return {
            name = xPlayer.job.name,
            label = xPlayer.job.label,
            grade = {
                level = xPlayer.job.grade,
                name = xPlayer.job.grade_name,
                label = xPlayer.job.grade_label
            },
            type = xPlayer.job.type or 'job'
        }

    -- QB / QBX
    elseif framework == 'qb' or framework == 'qbx' then
        local Player = Bridge.CORE().Functions.GetPlayer(playerId)
        if not Player or not Player.PlayerData or not Player.PlayerData.job then return nil end

        local job = Player.PlayerData.job

        return {
            name = job.name,
            label = job.label,
            grade = {
                level = job.grade.level,
                name = job.grade.name,
                label = job.grade.name
            },
            type = job.type or 'job'
        }
    end

    return nil
end)

exports('HasJob', function(playerId, jobName)
    local job = exports.motion_bridge:GetPlayerJob(playerId)
    return job and job.name == jobName or false
end)

exports('HasJobGrade', function(playerId, jobName, minGrade)
    local job = exports.motion_bridge:GetPlayerJob(playerId)

    if not job then return false end
    if job.name ~= jobName then return false end

    return job.grade.level >= minGrade
end)

--[[
    GetPlayerGroup(playerId) -> string
    HasGroup(playerId, groups) -> bool
    groups = {"admin", "superadmin", ...}
]]
exports('GetPlayerGroup', function(playerId)
    if not playerId then return "user" end

    local framework = Bridge.FRAMEWORK()

    if framework == 'esx' then
        local ESX = exports['es_extended']:getSharedObject()
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer and xPlayer.getGroup then return xPlayer.getGroup() or "user" end
    elseif framework == 'qb' or framework == 'qbx' then
        local Player = Bridge.CORE().Functions.GetPlayer(playerId)
        if Player and Player.PlayerData then
            return Player.PlayerData.permission or (Player.PlayerData.job and Player.PlayerData.job.grade_name) or "user"
        end
    elseif framework == 'ox' and lib.checkDependency('ox_core', '0.0.0', false) then
        local ok, Ox = pcall(require, '@ox_core.lib.init')
        if ok and Ox then
            local Player = Ox.GetPlayer(playerId)
            if Player and Player.getGroups then
                local groups = Player.getGroups()
                for _, g in ipairs({"admin", "superadmin", "god", "mod"}) do
                    if groups and groups[g] then return g end
                end
            end
        end
    end

    return "user"
end)

exports('HasGroup', function(playerId, groups)
    if not groups or type(groups) ~= "table" then return false end
    local grp = exports.motion_bridge:GetPlayerGroup(playerId)
    grp = tostring(grp):lower()
    for _, g in ipairs(groups) do
        if tostring(g):lower() == grp then return true end
    end
    return false
end)
