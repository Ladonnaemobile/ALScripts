local var_0_0 = class("IslandSyncControlCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(21209, {
		island_id = var_1_0.islandId,
		obj_id = var_1_0.objId,
		slot_id = var_1_0.slotId,
		mseconds = var_1_0.mseconds
	}, 21210, function(arg_2_0)
		if IslandConst.SYNC_TEST_DELAY_ON then
			local var_2_0 = math.random(IslandConst.SYNC_TEST_DELAY_L, IslandConst.SYNC_TEST_DELAY_R)

			LeanTween.delayedCall(var_2_0 / 1000, System.Action(function()
				existCall(var_1_0.onResult, arg_2_0.result)
			end))
		else
			existCall(var_1_0.onResult, arg_2_0.result)
		end
	end)
end

return var_0_0
