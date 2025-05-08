local var_0_0 = class("NewStoryRecordPanel")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5
local var_0_7 = 10

function var_0_0.GetUIName(arg_1_0)
	return "NewStoryRecordUI"
end

function var_0_0.Ctor(arg_2_0)
	arg_2_0.state = var_0_1
end

function var_0_0.Load(arg_3_0)
	arg_3_0.state = var_0_2
	arg_3_0.parentTF = arg_3_0:GetParent()

	ResourceMgr.Inst:getAssetAsync("ui/" .. arg_3_0:GetUIName(), "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_4_0)
		local var_4_0 = Object.Instantiate(arg_4_0, arg_3_0.parentTF)

		if arg_3_0:IsLoading() then
			arg_3_0.state = var_0_3

			arg_3_0:Init(var_4_0)
		end
	end), true, true)
end

function var_0_0.GetParent(arg_5_0)
	return pg.NewStoryMgr.GetInstance().frontTr
end

function var_0_0.IsEmptyOrUnload(arg_6_0)
	return arg_6_0.state == var_0_1 or arg_6_0.state == var_0_6
end

function var_0_0.IsLoading(arg_7_0)
	return arg_7_0.state == var_0_2
end

function var_0_0.IsShowing(arg_8_0)
	return arg_8_0.state == var_0_4
end

function var_0_0.CanOpen(arg_9_0)
	return arg_9_0.state == var_0_1 or arg_9_0.state == var_0_5 or arg_9_0.state == var_0_6
end

function var_0_0.Init(arg_10_0, arg_10_1)
	arg_10_0._go = arg_10_1
	arg_10_0._tf = arg_10_1.transform
	arg_10_0.pageAnim = arg_10_0._tf:GetComponent(typeof(Animation))
	arg_10_0.pageAniEvent = arg_10_0._tf:GetComponent(typeof(DftAniEvent))
	arg_10_0.container = arg_10_0._tf:Find("content")
	arg_10_0.tpl = arg_10_0._tf:Find("content/tpl")
	arg_10_0.cg = GetOrAddComponent(arg_10_0._tf, typeof(CanvasGroup))
	arg_10_0.tplPools = {
		arg_10_0.tpl
	}
	arg_10_0.closeBtn = arg_10_0._tf:Find("close")
	arg_10_0.bgImage = arg_10_0._tf:GetComponent(typeof(Image))
	arg_10_0.scrollrect = arg_10_0._tf:GetComponent(typeof(ScrollRect))
	arg_10_0.contentSizeFitter = arg_10_0._tf:Find("content"):GetComponent(typeof(ContentSizeFitter))

	onButton(nil, arg_10_0.closeBtn, function()
		setButtonEnabled(arg_10_0.closeBtn, false)
		arg_10_0:Hide()
	end, SFX_PANEL)
	arg_10_0.pageAniEvent:SetEndEvent(function()
		arg_10_0:OnHide()
	end)

	arg_10_0.state = var_0_4

	arg_10_0:UpdateAll()
end

function var_0_0.UpdateAll(arg_13_0)
	arg_13_0.cg.blocksRaycasts = false

	seriesAsync({
		function(arg_14_0)
			arg_13_0.cg.alpha = 0

			arg_13_0:UpdateList(arg_14_0)
		end,
		function(arg_15_0)
			onNextTick(arg_15_0)
		end,
		function(arg_16_0)
			arg_13_0.cg.alpha = 1

			arg_13_0:PlayAnimation(arg_16_0)
		end
	}, function()
		arg_13_0.cg.blocksRaycasts = true

		arg_13_0:BlurPanel()
	end)
end

local function var_0_8(arg_18_0)
	setActive(arg_18_0._tf, true)
	setButtonEnabled(arg_18_0.closeBtn, true)
	arg_18_0.pageAnim:Play("anim_storyrecordUI_record_in")

	arg_18_0.state = var_0_4

	arg_18_0:UpdateAll()
end

