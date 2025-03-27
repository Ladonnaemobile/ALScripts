local var_0_0 = class("ClueTasksMediator", import("view.base.ContextMediator"))

var_0_0.ON_TASK_SUBMIT = "ClueTasksMediator.ON_TASK_SUBMIT"
var_0_0.ON_TASK_SUBMIT_ONESTEP = "ClueTasksMediator.ON_TASK_SUBMIT_ONESTEP"
var_0_0.ON_TASK_GO = "ClueTasksMediator.ON_TASK_GO"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()
end

function var_0_0.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.ON_TASK_SUBMIT_ONESTEP, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		arg_2_0:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_3_1,
			task_ids = arg_3_2,
			callback = arg_3_3
		})
	end)
	arg_2_0:bind(var_0_0.ON_TASK_GO, function(arg_4_0, arg_4_1, arg_4_2)
		arg_2_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_4_1
		})
	end)
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		warning("hand SUBMIT_ACTIVITY_TASK_DONE", #var_6_1.awards)

		if #var_6_1.awards > 0 then
			arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awards)
		end

		arg_6_0.viewComponent:UpdateView()
	end
end

return var_0_0
