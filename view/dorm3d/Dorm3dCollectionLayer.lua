local var_0_0 = class("Dorm3dCollectionLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dCollectionUI"
end

function var_0_0.SetApartment(arg_2_0, arg_2_1)
	arg_2_0.contextData.apartment = arg_2_1
end

function var_0_0.SetRoom(arg_3_0, arg_3_1)
	arg_3_0.room = getProxy(ApartmentProxy):getRoom(arg_3_1)
end

function var_0_0.init(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf:Find("bg"), function()
		arg_4_0:closeView()
	end, SFX_PANEL)

	local var_4_0 = arg_4_0._tf:Find("window")

	eachChild(var_4_0:Find("toggles"), function(arg_6_0)
		onToggle(arg_4_0, arg_6_0, function(arg_7_0)
			if arg_7_0 then
				arg_4_0:SetPage(arg_6_0.name)
			end
		end, SFX_PANEL)
	end)

	local var_4_1 = var_4_0:Find("content")

	arg_4_0.memoryView = Dorm3dMemorySubView.New(var_4_1, arg_4_0.event, arg_4_0.contextData)

	arg_4_0.memoryView:SetExtra(var_4_1:Find("memory"))

	arg_4_0.collectItemView = Dorm3dCollectionItemSubView.New(var_4_1, arg_4_0.event, arg_4_0.contextData)

	arg_4_0.collectItemView:SetExtra(var_4_1:Find("item"))
	pg.UIMgr.GetInstance():BlurPanel(arg_4_0._tf, false, {
		weight = LayerWeightConst.SECOND_LAYER
	})
end

function var_0_0.SetPage(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs({
		memory = arg_8_0.memoryView,
		item = arg_8_0.collectItemView
	}) do
		if iter_8_0 == arg_8_1 then
			iter_8_1:ExecuteAction("Show")
		elseif iter_8_1:isShowing() then
			iter_8_1:Hide()
		end
	end
end

function var_0_0.didEnter(arg_9_0)
	if arg_9_0.room:isPersonalRoom() then
		triggerToggle(arg_9_0._tf:Find("window/toggles/memory"), true)
	else
		triggerToggle(arg_9_0._tf:Find("window/toggles/item"), true)
		setActive(arg_9_0._tf:Find("window/toggles/memory"), false)
	end
end

function var_0_0.onBackPressed(arg_10_0)
	var_0_0.super.onBackPressed(arg_10_0)
end

function var_0_0.willExit(arg_11_0)
	arg_11_0.memoryView:Destroy()
	arg_11_0.collectItemView:Destroy()
	pg.UIMgr.GetInstance():UnblurPanel(arg_11_0._tf)
end

return var_0_0
