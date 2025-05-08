local var_0_0 = class("GetIslandOrderExpAwardCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.level
	local var_1_2 = var_1_0.callback
	local var_1_3 = getProxy(IslandProxy):GetIsland():GetOrderAgency()

	if not var_1_3:CanGetAward(var_1_1) then
		pg.TipsMgr.GetInstance():ShowTips(i18n1("不可领取"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21412, {
		lv = var_1_1
	}, 21413, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:UpdateGotAwardList(var_1_1)

			local var_2_0 = IslandDropHelper.AddItems(arg_2_0)

			arg_1_0:sendNotification(GAME.ISLAND_GET_ORDER_EXP_AWARD_DONE, {
				dropData = var_2_0,
				callback = var_1_2,
				level = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end
	end)
end

return var_0_0
