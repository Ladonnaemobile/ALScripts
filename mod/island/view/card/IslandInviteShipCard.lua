local var_0_0 = class("IslandInviteShipCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.selectedTF = arg_1_0._tf:Find("frame/sel")
	arg_1_0.selectedDotTF = arg_1_0._tf:Find("frame/sel_dot")
	arg_1_0.frameTF = arg_1_0._tf:Find("frame")
	arg_1_0.iconTF = arg_1_0.frameTF:Find("main/icon")
	arg_1_0.textTF = arg_1_0.frameTF:Find("main/Text")
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.configId = arg_2_1

	setText(arg_2_0.textTF, pg.island_ship[arg_2_1].name)
	arg_2_0:UpdateSelected(arg_2_2)
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1 == arg_3_0.configId

	SetCompomentEnabled(arg_3_0.frameTF, "EventTriggerListener", var_3_0)
	setActive(arg_3_0.selectedTF, var_3_0)
	setActive(arg_3_0.selectedDotTF, var_3_0)

	local var_3_1 = var_3_0 and 1 or 0.8

	setLocalScale(arg_3_0.frameTF, {
		x = var_3_1,
		y = var_3_1,
		z = var_3_1
	})
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
