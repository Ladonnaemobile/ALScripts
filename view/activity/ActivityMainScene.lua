local var_0_0 = class("ActivityMainScene", import("..base.BaseUI"))

var_0_0.LOCK_ACT_MAIN = "ActivityMainScene:LOCK_ACT_MAIN"
var_0_0.UPDATE_ACTIVITY = "ActivityMainScene:UPDATE_ACTIVITY"
var_0_0.GET_PAGE_BGM = "ActivityMainScene.GET_PAGE_BGM"
var_0_0.FLUSH_TABS = "ActivityMainScene.FLUSH_TABS"

function var_0_0.preload(arg_1_0, arg_1_1)
	arg_1_1()
end

function var_0_0.getUIName(arg_2_0)
	return "ActivityMainUI"
end

function var_0_0.PlayBGM(arg_3_0)
	return
end

function var_0_0.onBackPressed(arg_4_0)
	if arg_4_0.locked then
		return
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.windowList) do
		if isActive(iter_4_1._tf) then
			arg_4_0:HideWindow(iter_4_1.class)

			return
		end
	end

	if arg_4_0.awardWindow and arg_4_0.awardWindow:GetLoaded() and arg_4_0.awardWindow:isShowing() then
		arg_4_0.awardWindow:Hide()

		return
	end

	arg_4_0:emit(var_0_0.ON_BACK_PRESSED)
end

local var_0_1

function var_0_0.init(arg_5_0)
	arg_5_0.btnBack = arg_5_0:findTF("blur_panel/adapt/top/back_btn")
	arg_5_0.pageContainer = arg_5_0:findTF("pages")
	arg_5_0.permanentFinshMask = arg_5_0:findTF("pages_finish")
	arg_5_0.tabs = arg_5_0:findTF("scroll/viewport/content")
	arg_5_0.tab = arg_5_0:findTF("tab", arg_5_0.tabs)
	arg_5_0.entranceList = UIItemList.New(arg_5_0:findTF("enter/viewport/content"), arg_5_0:findTF("enter/viewport/content/btn"))
	arg_5_0.windowList = {}
	arg_5_0.lockAll = arg_5_0:findTF("blur_panel/lock_all")
	arg_5_0.awardWindow = AwardWindow.New(arg_5_0._tf, arg_5_0.event)
	arg_5_0.chargeTipWindow = ChargeTipWindow.New(arg_5_0._tf, arg_5_0.event)

	setActive(arg_5_0.tab, false)
	setActive(arg_5_0.lockAll, false)
	setActive(arg_5_0.permanentFinshMask, false)
	setText(arg_5_0.permanentFinshMask:Find("piece/Text"), i18n("activity_permanent_tips2"))
	onButton(arg_5_0, arg_5_0.permanentFinshMask:Find("piece/arrow/Image"), function()
		arg_5_0:emit(ActivityMediator.FINISH_ACTIVITY_PERMANENT)
	end, SFX_PANEL)

	arg_5_0.tabsList = UIItemList.New(arg_5_0.tabs, arg_5_0.tab)

	arg_5_0.tabsList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = arg_5_0.activities[arg_7_1 + 1]

			if arg_5_0.pageDic[var_7_0.id] ~= nil then
				local var_7_1 = var_7_0:getConfig("title_res_tag")

				if var_7_1 then
					local var_7_2 = arg_5_0:findTF("red", arg_7_2)
					local var_7_3 = GetSpriteFromAtlas("activityuitable/" .. var_7_1 .. "_text", "") or GetSpriteFromAtlas("activityuitable/activity_text", "")
					local var_7_4 = GetSpriteFromAtlas("activityuitable/" .. var_7_1 .. "_text_selected", "") or GetSpriteFromAtlas("activityuitable/activity_text_selected", "")

					setImageSprite(arg_5_0:findTF("off/text", arg_7_2), var_7_3, true)
					setImageSprite(arg_5_0:findTF("on/text", arg_7_2), var_7_4, true)
					setActive(var_7_2, var_7_0:readyToAchieve())
					onToggle(arg_5_0, arg_7_2, function(arg_8_0)
						if arg_8_0 then
							arg_5_0:selectActivity(var_7_0)
						end
					end, SFX_PANEL)
				else
					onToggle(arg_5_0, arg_7_2, function(arg_9_0)
						arg_5_0:loadActivityPanel(arg_9_0, var_7_0)
					end, SFX_PANEL)
				end
			end
		end
	end)
