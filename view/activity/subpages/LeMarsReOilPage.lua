local var_0_0 = class("LeMarsReOilPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	onButton(arg_1_0, arg_1_0.battleBtn, function()
		arg_1_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)
	end, SFX_PANEL)
end

function var_0_0.OnUpdateFlush(arg_3_0)
	var_0_0.super.OnUpdateFlush(arg_3_0)

	local var_3_0, var_3_1, var_3_2 = arg_3_0.ptData:GetResProgress()

	setText(arg_3_0.progress, (var_3_2 >= 1 and setColorStr(var_3_0, "#1EA2ACFF") or var_3_0) .. "/" .. var_3_1)
end

return var_0_0
