local var_0_0 = class("BuildShipRegularExchangeMediator", import("...base.ContextMediator"))

var_0_0.EXCHAGNE_SHIP = "BuildShipRegularExchangeMediator.EXCHAGNE_SHIP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.EXCHAGNE_SHIP, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.REGULAR_BUILD_POOL_EXCHANGE, {
			id = arg_2_1
		})
	end)
	arg_1_0.viewComponent:setCount(getProxy(BuildShipProxy):getRegularExchangeCount())
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.REGULAR_BUILD_POOL_EXCHANGE_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == GAME.REGULAR_BUILD_POOL_EXCHANGE_DONE then
		arg_4_0.viewComponent:flush()
	end
end

return var_0_0
