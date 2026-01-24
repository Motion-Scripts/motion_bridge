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
