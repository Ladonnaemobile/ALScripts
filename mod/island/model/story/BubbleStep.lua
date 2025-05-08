local var_0_0 = class("BubbleStep", import(".IslandBaseStep"))

var_0_0.HIDE_TYPE_IMMEDIATELY = 0
var_0_0.HIDE_TYPE_NEVER = 1
var_0_0.HIDE_TYPE_TIME = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.time = arg_1_1.time or 3
	arg_1_0.hideType = arg_1_1.hideType or var_0_0.HIDE_TYPE_IMMEDIATELY
	arg_1_0.hideTime = arg_1_1.hideTime or 0
end

function var_0_0.GetHideType(arg_2_0)
	return arg_2_0.hideType, arg_2_0.hideTime
end

function var_0_0.GetTime(arg_3_0)
	return arg_3_0.time
end

return var_0_0
