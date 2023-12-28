deniedUsers = {}

Roby.GetDeniedUsersFromServer = function ()
    TriggerServerEvent('sendDeniedUsersToClient')
end

Roby.CeckDeniedUsers = function (weapon, identifier, source)
    if weapon and deniedUsers[identifier] then
        TriggerServerEvent("disarmplayer")
    else
        return
    end
end