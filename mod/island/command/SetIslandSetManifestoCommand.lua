local var_0_0 = class("SetIslandSetManifestoCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().manifesto

	pg.ConnectionMgr.GetInstance():Send(21006, {
		signature = var_1_0
	}, 21007, function(arg_2_0)
		if arg_2_0.ret == 0 then
			getProxy(IslandProxy):GetIsland():SetManifesto(var_1_0)
			arg_1_0:sendNotification(GAME.ISLAND_SET_MANIFESTO_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.ret] .. arg_2_0.ret)
		end
	end)
end

return var_0_0
