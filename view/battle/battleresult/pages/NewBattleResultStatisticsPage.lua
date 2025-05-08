local var_0_0 = class("NewBattleResultStatisticsPage", import("view.base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 0
local var_0_4 = 1

function var_0_0.getUIName(arg_1_0)
	return "NewBattleResultStatisticsPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.mask = arg_2_0:findTF("mask")
	arg_2_0.paintingTr = arg_2_0:findTF("painting")
	arg_2_0.resultPaintingTr = arg_2_0:findTF("result")
	arg_2_0.topPanel = arg_2_0:findTF("top")
	arg_2_0.gradeIcon = arg_2_0:findTF("top/grade/icon"):GetComponent(typeof(Image))
	arg_2_0.gradeTxt = arg_2_0:findTF("top/grade/Text"):GetComponent(typeof(Image))
	arg_2_0.chapterName = arg_2_0:findTF("top/grade/chapterName"):GetComponent(typeof(Text))
	arg_2_0.opBonus = arg_2_0:findTF("top/grade/operation_bonus")
	arg_2_0.playerName = arg_2_0:findTF("top/exp/name"):GetComponent(typeof(Text))
	arg_2_0.playerLv = arg_2_0:findTF("top/exp/lv"):GetComponent(typeof(Text))
	arg_2_0.playerExp = arg_2_0:findTF("top/exp/Text"):GetComponent(typeof(Text))
	arg_2_0.playerExpLabel = arg_2_0:findTF("top/exp/Text/exp_label"):GetComponent(typeof(Text))
	arg_2_0.playerExpBar = arg_2_0:findTF("top/exp/exp_bar/progress"):GetComponent(typeof(Image))
	arg_2_0.commmanderContainer = arg_2_0:findTF("top/exp/commanders")
	arg_2_0.shipContainer = arg_2_0:findTF("left")
	arg_2_0.rawImage = arg_2_0._tf:Find("bg"):GetComponent(typeof(RawImage))

	setActive(arg_2_0.rawImage, false)

	arg_2_0.blackBg = arg_2_0._tf:Find("black")
	arg_2_0.bottomPanel = arg_2_0:findTF("bottom")
	arg_2_0.confrimBtn = arg_2_0:findTF("bottom/confirmBtn")
	arg_2_0.statisticsBtn = arg_2_0:findTF("bottom/statisticsBtn")
	arg_2_0.mainFleetBtn = arg_2_0:findTF("bottom/mainFleetBtn")
	arg_2_0.subFleetBtn = arg_2_0:findTF("bottom/subFleetBtn")
	arg_2_0.chatText = arg_2_0:findTF("chat/Text"):GetComponent(typeof(Text))

	setText(arg_2_0.confrimBtn:Find("Text"), i18n("msgbox_text_confirm"))

	arg_2_0.cg = GetOrAddComponent(arg_2_0._tf, typeof(CanvasGroup))
	arg_2_0.commaderTpls = {}
	arg_2_0.emptyTpls = {
		arg_2_0:findTF("top/exp/emptycomanders/1"),
		arg_2_0:findTF("top/exp/emptycomanders/2")
	}

	setText(arg_2_0.emptyTpls[1]:Find("Text"), i18n("series_enemy_empty_commander_main"))
	setText(arg_2_0.emptyTpls[2]:Find("Text"), i18n("series_enemy_empty_commander_assistant"))

	arg_2_0.surfaceShipTpls = {}
	arg_2_0.subShipTpls = {}
	arg_2_0.animationFlags = {
		[var_0_1] = {
			[var_0_3] = false,
			[var_0_4] = false
		},
		[var_0_2] = {
			[var_0_3] = false,
			[var_0_4] = false
		}
	}
	arg_2_0.animation = NewBattleResultAnimation.New(arg_2_0._tf)
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.teamType = var_0_1
	arg_3_0.displayMode = var_0_3
end

function var_0_0.SetUp(arg_4_0, arg_4_1, arg_4_2)
	seriesAsync({
		function(arg_5_0)
			arg_4_0.cg.alpha = 0

			arg_4_0:UpdatePainting(arg_5_0)
			arg_4_0:UpdateGrade()
			arg_4_0:UpdateChapterName()
			arg_4_0:UpdateSwitchBtn()
			arg_4_0:UpdatePlayer()
		end,
		function(arg_6_0)
			arg_4_0:LoadBG(arg_6_0)
		end,
		function(arg_7_0)
			arg_4_0.cg.alpha = 1

			arg_4_0:PlayEnterAnimation(arg_7_0)
		end,
		function(arg_8_0)
			if arg_4_2 then
				arg_4_2()
			end

			arg_4_0:InitMainView(arg_8_0)
		end
	}, function()
		arg_4_0:UpdateMetaBtn()
		arg_4_0:RegisterEvent(arg_4_1)
	end)
end

function var_0_0.InitMainView(arg_10_0, arg_10_1)
	arg_10_0.isEnter = true

	parallelAsync({
		function(arg_11_0)
			arg_10_0:UpdateCommanders(arg_11_0)
		end,
		function(arg_12_0)
			arg_10_0:StartEnterAnimation(arg_12_0)
		end,
		function(arg_13_0)
			arg_10_0:InitShips(arg_13_0)
		end
	}, arg_10_1)
end

function var_0_0.PlayEnterAnimation(arg_14_0, arg_14_1)
	if not getProxy(SettingsProxy):IsDisplayResultPainting() then
		arg_14_1()

		return
	end

	local var_14_0 = pg.UIMgr.GetInstance().uiCamera.gameObject.transform:Find("Canvas")

	arg_14_0.blackBg.sizeDelta = var_14_0.sizeDelta

	if arg_14_0.effectTr then
		arg_14_0.effectTr.anchorMax = Vector2(0.5, 0.5)
		arg_14_0.effectTr.anchorMin = Vector2(0.5, 0.5)

		local var_14_1 = GameObject.Find("UICamera/Canvas").transform

		arg_14_0.effectTr.sizeDelta = var_14_1.sizeDelta
	end

	setAnchoredPosition(arg_14_0.topPanel, {
		y = 320
	})
	setAnchoredPosition(arg_14_0.bottomPanel, {
		y = -320
	})

	local var_14_2 = arg_14_0:GetPaintingPosition()

	arg_14_0.mask.localPosition = var_14_2

	if arg_14_0.animation then
		arg_14_0.animation:Play(arg_14_0.resultPaintingData, arg_14_1)
	end
end

function var_0_0.LoadBG(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._parentTf:Find("Effect")

	if not IsNil(var_15_0) then
		setParent(var_15_0, arg_15_0._tf)
		var_15_0:SetSiblingIndex(2)

		arg_15_0.effectTr = var_15_0

		arg_15_1()
	else
		local var_15_1 = NewBattleResultUtil.Score2Bg(arg_15_0.contextData.score)

		LoadAnyAsync("BattleResultItems/" .. var_15_1, "", nil, function(arg_16_0)
			if arg_15_0.exited or IsNil(arg_16_0) then
				if arg_15_1 then
					arg_15_1()
				end

				return
			end

			local var_16_0 = Object.Instantiate(arg_16_0, arg_15_0._tf)

			var_16_0.transform:SetSiblingIndex(2)

			arg_15_0.effectTr = var_16_0.transform

			if arg_15_1 then
				arg_15_1()
			end
		end)
	end
end

function var_0_0.RegisterEvent(arg_17_0, arg_17_1)
	onButton(arg_17_0, arg_17_0.mainFleetBtn, function()
		arg_17_0.teamType = var_0_1

		arg_17_0:UpdateShips(false)
		arg_17_0:UpdateCommanders(function()
			return
		end)
		arg_17_0:UpdateSwitchBtn()
	end, SFX_PANEL)
	onButton(arg_17_0, arg_17_0.subFleetBtn, function()
		arg_17_0.teamType = var_0_2

		arg_17_0:UpdateShips(false)
		arg_17_0:UpdateCommanders(function()
			return
		end)
		arg_17_0:UpdateSwitchBtn()
	end, SFX_PANEL)
	onButton(arg_17_0, arg_17_0.statisticsBtn, function()
		arg_17_0.displayMode = 1 - arg_17_0.displayMode

		arg_17_0:UpdateShipDetail()
	end, SFX_PANEL)
	onButton(arg_17_0, arg_17_0.confrimBtn, function()
		arg_17_1()
	end, SFX_PANEL)

	if arg_17_0.contextData.autoSkipFlag then
		onNextTick(function()
			triggerButton(arg_17_0.confrimBtn)
		end)
	end
end

local function var_0_5(arg_25_0, arg_25_1)
	onButton(arg_25_0, arg_25_1, function()
		setActive(arg_25_1, false)

		if arg_25_0.metaExpView then
			return
		end

		arg_25_0.metaExpView = BattleResultMetaExpView.New(arg_25_0._tf, arg_25_0.event, arg_25_0.contextData)

		local var_26_0 = getProxy(MetaCharacterProxy):getLastMetaSkillExpInfoList()

		arg_25_0.metaExpView:setData(var_26_0, function()
			if arg_25_1 then
				setActive(arg_25_1, true)
			end

			arg_25_0.metaExpView = nil
		end)
		arg_25_0.metaExpView:Reset()
		arg_25_0.metaExpView:Load()
		arg_25_0.metaExpView:ActionInvoke("Show")
		arg_25_0.metaExpView:ActionInvoke("openPanel")
	end, SFX_PANEL)
end

function var_0_0.UpdateMetaBtn(arg_28_0)
	local var_28_0 = getProxy(MetaCharacterProxy):getLastMetaSkillExpInfoList()

	if var_28_0 and #var_28_0 > 0 then
		LoadAnyAsync("BattleResultItems/MetaBtn", "", nil, function(arg_29_0)
			if arg_28_0.exited or IsNil(arg_29_0) then
				return
			end

			local var_29_0 = Object.Instantiate(arg_29_0, arg_28_0._tf)

			var_0_5(arg_28_0, var_29_0.transform)
		end)
	end
end

function var_0_0.StartEnterAnimation(arg_30_0, arg_30_1)
	LeanTween.value(arg_30_0.topPanel.gameObject, 320, 0, 0.2):setOnUpdate(System.Action_float(function(arg_31_0)
		setAnchoredPosition(arg_30_0.topPanel, {
			y = arg_31_0
		})
	end))
	LeanTween.value(arg_30_0.bottomPanel.gameObject, -320, 0, 0.2):setOnUpdate(System.Action_float(function(arg_32_0)
		setAnchoredPosition(arg_30_0.bottomPanel, {
			y = arg_32_0
		})
	end)):setOnComplete(System.Action(arg_30_1))
end

function var_0_0.GetShipSlotExpandPosition(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:GetShipSlotShrinkPosition(arg_33_1)

	return Vector2(1300, var_33_0.y)
end

function var_0_0.GetShipSlotShrinkPosition(arg_34_0, arg_34_1)
	return Vector2(500, 250) + (arg_34_1 - 1) * Vector2(69.55, -117.7)
end

local function var_0_6(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = ""
	local var_35_1 = arg_35_0 and arg_35_0[arg_35_2]

	if arg_35_1 or var_35_1 then
		var_35_0 = arg_35_1 and arg_35_1:getConfig("name") or var_35_1 and i18n("Word_Ship_Exp_Buff")
	end

	return var_35_0
end

function var_0_0.GetAnimationFlag(arg_36_0)
	if arg_36_0.contextData.autoSkipFlag then
		return false
	end

	local var_36_0 = arg_36_0.animationFlags[arg_36_0.teamType][arg_36_0.displayMode]

	if var_36_0 == false then
		arg_36_0.animationFlags[arg_36_0.teamType][arg_36_0.displayMode] = true
	end

	return not var_36_0
end

function var_0_0.UpdateShipDetail(arg_37_0)
	local var_37_0 = arg_37_0.teamType == var_0_1
	local var_37_1 = var_37_0 and arg_37_0.surfaceShipTpls or arg_37_0.subShipTpls
	local var_37_2, var_37_3 = NewBattleResultUtil.SeparateSurfaceAndSubShips(arg_37_0.contextData.oldMainShips)
	local var_37_4 = var_37_0 and var_37_2 or var_37_3
	local var_37_5 = arg_37_0.displayMode == var_0_3
	local var_37_6 = arg_37_0.contextData.expBuff
	local var_37_7 = arg_37_0.contextData.buffShips
	local var_37_8 = NewBattleResultUtil.GetMaxOutput(arg_37_0.contextData.oldMainShips, arg_37_0.contextData.statistics)

	arg_37_0.numeberAnimations = {}

	local var_37_9 = arg_37_0:GetAnimationFlag()

	for iter_37_0, iter_37_1 in ipairs(var_37_4) do
		local var_37_10 = arg_37_0.contextData.statistics[iter_37_1.id] or {}
		local var_37_11 = var_37_1[iter_37_0]
		local var_37_12 = arg_37_0.contextData.newMainShips[iter_37_1.id]

		local function var_37_13()
			setText(var_37_11:Find("atk"), not var_37_5 and (var_37_10.output or 0) or "EXP" .. "<color=#FFDE38>+" .. NewBattleResultUtil.GetShipExpOffset(iter_37_1, var_37_12) .. "</color>")
			setText(var_37_11:Find("killCount"), not var_37_5 and (var_37_10.kill_count or 0) or "Lv." .. var_37_12.level)

			var_37_11:Find("dmg/bar"):GetComponent(typeof(Image)).fillAmount = not var_37_5 and (var_37_10.output or 0) / var_37_8 or var_37_12:getExp() / getExpByRarityFromLv1(var_37_12:getConfig("rarity"), var_37_12.level)
		end

		if var_37_9 then
			local var_37_14 = NewBattleResultShipCardAnimation.New(var_37_11, var_37_5, iter_37_1, var_37_12, var_37_10, var_37_8)

			var_37_14:SetUp(var_37_13)
			table.insert(arg_37_0.numeberAnimations, var_37_14)
		else
			var_37_13()
		end

		setText(var_37_11:Find("kill_count_label"), not var_37_5 and i18n("battle_result_kill_count") or iter_37_1:getName())
		setText(var_37_11:Find("dmg_count_label"), not var_37_5 and i18n("battle_result_dmg") or var_0_6(var_37_7, var_37_6, iter_37_1:getGroupId()) or "")
	end
end

local function var_0_7(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_1:Find("MVP")

	if IsNil(var_39_0) then
		LoadAnyAsync("BattleResultItems/MVP", "", nil, function(arg_40_0)
			if arg_39_0.exited or IsNil(arg_40_0) then
				return
			end

			Object.Instantiate(arg_40_0, arg_39_1).name = "MVP"
		end)
	end

	local var_39_1 = arg_39_1:Find("MVPBG")

	if IsNil(var_39_1) then
		LoadAnyAsync("BattleResultItems/MVPBG", "", nil, function(arg_41_0)
			if arg_39_0.exited or IsNil(arg_41_0) then
				return
			end

			local var_41_0 = Object.Instantiate(arg_41_0, arg_39_1)

			var_41_0.name = "MVPBG"

			var_41_0.transform:SetAsFirstSibling()
		end)
	end
end

local function var_0_8(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1:Find("LevelUp")

	if IsNil(var_42_0) then
		LoadAnyAsync("BattleResultItems/LevelUp", "", nil, function(arg_43_0)
			if arg_42_0.exited or IsNil(arg_43_0) then
				return
			end

			Object.Instantiate(arg_43_0, arg_42_1).name = "LevelUp"
		end)
	end
end

local function var_0_9(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1:Find("Intmacy")

	if IsNil(var_44_0) then
		ResourceMgr.Inst:getAssetAsync("ui/zhandoujiesuan_xingxing", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_45_0)
			if arg_44_0.exited or IsNil(arg_45_0) then
				return
			end

			Object.Instantiate(arg_45_0, arg_44_1).name = "Intmacy"
		end), true, true)
	end
end

local function var_0_10(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	local var_46_0 = arg_46_1:Find("mask/icon"):GetComponent(typeof(Image))

	var_46_0.sprite = LoadSprite("herohrzicon/" .. arg_46_2:getPainting())
	var_46_0.gameObject.transform.sizeDelta = Vector2(432, 96)

	setImageSprite(arg_46_1:Find("type"), GetSpriteFromAtlas("shiptype", shipType2print(arg_46_2:getShipType())), true)

	local var_46_1 = arg_46_2:getStar()
	local var_46_2 = arg_46_2:getMaxStar()
	local var_46_3 = UIItemList.New(arg_46_1:Find("stars"), arg_46_1:Find("stars/star_tpl"))
	local var_46_4 = var_46_2 - var_46_1

	var_46_3:make(function(arg_47_0, arg_47_1, arg_47_2)
		if arg_47_0 == UIItemList.EventUpdate then
			local var_47_0 = arg_47_1 + 1 <= var_46_4

			SetActive(arg_47_2:Find("empty"), var_47_0)
			SetActive(arg_47_2:Find("star"), not var_47_0)
		end
	end)
	var_46_3:align(var_46_2)

	if arg_46_3 then
		var_0_7(arg_46_0, arg_46_1)
	end

	if arg_46_4 then
		var_0_8(arg_46_0, arg_46_1)
	end

	if arg_46_5 then
		onDelayTick(function()
			if arg_46_0.exited then
				return
			end

			var_0_9(arg_46_0, arg_46_1)
		end, 1)
	end
end

function var_0_0.InitShips(arg_49_0, arg_49_1)
	arg_49_0:UpdateShips(true, arg_49_1)
end

function var_0_0.UpdateShips(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = arg_50_0.teamType == var_0_1 and arg_50_0.surfaceShipTpls or arg_50_0.subShipTpls
	local var_50_1 = arg_50_0.teamType == var_0_1 and arg_50_0.subShipTpls or arg_50_0.surfaceShipTpls
	local var_50_2, var_50_3 = NewBattleResultUtil.SeparateSurfaceAndSubShips(arg_50_0.contextData.oldMainShips)
	local var_50_4 = arg_50_0.teamType == var_0_1 and var_50_2 or var_50_3

	local function var_50_5()
		for iter_51_0, iter_51_1 in ipairs(var_50_4) do
			local var_51_0 = var_50_0[iter_51_0]

			var_51_0:GetComponent(typeof(CanvasGroup)).alpha = 1
			var_51_0.anchoredPosition = arg_50_0:GetShipSlotExpandPosition(iter_51_0)

			local var_51_1 = arg_50_0.contextData.newMainShips[iter_51_1.id]

			var_0_10(arg_50_0, var_51_0, iter_51_1, arg_50_0.contextData.statistics.mvpShipID and arg_50_0.contextData.statistics.mvpShipID == iter_51_1.id, var_51_1.level > iter_51_1.level, var_51_1:getIntimacy() > iter_51_1:getIntimacy())
		end

		arg_50_0:UpdateShipDetail()
		arg_50_0:StartShipsEnterAnimation(var_50_0, arg_50_1 and 0.6 or 0, arg_50_2)
	end

	arg_50_0:LoadShipTpls(var_50_0, var_50_4, var_50_5)

	for iter_50_0, iter_50_1 in ipairs(var_50_1) do
		iter_50_1:GetComponent(typeof(CanvasGroup)).alpha = 0
	end
end

function var_0_0.LoadShipTpls(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	local var_52_0 = {}

	if #arg_52_1 < #arg_52_2 then
		table.insert(var_52_0, function(arg_53_0)
			LoadAnyAsync("BattleResultItems/Ship", "", nil, function(arg_54_0)
				if arg_52_0.exited then
					arg_53_0()

					return
				end

				arg_53_0(arg_54_0)
			end)
		end)
		table.insert(var_52_0, function(arg_55_0, arg_55_1)
			if not arg_55_1 then
				arg_55_0()

				return
			end

			for iter_55_0 = #arg_52_1 + 1, #arg_52_2 do
				local var_55_0 = Object.Instantiate(arg_55_1, arg_52_0.shipContainer).transform

				var_55_0:GetComponent(typeof(CanvasGroup)).alpha = 0

				table.insert(arg_52_1, var_55_0)
			end

			arg_55_0()
		end)
	end

	seriesAsync(var_52_0, arg_52_3)
end

function var_0_0.StartShipsEnterAnimation(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	if arg_56_2 <= 0 then
		for iter_56_0, iter_56_1 in ipairs(arg_56_1) do
			iter_56_1.anchoredPosition = arg_56_0:GetShipSlotShrinkPosition(iter_56_0)
		end

		return
	end

	local var_56_0 = {}

	for iter_56_2, iter_56_3 in ipairs(arg_56_1) do
		local var_56_1 = iter_56_3:GetComponent(typeof(CanvasGroup))

		var_56_1.alpha = 0

		local var_56_2 = arg_56_0:GetShipSlotExpandPosition(iter_56_2)
		local var_56_3 = arg_56_0:GetShipSlotShrinkPosition(iter_56_2)

		table.insert(var_56_0, function(arg_57_0)
			if arg_56_0.exited then
				return
			end

			var_56_1.alpha = 1

			LeanTween.value(iter_56_3.gameObject, var_56_2.x, var_56_3.x, arg_56_2 - (iter_56_2 - 1) * 0.1):setOnUpdate(System.Action_float(function(arg_58_0)
				iter_56_3.anchoredPosition = Vector3(arg_58_0, iter_56_3.anchoredPosition.y, 0)
			end))
			onDelayTick(arg_57_0, 0.1)
		end)
	end

	seriesAsync(var_56_0, arg_56_3)
end

function var_0_0.UpdateSwitchBtn(arg_59_0)
	local var_59_0 = NewBattleResultUtil.HasSubShip(arg_59_0.contextData.oldMainShips)
	local var_59_1 = NewBattleResultUtil.HasSurfaceShip(arg_59_0.contextData.oldMainShips)

	setActive(arg_59_0.mainFleetBtn, arg_59_0.teamType == var_0_2 and var_59_1 and var_59_0)
	setActive(arg_59_0.subFleetBtn, arg_59_0.teamType == var_0_1 and var_59_1 and var_59_0)

	if not var_59_1 then
		arg_59_0.teamType = var_0_2
	end
end

function var_0_0.UpdateMvpPainting(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0.contextData.oldMainShips
	local var_60_1, var_60_2, var_60_3, var_60_4 = NewBattleResultUtil.SeparateMvpShip(var_60_0, arg_60_0.contextData.statistics.mvpShipID, arg_60_0.contextData.statistics._flagShipID)

	var_60_4 = var_60_4 or var_60_0[#var_60_0 - 1]

	local var_60_5 = arg_60_0.resultPaintingTr
	local var_60_6 = var_60_4:getPainting()

	setPaintingPrefabAsync(var_60_5, var_60_6, "jiesuan", function()
		ShipExpressionHelper.SetExpression(findTF(var_60_5, "fitter"):GetChild(0), var_60_6, ShipWordHelper.WORD_TYPE_MVP, var_60_4:getCVIntimacy())
		arg_60_0:RecordPainting(arg_60_1)
	end)
	arg_60_0:DisplayShipDialogue(var_60_4)
end

function var_0_0.RecordPainting(arg_62_0, arg_62_1)
	onNextTick(function()
		local var_63_0 = arg_62_0.resultPaintingTr:Find("fitter"):GetChild(0)

		if not IsNil(var_63_0) then
			arg_62_0.resultPaintingData = {
				position = Vector2(var_63_0.position.x, var_63_0.position.y),
				pivot = rtf(var_63_0).pivot,
				scale = Vector2(var_63_0.localScale.x, var_63_0.localScale.y)
			}

			SetParent(var_63_0, arg_62_0.paintingTr:Find("painting/fitter"), true)
		end

		arg_62_1()
	end)
end

function var_0_0.UpdateFailedPainting(arg_64_0, arg_64_1)
	local var_64_0 = arg_64_0.contextData.oldMainShips

	LoadAnyAsync("BattleResultItems/FailedPainting", "", nil, function(arg_65_0)
		if arg_64_0.exited or IsNil(arg_65_0) then
			arg_64_1()

			return
		end

		Object.Instantiate(arg_65_0, arg_64_0.paintingTr).transform:SetAsFirstSibling()
		arg_64_1()
	end)
	arg_64_0:DisplayShipDialogue(var_64_0[math.random(#var_64_0)])
end

function var_0_0.GetPaintingPosition(arg_66_0)
	local var_66_0 = arg_66_0.contextData.oldMainShips

	return (NewBattleResultDisplayPaintingsPage.StaticGetFinalExpandPosition(#var_66_0))
end

function var_0_0.UpdatePaintingPosition(arg_67_0)
	local var_67_0 = arg_67_0:GetPaintingPosition()

	arg_67_0.paintingTr.localPosition = var_67_0
end

function var_0_0.UpdatePainting(arg_68_0, arg_68_1)
	arg_68_0:UpdatePaintingPosition()

	if arg_68_0.contextData.score > 1 then
		arg_68_0:UpdateMvpPainting(arg_68_1)
	else
		arg_68_0:UpdateFailedPainting(arg_68_1)
	end
end

function var_0_0.DisplayShipDialogue(arg_69_0, arg_69_1)
	local var_69_0
	local var_69_1
	local var_69_2

	if arg_69_0.contextData.score > 1 then
		local var_69_3, var_69_4

		var_69_3, var_69_4, var_69_1 = ShipWordHelper.GetWordAndCV(arg_69_1.skinId, ShipWordHelper.WORD_TYPE_MVP, nil, nil, arg_69_1:getCVIntimacy())
	else
		local var_69_5, var_69_6

		var_69_5, var_69_6, var_69_1 = ShipWordHelper.GetWordAndCV(arg_69_1.skinId, ShipWordHelper.WORD_TYPE_LOSE, nil, nil, arg_69_1:getCVIntimacy())
	end

	arg_69_0.chatText.text = var_69_1
	arg_69_0.chatText.alignment = #var_69_1 > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

	arg_69_0:PlayMvpShipVoice()
end

function var_0_0.PlayMvpShipVoice(arg_70_0)
	if not arg_70_0.contextData.statistics.mvpShipID or type(arg_70_0.contextData.statistics.mvpShipID) == "number" and arg_70_0.contextData.statistics.mvpShipID <= 0 then
		return
	end

	local var_70_0 = _.detect(arg_70_0.contextData.oldMainShips, function(arg_71_0)
		return arg_71_0.id == arg_70_0.contextData.statistics.mvpShipID
	end)

	assert(var_70_0)

	local var_70_1
	local var_70_2
	local var_70_3

	if arg_70_0.contextData.score > 1 then
		local var_70_4, var_70_5

		var_70_4, var_70_3, var_70_5 = ShipWordHelper.GetWordAndCV(var_70_0.skinId, ShipWordHelper.WORD_TYPE_MVP, nil, nil, var_70_0:getCVIntimacy())
	else
		local var_70_6, var_70_7

		var_70_6, var_70_3, var_70_7 = ShipWordHelper.GetWordAndCV(var_70_0.skinId, ShipWordHelper.WORD_TYPE_LOSE)
	end

	if var_70_3 then
		arg_70_0:StopVoice()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_70_3, function(arg_72_0)
			arg_70_0._currentVoice = arg_72_0
		end)
	end
end

function var_0_0.StopVoice(arg_73_0)
	if arg_73_0._currentVoice then
		arg_73_0._currentVoice:PlaybackStop()

		arg_73_0._currentVoice = nil
	end
end

function var_0_0.UpdateGrade(arg_74_0)
	local var_74_0, var_74_1 = NewBattleResultUtil.Score2Grade(arg_74_0.contextData.score, arg_74_0.contextData._scoreMark)

	LoadImageSpriteAsync(var_74_0, arg_74_0.gradeIcon, false)
	LoadImageSpriteAsync(var_74_1, arg_74_0.gradeTxt, false)
end

function var_0_0.UpdateChapterName(arg_75_0)
	local var_75_0 = NewBattleResultUtil.GetChapterName(arg_75_0.contextData)

	arg_75_0.chapterName.text = var_75_0

	setActive(arg_75_0.opBonus, NewBattleResultUtil.IsOpBonus(arg_75_0.contextData.extraBuffList))
end

function var_0_0.UpdatePlayer(arg_76_0)
	local var_76_0 = arg_76_0.contextData.oldPlayer
	local var_76_1 = getProxy(PlayerProxy):getRawData()

	arg_76_0.playerName.text = var_76_1:GetName()

	local function var_76_2()
		arg_76_0.playerLv.text = "Lv." .. var_76_1.level

		local var_77_0 = NewBattleResultUtil.GetPlayerExpOffset(var_76_0, var_76_1)

		arg_76_0.playerExp.text = "+" .. var_77_0
		arg_76_0.playerExpLabel.text = "EXP"
		arg_76_0.playerExpBar.fillAmount = var_76_1.level == var_76_1:getMaxLevel() and 1 or var_76_1.exp / getConfigFromLevel1(pg.user_level, var_76_1.level).exp_interval
	end

	if not arg_76_0.contextData.autoSkipFlag then
		local var_76_3 = NewBattleResultPlayerAniamtion.New(arg_76_0.playerLv, arg_76_0.playerExp, arg_76_0.playerExpBar, var_76_1, var_76_0)

		var_76_3:SetUp(var_76_2)

		arg_76_0.playerAniamtion = var_76_3
	else
		var_76_2()
	end
end

local function var_0_11(arg_78_0, arg_78_1, arg_78_2)
	GetImageSpriteFromAtlasAsync("commandericon/" .. arg_78_2:getPainting(), "", arg_78_0:Find("icon"))
	setText(arg_78_0:Find("name_text"), arg_78_2:getName())
	setText(arg_78_0:Find("lv_text"), "Lv." .. arg_78_2.level)
	setText(arg_78_0:Find("exp"), "+" .. arg_78_1.exp)

	local var_78_0 = arg_78_2:isMaxLevel() and 1 or arg_78_1.curExp / arg_78_2:getNextLevelExp()

	arg_78_0:Find("exp_bar/progress"):GetComponent(typeof(Image)).fillAmount = var_78_0
end

function var_0_0.UpdateCommanders(arg_79_0, arg_79_1)
	local var_79_0 = arg_79_0.teamType
	local var_79_1 = arg_79_0.contextData.commanderExps or {}
	local var_79_2 = var_79_0 == var_0_1 and var_79_1.surfaceCMD or var_79_1.submarineCMD

	var_79_2 = var_79_2 or {}

	local function var_79_3()
		for iter_80_0 = 1, #var_79_2 do
			local var_80_0 = getProxy(CommanderProxy):getCommanderById(var_79_2[iter_80_0].commander_id)

			setActive(arg_79_0.commaderTpls[iter_80_0], true)
			var_0_11(arg_79_0.commaderTpls[iter_80_0], var_79_2[iter_80_0], var_80_0)
		end

		for iter_80_1 = #arg_79_0.commaderTpls, #var_79_2 + 1, -1 do
			setActive(arg_79_0.commaderTpls[iter_80_1], false)
		end
	end

	for iter_79_0 = 1, #arg_79_0.emptyTpls do
		setActive(arg_79_0.emptyTpls[iter_79_0], var_79_2[iter_79_0] == nil)
	end

	arg_79_0:LoadCommanderTpls(#var_79_2, var_79_3)
	arg_79_1()
end

function var_0_0.LoadCommanderTpls(arg_81_0, arg_81_1, arg_81_2)
	local var_81_0 = {}

	if arg_81_1 > #arg_81_0.commaderTpls then
		table.insert(var_81_0, function(arg_82_0)
			LoadAnyAsync("BattleResultItems/Commander", "", nil, function(arg_83_0)
				if arg_81_0.exited then
					arg_82_0()

					return
				end

				arg_82_0(arg_83_0)
			end)
		end)
		table.insert(var_81_0, function(arg_84_0, arg_84_1)
			if not arg_84_1 then
				arg_84_0()

				return
			end

			for iter_84_0 = #arg_81_0.commaderTpls + 1, arg_81_1 do
				table.insert(arg_81_0.commaderTpls, Object.Instantiate(arg_84_1, arg_81_0.commmanderContainer).transform)
			end

			arg_84_0()
		end)
	end

	seriesAsync(var_81_0, arg_81_2)
end

function var_0_0.onBackPressed(arg_85_0)
	if arg_85_0.metaExpView then
		arg_85_0.metaExpView:closePanel()

		arg_85_0.metaExpView = nil

		return true
	end

	return false
end

function var_0_0.OnDestroy(arg_86_0)
	arg_86_0.exited = true

	if arg_86_0.metaExpView then
		arg_86_0.metaExpView:Destroy()

		arg_86_0.metaExpView = nil
	end

	if arg_86_0:isShowing() then
		arg_86_0:Hide()
	end

	if arg_86_0.animation then
		arg_86_0.animation:Dispose()
	end

	arg_86_0.animation = nil

	if LeanTween.isTweening(arg_86_0.topPanel.gameObject) then
		LeanTween.cancel(arg_86_0.topPanel.gameObject)
	end

	if LeanTween.isTweening(arg_86_0.bottomPanel.gameObject) then
		LeanTween.cancel(arg_86_0.bottomPanel.gameObject)
	end

	if arg_86_0.surfaceShipTpls then
		for iter_86_0, iter_86_1 in ipairs(arg_86_0.surfaceShipTpls) do
			if LeanTween.isTweening(iter_86_1.gameObject) then
				LeanTween.cancel(iter_86_1.gameObject)
			end
		end
	end

	if arg_86_0.subShipTpls then
		for iter_86_2, iter_86_3 in ipairs(arg_86_0.subShipTpls) do
			if LeanTween.isTweening(iter_86_3.gameObject) then
				LeanTween.cancel(iter_86_3.gameObject)
			end
		end
	end

	if arg_86_0.numeberAnimations then
		for iter_86_4, iter_86_5 in ipairs(arg_86_0.numeberAnimations) do
			iter_86_5:Dispose()
		end
	end

	if arg_86_0.playerAniamtion then
		arg_86_0.playerAniamtion:Dispose()

		arg_86_0.playerAniamtion = nil
	end
end

return var_0_0
