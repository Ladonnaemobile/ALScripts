local var_0_0 = class("BattleGateBossRushEX")

ys.Battle.BattleGateBossRushEX = var_0_0
var_0_0.__name = "BattleGateBossRushEX"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.actId
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = getProxy(FleetProxy)
	local var_1_3 = getProxy(BayProxy)
	local var_1_4 = pg.battle_cost_template[SYSTEM_BOSS_RUSH_EX]
	local var_1_5 = var_1_4.oil_cost > 0
	local var_1_6 = 0
	local var_1_7 = 0
	local var_1_8 = 0
	local var_1_9 = 0
	local var_1_10 = getProxy(ActivityProxy):getActivityById(var_1_0):GetSeriesData()
	local var_1_11 = var_1_10:GetStaegLevel() + 1
	local var_1_12 = var_1_10:GetExpeditionIds()[var_1_11]
	local var_1_13 = var_1_10:GetFleetIds()
	local var_1_14 = var_1_13[var_1_11]
	local var_1_15 = var_1_13[#var_1_13]

	if var_1_10:GetMode() == BossRushSeriesData.MODE.SINGLE then
		var_1_14 = var_1_13[1]
	end

	local var_1_16 = var_1_2:getActivityFleets()[var_1_0]
	local var_1_17 = var_1_16[var_1_14]
	local var_1_18 = var_1_16[var_1_15]
	local var_1_19 = {}
	local var_1_20 = var_1_3:getSortShipsByFleet(var_1_17)

	for iter_1_0, iter_1_1 in ipairs(var_1_20) do
		var_1_19[#var_1_19 + 1] = iter_1_1.id
	end

	local var_1_21 = var_1_1:getRawData()

	if var_1_5 and var_1_9 > var_1_21.oil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	arg_1_1.ShipVertify()

	local function var_1_22(arg_2_0)
		if var_1_5 then
			var_1_21:consume({
				gold = 0,
				oil = var_1_7
			})
		end

		if var_1_4.enter_energy_cost > 0 then
			local var_2_0 = pg.gameset.battle_consume_energy.key_value

			for iter_2_0, iter_2_1 in ipairs(var_1_20) do
				iter_2_1:cosumeEnergy(var_2_0)
				var_1_3:updateShip(iter_2_1)
			end
		end

		var_1_1:updatePlayer(var_1_21)

		local var_2_1 = {
			prefabFleet = {},
			stageId = var_1_12,
			system = SYSTEM_BOSS_RUSH_EX,
			actId = var_1_0,
			token = arg_2_0.key
		}

		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, var_2_1)
	end

	local function var_1_23(arg_3_0)
		arg_1_1:RequestFailStandardProcess(arg_3_0)
	end

	BeginStageCommand.SendRequest(SYSTEM_BOSS_RUSH_EX, var_1_19, {
		var_1_12
	}, var_1_22, var_1_23)
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	local var_4_0 = pg.battle_cost_template[SYSTEM_BOSS_RUSH_EX]
	local var_4_1 = getProxy(FleetProxy)
	local var_4_2 = getProxy(BayProxy)
	local var_4_3 = arg_4_0.statistics._battleScore
	local var_4_4 = var_4_3 > ys.Battle.BattleConst.BattleScore.C
	local var_4_5 = 0
	local var_4_6 = {}
	local var_4_7 = {}

	;(function()
		local var_5_0 = arg_4_0.actId
		local var_5_1 = getProxy(ActivityProxy):getActivityById(var_5_0):GetSeriesData()
		local var_5_2 = var_5_1:GetStaegLevel() + 1
		local var_5_3 = var_5_1:GetFleetIds()
		local var_5_4 = var_5_3[var_5_2]
		local var_5_5 = var_5_3[#var_5_3]

		if var_5_1:GetMode() == BossRushSeriesData.MODE.SINGLE then
			var_5_4 = var_5_3[1]
		end

		local var_5_6 = var_4_1:getActivityFleets()[var_5_0]
		local var_5_7 = var_5_6[var_5_4]
		local var_5_8 = var_5_6[var_5_5]

		local function var_5_9(arg_6_0)
			table.insertto(var_4_7, _.values(arg_6_0.commanderIds))
			table.insertto(var_4_6, var_4_2:getSortShipsByFleet(arg_6_0))
		end

		var_5_9(var_5_7)

		if arg_4_0.statistics.submarineAid then
			var_5_9(var_5_8)
		end
	end)()

	local var_4_8 = arg_4_1.GeneralPackage(arg_4_0, var_4_6)

	var_4_8.commander_id_list = var_4_7

	local function var_4_9(arg_7_0)
		arg_4_0.statistics.mvpShipID = arg_7_0.mvp

		local var_7_0 = {
			system = SYSTEM_BOSS_RUSH_EX,
			statistics = arg_4_0.statistics,
			score = var_4_3,
			result = arg_7_0.result
		}
		local var_7_1 = arg_4_0.actId
		local var_7_2 = getProxy(ActivityProxy):getActivityById(var_7_1)

		var_7_2:GetSeriesData():PassStage(var_7_0)
		getProxy(ActivityProxy):updateActivity(var_7_2)
		arg_4_1:sendNotification(GAME.FINISH_STAGE_DONE, var_7_0)
	end

	seriesAsync({
		function(arg_8_0)
			if var_4_4 then
				arg_4_1:SendRequest(var_4_8, function(arg_9_0)
					arg_8_0(arg_9_0)
				end)

				return
			end

			arg_8_0({})
		end,
		function(arg_10_0, arg_10_1)
			var_4_9(arg_10_1)
		end
	})
end

return var_0_0
