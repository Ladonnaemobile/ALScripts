local var_0_0 = class("YidaliPTPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.progresses = arg_1_0:findTF("progresses", arg_1_0.bg)
	arg_1_0.progress_r = arg_1_0:findTF("progress_r", arg_1_0.progresses)
	arg_1_0.progress_l = arg_1_0:findTF("progress_l", arg_1_0.progresses)
end

function var_0_0.OnUpdateFlush(arg_2_0)
	local var_2_0 = arg_2_0.ptData:getTargetLevel()
	local var_2_1 = arg_2_0.activity:getConfig("config_client").story

	if checkExist(var_2_1, {
		var_2_0
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_2_1[var_2_0][1])
	end

	local var_2_2, var_2_3, var_2_4 = arg_2_0.ptData:GetLevelProgress()
	local var_2_5, var_2_6, var_2_7 = arg_2_0.ptData:GetResProgress()

	setText(arg_2_0.step, var_2_2 .. "/" .. var_2_3)
	setText(arg_2_0.progress_l, var_2_7 >= 1 and setColorStr(var_2_5, COLOR_GREEN) or var_2_5)
	setText(arg_2_0.progress_r, "/" .. var_2_6)
	setSlider(arg_2_0.slider, 0, 1, var_2_7)

	local var_2_8 = arg_2_0.ptData:CanGetAward()
	local var_2_9 = arg_2_0.ptData:CanGetNextAward()
	local var_2_10 = arg_2_0.ptData:CanGetMorePt()

	setActive(arg_2_0.battleBtn, var_2_10 and not var_2_8 and var_2_9)
	setActive(arg_2_0.getBtn, var_2_8)
	setActive(arg_2_0.gotBtn, not var_2_9)

	local var_2_11 = arg_2_0.ptData:GetAward()

	updateDrop(arg_2_0.awardTF, var_2_11)
	onButton(arg_2_0, arg_2_0.awardTF, function()
		arg_2_0:emit(BaseUI.ON_DROP, var_2_11)
	end, SFX_PANEL)
end

return var_0_0
