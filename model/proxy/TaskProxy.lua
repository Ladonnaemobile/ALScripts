local var_0_0 = class("TaskProxy", import(".NetProxy"))

var_0_0.TASK_ADDED = "task added"
var_0_0.TASK_UPDATED = "task updated"
var_0_0.TASK_REMOVED = "task removed"
var_0_0.TASK_FINISH = "task finish"
var_0_0.TASK_PROGRESS_UPDATE = "task TASK_PROGRESS_UPDATE"
var_0_0.WEEK_TASK_UPDATED = "week task updated"
var_0_0.WEEK_TASKS_ADDED = "week tasks added"
var_0_0.WEEK_TASKS_DELETED = "week task deleted"
var_0_0.WEEK_TASK_RESET = "week task refresh"
mingshiTriggerId = 1
mingshiActivityId = 21
changdaoActivityId = 10006
changdaoTaskStartId = 5031

function var_0_0.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.finishData = {}
	arg_1_0.tmpInfo = {}

	arg_1_0:on(20001, function(arg_2_0)
		arg_1_0:initTaskInfo(arg_2_0.info)
		getProxy(TechnologyProxy):updateBlueprintStates()
	end)
	arg_1_0:on(20002, function(arg_3_0)
		arg_1_0:updateProgress(arg_3_0.info)
		arg_1_0:sendNotification(GAME.TASK_PROGRESS_UPDATE)
	end)
	arg_1_0:on(20003, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.info) do
			local var_4_0 = Task.New(iter_4_1)

			arg_1_0:addTask(var_4_0)
		end
	end)
	arg_1_0:on(20004, function(arg_5_0)
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.id_list) do
			arg_1_0:removeTaskById(iter_5_1)
		end
	end)
	arg_1_0:on(20015, function(arg_6_0)
		pg.proxyRegister.dayProto = true
	end)

	arg_1_0.taskTriggers = {}
	arg_1_0.weekTaskProgressInfo = WeekTaskProgress.New()

	arg_1_0:on(20101, function(arg_7_0)
		arg_1_0.weekTaskProgressInfo:Init(arg_7_0.info)
		arg_1_0:sendNotification(var_0_0.WEEK_TASK_RESET)
	end)
	arg_1_0:on(20102, function(arg_8_0)
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.task) do
			print("update sub task ", iter_8_1)

			local var_8_0 = WeekPtTask.New(iter_8_1)

			arg_1_0.weekTaskProgressInfo:UpdateSubTask(var_8_0)
			arg_1_0:sendNotification(var_0_0.WEEK_TASK_UPDATED, {
				id = var_8_0.id
			})
		end
	end)
	arg_1_0:on(20103, function(arg_9_0)
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.id) do
			local var_9_0 = WeekPtTask.New({
				progress = 0,
				id = iter_9_1
			})

			arg_1_0.weekTaskProgressInfo:AddSubTask(var_9_0)
		end

		arg_1_0:sendNotification(var_0_0.WEEK_TASKS_ADDED)
	end)
	arg_1_0:on(20104, function(arg_10_0)
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.id) do
			print("remove sub task ", iter_10_1)
			arg_1_0.weekTaskProgressInfo:RemoveSubTask(iter_10_1)
		end

		arg_1_0:sendNotification(var_0_0.WEEK_TASKS_DELETED)
	end)
	arg_1_0:on(20105, function(arg_11_0)
		local var_11_0 = arg_11_0.pt

		arg_1_0.weekTaskProgressInfo:UpdateProgress(var_11_0)
	end)

	arg_1_0.submittingTask = {}
end

function var_0_0.timeCall(arg_12_0)
	return {
		[ProxyRegister.DayCall] = function(arg_13_0)
			arg_12_0:sendNotification(GAME.ACCEPT_ACTIVITY_TASK)
			arg_12_0:sendNotification(GAME.ZERO_HOUR_OP_DONE)
		end
	}
end

function var_0_0.initTaskInfo(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_0 = Task.New(iter_14_1)

		if var_14_0:getConfigTable() ~= nil then
			var_14_0:display("loaded")

			if var_14_0:getTaskStatus() ~= 2 then
				arg_14_0.data[var_14_0.id] = var_14_0
			else
				arg_14_0.finishData[var_14_0.id] = var_14_0
			end

			var_14_0:setActId(arg_14_2)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("task_notfound_error") .. tostring(iter_14_1.id))
			Debugger.LogWarning("Missing Task Config, id :" .. tostring(iter_14_1.id))
		end
	end

	if arg_14_3 and #arg_14_3 > 0 then
		for iter_14_2, iter_14_3 in ipairs(arg_14_3) do
			local var_14_1 = Task.New({
				id = iter_14_3
			})

			if var_14_1:getConfigTable() ~= nil then
				var_14_1:display("loaded")

				arg_14_0.finishData[var_14_1.id] = var_14_1

				var_14_1:setActId(arg_14_2)
				var_14_1:setTaskFinish()
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("task_notfound_error") .. tostring(iter_14_3.id))
				Debugger.LogWarning("Missing Task Config, id :" .. tostring(iter_14_3.id))
			end
		end
	end
