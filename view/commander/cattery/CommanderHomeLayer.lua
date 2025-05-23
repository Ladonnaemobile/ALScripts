local var_0_0 = class("CommanderHomeLayer", import("...base.BaseUI"))

var_0_0.DESC_PAGE_OPEN = "CommanderHomeLayer:DESC_PAGE_OPEN"
var_0_0.DESC_PAGE_CLOSE = "CommanderHomeLayer:DESC_PAGE_CLOSE"

function var_0_0.getUIName(arg_1_0)
	return "CommanderHomeUI"
end

function var_0_0.SetHome(arg_2_0, arg_2_1)
	arg_2_0.home = arg_2_1
end

function var_0_0.OnCatteryUpdate(arg_3_0, arg_3_1)
	local var_3_0

	for iter_3_0, iter_3_1 in pairs(arg_3_0.cards) do
		if iter_3_1.cattery.id == arg_3_1 then
			var_3_0 = iter_3_1.cattery

			iter_3_1:Update(var_3_0)
		end
	end

	if var_3_0 and arg_3_0.catteryDescPage:GetLoaded() and arg_3_0.catteryDescPage:isShowing() then
		arg_3_0.catteryDescPage:OnCatteryUpdate(var_3_0)
	end

	arg_3_0:UpdateMain()
end

function var_0_0.OnCatteryStyleUpdate(arg_4_0, arg_4_1)
	local var_4_0

	for iter_4_0, iter_4_1 in pairs(arg_4_0.cards) do
		if iter_4_1.cattery.id == arg_4_1 then
			var_4_0 = iter_4_1.cattery

			iter_4_1:UpdateStyle(var_4_0)
		end
	end

	if var_4_0 and arg_4_0.catteryDescPage:GetLoaded() and arg_4_0.catteryDescPage:isShowing() then
		arg_4_0.catteryDescPage:OnCatteryStyleUpdate(var_4_0)
	end
end

function var_0_0.OnCommanderExpChange(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.cards) do
		local var_5_0 = iter_5_1.cattery

		if var_5_0:ExistCommander() then
			iter_5_1:Update(var_5_0)
		end
	end

	if arg_5_0.catteryDescPage:GetLoaded() and arg_5_0.catteryDescPage:isShowing() then
		arg_5_0.catteryDescPage:FlushCatteryInfo()
	end

	arg_5_0.awardDisplayView:ExecuteAction("AddPlan", {
		homeExp = 0,
		commanderExps = arg_5_1,
		awards = {}
	})
end

function var_0_0.OnCatteryOPDone(arg_6_0)
	arg_6_0:UpdateMain()
end

function var_0_0.OnZeroHour(arg_7_0)
	arg_7_0:UpdateMain()
end

