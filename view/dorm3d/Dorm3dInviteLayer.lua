local var_0_0 = class("Dorm3dInviteLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dInviteWindow"
end

function var_0_0.init(arg_2_0)
	arg_2_0.rtInvitePanel = arg_2_0._tf:Find("invite_panel")

	setText(arg_2_0.rtInvitePanel:Find("window/Text"), i18n("dorm3d_invite_beach_tip"))
	setText(arg_2_0.rtInvitePanel:Find("window/btn_confirm/Text"), i18n("text_confirm"))
	onButton(arg_2_0, arg_2_0.rtInvitePanel:Find("bg"), function()
		arg_2_0:closeView()
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0.rtInvitePanel:Find("window/btn_close"), function()
		arg_2_0:closeView()
	end, SFX_CANCEL)

	arg_2_0.rtSelectPanel = arg_2_0._tf:Find("select_panel")

	setText(arg_2_0.rtSelectPanel:Find("window/character/title"), i18n("dorm3d_select_tip"))
	onButton(arg_2_0, arg_2_0.rtSelectPanel:Find("bg"), function()
		arg_2_0:HideSelectPanel()
		arg_2_0:ShowInvitePanel()
	end, SFX_CANCEL)
	setText(arg_2_0.rtSelectPanel:Find("window/title/Text"), i18n("dorm3d_data_choose"))
	setText(arg_2_0.rtSelectPanel:Find("window/bottom/container/btn_confirm/Text"), i18n("text_confirm"))
end

function var_0_0.ShowInvitePanel(arg_6_0)
	GetImageSpriteFromAtlasAsync("dorm3dselect/room_invite_" .. arg_6_0.room:getConfig("assets_prefix"), "", arg_6_0.rtInvitePanel:Find("window/Image"))
	setText(arg_6_0.rtInvitePanel:Find("window/Text"), i18n("dorm3d_data_go", arg_6_0.room:getRoomName()))

	local var_6_0, var_6_1 = arg_6_0.room:getInteractRange()
	local var_6_2 = arg_6_0.rtInvitePanel:Find("window/container")

	UIItemList.StaticAlign(var_6_2, var_6_2:GetChild(0), var_6_1, function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1

		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = arg_6_0.selectIds[arg_7_1]

			setActive(arg_7_2:Find("empty"), not var_7_0)
			setActive(arg_7_2:Find("ship"), var_7_0)

			if var_7_0 then
				local var_7_1 = pg.dorm3d_resource.get_id_list_by_ship_group[var_7_0][1]

				GetImageSpriteFromAtlasAsync(pg.dorm3d_resource[var_7_1].head_Icon, "", arg_7_2:Find("ship"), true)
			end

			onButton(arg_6_0, arg_7_2, function()
				arg_6_0:HideInvitePanel()
				arg_6_0:ShowSelectPanel()
			end, SFX_PANEL)

			if arg_7_1 == var_6_1 or not var_7_0 then
				local var_7_2 = getProxy(PlayerProxy):getRawData().id

				setActive(arg_7_2:Find("tip"), PlayerPrefs.GetInt(var_7_2 .. "_dorm3dRoomInviteSuccess_" .. arg_6_0.room.id, 1) == 0)
			end
		end
	end)
	onButton(arg_6_0, arg_6_0.rtInvitePanel:Find("window/btn_confirm"), function()
		if #arg_6_0.selectIds < var_6_0 or #arg_6_0.selectIds > var_6_1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_data_Invite_lack"))

			return
		end

		local var_9_0 = {}

		if #arg_6_0.selectIds >= 3 and not ApartmentProxy.CheckDeviceRAMEnough() then
			table.insert(var_9_0, function(arg_10_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("drom3d_beach_memory_limit_tip"),
					onYes = arg_10_0
				})
			end)
		end

		seriesAsync(var_9_0, function()
			arg_6_0:emit(Dorm3dInviteMediator.ON_DORM, {
				roomId = arg_6_0.room.id,
				groupIds = underscore.rest(arg_6_0.selectIds, 1)
			})
		end)
	end, SFX_CONFIRM)
	pg.UIMgr.GetInstance():OverlayPanel(arg_6_0.rtInvitePanel, {
		force = true,
		weight = LayerWeightConst.SECOND_LAYER
	})
	setActive(arg_6_0.rtInvitePanel, true)
	pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_sidebar")
