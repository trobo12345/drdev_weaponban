deniedUsers = {}

Roby.loadDeniedUsers = function()
    MySQL.Async.fetchAll('SELECT identifier FROM drdev_antiweapon', {}, function(result)
        for _, row in ipairs(result) do
            local identifier = row.identifier
            deniedUsers[identifier] = true
        end
    end)
end

Roby.saveDeniedUsers = function (deniedUsers)
    MySQL.Async.execute('DELETE FROM drdev_antiweapon', {}, function(rowsChanged)
        for identifier, _ in pairs(deniedUsers) do
            MySQL.Async.execute('INSERT INTO drdev_antiweapon (identifier) VALUES (@identifier)', {
                ['@identifier'] = identifier
            }, function()
            end)
        end
    end)
end

Roby.loadDeniedUsers()