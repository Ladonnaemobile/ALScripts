local var_0_0 = class("NewMainScene", import("..base.BaseUI"))

var_0_0.THEME_CLASSIC = 1
var_0_0.THEME_MELLOW = 2
var_0_0.OPEN_LIVEAREA = "NewMainScene:OPEN_LIVEAREA"
var_0_0.UPDATE_COVER = "NewMainScene:UPDATE_COVER"
var_0_0.FOLD = "NewMainScene:FOLD"
var_0_0.CHAT_STATE_CHANGE = "NewMainScene:CHAT_STATE_CHANGE"
var_0_0.ON_CHANGE_SKIN = "NewMainScene:ON_CHANGE_SKIN"
var_0_0.ON_BUFF_DESC = "NewMainScene:ON_BUFF_DESC"
var_0_0.ON_SKIN_FREEUSAGE_DESC = "NewMainScene:ON_SKIN_FREEUSAGE_DESC"
var_0_0.ENABLE_PAITING_MOVE = "NewMainScene:ENABLE_PAITING_MOVE"
var_0_0.ENABLE_PAITING_SCALE = "NewMainScene:ENABLE_PAITING_SCALE"
var_0_0.SAVE_PART_SCALE = "NewMainScene:SAVE_PART_SCALE"
var_0_0.RESET_PAITING_SCALE = "NewMainScene:RESET_PAITING_SCALE"
var_0_0.SET_SCALE_PART_CONTENT = "NewMainScene:SET_SCALE_PART_CONTENT"
var_0_0.ON_ENTER_DONE = "NewMainScene:ON_ENTER_DONE"
var_0_0.ENTER_SILENT_VIEW = "NewMainScene:ENTER_SILENT_VIEW"
var_0_0.EXIT_SILENT_VIEW = "NewMainScene:EXIT_SILENT_VIEW"
var_0_0.RESET_L2D = "NewMainScene:RESET_L2D"

function var_0_0.getUIName(arg_1_0)
	return "NewMainUI"
end

function var_0_0.needCache(arg_2_0)
	return true
end

function var_0_0.GetThemeStyle(arg_3_0)
	return getProxy(SettingsProxy):GetMainSceneThemeStyle()
end

function var_0_0.PlayBGM(arg_4_0)
	return
end

function var_0_0.GetFlagShip(arg_5_0)
	return (getProxy(PlayerProxy):getRawData():GetFlagShip())
end