end

function var_0_0.HideInvitePanel(arg_12_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_12_0.rtInvitePanel, arg_12_0._tf)
	setActive(arg_12_0.rtInvitePanel, false)
end

function var_0_0.ShowSelectPanel(arg_13_0)
	local var_13_0 = arg_13_0.room:getInviteList()
	local var_13_1, var_13_2 = arg_13_0.room:getInteractRange()
	local var_13_3 = {}
	local var_13_4 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if not arg_13_0.room.unlockCharacter[iter_13_1] then
			var_13_4[iter_13_1] = "lock"
		elseif not getProxy(ApartmentProxy):getApartment(iter_13_1) then
			var_13_4[iter_13_1] = "room"
		elseif Apartment.New({
			ship_group = iter_13_1
		}):needDownload() then
			var_13_4[iter_13_1] = "download"
		else
			var_13_4[iter_13_1] = nil
		end
	end

	local var_13_5 = getProxy(PlayerProxy):getRawData().id
	local var_13_6 = arg_13_0.rtSelectPanel:Find("window/character/container")

	UIItemList.StaticAlign(var_13_6, var_13_6:GetChild(0), #var_13_0, function(arg_14_0, arg_14_1, arg_14_2)
		arg_14_1 = arg_14_1 + 1

		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = var_13_0[arg_14_1]

			setActive(arg_14_2:Find("base"), var_14_0)
			setActive(arg_14_2:Find("empty"), not var_14_0)

			if not var_14_0 then
				arg_14_2.name = "null"

				setText(arg_14_2:Find("empty/Text"), i18n("dorm3d_waiting"))
			else
				arg_14_2.name = tostring(var_14_0)

				arg_13_0:UpdateSelectableCard(arg_14_2:Find("base"), var_14_0, function(arg_15_0)
					table.removebyvalue(var_13_3, var_14_0, true)

					if arg_15_0 then
						table.insert(var_13_3, var_14_0)
					end

					setText(arg_13_0.rtSelectPanel:Find("window/bottom/title/Text"), i18n("dorm3d_select_tip") .. #var_13_3 .. "/" .. var_13_2)
				end)
				triggerToggle(arg_14_2:Find("base"), table.contains(arg_13_0.selectIds, var_14_0))
				setActive(arg_14_2:Find("base/mask"), var_13_4[var_14_0])
				onButton(arg_13_0, arg_14_2:Find("base/mask"), function()
					if var_13_4[var_14_0] == "lock" then
						arg_13_0:HideSelectPanel()
						arg_13_0:emit(Dorm3dInviteMediator.OPEN_ROOM_UNLOCK_WINDOW, arg_13_0.room:GetConfigID(), var_14_0)
					elseif var_13_4[var_14_0] == "room" then
						pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_role_locked"))
					elseif var_13_4[var_14_0] == "download" then
						pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_guide_beach_tip"))
					end
				end, SFX_PANEL)
				eachChild(arg_14_2:Find("base/operation"), function(arg_17_0)
					setActive(arg_17_0, arg_17_0.name == var_13_4[var_14_0])
				end)
			end

			setActive(arg_14_2:Find("tip"), PlayerPrefs.GetInt(var_13_5 .. "_dorm3dRoomInviteSuccess_" .. arg_13_0.room.id .. "_" .. var_14_0, 1) == 0)
			PlayerPrefs.SetInt(var_13_5 .. "_dorm3dRoomInviteSuccess_" .. arg_13_0.room.id .. "_" .. var_14_0, 1)
		end
	end)
	PlayerPrefs.SetInt(var_13_5 .. "_dorm3dRoomInviteSuccess_" .. arg_13_0.room.id, 1)
	onButton(arg_13_0, arg_13_0.rtSelectPanel:Find("window/bottom/container/btn_confirm"), function()
		if #var_13_3 > var_13_2 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_data_Invite_lack"))

			return
		end

		arg_13_0.selectIds = var_13_3

		arg_13_0:HideSelectPanel()
		arg_13_0:ShowInvitePanel()
	end, SFX_CONFIRM)
	pg.UIMgr.GetInstance():OverlayPanelPB(arg_13_0.rtSelectPanel, {
		force = true,
		weight = LayerWeightConst.SECOND_LAYER,
		pbList = {
			arg_13_0.rtSelectPanel:Find("window")
		}
	})
	setActive(arg_13_0.rtSelectPanel, true)
end

function var_0_0.UpdateSelectableCard(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = Apartment.New({
		ship_group = arg_19_2
	}):GetSkinModelID(arg_19_0.room:getConfig("tag"))

	GetImageSpriteFromAtlasAsync(string.format("dorm3dselect/room_card_apartment_%d", var_19_0), "", arg_19_1:Find("Image"))
	GetImageSpriteFromAtlasAsync(string.format("dorm3dselect/room_card_apartment_name_%d", arg_19_2), "", arg_19_1:Find("name"))

	local var_19_1 = getProxy(ApartmentProxy):getApartment(arg_19_2)
	local var_19_2 = not var_19_1 or var_19_1:needDownload()

	setActive(arg_19_1:Find("lock"), var_19_2)
	setActive(arg_19_1:Find("mask"), var_19_2)
	setActive(arg_19_1:Find("unlock"), not var_19_2)
	setActive(arg_19_1:Find("favor_level"), var_19_1)

	if var_19_1 then
		setText(arg_19_1:Find("favor_level/Text"), var_19_1.level)
	end

	onToggle(arg_19_0, arg_19_1, function(arg_20_0)
		arg_19_3(arg_20_0)

		if arg_20_0 then
			if not var_19_1 then
				pg.TipsMgr.GetInstance():ShowTips(string.format("need unlock apartment{%d}", arg_19_2))
				triggerToggle(arg_19_1, false)
			elseif var_19_1:needDownload() then
				pg.TipsMgr.GetInstance():ShowTips(string.format("need download resource{%d}", arg_19_2))
				triggerToggle(arg_19_1, false)
			end
		end
	end, SFX_UI_CLICK)
end

function var_0_0.HideSelectPanel(arg_21_0)
	pg.UIMgr.GetInstance():UnblurPanel(arg_21_0.rtSelectPanel, arg_21_0._tf)
	setActive(arg_21_0.rtSelectPanel, false)
end

function var_0_0.UpdateRoom(arg_22_0, arg_22_1)
	arg_22_0.room = arg_22_1
end

function var_0_0.didEnter(arg_23_0)
	arg_23_0.selectIds = underscore.filter(arg_23_0.contextData.groupIds or {}, function(arg_24_0)
		return arg_23_0.room.unlockCharacter[arg_24_0] and tobool(getProxy(ApartmentProxy):getApartment(arg_24_0)) and not Apartment.New({
			ship_group = arg_24_0
		}):needDownload()
	end)
	arg_23_0.contextData.groupIds = nil

	arg_23_0:ShowInvitePanel()
end

function var_0_0.onBackPressed(arg_25_0)
	if isActive(arg_25_0.rtSelectPanel) then
		arg_25_0:HideSelectPanel()
		arg_25_0:ShowInvitePanel()
	else
		arg_25_0:closeView()
	end
end

function var_0_0.willExit(arg_26_0)
	if isActive(arg_26_0.rtSelectPanel) then
		arg_26_0:HideSelectPanel()
	else
		arg_26_0:HideInvitePanel()
	end
end

return var_0_0
