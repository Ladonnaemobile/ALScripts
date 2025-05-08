local var_0_0 = class("WatermelonGameVo")
local var_0_1 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameId = arg_1_1
	arg_1_0.hubId = pg.mini_game[arg_1_0.gameId].hub_id
	arg_1_0.drop = pg.mini_game[arg_1_0.gameId].simple_config_data.drop_ids
	arg_1_0.totalTimes = pg.mini_game_hub[arg_1_0.hubId].reward_need
	arg_1_0.mgData = getProxy(MiniGameProxy):GetMiniGameData(arg_1_0.gameId)
	arg_1_0.mgHubData = getProxy(MiniGameProxy):GetHubByHubId(arg_1_0.hubId)
	arg_1_0.tplItemPool = {}
end

function var_0_0.getGameTimes(arg_2_0)
	if arg_2_0.mgHubData then
		return arg_2_0.mgHubData.count or 0
	end

	return 0
end

function var_0_0.getGameUseTimes(arg_3_0)
	if arg_3_0.mgHubData then
		return arg_3_0.mgHubData.usedtime or 0
	end

	return 0
end

function var_0_0.GetGameRound(arg_4_0)
	if arg_4_0.selectRound ~= nil then
		return arg_4_0.selectRound
	end

	local var_4_0 = arg_4_0:getGameUseTimes()
	local var_4_1 = arg_4_0:GetGameTimes()

	if var_4_1 and var_4_1 > 0 then
		return var_4_0 + 1
	end

	if var_4_0 and var_4_0 > 0 then
		return var_4_0
	end

	return 1
end

function var_0_0.prepare(arg_5_0)
	arg_5_0.gameTime = WatermelonGameConst.game_time
	arg_5_0.gameStepTime = 0
	arg_5_0.deltaTime = 0
	arg_5_0.scoreNum = 0
	arg_5_0.startSettlement = false
	arg_5_0._joyStickData = nil
	arg_5_0.createBallCd = var_0_1
end

function var_0_0.setJoyStickData(arg_6_0, arg_6_1)
	arg_6_0._joyStickData = arg_6_1
end

function var_0_0.getJoyStickData(arg_7_0)
	return arg_7_0._joyStickData
end

function var_0_0.setGameTpl(arg_8_0, arg_8_1)
	arg_8_0.tpl = arg_8_1
end

function var_0_0.getTplItemFromPool(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_1 or arg_9_1 == "" then
		return nil
	end

	if not arg_9_2 then
		return nil
	end

	if arg_9_0.tplItemPool[arg_9_1] == nil then
		arg_9_0.tplItemPool[arg_9_1] = {}
	end

	if #arg_9_0.tplItemPool[arg_9_1] == 0 then
		local var_9_0 = tf(instantiate(findTF(arg_9_0.tpl, arg_9_1)))

		setParent(var_9_0, arg_9_2)

		return var_9_0
	else
		return table.remove(arg_9_0.tplItemPool[arg_9_1], #arg_9_0.tplItemPool[arg_9_1])
	end
end

function var_0_0.returnTplItem(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_2 or not arg_10_1 then
		return
	end

	setActive(arg_10_2, false)
	table.insert(arg_10_0.tplItemPool[arg_10_1], arg_10_2)
end

function var_0_0.clear(arg_11_0)
	arg_11_0.tpl = nil
	arg_11_0.tplItemPool = nil
end

return var_0_0
