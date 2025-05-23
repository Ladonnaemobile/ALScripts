local var_0_0 = class("ShipCustomMsgBox", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "ShipCustomMsgBox"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.customMsgbox = arg_2_0._tf
	arg_2_0.msgBoxItemPanel = arg_2_0.customMsgbox:Find("frame/bg/item_panel")
	arg_2_0.msgboxItemContains = arg_2_0.customMsgbox:Find("frame/bg/item_panel/items")
	arg_2_0.msgBoxItemTpl = arg_2_0.msgboxItemContains:Find("equipmenttpl")
	arg_2_0.msgBoxItemContent = arg_2_0.customMsgbox:Find("frame/bg/item_panel/content")
	arg_2_0.msgBoxItemContent1 = arg_2_0.customMsgbox:Find("frame/bg/item_panel/content_num")
	arg_2_0.msgBoxCancelBtn = arg_2_0.customMsgbox:Find("frame/btns/cancel_btn")
	arg_2_0.msgBoxConfirmBtn = arg_2_0.customMsgbox:Find("frame/btns/confirm_btn")
	arg_2_0.msgBoxContent = arg_2_0.customMsgbox:Find("frame/bg/content")
	arg_2_0.msgBtnBack = arg_2_0.customMsgbox:Find("frame/top/btnBack")
	arg_2_0.msgBoxTitle = arg_2_0.customMsgbox:Find("frame/top/title_list/infomation/title")
	arg_2_0.msgBoxTitleEn = arg_2_0.customMsgbox:Find("frame/top/title_list/infomation/title_en")

	SetActive(arg_2_0.customMsgbox, false)

	arg_2_0.settings = {}

	onButton(arg_2_0, arg_2_0.msgBoxConfirmBtn, function()
		if arg_2_0.settings.onYes then
			arg_2_0.settings.onYes()
		else
			arg_2_0:hideCustomMsgBox()
		end
	end, SFX_PANEL)
	SetActive(arg_2_0.msgBoxCancelBtn, not defaultValue(arg_2_0.settings.hideNO, false))
	onButton(arg_2_0, arg_2_0.msgBoxCancelBtn, function()
		if arg_2_0.settings.onCancel then
			arg_2_0.settings.onCancel()
		else
			arg_2_0:hideCustomMsgBox()
		end
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.customMsgbox, function()
		arg_2_0:hideCustomMsgBox()
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.msgBtnBack, function()
		arg_2_0:hideCustomMsgBox()
	end, SFX_CANCEL)
end

function var_0_0.SetShareData(arg_7_0, arg_7_1)
	arg_7_0.shareData = arg_7_1
end

function var_0_0.showCustomMsgBox(arg_8_0, arg_8_1)
	arg_8_0.isShowCustomMsgBox = true
	arg_8_0.settings = arg_8_1

	setActive(arg_8_0.customMsgbox, true)
	pg.UIMgr.GetInstance():OverlayPanel(arg_8_0.customMsgbox, {
		groupName = LayerWeightConst.GROUP_SHIPINFOUI
	})

	local var_8_0 = arg_8_1.items and #arg_8_1.items > 0

	setActive(arg_8_0.msgBoxItemPanel, var_8_0)
	setActive(arg_8_0.msgBoxContent, not var_8_0)

	if var_8_0 then
		local var_8_1 = arg_8_1.items

		for iter_8_0 = arg_8_0.msgboxItemContains.childCount + 1, #var_8_1 do
			cloneTplTo(arg_8_0.msgBoxItemTpl, arg_8_0.msgboxItemContains)
		end

		local var_8_2 = arg_8_0.msgboxItemContains.childCount

		for iter_8_1 = 1, var_8_2 do
			local var_8_3 = arg_8_0.msgboxItemContains:GetChild(iter_8_1 - 1)

			SetActive(var_8_3, iter_8_1 <= #var_8_1)

			if iter_8_1 <= #var_8_1 then
				local var_8_4 = var_8_1[iter_8_1]

				updateDrop(var_8_3, var_8_4)

				local var_8_5 = 0

				if var_8_4.type == DROP_TYPE_RESOURCE then
					var_8_5 = arg_8_0.shareData.player:getResById(var_8_4.id)
				elseif var_8_4.type == DROP_TYPE_ITEM then
					var_8_5 = getProxy(BagProxy):getItemCountById(var_8_4.id)
				end

				local var_8_6 = var_8_4.count

				var_8_5 = var_8_5 < var_8_6 and "<color=#D6341DFF>" .. var_8_5 .. "</color>" or "<color=#A9F548FF>" .. var_8_5 .. "</color>"

				setText(var_8_3:Find("icon_bg/count"), var_8_5 .. "/" .. var_8_6)
			end
		end

		setText(arg_8_0.msgBoxItemContent, arg_8_1.content or "")
		setText(arg_8_0.msgBoxItemContent1, arg_8_1.content1 or "")
	else
		setText(arg_8_0.msgBoxContent, arg_8_1.content or "")
	end

	if arg_8_1.title then
		local var_8_7 = arg_8_1.title.title
		local var_8_8 = arg_8_1.title.titleEn

		setText(arg_8_0.msgBoxTitle, var_8_7)
		setText(arg_8_0.msgBoxTitleEn, var_8_8 or "")
	end
end

function var_0_0.hideCustomMsgBox(arg_9_0)
	arg_9_0.isShowCustomMsgBox = nil

	SetActive(arg_9_0.customMsgbox, false)
end

function var_0_0.OnDestroy(arg_10_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0.customMsgbox, arg_10_0._tf)

	arg_10_0.shareData = nil
end

return var_0_0
