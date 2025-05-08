local var_0_0 = class("IslandSlotCollectCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.build_id
	local var_1_2 = var_1_0.area_id
	local var_1_3 = getProxy(IslandProxy):GetIsland():GetBuildingAgency()

	pg.ConnectionMgr.GetInstance():Send(21507, {
		build_id = var_1_1,
		area_id = var_1_2
	}, 21508, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:GetBuilding(var_1_1):UpdateCollectDataBySlotId(arg_2_0.collect_area)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end
	end)
end

return var_0_0