end

function var_0_0.updateProgress(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_0 = arg_15_0.data[iter_15_1.id]

		if var_15_0 ~= nil then
			local var_15_1 = var_15_0:isFinish()

			var_15_0.progress = iter_15_1.progress

			arg_15_0:updateTask(var_15_0)

			if not var_15_1 then
				arg_15_0:sendNotification(var_0_0.TASK_PROGRESS_UPDATE, var_15_0:clone())
			end
		end
	end
end

function var_0_0.initActData(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0:initTaskInfo(arg_16_2, arg_16_1, arg_16_3)
end

function var_0_0.updateActProgress(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:updateProgress(arg_17_2)
end

function var_0_0.addActData(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0, iter_18_1 in ipairs(arg_18_2) do
		local var_18_0 = Task.New(iter_18_1)

		var_18_0:setActId(arg_18_1)
		arg_18_0:addTask(var_18_0)
	end
end

function var_0_0.removeActData(arg_19_0, arg_19_1, arg_19_2)
	for iter_19_0, iter_19_1 in ipairs(arg_19_2) do
		arg_19_0:removeTaskById(iter_19_1.id)
	end
end

function var_0_0.clearTimeOut(arg_20_0)
	if not arg_20_0.datas or #arg_20_0.datas == 0 then
		return
	end

	local var_20_0 = false
	local var_20_1 = {}

	for iter_20_0 = #arg_20_0.datas, 1, -1 do
		local var_20_2 = arg_20_0.datas[iter_20_0]

		if var_20_2:isActivityTask() then
			local var_20_3 = var_20_2:getActId()
			local var_20_4 = getProxy(ActivityProxy):getActivityById(var_20_3)

			if not var_20_4 or var_20_4:isEnd() then
				table.insert(var_20_1, var_20_2)

				local var_20_5 = true
			end
		end
	end

	for iter_20_1 = 1, #var_20_1 do
		arg_20_0:removeTask(var_20_1[iter_20_1])
	end
end

function var_0_0.GetWeekTaskProgressInfo(arg_21_0)
	return arg_21_0.weekTaskProgressInfo
end

function var_0_0.getTasksForBluePrint(arg_22_0)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in pairs(arg_22_0.data or {}) do
		var_22_0[iter_22_1.id] = iter_22_1
	end

	for iter_22_2, iter_22_3 in pairs(arg_22_0.finishData) do
		var_22_0[iter_22_3.id] = iter_22_3
	end

	return var_22_0
end

function var_0_0.addTmpTask(arg_23_0, arg_23_1)
	arg_23_0.tmpInfo[arg_23_1.id] = arg_23_1
end

function var_0_0.checkTmpTask(arg_24_0, arg_24_1)
	if arg_24_0.tmpInfo[arg_24_1] then
		arg_24_0:addTask(arg_24_0.tmpInfo[arg_24_1])

		arg_24_0.tmpInfo[arg_24_1] = nil
	end
end

function var_0_0.addTask(arg_25_0, arg_25_1)
	assert(isa(arg_25_1, Task), "should be an instance of Task")

	if arg_25_0.data[arg_25_1.id] then
		arg_25_0:addTmpTask(arg_25_1)

		return
	end

	if arg_25_1:getConfigTable() == nil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("task_notfound_error") .. tostring(arg_25_1.id))
		Debugger.LogWarning("Missing Task Config, id :" .. tostring(arg_25_1.id))

		return
	end

	arg_25_0.data[arg_25_1.id] = arg_25_1:clone()

	arg_25_0.data[arg_25_1.id]:display("added")
	arg_25_0.data[arg_25_1.id]:onAdded()
	arg_25_0.facade:sendNotification(var_0_0.TASK_ADDED, arg_25_1:clone())
	arg_25_0:checkAutoSubmitTask(arg_25_0.data[arg_25_1.id])
end

function var_0_0.updateTask(arg_26_0, arg_26_1)
	assert(isa(arg_26_1, Task), "should be an instance of Task")

	local var_26_0 = arg_26_0.data[arg_26_1.id]

	assert(var_26_0 ~= nil, "task should exist")

	arg_26_0.data[arg_26_1.id] = arg_26_1:clone()
	arg_26_0.data[arg_26_1.id].acceptTime = var_26_0.acceptTime

	arg_26_0.data[arg_26_1.id]:display("updated")
	arg_26_0.facade:sendNotification(var_0_0.TASK_UPDATED, arg_26_1:clone())
	arg_26_0:checkAutoSubmitTask(arg_26_0.data[arg_26_1.id])
end

function var_0_0.getTasks(arg_27_0)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(arg_27_0.data) do
		table.insert(var_27_0, iter_27_1)
	end

	return Clone(var_27_0)
end

function var_0_0.getTaskById(arg_28_0, arg_28_1)
	if arg_28_0.data[arg_28_1] then
		return arg_28_0.data[arg_28_1]:clone()
	end
end

function var_0_0.getFinishTaskById(arg_29_0, arg_29_1)
	if arg_29_0.finishData[arg_29_1] then
		return arg_29_0.finishData[arg_29_1]:clone()
	end
end

function var_0_0.removeFinishTaskById(arg_30_0, arg_30_1)
	if arg_30_0.finishData[arg_30_1] then
		arg_30_0.finishData[arg_30_1] = nil
	end
end

function var_0_0.getTaskVO(arg_31_0, arg_31_1)
	return arg_31_0:getTaskById(arg_31_1) or arg_31_0:getFinishTaskById(arg_31_1)
end

function var_0_0.getCanReceiveCount(arg_32_0)
	local var_32_0 = 0

	for iter_32_0, iter_32_1 in pairs(arg_32_0.data) do
		if iter_32_1:ShowOnTaskScene() and iter_32_1:isFinish() and iter_32_1:isReceive() == false then
			var_32_0 = var_32_0 + 1

			local var_32_1 = iter_32_1:getConfig("award_display")

			for iter_32_2, iter_32_3 in ipairs(var_32_1) do
				local var_32_2, var_32_3, var_32_4 = unpack(iter_32_3)

				if not LOCK_UR_SHIP and var_32_2 == DROP_TYPE_VITEM and Item.getConfigData(var_32_3).virtual_type == 20 then
					local var_32_5 = pg.gameset.urpt_chapter_max.description[1]
					local var_32_6 = not LOCK_UR_SHIP and getProxy(BagProxy):GetLimitCntById(var_32_5) or 0
					local var_32_7 = not LOCK_UR_SHIP and pg.gameset.urpt_chapter_max.description[2] or 0

					if var_32_6 + var_32_4 - var_32_7 > 0 then
						var_32_0 = var_32_0 - 1
					end
				end
			end
		end
	end

	local var_32_8 = arg_32_0:GetWeekTaskProgressInfo()

	if var_32_8:CanUpgrade() then
		var_32_0 = var_32_0 + 1
	end

	return var_32_0 + var_32_8:GetCanSubmitSubTaskCnt()
end

function var_0_0.getNotFinishCount(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1 or 3
	local var_33_1 = 0

	for iter_33_0, iter_33_1 in pairs(arg_33_0.data) do
		if iter_33_1:GetRealType() == var_33_0 and iter_33_1:isFinish() == false then
			var_33_1 = var_33_1 + 1
		end
	end

	return var_33_1
end

function var_0_0.removeTask(arg_34_0, arg_34_1)
	assert(isa(arg_34_1, Task), "should be an instance of Task")
	arg_34_0:removeTaskById(arg_34_1.id)
end

function var_0_0.removeTaskById(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0.data[arg_35_1]

	if var_35_0 == nil then
		return
	end

	if var_35_0:isCircle() then
		return
	end

	arg_35_0.finishData[arg_35_1] = arg_35_0.data[arg_35_1]:clone()
	arg_35_0.finishData[arg_35_1].submitTime = pg.TimeMgr.GetInstance():GetServerTime()
	arg_35_0.data[arg_35_1] = nil

	arg_35_0.facade:sendNotification(var_0_0.TASK_REMOVED, var_35_0)
	arg_35_0:checkTmpTask(arg_35_1)
end

function var_0_0.getmingshiTaskID(arg_36_0, arg_36_1)
	local var_36_0 = pg.task_data_trigger[mingshiTriggerId]

	if arg_36_1 >= var_36_0.count then
		local var_36_1 = var_36_0.task_id

		if var_36_1 and not arg_36_0:getTaskVO(var_36_1) then
			return var_36_1
		end
	end

	return 0
end

function var_0_0.dealMingshiTouchFlag(arg_37_0, arg_37_1)
	local var_37_0 = getProxy(ActivityProxy):getActivityById(mingshiActivityId)

	if not var_37_0 or var_37_0:isEnd() then
		return
	end

	local var_37_1 = var_37_0:getConfig("config_id")
	local var_37_2 = var_37_0:getConfig("config_data")[1]

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		hideNo = true,
		content = i18n("mingshi_task_tip_" .. arg_37_1)
	})

	local var_37_3 = arg_37_0:getTaskById(var_37_2)

	if var_37_3 and var_37_3:getTaskStatus() < 1 then
		if not arg_37_0.mingshiTouchList then
			arg_37_0.mingshiTouchList = {}
		end

		for iter_37_0, iter_37_1 in pairs(arg_37_0.mingshiTouchList) do
			if iter_37_1 == arg_37_1 then
				return
			end
		end

		for iter_37_2, iter_37_3 in pairs(var_37_0.data1_list) do
			if iter_37_3 == arg_37_1 then
				return
			end
		end

		table.insert(arg_37_0.mingshiTouchList, arg_37_1)
		arg_37_0:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 2,
			activity_id = mingshiActivityId,
			arg1 = arg_37_1
		})
	end
end

function var_0_0.mingshiTouchFlagEnabled(arg_38_0)
	local var_38_0 = getProxy(ActivityProxy):getActivityById(mingshiActivityId)

	if not var_38_0 or var_38_0:isEnd() then
		return
	end

	local var_38_1 = tonumber(var_38_0:getConfig("config_id"))
	local var_38_2 = tonumber(var_38_0:getConfig("config_data")[1])
	local var_38_3 = arg_38_0:getTaskById(var_38_2)

	if var_38_3 and var_38_3:getTaskStatus() < 1 then
		return true
	end

	if arg_38_0:getTaskVO(var_38_1) then
		return false
	end

	return true
end

function var_0_0.getAcademyTask(arg_39_0, arg_39_1)
	local var_39_0 = getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASK_LIST)
	local var_39_1 = _.detect(var_39_0, function(arg_40_0)
		local var_40_0 = arg_40_0:getTaskShip()

		return var_40_0 and var_40_0.groupId == arg_39_1
	end)

	if var_39_1 and not var_39_1:isEnd() then
		return getActivityTask(var_39_1, true)
	end
