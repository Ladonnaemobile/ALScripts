local var_0_0 = class("BossSinglePreCombatMediator", import("view.base.ContextMediator"))

var_0_0.ON_START = "PreCombatMediator:ON_START"
var_0_0.ON_COMMIT_EDIT = "PreCombatMediator:ON_COMMIT_EDIT"
var_0_0.ON_ABORT_EDIT = "PreCombatMediator:ON_ABORT_EDIT"
var_0_0.OPEN_SHIP_INFO = "PreCombatMediator:OPEN_SHIP_INFO"
var_0_0.CHANGE_FLEET_SHIPS_ORDER = "PreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
var_0_0.BEGIN_STAGE_PROXY = "PreCombatMediator:BEGIN_STAGE_PROXY"
var_0_0.SHOW_CONTINUOUS_OPERATION_WINDOW = "PreCombatMediator:SHOW_CONTINUOUS_OPERATION_WINDOW"
var_0_0.CONTINUOUS_OPERATION = "PreCombatMediator:CONTINUOUS_OPERATION"
var_0_0.ON_AUTO = "BossSinglePreCombatMediator:ON_AUTO"
var_0_0.ON_SUB_AUTO = "BossSinglePreCombatMediator:ON_SUB_AUTO"

function var_0_0.register(arg_1_0)
	arg_1_0:bindEvent()

	arg_1_0.ships = getProxy(BayProxy):getRawData()

	arg_1_0.viewComponent:SetShips(arg_1_0.ships)

	local var_1_0 = arg_1_0.contextData.fleets

	arg_1_0.fleets = var_1_0

	arg_1_0.viewComponent:SetFleets(var_1_0)

	local var_1_1 = getProxy(PlayerProxy):getData()

	arg_1_0.viewComponent:SetPlayerInfo(var_1_1)

	local var_1_2 = var_1_0[1]

	arg_1_0.viewComponent:SetCurrentFleet(var_1_2.id)

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if iter_1_1:isSubmarineFleet() and iter_1_1:isLegalToFight() == true then
			arg_1_0.viewComponent:SetSubFlag(true)

			break
		end
	end
end

function var_0_0.bindEvent(arg_2_0)
	local var_2_0 = arg_2_0.contextData.system

	local function var_2_1()
		local var_3_0 = 0

		for iter_3_0, iter_3_1 in ipairs(arg_2_0.contextData.fleets) do
			local var_3_1 = iter_3_1:GetCostSum().oil
			local var_3_2 = iter_3_0 == 1
			local var_3_3 = arg_2_0.contextData.costLimit[var_3_2 and 1 or 2]

			if var_3_3 > 0 then
				var_3_1 = math.min(var_3_1, var_3_3)
			end

			var_3_0 = var_3_0 + var_3_1
		end

		return var_3_0
	end

	arg_2_0:bind(var_0_0.ON_ABORT_EDIT, function(arg_4_0)
		return
	end)
	arg_2_0:bind(var_0_0.ON_AUTO, function(arg_5_0, arg_5_1)
		arg_2_0:onAutoBtn(arg_5_1)
	end)
	arg_2_0:bind(var_0_0.ON_SUB_AUTO, function(arg_6_0, arg_6_1)
		arg_2_0:onAutoSubBtn(arg_6_1)
	end)
	arg_2_0:bind(var_0_0.CHANGE_FLEET_SHIPS_ORDER, function(arg_7_0, arg_7_1)
		arg_2_0:refreshEdit(arg_7_1)
	end)
	arg_2_0:bind(var_0_0.OPEN_SHIP_INFO, function(arg_8_0, arg_8_1, arg_8_2)
		arg_2_0.contextData.form = PreCombatLayer.FORM_EDIT

		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_8_2:getShipIds()) do
			table.insert(var_8_0, arg_2_0.ships[iter_8_1])
		end

		arg_2_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_8_1,
			shipVOs = var_8_0
		})
	end)
	arg_2_0:bind(var_0_0.ON_COMMIT_EDIT, function(arg_9_0, arg_9_1)
		arg_2_0:commitEdit(arg_9_1)
	end)
	arg_2_0:bind(var_0_0.ON_START, function(arg_10_0, arg_10_1, arg_10_2)
		if var_2_1() > getProxy(PlayerProxy):getRawData().oil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

			return
		end

		seriesAsync({
			function(arg_11_0)
				if pg.battle_cost_template[var_2_0].enter_energy_cost == 0 then
					arg_11_0()

					return
				end

				local var_11_0
				local var_11_1
				local var_11_2 = arg_2_0.fleets[1]
				local var_11_3 = "ship_energy_low_warn_no_exp"
				local var_11_4 = {}

				for iter_11_0, iter_11_1 in ipairs(var_11_2.ships) do
					table.insert(var_11_4, getProxy(BayProxy):getShipById(iter_11_1))
				end

				local var_11_5 = var_11_2:GetName()

				Fleet.EnergyCheck(var_11_4, var_11_5, function(arg_12_0)
					if arg_12_0 then
						arg_11_0()
					end
				end, nil, var_11_3)
			end,
			function(arg_13_0)
				if arg_2_0.contextData.OnConfirm then
					arg_2_0.contextData.OnConfirm(arg_13_0)
				else
					arg_13_0()
				end
			end,
			function()
				arg_2_0.viewComponent:emit(var_0_0.BEGIN_STAGE_PROXY, {
					curFleetId = arg_10_1,
					continuousBattleTimes = arg_10_2
				})
			end
		})
	end)
	arg_2_0:bind(var_0_0.SHOW_CONTINUOUS_OPERATION_WINDOW, function(arg_15_0, arg_15_1)
		arg_2_0:addSubLayers(Context.New({
			mediator = BossSingleContinuousOperationWindowMediator,
			viewComponent = BossSingleContinuousOperationWindow,
			data = {
				mainFleetId = arg_15_1,
				stageId = arg_2_0.contextData.stageId,
				system = arg_2_0.contextData.system,
				oilCost = var_2_1()
			}
		}))
	end)
	arg_2_0:bind(var_0_0.BEGIN_STAGE_PROXY, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_2_0.contextData.useTicket and 1 or 0

		arg_2_0:sendNotification(GAME.BEGIN_STAGE, {
			stageId = arg_2_0.contextData.stageId,
			mainFleetId = arg_16_1.curFleetId,
			system = arg_2_0.contextData.system,
			actId = arg_2_0.contextData.actId,
			variableBuffList = arg_2_0.contextData.buffList,
			continuousBattleTimes = arg_16_1.continuousBattleTimes,
			totalBattleTimes = arg_16_1.continuousBattleTimes,
			useVariableTicket = var_16_0
		})
	end)
