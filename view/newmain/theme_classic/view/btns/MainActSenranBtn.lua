local var_0_0 = class("MainActSenranBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_senran"
end

function var_0_0.GetActivityID(arg_2_0)
	local var_2_0 = checkExist(arg_2_0.config, {
		"time"
	})

	if not var_2_0 then
		return nil
	end

	return var_2_0[1] == "default" and var_2_0[2] or nil
end

function var_0_0.OnInit(arg_3_0)
	local var_3_0 = arg_3_0:GetActivityID()
	local var_3_1 = getProxy(ActivityProxy):getActivityById(var_3_0)
	local var_3_2 = Activity.IsActivityReady(var_3_1)

	setActive(arg_3_0.tipTr.gameObject, var_3_2)
end

return var_0_0
