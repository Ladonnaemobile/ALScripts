local var_0_0 = class("SettingsMiniProgramPanle", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsMiniProgramCH"
end

function var_0_0.GetTitle(arg_2_0)
	return "小程序"
end

function var_0_0.GetTitleEn(arg_3_0)
	return "/ MiniProgram"
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.serviceBtn = findTF(arg_4_0._tf, "delete")

	onButton(arg_4_0, arg_4_0.serviceBtn, function()
		pg.SdkMgr.GetInstance():OpenMiniProgram()
	end, SFX_PANEL)
end

function var_0_0.OnUpdate(arg_6_0)
	return
end

return var_0_0
