local var_0_0 = class("BossSingleBattleFleetSelectMediatorComponent")

function var_0_0.AttachFleetSelect(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.New(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
end

function var_0_0.DetachFleetSelect(arg_2_0)
	if arg_2_0._IFleetSelect == nil then
		return
	end

	arg_2_0._IFleetSelect:_Destory_()

	arg_2_0._IFleetSelect = nil
end

function var_0_0.Ctor(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0._target_ = arg_3_1
	arg_3_0._actType = arg_3_2
	arg_3_0._systemType = arg_3_3
	arg_3_0._subFleetOffset = arg_3_4 or 10

	arg_3_0:_Init_()
end

function var_0_0._Init_(arg_4_0)
	arg_4_0._target_.class.GO_SCENE = arg_4_0._target_.__cname .. ":GO_SCENE"
	arg_4_0._target_.class.GO_SUBLAYER = arg_4_0._target_.__cname .. ":GO_SUBLAYER"
	arg_4_0._target_.class.ON_PRECOMBAT = arg_4_0._target_.__cname .. ":ON_PRECOMBAT"
	arg_4_0._target_.class.ON_COMMIT_FLEET = arg_4_0._target_.__cname .. ":ON_COMMIT_FLEET"
	arg_4_0._target_.class.ON_FLEET_RECOMMEND = arg_4_0._target_.__cname .. ":ON_FLEET_RECOMMEND"
	arg_4_0._target_.class.ON_FLEET_CLEAR = arg_4_0._target_.__cname .. ":ON_FLEET_CLEAR"
	arg_4_0._target_.class.ON_OPEN_DOCK = arg_4_0._target_.__cname .. ":ON_OPEN_DOCK"
	arg_4_0._target_.class.ON_FLEET_SHIPINFO = arg_4_0._target_.__cname .. ":ON_FLEET_SHIPINFO"
	arg_4_0._target_.class.ON_SELECT_COMMANDER = arg_4_0._target_.__cname .. ":ON_SELECT_COMMANDER"
	arg_4_0._target_.class.COMMANDER_FORMATION_OP = arg_4_0._target_.__cname .. ":COMMANDER_FORMATION_OP"
	arg_4_0._target_.class.ON_COMMANDER_SKILL = arg_4_0._target_.__cname .. ":ON_COMMANDER_SKILL"
	arg_4_0._target_.class.ON_PERFORM_COMBAT = arg_4_0._target_.__cname .. ":ON_PERFORM_COMBAT"

	arg_4_0:bindBattleEvents()

	arg_4_0._target_._IFleetSelect = arg_4_0
end

function var_0_0._Destory_(arg_5_0)
	arg_5_0._target_ = nil
end

function var_0_0.bindBattleEvents(arg_6_0)
	arg_6_0._target_.contextData.mediatorClass = arg_6_0._target_.class

	local var_6_0 = getProxy(FleetProxy)
	local var_6_1 = getProxy(ActivityProxy):getActivityByType(arg_6_0._actType)

	if not var_6_1 then
		return
	end

	arg_6_0._target_.contextData.bossActivity = var_6_1
	arg_6_0._target_.contextData.activityID = var_6_1.id
	arg_6_0._target_.contextData.stageIDs = var_6_1:GetStageIDs()
	arg_6_0._target_.contextData.useOilLimit = var_6_1:GetOilLimits()

	local var_6_2 = getProxy(FleetProxy):getActivityFleets()[arg_6_0._target_.contextData.activityID]

	arg_6_0._target_.contextData.actFleets = var_6_2

	local var_6_3 = getProxy(CommanderProxy):getPrefabFleet()

	arg_6_0._target_.viewComponent:setCommanderPrefabs(var_6_3)
	pg.GuildMsgBoxMgr.GetInstance():NotificationForBattle()
	arg_6_0._target_:bind(arg_6_0._target_.GO_SCENE, function(arg_7_0, arg_7_1, ...)
		arg_6_0._target_:sendNotification(GAME.GO_SCENE, arg_7_1, ...)
	end)
	arg_6_0._target_:bind(arg_6_0._target_.GO_SUBLAYER, function(arg_8_0, arg_8_1, arg_8_2)
		arg_6_0._target_:addSubLayers(arg_8_1, nil, arg_8_2)
	end)
	arg_6_0._target_:bind(ActivityMediator.EVENT_PT_OPERATION, function(arg_9_0, arg_9_1)
		arg_6_0._target_:sendNotification(GAME.ACT_NEW_PT, arg_9_1)
	end)
	arg_6_0._target_:bind(arg_6_0._target_.ON_PRECOMBAT, function(arg_10_0, arg_10_1)
		local var_10_0 = var_6_0:getActivityFleets()[arg_6_0._target_.contextData.activityID]

		if not var_10_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_no_fleet"))

			return
		end

		var_10_0[arg_10_1]:RemoveUnusedItems()

		if var_10_0[arg_10_1]:isLegalToFight() ~= true then
			pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_formation_unsatisfied"))

			return
		end

		var_10_0[arg_10_1 + arg_6_0._subFleetOffset]:RemoveUnusedItems()

		local var_10_1 = {
			var_10_0[arg_10_1],
			var_10_0[arg_10_1 + arg_6_0._subFleetOffset]
		}
		local var_10_2 = arg_6_0._target_.contextData.activityID

		if _.any(var_10_1, function(arg_11_0)
			local var_11_0, var_11_1 = arg_11_0:HaveShipsInEvent()

			if var_11_0 then
				pg.TipsMgr.GetInstance():ShowTips(var_11_1)

				return true
			end

			return _.any(arg_11_0:getShipIds(), function(arg_12_0)
				local var_12_0 = getProxy(BayProxy):RawGetShipById(arg_12_0)

				if not var_12_0 then
					return
				end

				local var_12_1, var_12_2 = ShipStatus.ShipStatusCheck("inActivity", var_12_0, nil, {
					inActivity = var_10_2
				})

				if not var_12_1 then
					pg.TipsMgr.GetInstance():ShowTips(var_12_2)

					return true
				end
			end)
		end) then
			return
		end

		local var_10_3
		local var_10_4
		local var_10_5 = arg_6_0._systemType
		local var_10_6 = arg_6_0._target_.contextData.stageIDs[arg_10_1]
		local var_10_7 = arg_6_0._target_.contextData.useOilLimit[arg_10_1]

		arg_6_0._target_:sendNotification(GAME.GO_SCENE, SCENE.BOSS_SINGLE_PRECONBAT, {
			system = var_10_5,
			stageId = var_10_6,
			actId = arg_6_0._target_.contextData.activityID,
			fleets = var_10_1,
			costLimit = var_10_7,
			buffList = arg_6_0._target_.contextData.selectedBuffList,
			useTicket = arg_6_0._target_.contextData.useTicket
		})
	end)
	arg_6_0._target_:bind(arg_6_0._target_.ON_COMMIT_FLEET, function()
		var_6_0:commitActivityFleet(arg_6_0._target_.contextData.activityID)
	end)
	arg_6_0._target_:bind(arg_6_0._target_.ON_FLEET_RECOMMEND, function(arg_14_0, arg_14_1)
		var_6_0:recommendActivityFleet(arg_6_0._target_.contextData.activityID, arg_14_1)

		local var_14_0 = var_6_0:getActivityFleets()[arg_6_0._target_.contextData.activityID]

		arg_6_0._target_.contextData.actFleets = var_14_0

		arg_6_0._target_.viewComponent:updateEditPanel()
	end)
	arg_6_0._target_:bind(arg_6_0._target_.ON_FLEET_CLEAR, function(arg_15_0, arg_15_1)
		local var_15_0 = var_6_0:getActivityFleets()[arg_6_0._target_.contextData.activityID]
		local var_15_1 = var_15_0[arg_15_1]

		var_15_1:clearFleet()
		var_6_0:updateActivityFleet(arg_6_0._target_.contextData.activityID, arg_15_1, var_15_1)

		arg_6_0._target_.contextData.actFleets = var_15_0

		arg_6_0._target_.viewComponent:updateEditPanel()
	end)
	arg_6_0._target_:bind(arg_6_0._target_.ON_OPEN_DOCK, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_1.fleetIndex
		local var_16_1 = arg_16_1.shipVO
		local var_16_2 = arg_16_1.fleet
		local var_16_3 = arg_16_1.teamType
		local var_16_4 = arg_6_0._target_.contextData.activityID
		local var_16_5, var_16_6, var_16_7 = var_0_0.getDockCallbackFuncs4ActicityFleet(arg_6_0._actType, var_16_1, var_16_0, var_16_3)

		arg_6_0._target_:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			selectedMax = 1,
			useBlackBlock = true,
			selectedMin = 0,
			leastLimitMsg = i18n("ship_formationMediator_leastLimit"),
			quitTeam = var_16_1 ~= nil,
			teamFilter = var_16_3,
			leftTopInfo = i18n("word_formation"),
			onShip = var_16_5,
			confirmSelect = var_16_6,
			onSelected = var_16_7,
			hideTagFlags = setmetatable({
				inActivity = var_16_4
			}, {
				__index = ShipStatus.TAG_HIDE_ACTIVITY_BOSS
			}),
			otherSelectedIds = var_16_2,
			ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
				isActivityNpc = true
			})
		})
	end)
	arg_6_0._target_:bind(arg_6_0._target_.ON_FLEET_SHIPINFO, function(arg_17_0, arg_17_1)
		arg_6_0._target_:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_17_1.shipId,
			shipVOs = arg_17_1.shipVOs
		})
	end)
	arg_6_0._target_:bind(arg_6_0._target_.COMMANDER_FORMATION_OP, function(arg_18_0, arg_18_1)
		arg_6_0._target_:sendNotification(GAME.COMMANDER_FORMATION_OP, {
			data = arg_18_1
		})
	end)
	arg_6_0._target_:bind(arg_6_0._target_.ON_COMMANDER_SKILL, function(arg_19_0, arg_19_1)
		arg_6_0._target_:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				skill = arg_19_1
			}
		}))
	end)
	arg_6_0._target_:bind(arg_6_0._target_.ON_SELECT_COMMANDER, function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = var_6_0:getActivityFleets()[arg_6_0._target_.contextData.activityID]
		local var_20_1 = var_20_0[arg_20_1]
		local var_20_2 = var_20_1:getCommanders()

		arg_6_0._target_:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
			maxCount = 1,
			mode = CommanderCatScene.MODE_SELECT,
			activeCommander = var_20_2[arg_20_2],
			fleetType = CommanderCatScene.FLEET_TYPE_BOSSSINGLE_VARIABLE,
			ignoredIds = {},
			onCommander = function(arg_21_0)
				return true
			end,
			onSelected = function(arg_22_0, arg_22_1)
				local var_22_0 = arg_22_0[1]
				local var_22_1 = getProxy(CommanderProxy):getCommanderById(var_22_0)

				for iter_22_0, iter_22_1 in pairs(var_20_0) do
					if iter_22_0 == arg_20_1 then
						for iter_22_2, iter_22_3 in pairs(var_20_2) do
							if iter_22_3.groupId == var_22_1.groupId and iter_22_2 ~= arg_20_2 then
								pg.TipsMgr.GetInstance():ShowTips(i18n("commander_can_not_select_same_group"))

								return
							end
						end
					elseif iter_22_0 == var_0_0.GetPairedFleetIndex(arg_20_1, arg_6_0._subFleetOffset) then
						local var_22_2 = iter_22_1:getCommanders()

						for iter_22_4, iter_22_5 in pairs(var_22_2) do
							if var_22_0 == iter_22_5.id then
								pg.TipsMgr.GetInstance():ShowTips(i18n("commander_is_in_fleet_already"))

								return
							end
						end
					end
				end

				var_20_1:updateCommanderByPos(arg_20_2, var_22_1)
				var_6_0:updateActivityFleet(arg_6_0._target_.contextData.activityID, arg_20_1, var_20_1)
				arg_22_1()
			end,
			onQuit = function(arg_23_0)
				var_20_1:updateCommanderByPos(arg_20_2, nil)
				var_6_0:updateActivityFleet(arg_6_0._target_.contextData.activityID, arg_20_1, var_20_1)
				arg_23_0()
			end
		})
	end)
	arg_6_0._target_:bind(PreCombatMediator.BEGIN_STAGE_PROXY, function(arg_24_0, arg_24_1)
		arg_6_0._target_:sendNotification(PreCombatMediator.BEGIN_STAGE_PROXY, {
			curFleetId = arg_24_1
		})
	end)
	arg_6_0._target_:bind(arg_6_0._target_.ON_PERFORM_COMBAT, function(arg_25_0, arg_25_1, arg_25_2)
		arg_6_0._target_:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_PERFORM,
			stageId = arg_25_1,
			exitCallback = arg_25_2
		})
	end)
