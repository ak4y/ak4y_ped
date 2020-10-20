# ak4y_ped
- esx_skin > client > main.lua

*1*: Aşağıdaki kodu bulun ve tamamen yorum satırına alın.
```
AddEventHandler('playerSpawned', function()
	Citizen.CreateThread(function()
		while not playerLoaded do
			Citizen.Wait(100)
		end

		if firstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
					TriggerEvent('skinchanger:loadSkin', {sex = 0}, OpenSaveableMenu)
				else
					TriggerEvent('skinchanger:loadSkin', skin)
				end
			end)

			firstSpawn = false
		end
	end)
end)
```
*2*: Aşağıdaki kodu clientin içine yapıştırın
```
RegisterNetEvent('esx_skin:karakterYukle')
AddEventHandler('esx_skin:karakterYukle', function()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		if skin == nil then
			TriggerEvent('skinchanger:loadSkin', {sex = 0}, OpenSaveableMenu)
		else
			TriggerEvent('skinchanger:loadSkin', skin)
		end
	end)
end)
```