function var_0_0.PlayBgm(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1

	if underscore.any({
		function()
			if arg_6_1:IsBgmSkin() and getProxy(SettingsProxy):IsBGMEnable() then
				var_6_0 = arg_6_1:GetSkinBgm()
			end

			return tobool(var_6_0)
		end,
		function()
			if getProxy(SettingsProxy):IsEnableMainMusicPlayer() and getProxy(AppreciateProxy):CanPlayMainMusicPlayer() then
				var_6_0 = "MainMusicPlayer"
				var_6_1 = {
					loopType = getProxy(AppreciateProxy):getMusicPlayerLoopType(),
					albumName = getProxy(AppreciateProxy):getMainPlayerAlbumName()
				}
			end

			return tobool(var_6_0)
		end,
		function()
			local var_9_0, var_9_1 = MainBGView.GetBgAndBgm()

			var_6_0 = var_9_1

			return tobool(var_6_0)
		end,
		function()
			var_6_0 = var_0_0.super.getBGM(arg_6_0)

			return tobool(var_6_0)
		end
	}, function(arg_11_0)
		return arg_11_0()
	end) then
		pg.BgmMgr.GetInstance():Push(arg_6_0.__cname, var_6_0, var_6_1)
	end
end

function var_0_0.ResUISettings(arg_12_0)
	return {
		showType = PlayerResUI.TYPE_ALL,
		anim = not arg_12_0.resAnimFlag,
		weight = LayerWeightConst.BASE_LAYER + 1
	}
end

function var_0_0.ShowOrHideResUI(arg_13_0, arg_13_1)
	if not arg_13_0.isInit then
		return
	end

	var_0_0.super.ShowOrHideResUI(arg_13_0, arg_13_1)
end

function var_0_0.init(arg_14_0)
	arg_14_0.mainCG = GetOrAddComponent(arg_14_0._tf, typeof(CanvasGroup))
	arg_14_0.bgView = MainBGView.New(arg_14_0:findTF("Sea/bg"))
	arg_14_0.paintingView = MainPaintingView.New(arg_14_0:findTF("paint"), arg_14_0:findTF("paintBg"), arg_14_0.event)
	arg_14_0.effectView = MainEffectView.New(arg_14_0:findTF("paint/effect"))
	arg_14_0.buffDescPage = MainBuffDescPage.New(arg_14_0._tf, arg_14_0.event)
	arg_14_0.calibrationPage = MainCalibrationPage.New(arg_14_0._tf, arg_14_0.event, arg_14_0.contextData)
	arg_14_0.silentView = MainSilentView.New(arg_14_0._tf, arg_14_0.event, arg_14_0.contextData)
	arg_14_0.silentChecker = MainSilentChecker.New(arg_14_0.event)
	arg_14_0.skinExperienceDisplayPage = SkinExperienceDiplayPage.New(arg_14_0._tf, arg_14_0.event)

	if USE_OLD_MAIN_LIVE_AREA_UI then
		arg_14_0.liveAreaPage = MainLiveAreaOldPage.New(arg_14_0._tf, arg_14_0.event)
	else
		arg_14_0.liveAreaPage = MainLiveAreaPage.New(arg_14_0._tf, arg_14_0.event)
	end

	pg.redDotHelper = MainReddotView.New()
	arg_14_0.sequenceView = MainSequenceView.New()
	arg_14_0.awakeSequenceView = MainAwakeSequenceView.New()
	arg_14_0.themes = {
		[var_0_0.THEME_CLASSIC] = NewMainClassicTheme.New(arg_14_0._tf, arg_14_0.event, arg_14_0.contextData),
		[var_0_0.THEME_MELLOW] = NewMainMellowTheme.New(arg_14_0._tf, arg_14_0.event, arg_14_0.contextData)
	}
end

function var_0_0.didEnter(arg_15_0)
	arg_15_0:bind(var_0_0.FOLD, function(arg_16_0, arg_16_1)
		arg_15_0:FoldPanels(arg_16_1)

		local var_16_0 = arg_15_0.paintingView.ship

		if not var_16_0 then
			return
		end

		arg_15_0.calibrationPage:ExecuteAction("ShowOrHide", arg_16_1, arg_15_0.bgView.ship, arg_15_0.theme:GetPaintingOffset(var_16_0), arg_15_0.theme:GetCalibrationBG())
	end)
	arg_15_0:bind(var_0_0.ON_CHANGE_SKIN, function(arg_17_0)
		arg_15_0:SwitchToNextShip()
	end)
	arg_15_0:bind(var_0_0.ENTER_SILENT_VIEW, function()
		arg_15_0:ExitCalibrationView()
		arg_15_0:FoldPanels(true)
		arg_15_0.silentView:ExecuteAction("Show")
	end)
	arg_15_0:bind(GAME.WILL_LOGOUT, function()
		arg_15_0:GameLogout()
	end)
	arg_15_0:bind(var_0_0.EXIT_SILENT_VIEW, function()
		arg_15_0:ExitSilentView()
		arg_15_0:SetUpSilentChecker()
		pg.redDotHelper:_Refresh()
	end)
	arg_15_0:bind(var_0_0.ON_SKIN_FREEUSAGE_DESC, function(arg_21_0, arg_21_1)
		arg_15_0.skinExperienceDisplayPage:ExecuteAction("Show", arg_21_1)
	end)
	arg_15_0:bind(NewMainScene.OPEN_LIVEAREA, function(arg_22_0)
		arg_15_0.liveAreaPage:ExecuteAction("Show")
	end)
	arg_15_0:SetUp(false, true)
end

function var_0_0.SetUp(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.mainCG.blocksRaycasts = false
	arg_23_0.isInit = false
	arg_23_0.resAnimFlag = false

	local var_23_0

	seriesAsync({
		function(arg_24_0)
			arg_23_0.awakeSequenceView:Execute(arg_24_0)
		end,
		function(arg_25_0)
			var_23_0 = arg_23_0:GetFlagShip()

			arg_23_0.bgView:Init(var_23_0)
			onNextTick(arg_25_0)
		end,
		function(arg_26_0)
			arg_23_0.theme = arg_23_0.themes[arg_23_0:GetThemeStyle()]

			arg_23_0.theme:ExecuteAction("Show", arg_26_0)
		end,
		function(arg_27_0)
			onNextTick(arg_27_0)
		end,
		function(arg_28_0)
			arg_23_0.isInit = true

			arg_23_0.theme:PlayEnterAnimation(var_23_0, arg_28_0)

			local var_28_0 = arg_23_0.theme:GetPaintingOffset(var_23_0)

			arg_23_0.paintingView:Init(var_23_0, var_28_0, arg_23_1)

			arg_23_0.resAnimFlag = true
		end,
		function(arg_29_0)
			arg_23_0:PlayBgm(var_23_0)
			arg_23_0.effectView:Init(var_23_0)
			arg_23_0.theme:init(var_23_0)
			onNextTick(arg_29_0)
		end,
		function(arg_30_0)
			arg_23_0:ShowOrHideResUI(arg_23_0.theme:ApplyDefaultResUI())
			arg_23_0.sequenceView:Execute(arg_30_0)
		end
	}, function()
		arg_23_0:SetUpSilentChecker()
		arg_23_0:emit(var_0_0.ON_ENTER_DONE)

		arg_23_0.mainCG.blocksRaycasts = true

		if arg_23_2 then
			gcAll()
		end
	end)
end

function var_0_0.SetUpSilentChecker(arg_32_0)
	local var_32_0 = getProxy(SettingsProxy):GetMainSceneScreenSleepTime()

	arg_32_0.defaultSleepTimeout = Screen.sleepTimeout
	Screen.sleepTimeout = var_32_0

	if SettingsMainScenePanel.IsEnableStandbyMode() then
		arg_32_0.silentChecker:SetUp()
	end
end

function var_0_0.RevertSleepTimeout(arg_33_0)
	if arg_33_0.defaultSleepTimeout and Screen.sleepTimeout ~= arg_33_0.defaultSleepTimeout then
		Screen.sleepTimeout = arg_33_0.defaultSleepTimeout
	end

	arg_33_0.defaultSleepTimeout = nil
end

function var_0_0.FoldPanels(arg_34_0, arg_34_1)
	if not arg_34_0.theme then
		return
	end

	arg_34_0.theme:OnFoldPanels(arg_34_1)
	arg_34_0.paintingView:Fold(arg_34_1, 0.5)
	pg.playerResUI:Fold(arg_34_1, 0.5)
end

function var_0_0.HidePanel(arg_35_0, arg_35_1)
	if not arg_35_0.theme then
		return
	end

	arg_35_0.theme:OnFoldPanels(arg_35_1)
	pg.playerResUI:Fold(arg_35_1, 0.5)
end

function var_0_0.SwitchToNextShip(arg_36_0)
	if arg_36_0.paintingView:IsLoading() or arg_36_0.bgView:IsLoading() or not arg_36_0.theme then
		return
	end

	local var_36_0 = getProxy(PlayerProxy):getRawData():GetNextFlagShip()

	if arg_36_0.bgView.ship.skinId ~= var_36_0.skinId or arg_36_0.bgView.ship.id ~= var_36_0.id then
		arg_36_0.bgView:Refresh(var_36_0)
		arg_36_0:PlayBgm(var_36_0)
		arg_36_0.paintingView:Refresh(var_36_0, arg_36_0.theme:GetPaintingOffset(var_36_0))
		arg_36_0.effectView:Refresh(var_36_0)
		arg_36_0.theme:OnSwitchToNextShip(var_36_0)
	end
end

function var_0_0.UpdateFlagShip(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_0.paintingView:IsLoading() or arg_37_0.bgView:IsLoading() or not arg_37_0.theme then
		return
	end

	local var_37_0 = arg_37_2.callback

	arg_37_0.bgView:Refresh(arg_37_1)
	arg_37_0:PlayBgm(arg_37_1)
	arg_37_0.paintingView:SetOnceLoadedCall(var_37_0)
	arg_37_0.paintingView:Refresh(arg_37_1, arg_37_0.theme:GetPaintingOffset(arg_37_1))
	arg_37_0.effectView:Refresh(arg_37_1)
	arg_37_0.theme:OnSwitchToNextShip(arg_37_1)
end

function var_0_0.PlayChangeSkinActionOut(arg_38_0, arg_38_1)
	arg_38_0.paintingView:PlayChangeSkinActionOut(arg_38_1)
end

function var_0_0.PlayChangeSkinActionIn(arg_39_0, arg_39_1)
	arg_39_0.paintingView:PlayChangeSkinActionIn(arg_39_1)
end

function var_0_0.CheckAndReplayBgm(arg_40_0)
	local var_40_0 = arg_40_0:GetFlagShip()

	arg_40_0.theme:Refresh(var_40_0)
	arg_40_0:PlayBgm(var_40_0)
end

function var_0_0.SetEffectPanelVisible(arg_41_0, arg_41_1)
	if arg_41_0.theme then
		arg_41_0.theme:SetEffectPanelVisible(arg_41_1)
	end
end

function var_0_0.OnVisible(arg_42_0)
	local var_42_0 = arg_42_0.themes[arg_42_0:GetThemeStyle()]

	if not (not arg_42_0.theme or var_42_0 ~= arg_42_0.theme) then
		arg_42_0:Refresh()
	else
		arg_42_0:UnloadTheme()
		arg_42_0:SetUp(true)
	end
end

function var_0_0.Refresh(arg_43_0)
	arg_43_0.mainCG.blocksRaycasts = false

	seriesAsync({
		function(arg_44_0)
			arg_43_0.awakeSequenceView:Execute(arg_44_0)
		end,
		function(arg_45_0)
			arg_43_0.isInit = true

			arg_43_0:ShowOrHideResUI(arg_43_0.theme:ApplyDefaultResUI())

			local var_45_0 = arg_43_0:GetFlagShip()

			arg_43_0.bgView:Refresh(var_45_0)
			arg_43_0.paintingView:Refresh(var_45_0, arg_43_0.theme:GetPaintingOffset(var_45_0))
			arg_43_0.effectView:Refresh(var_45_0)
			arg_43_0.theme:Refresh(var_45_0)
			arg_43_0:PlayBgm(var_45_0)
			pg.redDotHelper:Refresh()
			arg_45_0()
		end,
		function(arg_46_0)
			arg_43_0.sequenceView:Execute(arg_46_0)
		end
	}, function()
		arg_43_0:SetUpSilentChecker()
		arg_43_0:emit(var_0_0.ON_ENTER_DONE)

		arg_43_0.mainCG.blocksRaycasts = true
	end)
end

function var_0_0.OnDisVisible(arg_48_0)
	arg_48_0:FoldPanels(false)
	arg_48_0.paintingView:Disable()
	arg_48_0.bgView:Disable()
	arg_48_0.sequenceView:Disable()
	arg_48_0.awakeSequenceView:Disable()
	arg_48_0.theme:Disable()
	pg.redDotHelper:Disable()
	arg_48_0.buffDescPage:Disable()
	arg_48_0.silentChecker:Disable()

	if arg_48_0.silentView and arg_48_0.silentView:isShowing() then
		arg_48_0:ExitSilentView()
	end

	arg_48_0.calibrationPage:Destroy()
	arg_48_0.calibrationPage:Reset()
	arg_48_0.skinExperienceDisplayPage:Destroy()
	arg_48_0.skinExperienceDisplayPage:Reset()
	arg_48_0.liveAreaPage:Destroy()
	arg_48_0.liveAreaPage:Reset()

	arg_48_0.isInit = false

	arg_48_0:RevertSleepTimeout()
end

function var_0_0.UnloadTheme(arg_49_0)
	if arg_49_0.theme then
		arg_49_0.theme:Destroy()
		arg_49_0.theme:Reset()

		arg_49_0.theme = nil
	end
end

function var_0_0.ExitCalibrationView(arg_50_0)
	if arg_50_0.calibrationPage and arg_50_0.calibrationPage:GetLoaded() and arg_50_0.calibrationPage:isShowing() then
		triggerButton(arg_50_0.calibrationPage.backBtn)
	end
end

function var_0_0.ExitSilentView(arg_51_0)
	if arg_51_0.silentView and arg_51_0.silentView:GetLoaded() and arg_51_0.silentView:isShowing() then
		arg_51_0:FoldPanels(false)
		arg_51_0.silentView:Destroy()
		arg_51_0.silentView:Reset()
	end
end

function var_0_0.GameLogout(arg_52_0)
	arg_52_0:ExitCalibrationView()
	arg_52_0:ExitSilentView()
end

function var_0_0.onBackPressed(arg_53_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if arg_53_0.silentView and arg_53_0.silentView:isShowing() then
		arg_53_0:ExitSilentView()

		return
	end

	if arg_53_0.liveAreaPage and arg_53_0.liveAreaPage:GetLoaded() and arg_53_0.liveAreaPage:isShowing() then
		arg_53_0.liveAreaPage:Hide()

		return
	end

	if arg_53_0.calibrationPage and arg_53_0.calibrationPage:GetLoaded() and arg_53_0.calibrationPage:isShowing() then
		triggerButton(arg_53_0.calibrationPage._parentTf)

		return
	end

	pg.SdkMgr.GetInstance():OnAndoridBackPress()
	pg.PushNotificationMgr.GetInstance():PushAll()
end

function var_0_0.willExit(arg_54_0)
	arg_54_0.bgView:Dispose()

	arg_54_0.bgView = nil

	if arg_54_0.calibrationPage then
		arg_54_0.calibrationPage:Destroy()

		arg_54_0.calibrationPage = nil
	end

	if arg_54_0.silentView then
		arg_54_0.silentView:Destroy()

		arg_54_0.silentView = nil
	end

	arg_54_0.paintingView:Dispose()

	arg_54_0.paintingView = nil

	arg_54_0.liveAreaPage:Destroy()

	arg_54_0.liveAreaPage = nil

	arg_54_0.sequenceView:Dispose()

	arg_54_0.sequenceView = nil

	arg_54_0.awakeSequenceView:Dispose()

	arg_54_0.awakeSequenceView = nil

	arg_54_0.effectView:Dispose()

	arg_54_0.effectView = nil

	pg.redDotHelper:Dispose()

	pg.redDotHelper = nil

	arg_54_0.buffDescPage:Destroy()

	arg_54_0.buffDescPage = nil

	arg_54_0.silentChecker:Dispose()

	arg_54_0.silentChecker = nil

	arg_54_0.skinExperienceDisplayPage:Destroy()

	arg_54_0.skinExperienceDisplayPage = nil

	arg_54_0:UnloadTheme()
	arg_54_0:RevertSleepTimeout()
end

return var_0_0
