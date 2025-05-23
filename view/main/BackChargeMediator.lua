local var_0_0 = class("BackChargeMediator", import("..base.ContextMediator"))

var_0_0.CHARGE = "BackChargeMediator:CHARGE"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(PlayerProxy):getData()

	arg_1_0.viewComponent:setPlayer(var_1_0)

	local var_1_1 = getProxy(ShopsProxy):getChargedList()

	if var_1_1 then
		arg_1_0.viewComponent:setChargedList(var_1_1)
	end

	arg_1_0:bind(var_0_0.CHARGE, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.REFUND_CHHARGE, {
			shopId = arg_2_1
		})
	end)
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		PlayerProxy.UPDATED,
		GAME.CHARGE_SUCCESS,
		GAME.REFUND_INFO_UPDATE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == PlayerProxy.UPDATED then
		-- block empty
	elseif var_4_0 == ShopsProxy.CHARGED_LIST_UPDATED then
		-- block empty
	elseif var_4_0 == GAME.CHARGE_CONFIRM_FAILED then
		-- block empty
	elseif var_4_0 == GAME.CHARGE_SUCCESS then
		arg_4_0:sendNotification(GAME.GET_REFUND_INFO)
	elseif var_4_0 == GAME.REFUND_INFO_UPDATE then
		arg_4_0.viewComponent:refundUpdate()
	end
end

return var_0_0
