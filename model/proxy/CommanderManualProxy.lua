local var_0_0 = class("CommanderManualProxy", import(".NetProxy"))

var_0_0.GET_TASK = 1
var_0_0.GET_PT_AWARD = 2
var_0_0.TOP_PAGE_TASK = 100
var_0_0.TOP_PAGE_GUIDE = 200
var_0_0.TOP_PAGE_TECH = 900

function var_0_0.register(arg_1_0)
	arg_1_0:on(22300, function(arg_2_0)
		arg_1_0.commanderManualPages = {}
		arg_1_0.topFinishedTaskIds = arg_2_0.finished_task_ids or {}

		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.handbooks) do
			var_2_0[iter_2_1.id] = iter_2_1
		end

		for iter_2_2, iter_2_3 in ipairs(pg.tutorial_handbook_task.all) do
			local var_2_1 = pg.tutorial_handbook_task[iter_2_3]
			local var_2_2

			if var_2_0[iter_2_3] then
				var_2_2 = CommanderManualPage.New(var_2_0[iter_2_3], arg_1_0.topFinishedTaskIds, true)
			else
				var_2_2 = CommanderManualPage.New({
					award = 0,
					pt = 0,
					id = iter_2_3,
					finished_task_ids = {}
				}, arg_1_0.topFinishedTaskIds, false)
			end

			table.insert(arg_1_0.commanderManualPages, var_2_2)
		end
	end)
end

function var_0_0.GetPagesByType(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.commanderManualPages) do
		if iter_3_1:getConfig("type") == arg_3_1 then
			table.insert(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end

function var_0_0.GetPageById(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.commanderManualPages) do
		if iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

function var_0_0.AddPagePt(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:GetPageById(arg_5_1)

	if var_5_0 then
		var_5_0:AddPt()
	end
end

function var_0_0.AddPageAward(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetPageById(arg_6_1)

	if var_6_0 then
		var_6_0:AddAward()
	end
end

function var_0_0.TaskAutoSubmitCall(arg_7_0, arg_7_1)
	arg_7_0:UnlockTaskSubmitCall(arg_7_1)
	arg_7_0:ShowTaskSubmitCall(arg_7_1)
end

function var_0_0.UnlockTaskSubmitCall(arg_8_0, arg_8_1)
	local var_8_0 = false

	for iter_8_0, iter_8_1 in ipairs(pg.tutorial_handbook.all) do
		local var_8_1 = pg.tutorial_handbook[iter_8_1]

		if table.contains(var_8_1.unlock_param, arg_8_1) then
			table.insert(arg_8_0.topFinishedTaskIds, arg_8_1)

			var_8_0 = true

			break
		end
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.commanderManualPages) do
		if table.contains(iter_8_3.leftUnlockTaskIds, arg_8_1) then
			iter_8_3:AddFinishedTaskId(arg_8_1)

			var_8_0 = true
		end

		for iter_8_4, iter_8_5 in ipairs(iter_8_3.unlockTaskIds) do
			if table.contains(iter_8_5, arg_8_1) then
				iter_8_3:AddFinishedTaskId(arg_8_1)

				var_8_0 = true

				break
			end
		end
	end

	if var_8_0 then
		for iter_8_6, iter_8_7 in ipairs(arg_8_0.commanderManualPages) do
			iter_8_7:ChangeUnlock(arg_8_0.topFinishedTaskIds)
			iter_8_7:GetTasks()
		end
	end
end

function var_0_0.GetPagesTasks(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.commanderManualPages) do
		iter_9_1:GetTasks()
	end
end

function var_0_0.ShowTaskSubmitCall(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.commanderManualPages) do
		if table.contains(iter_10_1.taskIdList, arg_10_1) and not iter_10_1:IsTaskComplete(arg_10_1) then
			iter_10_1:AddFinishedTaskId(arg_10_1)
			iter_10_1:AddPt()

			break
		end
	end
end

function var_0_0.AddPageTaskDone(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.commanderManualPages) do
		local var_11_0 = 0

		for iter_11_2, iter_11_3 in ipairs(iter_11_1.taskIds) do
			if table.contains(iter_11_3, arg_11_1.id) then
				var_11_0 = iter_11_2

				break
			end
		end

		if var_11_0 ~= 0 then
			arg_11_0:sendNotification(GAME.COMMANDER_MANUAL_OP_DONE, {
				operation = var_0_0.GET_TASK,
				pageId = iter_11_1.id,
				index = var_11_0
			})

			break
		end
	end
end

function var_0_0.IsTopUnlock(arg_12_0, arg_12_1)
	local var_12_0 = pg.tutorial_handbook[arg_12_1].unlock_param

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if not table.contains(arg_12_0.topFinishedTaskIds, iter_12_1) then
			return false
		end
	end

	return true
end

function var_0_0.GetLockTip(arg_13_0, arg_13_1)
	return pg.tutorial_handbook[arg_13_1].lock_hint
end

function var_0_0.ShouldShowTipByType(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetPagesByType(arg_14_1)

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if iter_14_1:ShouldShowTip() then
			return true
		end
	end

	return false
end

function var_0_0.ShouldShowTaskOrGuideTip(arg_15_0)
	return arg_15_0:ShouldShowTipByType(1) or arg_15_0:ShouldShowTipByType(2)
end

function var_0_0.IsTopPageComplete(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:GetPagesByType(arg_16_1)

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if not iter_16_1:IsComplete() then
			return false
		end
	end

	return true
end

function var_0_0.TaskProgressAdd(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(pg.task_data_template.all) do
		local var_17_1 = pg.task_data_template[iter_17_1]

		if var_17_1.type == Task.TYPE_COMMANDER_MANUAL and var_17_1.sub_type == arg_17_1 then
			table.insert(var_17_0, iter_17_1)
		end
	end

	for iter_17_2, iter_17_3 in ipairs(var_17_0) do
		local var_17_2 = getProxy(TaskProxy):getTaskById(iter_17_3)

		if var_17_2 and var_17_2:getTaskStatus() == 0 then
			arg_17_0:sendNotification(GAME.MINI_GAME_TASK_PROGRESS_UPDATE, {
				taskId = iter_17_3,
				progressAdd = arg_17_2
			})
		end
	end
end

return var_0_0