end

function var_0_0.isFinishPrevTasks(arg_41_0, arg_41_1)
	local var_41_0 = Task.New({
		id = arg_41_1
	}):getConfig("open_need")

	if var_41_0 and type(var_41_0) == "table" and #var_41_0 > 0 then
		return _.all(var_41_0, function(arg_42_0)
			local var_42_0 = arg_41_0:getTaskById(arg_42_0) or arg_41_0:getFinishTaskById(arg_42_0)

			return var_42_0 and var_42_0:isReceive()
		end)
	end

	return true
end

function var_0_0.isReceiveTasks(arg_43_0, arg_43_1)
	return _.all(arg_43_1, function(arg_44_0)
		local var_44_0 = arg_43_0:getFinishTaskById(arg_44_0)

		return var_44_0 and var_44_0:isReceive()
	end)
end

function var_0_0.pushAutoSubmitTask(arg_45_0)
	for iter_45_0, iter_45_1 in pairs(arg_45_0.data) do
		arg_45_0:checkAutoSubmitTask(iter_45_1)
	end
end

function var_0_0.checkAutoSubmitTask(arg_46_0, arg_46_1)
	if arg_46_1:getConfig("auto_commit") == 1 and arg_46_1:isFinish() and not arg_46_1:getAutoSubmit() then
		arg_46_1:setAutoSubmit(true)
		arg_46_0:sendNotification(GAME.SUBMIT_TASK, arg_46_1.id, function(arg_47_0)
			if arg_47_0 and arg_46_1:IsCommanderManualType() then
				getProxy(CommanderManualProxy):TaskAutoSubmitCall(arg_46_1.id)
			end
		end)
	end