end

function var_0_0.didEnter(arg_10_0)
	onButton(arg_10_0, arg_10_0.btnBack, function()
		arg_10_0:emit(var_0_0.ON_BACK)
	end, SOUND_BACK)
	arg_10_0:updateEntrances()
	arg_10_0:emit(ActivityMediator.SHOW_NEXT_ACTIVITY)
	arg_10_0:bind(var_0_0.LOCK_ACT_MAIN, function(arg_12_0, arg_12_1)
		arg_10_0.locked = arg_12_1

		setActive(arg_10_0.lockAll, arg_12_1)
	end)
	arg_10_0:bind(var_0_0.UPDATE_ACTIVITY, function(arg_13_0, arg_13_1)
		arg_10_0:updateActivity(arg_13_1)
	end)
	arg_10_0:bind(var_0_0.GET_PAGE_BGM, function(arg_14_0, arg_14_1, arg_14_2)
		arg_14_2.bgm = arg_10_0:getBGM(arg_14_1) or arg_10_0:getBGM()
	end)
	arg_10_0:bind(var_0_0.FLUSH_TABS, function()
		arg_10_0:flushTabs()
	end)
	getProxy(CommanderManualProxy):TaskProgressAdd(2020, 1)
end

function var_0_0.setPlayer(arg_16_0, arg_16_1)
	arg_16_0.shareData:SetPlayer(arg_16_1)
end

function var_0_0.setFlagShip(arg_17_0, arg_17_1)
	arg_17_0.shareData:SetFlagShip(arg_17_1)
end

function var_0_0.updateTaskLayers(arg_18_0)
	if not arg_18_0.activity then
		return
	end

	arg_18_0:updateActivity(arg_18_0.activity)
end

