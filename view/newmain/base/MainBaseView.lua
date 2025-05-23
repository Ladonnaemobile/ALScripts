local var_0_0 = class("MainBaseView", import("view.base.BaseEventLogic"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_2)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0.foldableHelper = MainFoldableHelper.New(arg_1_1, arg_1_0:GetDirection())
end

function var_0_0.Init(arg_2_0)
	return
end

function var_0_0.Fold(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.foldableHelper:Fold(arg_3_1, arg_3_2)
end

function var_0_0.Refresh(arg_4_0)
	return
end

function var_0_0.Disable(arg_5_0)
	return
end

function var_0_0.GetDirection(arg_6_0)
	return Vector2.zero
end

function var_0_0.SetVisible(arg_7_0, arg_7_1)
	setActive(arg_7_0._tf, arg_7_1)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.exited = true

	arg_8_0:disposeEvent()

	if arg_8_0.foldableHelper then
		pg.DelegateInfo.Dispose(arg_8_0)
		arg_8_0.foldableHelper:Dispose()

		arg_8_0.foldableHelper = nil
	end
end

return var_0_0
