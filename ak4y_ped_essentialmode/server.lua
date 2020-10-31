ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addGroupCommand', 'ped', 'admin', function(source, args, user)
	if args[1] and args[2] ~= nil then
		if ESX.GetPlayerFromId(args[1]) ~= nil then
			local xPlayer = ESX.GetPlayerFromId(args[1])
			if args[2] == "sil" then
				local Identifier = xPlayer.getIdentifier()
				MySQL.Async.fetchAll("UPDATE users SET ped = @ped WHERE identifier = @identifier",{['@identifier'] = Identifier,	['@ped'] = nil}) 
				Citizen.Wait(100)
				TriggerClientEvent("ak4y:pedSil", xPlayer.source)
			else
				TriggerClientEvent("ak4y:yeniPed", xPlayer.source, args[2])
			end
		end		
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = "'Ped Adı' ya da 'sil' (kisinin pedini siler)", params = {{ name = 'id' }} })

RegisterServerEvent('ak4y:savePed')
AddEventHandler('ak4y:savePed', function(model)
	local xPlayer = ESX.GetPlayerFromId(source)
	local Identifier = xPlayer.getIdentifier()
	MySQL.Async.fetchAll("UPDATE users SET ped = @ped WHERE identifier = @identifier",{['@identifier'] = Identifier,	['@ped'] = tostring(model)}) 
end)

RegisterServerEvent('ak4y:checkPed')
AddEventHandler('ak4y:checkPed', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local Identifier = xPlayer.getIdentifier()
	MySQL.Async.fetchAll("SELECT ped FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)
		if result[1].ped == "" or result[1].ped == nil then	
			TriggerClientEvent("ak4y:pedSil", xPlayer.source)
		else
			TriggerClientEvent("ak4y:pedYukle", xPlayer.source, result[1].ped)
		end
    end)
end)
