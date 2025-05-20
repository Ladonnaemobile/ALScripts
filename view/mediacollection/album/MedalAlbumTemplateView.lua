local var_0_0 = class("StarLightMedalAlbumView", import("view.base.BaseUI"))

var_0_0.ICON_SCALE = 1.35
var_0_0.MEDAL_COUNT = 8

function var_0_0.SetMedalGroupData(arg_1_0, arg_1_1)
	arg_1_0.medalGroupList = arg_1_1
	arg_1_0.currentMedalGroup = arg_1_0.medalGroupList[arg_1_0.GROUP_ID] or ActivityMedalGroup.New(arg_1_0.GROUP_ID)

	if arg_1_0.currentMedalGroup:GetMedalGroupState() == ActivityMedalGroup.STATE_ACTIVE then
		arg_1_0.medalTaskView:SetMedalGroup(arg_1_0.currentMedalGroup)
	end

	arg_1_0.medalDetailView:SetMedalGroup(arg_1_0.currentMedalGroup)

	local var_1_0 = arg_1_0.currentMedalGroup:getConfig("activity_medal_ids")

	for iter_1_0 = 1, arg_1_0.MEDAL_COUNT do
		local var_1_1 = var_1_0[iter_1_0]

		LoadImageSpriteAsync("activitymedal/" .. var_1_1 .. "_l", arg_1_0.slots[iter_1_0].slot, true)
		LoadImageSpriteAsync("activitymedal/" .. var_1_1, arg_1_0.slots[iter_1_0].active, true)
	end
end

function var_0_0.ShowPageBtn(arg_2_0, arg_2_1)
	setActive(arg_2_0.prevBtn, false)
	setActive(arg_2_0.nextBtn, false)
end

function var_0_0.UpdateMedalList(arg_3_0)
	return
end

function var_0_0.init(arg_4_0)
	arg_4_0:FindUI()

	arg_4_0.loader = AutoLoader.New()
end

function var_0_0.FindUI(arg_5_0)
	local var_5_0 = arg_5_0:findTF("Top")

	arg_5_0.bg = arg_5_0:findTF("mask")
	arg_5_0.backBtn = arg_5_0:findTF("BackBtn", var_5_0)
	arg_5_0.helpBtn = arg_5_0:findTF("InfoBtn", var_5_0)
	arg_5_0.taskBtn = arg_5_0:findTF("Desk/taskBtn")
	arg_5_0.prevBtn = arg_5_0:findTF("Desk/prevBtn")
	arg_5_0.nextBtn = arg_5_0:findTF("Desk/nextBtn")
	arg_5_0.slots = {}

	for iter_5_0 = 1, arg_5_0.MEDAL_COUNT do
		arg_5_0.slots[iter_5_0] = {
			slot = arg_5_0._tf:Find("Desk/Slot" .. iter_5_0),
			active = arg_5_0._tf:Find("Desk/Slot" .. iter_5_0 .. "/active"),
			tips = arg_5_0._tf:Find("Desk/Slot" .. iter_5_0 .. "/reddot"),
			click = arg_5_0._tf:Find("Desk/Slot" .. iter_5_0 .. "/Click")
		}
	end

	arg_5_0.medalLock = arg_5_0:findTF("Desk/medal")
	arg_5_0.trophyLock = arg_5_0:findTF("Desk/trophy")
	arg_5_0.medalDetailView = MedalDetailPanel.New(arg_5_0:findTF("DetailView"), arg_5_0)

	arg_5_0.medalDetailView:SetIconScale(arg_5_0.ICON_SCALE)

	arg_5_0.medalTaskView = MedalTaskPanel.New(arg_5_0:findTF("TaskView"), arg_5_0)
end

function var_0_0.didEnter(arg_6_0)
	var_0_0.super.didEnter(arg_6_0)
	arg_6_0:AddListener()
	arg_6_0:UpdateView()
	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)
