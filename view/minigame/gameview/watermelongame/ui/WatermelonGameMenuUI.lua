local var_0_0 = class("WatermelonGameMenuUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3
	arg_1_0.menuUI = findTF(arg_1_0._tf, "ui/menuUI")
	arg_1_0.battleScrollRect = GetComponent(findTF(arg_1_0.menuUI, "battList"), typeof(ScrollRect))
	arg_1_0.totalTimes = arg_1_0._gameVo.totalTimes
	arg_1_0.battleItems = {}
	arg_1_0.dropItems = {}
	arg_1_0.textLastTimes = findTF(arg_1_0.menuUI, "lastTimes/desc")
	arg_1_0.btnRank = findTF(arg_1_0.menuUI, "btnRank")
	arg_1_0.btnHome = findTF(arg_1_0.menuUI, "btnHome")

	GetComponent(arg_1_0.btnRank, typeof(Image)):SetNativeSize()

	arg_1_0.imgHelp = findTF(arg_1_0.menuUI, "imgHelp")
	arg_1_0.highScore = findTF(arg_1_0.menuUI, "highScore/text")

	setActive(arg_1_0.imgHelp, false)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "rightPanelBg/arrowUp"), function()
		local var_2_0 = arg_1_0.battleScrollRect.normalizedPosition.y + 1 / (arg_1_0.totalTimes - 4)

		if var_2_0 > 1 then
			var_2_0 = 1
		end

		scrollTo(arg_1_0.battleScrollRect, 0, var_2_0)
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "rightPanelBg/arrowDown"), function()
		local var_3_0 = arg_1_0.battleScrollRect.normalizedPosition.y - 1 / (arg_1_0.totalTimes - 4)

		if var_3_0 < 0 then
			var_3_0 = 0
		end

		scrollTo(arg_1_0.battleScrollRect, 0, var_3_0)
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnBack"), function()
		arg_1_0._event:emit(WatermelonGameEvent.CLOSE_GAME)
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0.menuUI, "btnRule"), function()
		arg_1_0._event:emit(WatermelonGameEvent.SHOW_RULE, true)
	end, SFX_CANCEL)
	onButton(arg_1_0._event, arg_1_0.imgHelp, function()
		arg_1_0._event:emit(WatermelonGameEvent.SHOW_RULE, false)
	end, SFX_CANCEL)

	arg_1_0.btnStart = findTF(arg_1_0.menuUI, "btnStart")

	onButton(arg_1_0._event, arg_1_0.btnStart, function()
		arg_1_0._event:emit(WatermelonGameEvent.READY_START)
	end, SFX_CANCEL)
	onButton(arg_1_0._event, arg_1_0.btnRank, function()
		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_1_0.mgHubData.id,
			cmd = MiniGameOPCommand.CMD_SPECIAL_TRACK,
			args1 = {
				arg_1_0._gameVo.gameId,
				103
			}
		})
		arg_1_0._event:emit(WatermelonGameEvent.SHOW_RANK)
	end, SFX_CANCEL)
	onButton(arg_1_0._event, arg_1_0.btnHome, function()
		arg_1_0._event:emit(WatermelonGameEvent.ON_HOME)
	end, SFX_CANCEL)

	local var_1_0 = findTF(arg_1_0.menuUI, "tplBattleItem")
	local var_1_1 = arg_1_0._gameVo.drop

	for iter_1_0 = 1, 7 do
		local var_1_2 = iter_1_0
		local var_1_3 = tf(instantiate(var_1_0))

		var_1_3.name = "battleItem_" .. iter_1_0

		setParent(var_1_3, findTF(arg_1_0.menuUI, "battList/Viewport/Content"))

		local var_1_4 = iter_1_0

		GetSpriteFromAtlasAsync(WatermelonGameConst.ui_atlas, "DAY" .. var_1_4, function(arg_10_0)
			if arg_10_0 then
				setImageSprite(findTF(var_1_3, "state_open/desc"), arg_10_0, true)
				setImageSprite(findTF(var_1_3, "state_clear/desc"), arg_10_0, true)
				setImageSprite(findTF(var_1_3, "state_current/desc"), arg_10_0, true)
				setImageSprite(findTF(var_1_3, "state_closed/desc"), arg_10_0, true)
			end
		end)

		local var_1_5 = findTF(var_1_3, "icon")
		local var_1_6 = {
			type = var_1_1[iter_1_0][1],
			id = var_1_1[iter_1_0][2],
			count = var_1_1[iter_1_0][3]
		}

		updateDrop(var_1_5, var_1_6)
		onButton(arg_1_0._event, var_1_5, function()
			arg_1_0._event:emit(BaseUI.ON_DROP, var_1_6)
		end, SFX_PANEL)
		table.insert(arg_1_0.dropItems, var_1_5)
		setActive(var_1_3, true)
		table.insert(arg_1_0.battleItems, var_1_3)

		local var_1_7 = arg_1_0._gameVo:getGameUseTimes()
		local var_1_8 = arg_1_0._gameVo:getGameTimes()
	end
