local var_0_0 = class("MusicPlayLoopTypeChangeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().loopType
	local var_1_1 = getProxy(AppreciateProxy)
	local var_1_2

	if var_1_0 == "list" then
		var_1_2 = 0
	elseif var_1_0 == "random" then
		var_1_2 = 1
	elseif var_1_0 == "one" then
		var_1_2 = 2
	else
		return
	end

	pg.ConnectionMgr.GetInstance():Send(17513, {
		music_no = var_1_1.mainMarkMusicId,
		music_mode = var_1_2
	}, 17514, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:setMusicPlayerLoopType(var_1_2)
			arg_1_0:sendNotification(GAME.APPRECIATE_CHANGE_MUSIC_PLAY_LOOP_TYPE_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end
	end)
end

return var_0_0