end

function var_0_0.AddListener(arg_7_0)
	onButton(arg_7_0, arg_7_0.backBtn, function()
		arg_7_0:closeView()
	end, SFX_CANCEL)

	for iter_7_0 = 1, arg_7_0.MEDAL_COUNT do
		onButton(arg_7_0, arg_7_0.slots[iter_7_0].click, function()
			arg_7_0:showMedalView(iter_7_0)
		end)
	end

	onButton(arg_7_0, arg_7_0.taskBtn, function()
		arg_7_0:showTaskView()
	end)
	onButton(arg_7_0, arg_7_0.bg, function()
		arg_7_0:closeView()
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[arg_7_0.HELP_TIPS].tip
		})
	end)
	onButton(arg_7_0, arg_7_0.medalLock, function()
		local var_13_0 = arg_7_0.currentMedalGroup:getConfig("item_show")[2]
		local var_13_1 = {
			type = var_13_0[1],
			id = var_13_0[2],
			count = var_13_0[3]
		}

		arg_7_0:emit(BaseUI.ON_DROP, var_13_1)
	end, SFX_PANEL)

	if arg_7_0.trophyLock then
		onButton(arg_7_0, arg_7_0.trophyLock, function()
			local var_14_0 = arg_7_0.currentMedalGroup:getConfig("item_show")[1]
			local var_14_1 = {
				type = var_14_0[1],
				id = var_14_0[2],
				count = var_14_0[3]
			}

			arg_7_0:emit(BaseUI.ON_DROP, var_14_1)
		end, SFX_PANEL)
	end
end

function var_0_0.showMedalView(arg_15_0, arg_15_1)
	arg_15_0.medalDetailView:SetCurrentIndex(arg_15_1)
	arg_15_0.medalDetailView:UpdateMedal()
	arg_15_0.medalDetailView:SetActive(true)
end

function var_0_0.showTaskView(arg_16_0)
	arg_16_0.medalTaskView:ShowMedalTask()
	arg_16_0.medalTaskView:SetActive(true)
end

function var_0_0.UpdateView(arg_17_0)
	local var_17_0 = arg_17_0.currentMedalGroup:GetMedalList()

	for iter_17_0 = 1, arg_17_0.MEDAL_COUNT do
		local var_17_1 = arg_17_0.currentMedalGroup:getConfig("activity_medal_ids")[iter_17_0]
		local var_17_2 = arg_17_0.slots[iter_17_0]

		if var_17_0[var_17_1].timeStamp then
			setActive(var_17_2.active, true)
		else
			setActive(var_17_2.active, false)
		end
	end

	local var_17_3 = arg_17_0.currentMedalGroup:getConfig("activity_link")[1][3][1]
	local var_17_4 = getProxy(TaskProxy):getTaskById(var_17_3)

	if arg_17_0.trophyLock then
		arg_17_0.trophyLock:GetComponent(typeof(Image)).enabled = var_17_4 ~= nil
	end

	arg_17_0.medalLock:GetComponent(typeof(Image)).enabled = var_17_4 ~= nil

	setActive(arg_17_0.taskBtn, arg_17_0.currentMedalGroup:GetMedalGroupState() == ActivityMedalGroup.STATE_ACTIVE)
end

function var_0_0.FlushTaskPanel(arg_18_0)
	arg_18_0.medalTaskView:SetMedalGroup(arg_18_0.currentMedalGroup)
	arg_18_0.medalTaskView:ShowMedalTask()
end

function var_0_0.willExit(arg_19_0)
	arg_19_0.medalDetailView:SetActive(false)
	arg_19_0.medalTaskView:SetActive(false)
	arg_19_0.medalDetailView:Dispose()
	arg_19_0.medalTaskView:Dispose()
	pg.UIMgr.GetInstance():UnblurPanel(arg_19_0._tf)
	arg_19_0.loader:Clear()
end

return var_0_0