end

function var_0_0.show(arg_12_0, arg_12_1)
	setActive(arg_12_0.menuUI, arg_12_1)
end

function var_0_0.setGameRoomUI(arg_13_0, arg_13_1)
	if arg_13_1 then
		setActive(findTF(arg_13_0.menuUI, "lastTimes"), false)
		setActive(findTF(arg_13_0.menuUI, "btnRank"), false)
	end
end

function var_0_0.update(arg_14_0, arg_14_1)
	arg_14_0.mgHubData = arg_14_1

	local var_14_0 = arg_14_0:getGameUsedTimes(arg_14_1)
	local var_14_1 = arg_14_0:getGameTimes(arg_14_1)

	setText(arg_14_0.textLastTimes, var_14_1)

	for iter_14_0 = 1, 7 do
		setActive(findTF(arg_14_0.battleItems[iter_14_0], "state_open"), false)
		setActive(findTF(arg_14_0.battleItems[iter_14_0], "state_closed"), false)
		setActive(findTF(arg_14_0.battleItems[iter_14_0], "state_clear"), false)
		setActive(findTF(arg_14_0.battleItems[iter_14_0], "state_current"), false)

		if iter_14_0 <= var_14_0 then
			SetParent(arg_14_0.dropItems[iter_14_0], findTF(arg_14_0.battleItems[iter_14_0], "state_clear/icon"))
			setActive(arg_14_0.dropItems[iter_14_0], true)
			setActive(findTF(arg_14_0.battleItems[iter_14_0], "state_clear"), true)
		elseif iter_14_0 == var_14_0 + 1 and var_14_1 >= 1 then
			setActive(findTF(arg_14_0.battleItems[iter_14_0], "state_current"), true)
			SetParent(arg_14_0.dropItems[iter_14_0], findTF(arg_14_0.battleItems[iter_14_0], "state_current/icon"))
			setActive(arg_14_0.dropItems[iter_14_0], true)
		elseif var_14_0 < iter_14_0 and iter_14_0 <= var_14_0 + var_14_1 then
			setActive(findTF(arg_14_0.battleItems[iter_14_0], "state_open"), true)
			SetParent(arg_14_0.dropItems[iter_14_0], findTF(arg_14_0.battleItems[iter_14_0], "state_open/icon"))
			setActive(arg_14_0.dropItems[iter_14_0], true)
		else
			setActive(findTF(arg_14_0.battleItems[iter_14_0], "state_closed"), true)
			SetParent(arg_14_0.dropItems[iter_14_0], findTF(arg_14_0.battleItems[iter_14_0], "state_closed/icon"))
			setActive(arg_14_0.dropItems[iter_14_0], true)
		end
	end

	local var_14_2 = 1 - (var_14_0 - 3 < 0 and 0 or var_14_0 - 3) / (arg_14_0.totalTimes - 4)

	if var_14_2 > 1 then
		var_14_2 = 1
	end

	scrollTo(arg_14_0.battleScrollRect, 0, var_14_2)

	local var_14_3 = getProxy(MiniGameProxy):GetHighScore(arg_14_0._gameVo.gameId)
	local var_14_4 = var_14_3 and #var_14_3 > 0 and var_14_3[1] or 0

	setText(arg_14_0.highScore, var_14_4)
end

function var_0_0.CheckGet(arg_15_0)
	local var_15_0 = arg_15_0.mgHubData

	setActive(findTF(arg_15_0.menuUI, "got"), false)

	local var_15_1 = arg_15_0:getUltimate(var_15_0)

	if var_15_1 and var_15_1 ~= 0 then
		setActive(findTF(arg_15_0.menuUI, "got"), true)
	end

	if var_15_1 == 0 then
		if arg_15_0._gameVo.totalTimes > arg_15_0:getGameUsedTimes(var_15_0) then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_15_0.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_15_0.menuUI, "got"), true)
	end
end

function var_0_0.getGameTimes(arg_16_0, arg_16_1)
	return arg_16_1.count
end

function var_0_0.getGameUsedTimes(arg_17_0, arg_17_1)
	return arg_17_1.usedtime
end

function var_0_0.getUltimate(arg_18_0, arg_18_1)
	return arg_18_1.ultimate
end

return var_0_0