function var_0_0.Show(arg_19_0, arg_19_1)
	arg_19_0.recorder = arg_19_1
	arg_19_0.displays = arg_19_1:GetContentList()

	if arg_19_0:IsEmptyOrUnload() then
		arg_19_0:Load()
	elseif arg_19_0:IsLoading() then
		-- block empty
	else
		var_0_8(arg_19_0)
	end
end

local function var_0_9(arg_20_0)
	local var_20_0
	local var_20_1 = false

	if #arg_20_0.tplPools <= 0 then
		var_20_0 = Object.Instantiate(arg_20_0.tpl, arg_20_0.tpl.parent)
	else
		var_20_1 = true
		var_20_0 = table.remove(arg_20_0.tplPools, 1)
	end

	GetOrAddComponent(var_20_0, typeof(CanvasGroup)).alpha = 1

	return var_20_0, var_20_1
end

local function var_0_10(arg_21_0, arg_21_1)
	setActive(arg_21_1, false)

	GetOrAddComponent(arg_21_1, typeof(CanvasGroup)).alpha = 1

	if #arg_21_0.tplPools >= 5 and arg_21_1 ~= arg_21_0.tpl then
		Object.Destroy(arg_21_1.gameObject)
	else
		table.insert(arg_21_0.tplPools, arg_21_1)
	end
end

function var_0_0.UpdateList(arg_22_0, arg_22_1)
	if not arg_22_0:IsShowing() then
		return
	end

	local var_22_0 = arg_22_0.displays
	local var_22_1 = {}
	local var_22_2 = 1

	arg_22_0.usingTpls = {}

	local var_22_3 = #var_22_0 < var_0_7 and #var_22_0 or var_0_7

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		local var_22_4 = #var_22_0

		table.insert(var_22_1, function(arg_23_0)
			local var_23_0, var_23_1 = var_0_9(arg_22_0)

			if not var_23_1 then
				var_22_2 = var_22_2 + 1
			end

			arg_22_0:UpdateRecord(var_23_0, iter_22_1)
			table.insert(arg_22_0.usingTpls, var_23_0)
			tf(var_23_0):SetAsLastSibling()

			if var_22_2 % 5 == 0 then
				var_22_2 = 1

				onNextTick(arg_23_0)
			else
				arg_23_0()
			end

			local var_23_2 = var_23_0:GetComponent(typeof(Animation))

			if iter_22_0 + var_22_3 <= var_22_4 then
				setActive(var_23_0, true)
				var_23_2:Play("anim_storyrecordUI_tql_reset")
			else
				GetOrAddComponent(var_23_0, typeof(CanvasGroup)).alpha = 0

				setActive(var_23_0, true)
			end
		end)
	end

	table.insert(var_22_1, function(arg_24_0)
		onDelayTick(function()
			arg_22_0.contentSizeFitter.enabled = false
			arg_22_0.contentSizeFitter.enabled = true

			scrollToBottom(arg_22_0._tf)
			arg_24_0()
		end, 0.05)
	end)
	seriesAsync(var_22_1, arg_22_1)
end

