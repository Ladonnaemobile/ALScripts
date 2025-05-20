local var_0_0 = class("MusicMainPlayAlbumChangeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().albumName
	local var_1_1 = getProxy(AppreciateProxy)
	local var_1_2
	local var_1_3 = var_1_0 == "none" and 0 or var_1_0 == "favor" and 999 or var_1_1:getAlbumMusicList(var_1_0)[1]

	if not var_1_3 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(17513, {
		music_no = var_1_3,
		music_mode = var_1_1.musicPlayerLoopType
	}, 17514, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:setMainPlayMusicAlbum(var_1_3)
			arg_1_0:sendNotification(GAME.APPRECIATE_CHANGE_MAIN_PLAY_ALBUM_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end
	end)
end

return var_0_0
