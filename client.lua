ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local cd = false -- Oyuna girişte pedfix kullanılması için verilen süre.
AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent("ak4y:checkPed")
	Citizen.Wait(2*60000)
	cd=true
end)

RegisterNetEvent("ak4y:pedYukle")
AddEventHandler("ak4y:pedYukle", function(model)
    if model ~= nil then
        local pedHash = GetHashKey(model)
			while not HasModelLoaded(pedHash) do
				RequestModel(pedHash)
				Citizen.Wait(10)
			end
		Citizen.Wait(150)
		SetPlayerModel(PlayerId(),pedHash)
		SetPedDefaultComponentVariation(PlayerPedId())
    end
end)

RegisterNetEvent("ak4y:pedSil")
AddEventHandler("ak4y:pedSil", function()
	TriggerEvent('esx_skin:karakterYukle')
end)

RegisterNetEvent("ak4y:yeniPed")
AddEventHandler("ak4y:yeniPed", function(model)
	TriggerServerEvent("ak4y:savePed", model)
	Citizen.Wait(200)
	TriggerServerEvent("ak4y:checkPed")
end)

RegisterCommand("pedfix", function()
	if cd then
		ESX.ShowNotification("Bu kodu yalnızca oyuna girdiğin ilk 2 dakika kullanabilirsin.")
	else
		TriggerServerEvent("ak4y:checkPed")
	end
end)


