local var_0_0 = class("IslandStoryRecordPanel", import("Mgr.Story.NewStoryRecordPanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.view = arg_1_1

	var_0_0.super.Ctor(arg_1_0)
end

function var_0_0.GetUIName(arg_2_0)
	return "IslandStoryRecordUI"
end

function var_0_0.GetParent(arg_3_0)
	return arg_3_0.view._tf
end

function var_0_0.BlurPanel(arg_4_0)
	return
end

function var_0_0.UnblurPanel(arg_5_0)
	return
end

return var_0_0
