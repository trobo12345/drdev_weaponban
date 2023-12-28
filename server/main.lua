RegisterCommand('denyweapon', function(source, args)
    local identifier = args[1]
    if identifier then
        MySQL.Async.fetchScalar('SELECT COUNT(*) FROM drdev_antiweapon WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(count)
            if count > 0 then
                TriggerClientEvent('esx:showNotification', source, identifier .. Lang[Roby.Lang]['already_banned'])
            else
                deniedUsers[identifier] = true
                Roby.saveDeniedUsers(deniedUsers)
                MySQL.Async.execute('INSERT INTO drdev_antiweapon (identifier) VALUES (@identifier)', {
                    ['@identifier'] = identifier
                }, function()
                    TriggerClientEvent('esx:showNotification', source, identifier .. Lang[Roby.Lang]['now_banned'])
                end)
            end
        end)
    end
end, true)


RegisterCommand('allowweapon', function(source, args)
    local identifier = args[1]
    if identifier then
        deniedUsers[identifier] = nil
        MySQL.Async.execute('DELETE FROM drdev_antiweapon WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('esx:showNotification', source, identifier .. Lang[Roby.Lang]['now_allowed'])
            else
                TriggerClientEvent('esx:showNotification', source, identifier .. Lang[Roby.Lang]['not_found'])
            end
        end)
    end
end, true)

RegisterNetEvent('sendDeniedUsersToClient')
AddEventHandler('sendDeniedUsersToClient', function()
    local source = source
    TriggerClientEvent('receiveDeniedUsers', source, deniedUsers)
end)

RegisterNetEvent("disarmplayer")
AddEventHandler("disarmplayer", function ()
    local source = source
    TriggerClientEvent('ox_inventory:disarm', source, false)
    TriggerClientEvent('esx:showNotification', source, Lang[Roby.Lang]['disarmed'])
end)
