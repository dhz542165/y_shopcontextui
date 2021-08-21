----------------------BY YZZOW AND DHZ----------------------
-------------------discord.gg/ZKJcrDddYx--------------------
----------------------BY YZZOW AND DHZ----------------------
local ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1000)
	end
end)
local BraquageeOk = nil

local BaseMenu = ContextUI:CreateMenu(1, "Personne") 

local Nourriture = ContextUI:CreateSubMenu(BaseMenu, "Nourriture")
local Boisson = ContextUI:CreateSubMenu(BaseMenu, "Boisson")
local Divers = ContextUI:CreateSubMenu(BaseMenu, "Divers")
local Verification = ContextUI:CreateSubMenu(BaseMenu, "Verification")

function Verif()
    ESX.TriggerServerCallback('dhz_cooldown:bracoverif', function(cb)
        BraquageeOk = cb
    end)
end


ContextUI:IsVisible(BaseMenu, function(Entity)
    if Entity.Model == -573920724 then 
        ContextUI:Button("Nourriture", nil, function(Selected)
            if (Selected) then
            end
        end, Nourriture)
        ContextUI:Button("Boisson", nil, function(Selected)
            if (Selected) then
            end
        end, Boisson)
        if  Config.diversactiver then
            ContextUI:Button("Divers", nil, function(Selected)
                if (Selected) then
                end
            end,Divers)
        end
        if  Config.braquage then
            if BraquageeOk == true then
                ContextUI:Button("~r~Braquer le vendeur", nil, function(Selected)
                    if (Selected) then
                    end
                end,Verification)
            else
                ContextUI:Button("~r~Braquage impossible", nil, function(Selected)
                    if (Selected) then
                    end
                end)
            end
        end
    end
end)

ContextUI:IsVisible(Nourriture, function(Entity)
    ContextUI:Button("Acheter 1X Pain", '~g~100$', function(Selected)
        if (Selected) then
            TriggerServerEvent("y_shop:Pain")
        end
    end)
end)

ContextUI:IsVisible(Boisson, function(Entity)
    ContextUI:Button("Acheter 1X Eau",'~g~100$', function(Selected)
        if (Selected) then
            TriggerServerEvent("y_shop:Eau")
        end
    end)
end)

ContextUI:IsVisible(Divers, function(Entity)
    ContextUI:Button("Acheter un Téléphone", '~g~100$', function(Selected)
        if (Selected) then
            TriggerServerEvent("y_shop:tel")
        end
    end)
end)

ContextUI:IsVisible(Verification, function(Entity)
    ContextUI:Button("~r~Oui", Config.Verification, function(Selected)
        if (Selected) then
            if IsPedArmed(PlayerPedId(), 4) then
                braquage() 
                ContextUI:CloseAll()
            else 
                ESX.ShowNotification("~r~Vous n'êtes pas armé")
            end    
        end
    end,BaseMenu)

    ContextUI:Button("~g~Non", Config.Verification, function(Selected)
        if (Selected) then
        end
    end,BaseMenu)
end)



Keys.Register("LMENU", "LMENU", "BaseMenu", function()
    ContextUI.Focus = not ContextUI.Focus;
    Verif()
end)

      
Citizen.CreateThread(function()

    for _, info in pairs(Config.npc) do
        blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(blip,628)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.9)
        SetBlipColour(blip, 30)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Magasin")
        EndTextCommandSetBlipName(blip)
      end

    for _, item in pairs(Config.npc) do
        RequestModel(item.hash)
        while not HasModelLoaded(item.hash) do
            Wait(1)
        end

        ped =  CreatePed(4, item.hash, item.x, item.y, item.z-0.92, item.a, false, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
    end
end)

RegisterNetEvent('y_braco:message')
AddEventHandler('y_braco:message', function(store)
    ESX.ShowAdvancedNotification('Braquage', 'Magasin', 'Mon magasin se fait braquer , aidez moi s\'il vous plait', 'CHAR_MANUEL', 10)
    ESX.ShowAdvancedNotification('Braquage', 'Magasin', 'Y pour accepter | F pour refuser', 'CHAR_MANUEL', 10)
    while true do 
        if IsControlPressed(0,246) then
            SetNewWaypoint(Config.npc[store].x, Config.npc[store].y)
            return
        elseif IsControlPressed(0,49) then
            return
        end
        Wait(0)
    end 
end)

function braquage()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local player = PlayerPedId()
    for k, v in pairs(Config.npc) do
        if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
            TriggerServerEvent('y_braco:appel',k)
        end
    end
    FreezeEntityPosition(player, true)
    ESX.ShowNotification('~g~Attendez ne me tuer pas je remplis le sac')
    Citizen.Wait(Config.time)
    TriggerServerEvent("petitkiwisauvages")
    FreezeEntityPosition(player, false)
end
