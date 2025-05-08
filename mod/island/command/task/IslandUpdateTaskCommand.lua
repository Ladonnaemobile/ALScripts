local var_0_0 = class("IslandUpdateTaskCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.taskId
	local var_1_2 = var_1_0.targetId
	local var_1_3 = var_1_0.progress
	local var_1_4 = 0

	warning("Req UpdateTask", var_1_4, var_1_2, var_1_3)
	pg.ConnectionMgr.GetInstance():Send(21036, {
		task_id = var_1_4,
		target_id = var_1_2,
		target_count = var_1_3
	}, 21037, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.task_list) do
				warning("Real UpdateTask", iter_2_1.id, #iter_2_1.process_list)

				local var_2_1 = IslandTask.New(iter_2_1)

				var_2_0:UpdateTask(var_2_1)
			end

			arg_1_0:sendNotification(GAME.ISLAND_UPDATE_TASK_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end
	end)
end

return var_0_0