end

function var_0_0.refreshEdit(arg_17_0, arg_17_1)
	local var_17_0 = getProxy(FleetProxy)
	local var_17_1 = arg_17_0.contextData.actId

	var_17_0:updateActivityFleet(var_17_1, arg_17_1.id, arg_17_1)

	local var_17_2 = var_17_0:getActivityFleets()[var_17_1]

	arg_17_0.viewComponent:SetFleets(var_17_2)
	arg_17_0.viewComponent:UpdateFleetView(false)
end

function var_0_0.commitEdit(arg_18_0, arg_18_1)
	getProxy(FleetProxy):commitActivityFleet(arg_18_0.contextData.actId)
	arg_18_1()
end

function var_0_0.onAutoBtn(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.isOn
	local var_19_1 = arg_19_1.toggle

	arg_19_0:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = var_19_0,
		toggle = var_19_1
	})
end

function var_0_0.onAutoSubBtn(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.isOn
	local var_20_1 = arg_20_1.toggle

	arg_20_0:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = var_20_0,
		toggle = var_20_1
	})
end

function var_0_0.removeShipFromFleet(arg_21_0, arg_21_1, arg_21_2)
	arg_21_1:removeShip(arg_21_2)

	return true
end

function var_0_0.listNotificationInterests(arg_22_0)
	return {
		GAME.BEGIN_STAGE_DONE,
		GAME.BEGIN_STAGE_ERRO,
		PreCombatMediator.BEGIN_STAGE_PROXY,
		var_0_0.CONTINUOUS_OPERATION
	}
end

function var_0_0.handleNotification(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1:getName()
	local var_23_1 = arg_23_1:getBody()

	if var_23_0 == GAME.BEGIN_STAGE_DONE then
		arg_23_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_23_1)
	elseif var_23_0 == GAME.BEGIN_STAGE_ERRO then
		if var_23_1 == 3 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = function()
					arg_23_0.viewComponent:closeView()
				end
			})
		end
	elseif var_23_0 == PreCombatMediator.BEGIN_STAGE_PROXY then
		arg_23_0.viewComponent:emit(PreCombatMediator.BEGIN_STAGE_PROXY, var_23_1)
	elseif var_23_0 == var_0_0.CONTINUOUS_OPERATION then
		arg_23_0.viewComponent:emit(PreCombatMediator.ON_START, var_23_1.mainFleetId, var_23_1.battleTimes)
	end
end

return var_0_0
