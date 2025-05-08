local var_0_0 = class("IslandUrgencyOrder", import(".IslandOrder"))

function var_0_0.IsUrgency(arg_1_0)
	return true
end

function var_0_0.GetTitle(arg_2_0)
	return i18n1("加急订单")
end

function var_0_0.IsEmpty(arg_3_0)
	return arg_3_0.showFlag == IslandOrderSlot.SHOW_FLAG_TOMORROW or pg.TimeMgr.GetInstance():GetServerTime() >= arg_3_0:GetDisappearTime()
end

function var_0_0.Clear(arg_4_0)
	arg_4_0.showFlag = IslandOrderSlot.SHOW_FLAG_TOMORROW
end

function var_0_0.IsLoading(arg_5_0)
	return false
end

function var_0_0.CanReplace(arg_6_0)
	return false
end

function var_0_0.GetTotalTime(arg_7_0)
	return -1
end

function var_0_0.GetDisappearTime(arg_8_0)
	return arg_8_0.submitTime
end

function var_0_0.GetCanSubmitTime(arg_9_0)
	return -1
end

return var_0_0
