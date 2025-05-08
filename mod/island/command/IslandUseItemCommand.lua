local var_0_0 = class("IslandUseItemCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.count or 1
	local var_1_3 = var_1_0.arg or {}
	local var_1_4 = getProxy(IslandProxy):GetIsland()
	local var_1_5 = var_1_4:GetInventoryAgency()

	if var_1_2 > var_1_5:GetOwnCount(var_1_1) then
		pg.TipsMgr.GetInstance():ShowTips(i18n1("数量不足"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21026, {
		id = var_1_1,
		count = var_1_2,
		arg = var_1_3
	}, 21027, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = IslandDropHelper.AddItems(arg_2_0)

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.ship_list) do
				var_1_4:GetCharacterAgency():AddShip(IslandShip.New(iter_2_1))
			end

			var_1_5:RemoveItem(var_1_1, var_1_2)
			arg_1_0:HandleUsageEffect(var_1_1, var_1_3)
			arg_1_0:sendNotification(GAME.ISLAND_USE_ITEM_DONE, {
				dropData = var_2_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end
	end)
end

function var_0_0.HandleUsageEffect(arg_3_0, arg_3_1, arg_3_2)
	if IslandItem.StaticGetUsageType(arg_3_1) == IslandItemUsage.usage_ship_state then
		local var_3_0 = IslandItem.StaticGetUsageArg(arg_3_1)
		local var_3_1 = tonumber(var_3_0)

		getProxy(IslandProxy):GetIsland():GetCharacterAgency():AddShipState(arg_3_2[1], var_3_1)
		pg.TipsMgr.GetInstance():ShowTips(i18n1("赠送成功"))
	end
end

return var_0_0