end

function var_0_0.addSubmittingTask(arg_48_0, arg_48_1)
	arg_48_0.submittingTask[arg_48_1] = true
end

function var_0_0.removeSubmittingTask(arg_49_0, arg_49_1)
	arg_49_0.submittingTask[arg_49_1] = nil
end

function var_0_0.isSubmitting(arg_50_0, arg_50_1)
	return arg_50_0.submittingTask[arg_50_1]
end

function var_0_0.triggerClientTasks(arg_51_0)
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in pairs(arg_51_0.data) do
		if iter_51_1:isClientTrigger() then
			table.insert(var_51_0, iter_51_1)
		end
	end

	return var_51_0
end

function var_0_0.GetBackYardInterActionTaskList(arg_52_0)
	local var_52_0 = {}

	for iter_52_0, iter_52_1 in pairs(arg_52_0.data) do
		if iter_52_1:IsBackYardInterActionType() then
			table.insert(var_52_0, iter_52_1)
		end
	end

	return var_52_0
end

function var_0_0.GetFlagShipInterActionTaskList(arg_53_0)
	local var_53_0 = {}

	for iter_53_0, iter_53_1 in pairs(arg_53_0.data) do
		if iter_53_1:IsFlagShipInterActionType() then
			table.insert(var_53_0, iter_53_1)
		end
	end

	return var_53_0
end

return var_0_0