function var_0_0.PlayAnimation(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.displays
	local var_26_1 = #var_26_0 < var_0_7 and #var_26_0 or var_0_7
	local var_26_2 = {}

	for iter_26_0 = 1, var_26_1 do
		table.insert(var_26_2, function(arg_27_0)
			local var_27_0 = #arg_26_0.usingTpls - var_26_1 + iter_26_0

			arg_26_0.usingTpls[var_27_0]:GetComponent(typeof(Animation)):Play("anim_storyrecordUI_tpl_in")
			onDelayTick(function()
				arg_27_0()
			end, 0.033)
		end)
	end

	seriesAsync(var_26_2)
	arg_26_1()
end

function var_0_0.UpdateRecord(arg_29_0, arg_29_1, arg_29_2)
	GetOrAddComponent(arg_29_1, typeof(CanvasGroup)).alpha = 1

	local var_29_0 = arg_29_1:Find("icon")

	setActive(var_29_0, arg_29_2.icon)

	if arg_29_2.icon then
		local var_29_1 = arg_29_2.icon

		GetImageSpriteFromAtlasAsync("SquareIcon/" .. var_29_1, "", var_29_0:Find("Image"))
	end

	if arg_29_2.name and arg_29_2.nameColor then
		local var_29_2 = string.gsub(arg_29_2.nameColor, "#", "")

		arg_29_1:Find("name"):GetComponent(typeof(Outline)).effectColor = Color.NewHex(var_29_2)

		setText(arg_29_1:Find("name"), setColorStr(arg_29_2.name, arg_29_2.nameColor))
	else
		setText(arg_29_1:Find("name"), arg_29_2.name or "")
	end

	local var_29_3 = arg_29_2.list
	local var_29_4 = UIItemList.New(arg_29_1:Find("content"), arg_29_1:Find("content/Text"))

	var_29_4:make(function(arg_30_0, arg_30_1, arg_30_2)
		if arg_30_0 == UIItemList.EventUpdate then
			setText(arg_30_2, var_29_3[arg_30_1 + 1])
		end
	end)
	var_29_4:align(#var_29_3)
	setActive(arg_29_1:Find("player"), arg_29_2.icon == nil and arg_29_2.isPlayer)

	local var_29_5 = arg_29_2.icon == nil and arg_29_2.name == nil
	local var_29_6 = var_29_4.container:GetComponent(typeof(UnityEngine.UI.HorizontalOrVerticalLayoutGroup))
	local var_29_7 = UnityEngine.RectOffset.New()

	var_29_7.left = 170
	var_29_7.right = 0
	var_29_7.top = var_29_5 and 25 or 90
	var_29_7.bottom = var_29_5 and 25 or 50
	var_29_6.padding = var_29_7
end

function var_0_0.OnHide(arg_31_0)
	arg_31_0:Clear()
	arg_31_0:UnblurPanel()
	setActive(arg_31_0._tf, false)
	setButtonEnabled(arg_31_0.closeBtn, true)

	arg_31_0.state = var_0_5
end

function var_0_0.Hide(arg_32_0)
	if arg_32_0:IsShowing() then
		arg_32_0.pageAnim:Play("anim_storyrecordUI_record_out")
	end
end

function var_0_0.BlurPanel(arg_33_0)
	setParent(pg.NewStoryMgr.GetInstance()._tf, pg.UIMgr.GetInstance().UIMain)

	local var_33_0 = pg.UIMgr.GetInstance().OverlayMain

	arg_33_0.hideNodes = {}

	for iter_33_0 = 1, var_33_0.childCount do
		local var_33_1 = var_33_0:GetChild(iter_33_0 - 1)

		if isActive(var_33_1) then
			table.insert(arg_33_0.hideNodes, var_33_1)
			setActive(var_33_1, false)
		end
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_33_0._tf, false, {
		weight = LayerWeightConst.TOP_LAYER
	})
end

function var_0_0.UnblurPanel(arg_34_0)
	setParent(pg.NewStoryMgr.GetInstance()._tf, pg.UIMgr.GetInstance().OverlayToast)

	if arg_34_0.hideNodes and #arg_34_0.hideNodes > 0 then
		for iter_34_0, iter_34_1 in ipairs(arg_34_0.hideNodes) do
			setActive(iter_34_1, true)
		end
	end

	arg_34_0.hideNodes = {}

	pg.UIMgr.GetInstance():UnblurPanel(arg_34_0._tf, arg_34_0.parentTF)
end

function var_0_0.Clear(arg_35_0)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0.usingTpls) do
		var_0_10(arg_35_0, iter_35_1)
	end

	arg_35_0.usingTpls = {}
end

function var_0_0.Unload(arg_36_0)
	if arg_36_0.state > var_0_2 then
		arg_36_0.state = var_0_6

		if not IsNil(arg_36_0.closeBtn) then
			removeOnButton(arg_36_0.closeBtn)
		end

		Object.Destroy(arg_36_0._go)

		arg_36_0._go = nil
		arg_36_0._tf = nil
		arg_36_0.container = nil
		arg_36_0.tpl = nil
	end
end

function var_0_0.Dispose(arg_37_0)
	arg_37_0:Hide()
	arg_37_0:Unload()
end

return var_0_0
