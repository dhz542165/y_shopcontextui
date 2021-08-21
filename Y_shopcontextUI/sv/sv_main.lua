----------------------BY YZZOW AND DHZ----------------------
-------------------discord.gg/ZKJcrDddYx--------------------
----------------------BY YZZOW AND DHZ----------------------
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('y_shop:Pain')
AddEventHandler('y_shop:Pain', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    if playerMoney >= 100 then
		xPlayer.addInventoryItem("bread", 1)
		xPlayer.removeMoney(100)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez ~g~acheté~s~ un pain')
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas assez d\'argents')
	end
end)

RegisterServerEvent('y_shop:Eau')
AddEventHandler('y_shop:Eau', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    if playerMoney >= 100 then
		xPlayer.addInventoryItem("water", 1)
		xPlayer.removeMoney(100)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez ~g~acheté~s~ une bouteille d\'eau')
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas assez d\'argents')
	end
end)

RegisterServerEvent('y_shop:tel')
AddEventHandler('y_shop:tel', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    if playerMoney >= 100 then
		xPlayer.addInventoryItem("tel", 1)
		xPlayer.removeMoney(100)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez ~g~acheté~s~ un téléphone')
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez pas assez d\'argents')
	end
end)

RegisterServerEvent('y_braco:appel')
AddEventHandler('y_braco:appel', function(store)
    local xPlayers = ESX.GetPlayers()
    for i = 1,#xPlayers do 
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == "unemployed" then
            TriggerClientEvent("y_braco:message", xPlayer.source , store)
        end            
    end
end)

local CooldownJoueur = false
ESX.RegisterServerCallback('dhz_cooldown:bracoverif', function(source, cb)
    local xPlayers = ESX.GetPlayers()
    if not CooldownJoueur then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('petitkiwisauvages')
AddEventHandler('petitkiwisauvages', function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addAccountMoney('black_money', Config.ArgentBraquage)
    TriggerClientEvent('esx:showNotification', source, 'Tiens prends l\'argent et laisse moi en paix s\'il te plait')
    CooldownJoueur = true
    Wait(180000)
    CooldownJoueur = false
end)
