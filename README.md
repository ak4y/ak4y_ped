# ak4y_ped

# esx_skin > client > main.lua
```
RegisterNetEvent('esx_skin:karakterYukle')
AddEventHandler('esx_skin:karakterYukle', function()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		if skin ~= nil then
			TriggerEvent('skinchanger:loadSkin', skin)

		end
	end)
end)
```