function var_0_0.OnOpAnimtion(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	setActive(arg_8_0.opAnim.gameObject, true)

	local var_8_0 = ({
		"clean",
		"feed",
		"play"
	})[arg_8_1]

	if not var_8_0 then
		arg_8_3()

		return
	end

	if arg_8_0.timer then
		arg_8_0.timer:Stop()

		arg_8_0.timer = nil
	end

	arg_8_0.timer = Timer.New(function()
		arg_8_0:CancelOpAnim()
	end, 0.8, 1)

	arg_8_0.timer:Start()
	arg_8_0.opAnim:SetTrigger(var_8_0)

	for iter_8_0, iter_8_1 in pairs(arg_8_0.cards) do
		if table.contains(arg_8_2, iter_8_1.cattery.id) then
			floatAni(iter_8_1.char, 20, 0.1, 2)
		end
	end

	arg_8_0.callback = arg_8_3
end

function var_0_0.CancelOpAnim(arg_10_0)
	if arg_10_0.callback then
		arg_10_0.timer:Stop()

		arg_10_0.timer = nil

		arg_10_0.opAnim:SetTrigger("empty")
		arg_10_0.callback()

		arg_10_0.callback = nil

		setActive(arg_10_0.opAnim.gameObject, false)
	end
end

function var_0_0.OnDisplayAwardDone(arg_11_0, arg_11_1)
	arg_11_0.awardDisplayView:ExecuteAction("AddPlan", arg_11_1)
end

function var_0_0.init(arg_12_0)
	arg_12_0.frame = arg_12_0:findTF("bg")
	arg_12_0.closeBtn = arg_12_0:findTF("bg/frame/close_btn")
	arg_12_0.levelInfoBtn = arg_12_0:findTF("bg/frame/title/help")
	arg_12_0.levelTxt = arg_12_0:findTF("bg/frame/title/Text"):GetComponent(typeof(Text))
	arg_12_0.scrollRect = arg_12_0:findTF("bg/frame/scrollrect"):GetComponent("ScrollRect")
	arg_12_0.scrollRectContent = arg_12_0:findTF("bg/frame/scrollrect/content")
	arg_12_0.batchBtn = arg_12_0:findTF("bg/frame/batch")
	arg_12_0.opAnim = arg_12_0:findTF("animation"):GetComponent(typeof(Animator))
	arg_12_0.UIlist = UIItemList.New(arg_12_0.scrollRectContent, arg_12_0.scrollRectContent:Find("tpl"))
	arg_12_0.helpBtn = arg_12_0:findTF("bg/frame/help")
	arg_12_0.cntTxt = arg_12_0:findTF("bg/frame/cnt/Text"):GetComponent(typeof(Text))
	arg_12_0.cards = {}
	arg_12_0.catteryDescPage = CatteryDescPage.New(arg_12_0._tf, arg_12_0.event, arg_12_0.contextData)
	arg_12_0.levelInfoPage = CommanderHomeLevelInfoPage.New(arg_12_0._tf, arg_12_0.event, arg_12_0.contextData)
	arg_12_0.awardDisplayView = CatteryOpAnimPage.New(arg_12_0._tf, arg_12_0.event)
	arg_12_0.batchSelPage = CommanderHomeBatchSelPage.New(arg_12_0._tf, arg_12_0.event)
	arg_12_0.flower = CatteryFlowerView.New(arg_12_0:findTF("bg/frame/flower"))
	arg_12_0.bubbleTF = arg_12_0:findTF("bg/bubble")
	arg_12_0.bubbleClean = arg_12_0.bubbleTF:Find("clean")
	arg_12_0.bubbleFeed = arg_12_0.bubbleTF:Find("feed")
	arg_12_0.bubblePlay = arg_12_0.bubbleTF:Find("play")
end

function var_0_0.RegisterEvent(arg_13_0)
	arg_13_0:bind(var_0_0.DESC_PAGE_CLOSE, function()
		setActive(arg_13_0.frame, true)
	end)
	arg_13_0:bind(var_0_0.DESC_PAGE_OPEN, function()
		setActive(arg_13_0.frame, false)
	end)
end

function var_0_0.didEnter(arg_16_0)
	arg_16_0:RegisterEvent()
	onButton(arg_16_0, arg_16_0.closeBtn, function()
		arg_16_0:emit(var_0_0.ON_CLOSE)
	end, SFX_PANEL)
	onButton(arg_16_0, arg_16_0._tf, function()
		if arg_16_0.forbiddenClose then
			return
		end

		arg_16_0:emit(var_0_0.ON_CLOSE)
	end, SFX_PANEL)
	onButton(arg_16_0, arg_16_0.levelInfoBtn, function()
		arg_16_0.levelInfoPage:ExecuteAction("Show", arg_16_0.home)
	end, SFX_PANEL)
	onButton(arg_16_0, arg_16_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.cat_home_help.tip
		})
	end, SFX_PANEL)
	onButton(arg_16_0, arg_16_0.bubbleClean, function()
		arg_16_0:CancelOpAnim()
		arg_16_0:emit(CommanderHomeMediator.ON_CLEAN)
	end, SFX_PANEL)
	onButton(arg_16_0, arg_16_0.bubbleFeed, function()
		arg_16_0:CancelOpAnim()
		arg_16_0:emit(CommanderHomeMediator.ON_FEED)
	end, SFX_PANEL)
	onButton(arg_16_0, arg_16_0.bubblePlay, function()
		arg_16_0:CancelOpAnim()
		arg_16_0:emit(CommanderHomeMediator.ON_PLAY)
	end, SFX_PANEL)
	onButton(arg_16_0, arg_16_0.batchBtn, function()
		arg_16_0.batchSelPage:ExecuteAction("Update", arg_16_0.home)
	end, SFX_PANEL)
	arg_16_0.UIlist:make(function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == UIItemList.EventUpdate then
			arg_16_0:OnUpdateItem(arg_25_2, arg_16_0.displays[arg_25_1 + 1])
		end
	end)
	arg_16_0:UpdateMain()

	arg_16_0.UIMgr = pg.UIMgr.GetInstance()

	arg_16_0.UIMgr:BlurPanel(arg_16_0._tf)
end

