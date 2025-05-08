local var_0_0 = class("SettingsOptionPage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "SettingsCombinationPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0:OnBindEvent()

	arg_2_0.panelContainer = arg_2_0:findTF("content")

	local var_2_0 = arg_2_0:GetPanels()

	arg_2_0.panels = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insert(arg_2_0.panels, iter_2_1.New(arg_2_0.panelContainer))
	end

	arg_2_0.contentSizeFitter = arg_2_0.panelContainer:GetComponent(typeof(ContentSizeFitter))
	arg_2_0.cg = arg_2_0._tf:GetComponent(typeof(CanvasGroup))
	arg_2_0.scrollrect = arg_2_0._tf:GetComponent(typeof(ScrollRect))

	arg_2_0:InitPanels()
	setActive(arg_2_0._tf, true)
end

function var_0_0.OnBindEvent(arg_3_0)
	arg_3_0:bind(SettingsRandomFlagShipAndSkinPanel.EVT_UPDTAE, function()
		local var_4_0 = arg_3_0:GetPanel(SettingsRandomFlagShipAndSkinPanel)

		if var_4_0 then
			var_4_0:OnRandomFlagshipFlagUpdate()
		end
	end)
	arg_3_0:bind(SettingsNotificationPanel.UPDATE_ALARM_PANEL, function()
		local var_5_0 = arg_3_0:GetPanel(SettingsNotificationPanel)

		if var_5_0 then
			var_5_0:UpdateAndroidAlarm()
		end
	end)
end

function var_0_0.GetPanels(arg_6_0)
	local var_6_0 = {
		SettingsFpsPanle,
		SettingsNotificationPanel,
		SettingsWorldPanle,
		SettingsRandomFlagShipAndSkinPanel,
		SettingsStoryAutoPlayPanel,
		SettingsStorySpeedPanel,
		SettingsMainScenePanel,
		SettingsOtherPanel
	}

	if arg_6_0:NeedAdjustScreen() then
		table.insert(var_6_0, 1, SettingsAdjustScreenPanle)
	end

	if ServerChooseMgr.Inst:IsGatewayPackage() then
		table.insert(var_6_0, 1, SettingsDebugPanel)
	end

	return var_6_0
end

function var_0_0.NeedAdjustScreen(arg_7_0)
	return Screen.width / Screen.height - 0.001 > ADAPT_NOTICE
end

function var_0_0.GetPanel(arg_8_0, arg_8_1)
	if not arg_8_0.panels then
		return nil
	end

	return _.detect(arg_8_0.panels, function(arg_9_0)
		return isa(arg_9_0, arg_8_1)
	end)
end

function var_0_0.InitPanels(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = GetOrAddComponent(arg_10_0.contentSizeFitter, typeof(CanvasGroup))

	arg_10_0.scrollrect.enabled = false

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.panels) do
		table.insert(var_10_0, function(arg_11_0)
			iter_10_1:Init(arg_11_0)
		end)
	end

	seriesAsync(var_10_0, function()
		arg_10_0.scrollrect.enabled = true

		arg_10_0:OnInitPanle()
	end)
end

function var_0_0.RebuildLayout(arg_13_0, arg_13_1)
	onDelayTick(function()
		arg_13_0.contentSizeFitter.enabled = false
		arg_13_0.contentSizeFitter.enabled = true

		arg_13_1()
	end, 0.05)
end

function var_0_0.OnInitPanle(arg_15_0)
	if arg_15_0.contextData.scroll then
		local var_15_0

		if arg_15_0.contextData.scroll == "world_settings" then
			local var_15_1 = arg_15_0:GetPanel(SettingsWorldPanle)
		else
			local var_15_2 = arg_15_0:GetPanel(arg_15_0.contextData.scroll)
		end

		local var_15_3 = arg_15_0:GetPanel(arg_15_0.contextData.scroll)

		if var_15_3 then
			arg_15_0:ScrollToPanel(var_15_3)
		end
	end
end

function var_0_0.ScrollToPanel(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.panelContainer:InverseTransformPoint(arg_16_1._tf.position)

	setAnchoredPosition(arg_16_0.panelContainer, {
		y = -var_16_0.y
	})
end

function var_0_0.OnDestroy(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.panels) do
		iter_17_1:Dispose()
	end

	arg_17_0.panels = nil
end

function var_0_0.Show(arg_18_0)
	arg_18_0.cg.blocksRaycasts = true
	arg_18_0.cg.alpha = 1
end

function var_0_0.Hide(arg_19_0)
	arg_19_0.cg.blocksRaycasts = false
	arg_19_0.cg.alpha = 0
end

return var_0_0
