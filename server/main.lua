local PlayersHarvesting   = {}
local PlayersTransforming = {}
local PlayersSelling      = {}

local function Harvestmeth(source)

	SetTimeout(5000, function()

		if PlayersHarvesting[source] == true then

			TriggerEvent('esx:getPlayerFromId', source, function(xPlayer)

				local methQuantity = xPlayer:getInventoryItem('meth').count

				if methQuantity == 60 then
					TriggerClientEvent('esx_meth:showNotification', source, 'Vous ne pouvez plus ramasser de meth, votre inventaire est plein')
				else
					xPlayer:addInventoryItem('meth', 1)
					Harvestmeth(source)
				end

			end)

		end
	end)
end

RegisterServerEvent('esx_meth:startHarvestmeth')
AddEventHandler('esx_meth:startHarvestmeth', function()

	PlayersHarvesting[source] = true

	TriggerClientEvent('esx_meth:showNotification', source, 'Ramassage en cours...')

	Harvestmeth(source)

end)

RegisterServerEvent('esx_meth:stopHarvestmeth')
AddEventHandler('esx_meth:stopHarvestmeth', function()

	PlayersHarvesting[source] = false

end)

local function Transformmeth(source)

	SetTimeout(5000, function()

		if PlayersTransforming[source] == true then

			TriggerEvent('esx:getPlayerFromId', source, function(xPlayer)

				local methQuantity = xPlayer:getInventoryItem('meth').count

				if methQuantity < 5 then
					TriggerClientEvent('esx_meth:showNotification', source, 'Vous n\'avez pas assez de meth à conditionner')
				else
					xPlayer:removeInventoryItem('meth', 5)
					xPlayer:addInventoryItem('meth_pooch', 1)
				
					Transformmeth(source)
				end

			end)

		end
	end)
end

RegisterServerEvent('esx_meth:startTransformmeth')
AddEventHandler('esx_meth:startTransformmeth', function()

	PlayersTransforming[source] = true

	TriggerClientEvent('esx_meth:showNotification', source, 'Conditonnement en cours...')

	Transformmeth(source)

end)

RegisterServerEvent('esx_meth:stopTransformmeth')
AddEventHandler('esx_meth:stopTransformmeth', function()

	PlayersTransforming[source] = false

end)

local function Sellmeth(source)

	SetTimeout(10000, function()

		if PlayersSelling[source] == true then

			TriggerEvent('esx:getPlayerFromId', source, function(xPlayer)

				local poochQuantity = xPlayer:getInventoryItem('meth_pooch').count

				if poochQuantity == 0 then
					TriggerClientEvent('esx_meth:showNotification', source, 'Vous n\'avez plus de pochons à vendre')
				else
					xPlayer:removeInventoryItem('meth_pooch', 1)
					xPlayer:addAccountMoney('black_money', 50)
				
					Sellmeth(source)
				end

			end)

		end
	end)
end

RegisterServerEvent('esx_meth:startSellmeth')
AddEventHandler('esx_meth:startSellmeth', function()

	PlayersSelling[source] = true

	TriggerClientEvent('esx_meth:showNotification', source, 'Vente en cours...')

	Sellmeth(source)

end)

RegisterServerEvent('esx_meth:stopSellmeth')
AddEventHandler('esx_meth:stopSellmeth', function()

	PlayersSelling[source] = false

end)