end

function var_0_0.GetPairedFleetIndex(arg_26_0, arg_26_1)
	if arg_26_0 < Fleet.SUBMARINE_FLEET_ID then
		return arg_26_0 + arg_26_1
	else
		return arg_26_0 - arg_26_1
	end
end

function var_0_0.getDockCallbackFuncs4ActicityFleet(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = getProxy(BayProxy)
	local var_27_1 = getProxy(FleetProxy)
	local var_27_2 = getProxy(ActivityProxy):getActivityByType(arg_27_0)
	local var_27_3 = var_27_1:getActivityFleets()[var_27_2.id][arg_27_2]

	local function var_27_4(arg_28_0, arg_28_1)
		local var_28_0, var_28_1 = ShipStatus.ShipStatusCheck("inActivity", arg_28_0, arg_28_1, {
			inActivity = var_27_2.id
		})

		if not var_28_0 then
			return var_28_0, var_28_1
		end

		if arg_27_1 and arg_27_1:isSameKind(arg_28_0) then
			return true
		end

		for iter_28_0, iter_28_1 in ipairs(var_27_3.ships or {}) do
			if arg_28_0:isSameKind(var_27_0:getShipById(iter_28_1)) then
				return false, i18n("ship_formationMediator_changeNameError_sameShip")
			end
		end

		return true
	end

	local function var_27_5(arg_29_0, arg_29_1, arg_29_2)
		arg_29_1()
	end

	local function var_27_6(arg_30_0)
		if arg_27_1 then
			var_27_3:removeShip(arg_27_1)
		end

		if #arg_30_0 > 0 then
			local var_30_0 = var_27_0:getShipById(arg_30_0[1])

			if not var_27_3:containShip(var_30_0) then
				var_27_3:insertShip(var_30_0, nil, arg_27_3)
			elseif arg_27_1 then
				var_27_3:insertShip(arg_27_1, nil, arg_27_3)
			end

			var_27_3:RemoveUnusedItems()
		end

		var_27_1:updateActivityFleet(var_27_2.id, arg_27_2, var_27_3)
	end

	return var_27_4, var_27_5, var_27_6
end

return var_0_0
