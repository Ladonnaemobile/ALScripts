local var_0_0 = class("CommanderManualCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if var_1_0.operation == CommanderManualProxy.GET_TASK then
		pg.ConnectionMgr.GetInstance():Send(22302, {
			id = var_1_0.pageId,
			index = var_1_0.index
		}, 22303, function(arg_2_0)
			if arg_2_0.result == 0 then
				getProxy(CommanderManualProxy):GetPageById(var_1_0.pageId):RemoveDoingGetTaskIndex(var_1_0.index)

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
			end
		end)
	elseif var_1_0.operation == CommanderManualProxy.GET_PT_AWARD then
		pg.ConnectionMgr.GetInstance():Send(22304, {
			id = var_1_0.pageId
		}, 22305, function(arg_3_0)
			if arg_3_0.result == 0 then
				getProxy(CommanderManualProxy):AddPageAward(var_1_0.pageId)

				local var_3_0 = PlayerConst.addTranDrop(arg_3_0.drop_list)

				arg_1_0:sendNotification(GAME.COMMANDER_MANUAL_OP_DONE, {
					operation = var_1_0.operation,
					awards = var_3_0,
					pageId = var_1_0.pageId
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
			end
		end)
	end
end

return var_0_0