function var_0_0.OnUpdateItem(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0.cards[arg_26_1]

	if not var_26_0 then
		var_26_0 = CatteryCard.New(arg_26_1)
		arg_26_0.cards[arg_26_1] = var_26_0
	end

	onButton(arg_26_0, var_26_0._tf, function()
		if not var_26_0.cattery:IsLocked() then
			arg_26_0.catteryDescPage:ExecuteAction("Update", arg_26_0.home, var_26_0.cattery)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("cat_home_unlock"))
		end
	end, SFX_PANEL)
	var_26_0:Update(arg_26_2)
end

function var_0_0.UpdateMain(arg_28_0)
	arg_28_0.levelTxt.text = "LV." .. arg_28_0.home:GetLevel()

	arg_28_0:InitCatteries()
	arg_28_0.flower:Update(arg_28_0.home)
end

function var_0_0.InitCatteries(arg_29_0)
	local var_29_0 = arg_29_0.home

	arg_29_0.displays = {}

	local var_29_1 = var_29_0:GetCatteries()
	local var_29_2 = 0
	local var_29_3 = 0

	for iter_29_0, iter_29_1 in pairs(var_29_1) do
		table.insert(arg_29_0.displays, iter_29_1)

		if iter_29_1:ExistCommander() then
			var_29_3 = var_29_3 + 1
		end

		if not iter_29_1:IsLocked() then
			var_29_2 = var_29_2 + 1
		end
	end

	arg_29_0.UIlist:align(#arg_29_0.displays)
	arg_29_0:UpdateBubble()

	arg_29_0.cntTxt.text = var_29_3 .. "/" .. var_29_2
end

function var_0_0.UpdateBubble(arg_30_0)
	local var_30_0 = arg_30_0.home:GetCatteries()
	local var_30_1 = false
	local var_30_2 = false
	local var_30_3 = false

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		if iter_30_1:ExistCleanOP() and iter_30_1:CommanderCanClean() then
			var_30_1 = true
		end

		if iter_30_1:ExiseFeedOP() and iter_30_1:CommanderCanFeed() then
			var_30_2 = true
		end

		if iter_30_1:ExistPlayOP() and iter_30_1:CommanderCanPlay() then
			var_30_3 = true
		end
	end

	local var_30_4 = var_30_1 or var_30_2 or var_30_3

	setActive(arg_30_0.bubbleTF, var_30_4)

	if LeanTween.isTweening(arg_30_0.bubbleTF.gameObject) then
		LeanTween.cancel(arg_30_0.bubbleTF.gameObject)
	end

	if var_30_4 then
		floatAni(arg_30_0.bubbleTF, 20, 0.5, -1)
		setActive(arg_30_0.bubbleClean, var_30_1)
		setActive(arg_30_0.bubbleFeed, var_30_2 and not var_30_1)
		setActive(arg_30_0.bubblePlay, var_30_3 and not var_30_2)
	end
end

function var_0_0.willExit(arg_31_0)
	arg_31_0.UIMgr:UnblurPanel(arg_31_0._tf, arg_31_0.UIMgr._normalUIMain)

	if LeanTween.isTweening(arg_31_0.bubbleTF.gameObject) then
		LeanTween.cancel(arg_31_0.bubbleTF.gameObject)
	end

	for iter_31_0, iter_31_1 in pairs(arg_31_0.cards) do
		iter_31_1:Dispose()
	end

	if arg_31_0.timer then
		arg_31_0.timer:Stop()

		arg_31_0.timer = nil
	end

	arg_31_0.cards = nil

	arg_31_0.flower:Dispose()

	arg_31_0.flower = nil

	arg_31_0.catteryDescPage:Destroy()

	arg_31_0.catteryDescPage = nil

	arg_31_0.levelInfoPage:Destroy()

	arg_31_0.levelInfoPage = nil

	arg_31_0.awardDisplayView:Destroy()
end

function var_0_0.onBackPressed(arg_32_0)
	if arg_32_0.catteryDescPage:GetLoaded() and arg_32_0.catteryDescPage:isShowing() then
		arg_32_0.catteryDescPage:Hide()

		return
	end

	if arg_32_0.levelInfoPage:GetLoaded() and arg_32_0.levelInfoPage:isShowing() then
		arg_32_0.levelInfoPage:Hide()

		return
	end

	if arg_32_0.batchSelPage:GetLoaded() and arg_32_0.batchSelPage:isShowing() then
		arg_32_0.batchSelPage:Hide()
	end

	var_0_0.super.onBackPressed(arg_32_0)
end

return var_0_0
