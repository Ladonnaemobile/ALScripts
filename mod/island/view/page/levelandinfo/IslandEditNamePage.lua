local var_0_0 = class("IslandEditNamePage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandEditNameui"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.input = arg_2_0:findTF("frame/name/InputField")
	arg_2_0.closeBtn = arg_2_0:findTF("frame/close")
	arg_2_0.confirmBtn = arg_2_0:findTF("frame/confirm")
	arg_2_0.content = arg_2_0:findTF("frame/Text")

	setText(arg_2_0:findTF("frame/title"), i18n1("岛屿名称修改"))
	setText(arg_2_0:findTF("frame/confirm/Text"), i18n1("确定"))
	setText(arg_2_0:findTF("frame/name/InputField/Placeholder"), i18n1("点击输入名称"))
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddListener(GAME.ISLAND_SET_NAME_DONE, arg_3_0.OnModifyName)
end

function var_0_0.RemoveListeners(arg_4_0)
	arg_4_0:RemoveListener(GAME.ISLAND_SET_NAME_DONE, arg_4_0.OnModifyName)
end

function var_0_0.OnModifyName(arg_5_0)
	arg_5_0:Hide()

	if arg_5_0.callback then
		arg_5_0.callback()
	end
end

function var_0_0.OnInit(arg_6_0)
	onButton(arg_6_0, arg_6_0._tf, function()
		arg_6_0:Hide()
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.closeBtn, function()
		arg_6_0:Hide()
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.confirmBtn, function()
		local var_9_0 = getInputText(arg_6_0.input)

		arg_6_0:emit(IslandMediator.SET_NAME, var_9_0, 1)
	end, SFX_PANEL)
end

function var_0_0.Show(arg_10_0, arg_10_1)
	var_0_0.super.Show(arg_10_0)

	arg_10_0.callback = arg_10_1

	arg_10_0:UpdateContent()
	pg.UIMgr.GetInstance():OverlayPanel(arg_10_0._tf, {
		weight = LayerWeightConst.SECOND_LAYER + 1
	})
end

function var_0_0.Hide(arg_11_0)
	var_0_0.super.Hide(arg_11_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0._tf, arg_11_0._parentTf)
end

function var_0_0.UpdateContent(arg_12_0)
	setInputText(arg_12_0.input, "")

	local var_12_0 = getProxy(IslandProxy):GetIsland():GetModifyNameConsume()
	local var_12_1 = Drop.New({
		type = var_12_0[1],
		id = var_12_0[2],
		count = var_12_0[3]
	})
	local var_12_2 = var_12_1:getName()
	local var_12_3 = var_12_1:getOwnedCount()
	local var_12_4 = var_12_3 < var_12_1.count and "#f36c6e" or "#39bfff"
	local var_12_5 = setColorStr(var_12_3 .. "/" .. var_12_1.count, var_12_4)

	setText(arg_12_0.content, i18n1("名称最长为9个汉字，更名需要消耗") .. var_12_2 .. var_12_5)
end

function var_0_0.OnDestroy(arg_13_0)
	arg_13_0.callback = nil
end

return var_0_0