function var_0_0.instanceActivityPage(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1:getConfig("page_info")

	if var_19_0.class_name and not arg_19_0.pageDic[arg_19_1.id] and not arg_19_1:isEnd() then
		local var_19_1 = import("view.activity.subPages." .. var_19_0.class_name).New(arg_19_0.pageContainer, arg_19_0.event, arg_19_0.contextData)

		if var_19_1:UseSecondPage(arg_19_1) then
			var_19_1:SetUIName(var_19_0.ui_name2)
		else
			var_19_1:SetUIName(var_19_0.ui_name)
		end

		var_19_1:SetShareData(arg_19_0.shareData)

		arg_19_0.pageDic[arg_19_1.id] = var_19_1
	end
end

function var_0_0.setActivities(arg_20_0, arg_20_1)
	arg_20_0.activities = arg_20_1 or {}
	arg_20_0.shareData = arg_20_0.shareData or ActivityShareData.New()
	arg_20_0.pageDic = arg_20_0.pageDic or {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		arg_20_0:instanceActivityPage(iter_20_1)
	end

	arg_20_0.activity = nil

	table.sort(arg_20_0.activities, function(arg_21_0, arg_21_1)
		local var_21_0 = arg_21_0:getShowPriority()
		local var_21_1 = arg_21_1:getShowPriority()

		if var_21_0 == var_21_1 then
			return arg_21_0.id > arg_21_1.id
		end

		return var_21_1 < var_21_0
	end)
	arg_20_0:flushTabs()
end

function var_0_0.getActivityIndex(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.activities) do
		if iter_22_1.id == arg_22_1 then
			return iter_22_0
		end
	end

	return nil
end

function var_0_0.updateActivity(arg_23_0, arg_23_1)
	if ActivityConst.PageIdLink[arg_23_1.id] then
		arg_23_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.PageIdLink[arg_23_1.id])
	end

	if arg_23_1:isShow() and not arg_23_1:isEnd() then
		arg_23_0.activities[arg_23_0:getActivityIndex(arg_23_1.id) or #arg_23_0.activities + 1] = arg_23_1

		table.sort(arg_23_0.activities, function(arg_24_0, arg_24_1)
			local var_24_0 = arg_24_0:getShowPriority()
			local var_24_1 = arg_24_1:getShowPriority()

			if var_24_0 == var_24_1 then
				return arg_24_0.id > arg_24_1.id
			end

			return var_24_1 < var_24_0
		end)

		if not arg_23_0.pageDic[arg_23_1.id] then
			arg_23_0:instanceActivityPage(arg_23_1)
		end

		arg_23_0:flushTabs()

		if arg_23_0.activity and arg_23_0.activity.id == arg_23_1.id then
			arg_23_0.activity = arg_23_1

			arg_23_0.pageDic[arg_23_1.id]:ActionInvoke("Flush", arg_23_1)
			setActive(arg_23_0.permanentFinshMask, pg.activity_task_permanent[arg_23_1.id] and arg_23_1:canPermanentFinish())
		end
	end
end

function var_0_0.removeActivity(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getActivityIndex(arg_25_1)

	if var_25_0 then
		table.remove(arg_25_0.activities, var_25_0)
		arg_25_0.pageDic[arg_25_1]:Destroy()

		arg_25_0.pageDic[arg_25_1] = nil

		arg_25_0:flushTabs()

		if arg_25_0.activity and arg_25_0.activity.id == arg_25_1 then
			arg_25_0.activity = nil

			arg_25_0:verifyTabs()
		end
	end
end

function var_0_0.loadLayers(arg_26_0)
	local var_26_0 = arg_26_0.pageDic[arg_26_0.activity.id]

	if var_26_0 and var_26_0.OnLoadLayers then
		var_26_0:OnLoadLayers()
	end
end

function var_0_0.removeLayers(arg_27_0)
	local var_27_0 = arg_27_0.pageDic[arg_27_0.activity.id]

	if var_27_0 and var_27_0.OnRemoveLayers then
		var_27_0:OnRemoveLayers()
	end
end

function var_0_0.GetOnShowEntranceData()
	var_0_1 = var_0_1 or require("GameCfg.activity.EntranceData")

	assert(var_0_1, "Missing EntranceData.lua!")

	var_0_1 = var_0_1 or {}

	return (_.select(var_0_1, function(arg_29_0)
		return arg_29_0.isShow and arg_29_0.isShow()
	end))
end

function var_0_0.updateEntrances(arg_30_0)
	local var_30_0 = var_0_0.GetOnShowEntranceData()
	local var_30_1 = math.max(#var_30_0, 5)

	arg_30_0.entranceList:make(function(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_0 == UIItemList.EventUpdate then
			local var_31_0 = var_30_0[arg_31_1 + 1]
			local var_31_1 = "empty"

			removeOnButton(arg_31_2)

			local var_31_2 = false

			if var_31_0 and table.getCount(var_31_0) ~= 0 and var_31_0.isShow() then
				onButton(arg_30_0, arg_31_2, function()
					arg_30_0:emit(var_31_0.event, var_31_0.data[1], var_31_0.data[2])
				end, SFX_PANEL)

				var_31_1 = var_31_0.banner

				if var_31_0.isTip then
					var_31_2 = var_31_0.isTip()
				end
			end

			setActive(arg_31_2:Find("tip"), var_31_2)
			LoadImageSpriteAsync("activitybanner/" .. var_31_1, arg_31_2)
		end
	end)
	arg_30_0.entranceList:align(var_30_1)
end

function var_0_0.flushTabs(arg_33_0)
	arg_33_0.tabsList:align(#arg_33_0.activities)
end

function var_0_0.selectActivity(arg_34_0, arg_34_1)
	if arg_34_1 and (not arg_34_0.activity or arg_34_0.activity.id ~= arg_34_1.id) then
		local var_34_0 = arg_34_0.pageDic[arg_34_1.id]

		assert(var_34_0, "找不到id:" .. arg_34_1.id .. "的活动页，请检查")
		var_34_0:Load()
		var_34_0:ActionInvoke("Flush", arg_34_1)
		var_34_0:ActionInvoke("ShowOrHide", true)

		if arg_34_0.activity and arg_34_0.activity.id ~= arg_34_1.id then
			arg_34_0.pageDic[arg_34_0.activity.id]:ActionInvoke("ShowOrHide", false)
		end

		arg_34_0.activity = arg_34_1
		arg_34_0.contextData.id = arg_34_1.id

		setActive(arg_34_0.permanentFinshMask, pg.activity_task_permanent[arg_34_1.id] and arg_34_1:canPermanentFinish())
	end
end

function var_0_0.checkAutoHideActivity(arg_35_0)
	if arg_35_0.activity and not arg_35_0.activity:isShow() then
		arg_35_0:removeActivity(arg_35_0.activity.id)
	end
end

function var_0_0.verifyTabs(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:getActivityIndex(arg_36_1) or 1
	local var_36_1 = arg_36_0.tabs:GetChild(var_36_0 - 1)

	triggerToggle(var_36_1, true)
end

function var_0_0.loadActivityPanel(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_2:getConfig("type")
	local var_37_1

	if var_37_1 and arg_37_1 then
		arg_37_0:emit(ActivityMediator.OPEN_LAYER, var_37_1)
	elseif var_37_1 and not arg_37_1 then
		arg_37_0:emit(ActivityMediator.CLOSE_LAYER, var_37_1.mediator)
	else
		originalPrint("------活动id为" .. arg_37_2.id .. "类型为" .. arg_37_2:getConfig("type") .. "的页面不存在")
	end
end

function var_0_0.getBonusWindow(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0:findTF(arg_38_1)

	if not var_38_0 then
		PoolMgr.GetInstance():GetUI("ActivitybonusWindow", true, function(arg_39_0)
			SetParent(arg_39_0, arg_38_0._tf, false)

			arg_39_0.name = arg_38_1

			arg_38_2(arg_39_0)
		end)
	else
		arg_38_2(var_38_0)
	end
end

function var_0_0.ShowWindow(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_1.__cname

	if not arg_40_0.windowList[var_40_0] then
		arg_40_0:getBonusWindow(var_40_0, function(arg_41_0)
			arg_40_0.windowList[var_40_0] = arg_40_1.New(tf(arg_41_0), arg_40_0)

			arg_40_0.windowList[var_40_0]:Show(arg_40_2)
		end)
	else
		arg_40_0.windowList[var_40_0]:Show(arg_40_2)
	end
end

function var_0_0.HideWindow(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1.__cname

	if not arg_42_0.windowList[var_42_0] then
		return
	end

	arg_42_0.windowList[var_42_0]:Hide()
end

function var_0_0.ShowAwardWindow(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	arg_43_0.awardWindow:ExecuteAction("Flush", arg_43_1, arg_43_2, arg_43_3)
end

function var_0_0.OnChargeSuccess(arg_44_0, arg_44_1)
	arg_44_0.chargeTipWindow:ExecuteAction("Show", arg_44_1)
end

function var_0_0.willExit(arg_45_0)
	arg_45_0.shareData = nil

	for iter_45_0, iter_45_1 in pairs(arg_45_0.pageDic) do
		iter_45_1:Destroy()
	end

	for iter_45_2, iter_45_3 in pairs(arg_45_0.windowList) do
		iter_45_3:Dispose()
	end

	if arg_45_0.awardWindow then
		arg_45_0.awardWindow:Destroy()

		arg_45_0.awardWindow = nil
	end

	if arg_45_0.chargeTipWindow then
		arg_45_0.chargeTipWindow:Destroy()

		arg_45_0.chargeTipWindow = nil
	end
end

return var_0_0
