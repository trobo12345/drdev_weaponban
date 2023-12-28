RegisterNetEvent('receiveDeniedUsers')
AddEventHandler('receiveDeniedUsers', function(receivedDeniedUsers)
    deniedUsers = receivedDeniedUsers
end)


AddEventHandler('ox_inventory:currentWeapon', function(weapon) 
    if weapon then
        Roby.GetDeniedUsersFromServer()
        Wait(5 * 100)
        local playeridentifier = ESX.PlayerData.identifier
        Roby.CeckDeniedUsers(weapon, playeridentifier, source)
    else
        return
    end
end)