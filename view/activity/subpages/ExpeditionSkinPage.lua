local var_0_0 = class("ExpeditionSkinPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnDataSetting(arg_1_0)
	arg_1_0.nday = 0
	arg_1_0.taskProxy = getProxy(TaskProxy)
	arg_1_0.taskGroup = arg_1_0.activity:getConfig("config_data")
	arg_1_0.preStory = arg_1_0.activity:getConfig("config_client").firstStory

	if arg_1_0.preStory ~= nil then
		pg.NewStoryMgr.GetInstance():Play(arg_1_0.preStory)
	end

	return updateActivityTaskStatus(arg_1_0.activity)
end

function var_0_0.OnUpdateFlush(arg_2_0)
	arg_2_0.nday = arg_2_0.activity.data3

	arg_2_0:PlayStory()

	if arg_2_0.dayTF then
		setText(arg_2_0.dayTF, arg_2_0.nday .. "/" .. #arg_2_0.taskGroup)
	end

	arg_2_0.uilist:align(#arg_2_0.taskGroup[arg_2_0.nday])
end

function var_0_0.PlayStory(arg_3_0)
	local var_3_0 = arg_3_0.activity:getConfig("config_client").story
	local var_3_1 = arg_3_0.nday - 1

	if arg_3_0.nday < 7 then
		local var_3_2 = arg_3_0.taskGroup[arg_3_0.nday][1]
		local var_3_3 = arg_3_0.taskGroup[arg_3_0.nday][2]
		local var_3_4 = arg_3_0.taskProxy:getTaskById(var_3_2) or arg_3_0.taskProxy:getFinishTaskById(var_3_2)
		local var_3_5 = arg_3_0.taskProxy:getTaskById(var_3_3) or arg_3_0.taskProxy:getFinishTaskById(var_3_3)

		if var_3_4:getTaskStatus() == 2 and var_3_5:getTaskStatus() == 2 then
			var_3_1 = var_3_1 + 1
		end
	end

	if checkExist(var_3_0, {
		var_3_1
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_3_0[var_3_1][1])
	end
end

function var_0_0.GetProgressColor(arg_4_0)
	return "#b9b49c"
end

return var_0_0
