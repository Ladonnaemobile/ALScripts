local var_0_0 = class("ShipProfileScene", import("...base.BaseUI"))

var_0_0.SHOW_SKILL_INFO = "event show skill info"
var_0_0.SHOW_EVALUATION = "event show evalution"
var_0_0.WEDDING_REVIEW = "event wedding review"
var_0_0.INDEX_DETAIL = 1
var_0_0.INDEX_PROFILE = 2
var_0_0.CHAT_ANIMATION_TIME = 0.3
var_0_0.CHAT_SHOW_TIME = 3

local var_0_1 = 0.35

function var_0_0.getUIName(arg_1_0)
	return "ShipProfileUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(CollectionProxy):getShipGroup(arg_2_0.contextData.groupId)

	LoadSpriteAtlasAsync("bg/star_level_bg_" .. var_2_0:rarity2bgPrintForGet(arg_2_0.showTrans), "", arg_2_1)
end

function var_0_0.setShipGroup(arg_3_0, arg_3_1)
	arg_3_0.shipGroup = arg_3_1
	arg_3_0.groupSkinList = ShipGroup.GetDisplayableSkinList(arg_3_1.id)
	arg_3_0.isBluePrintGroup = arg_3_0.shipGroup:isBluePrintGroup()
	arg_3_0.isMetaGroup = arg_3_0.shipGroup:isMetaGroup()
end

function var_0_0.setShowTrans(arg_4_0, arg_4_1)
	arg_4_0.showTrans = arg_4_1
end

function var_0_0.setOwnedSkinList(arg_5_0, arg_5_1)
	arg_5_0.ownedSkinList = arg_5_1
end

function var_0_0.init(arg_6_0)
	arg_6_0.bg = arg_6_0:findTF("bg")
	arg_6_0.staticBg = arg_6_0.bg:Find("static_bg")
	arg_6_0.painting = arg_6_0:findTF("paint")
	arg_6_0.paintingFitter = findTF(arg_6_0.painting, "fitter")
	arg_6_0.paintingInitPos = arg_6_0.painting.transform.localPosition
	arg_6_0.chatTF = arg_6_0:findTF("paint/chat")

	setActive(arg_6_0.chatTF, false)

	arg_6_0.commonPainting = arg_6_0.painting:Find("fitter")
	arg_6_0.l2dRoot = arg_6_0:findTF("live2d", arg_6_0.painting)
	arg_6_0.spinePaintingRoot = arg_6_0:findTF("spinePainting", arg_6_0.painting)
	arg_6_0.spinePaintingBgRoot = arg_6_0:findTF("paintBg/spinePainting")
	arg_6_0.chatBg = arg_6_0:findTF("chatbgtop", arg_6_0.chatTF)
	arg_6_0.initChatBgH = arg_6_0.chatBg.sizeDelta.y
	arg_6_0.chatText = arg_6_0:findTF("Text", arg_6_0.chatBg)
	arg_6_0.name = arg_6_0:findTF("name")
	arg_6_0.nameInitPos = arg_6_0.name.transform.localPosition
	arg_6_0.shipType = arg_6_0:findTF("type", arg_6_0.name)
	arg_6_0.labelName = arg_6_0:findTF("name_mask/Text", arg_6_0.name):GetComponent(typeof(Text))
	arg_6_0.labelEnName = arg_6_0:findTF("english_name", arg_6_0.name):GetComponent(typeof(Text))
	arg_6_0.stars = arg_6_0:findTF("stars", arg_6_0.name)
	arg_6_0.star = arg_6_0:getTpl("star_tpl", arg_6_0.stars)
	arg_6_0.blurPanel = arg_6_0:findTF("blur_panel")
	arg_6_0.top = arg_6_0:findTF("blur_panel/adapt/top")
	arg_6_0.btnBack = arg_6_0:findTF("back", arg_6_0.top)
	arg_6_0.bottomTF = arg_6_0:findTF("bottom")
	arg_6_0.labelHeart = arg_6_0:findTF("adapt/detail_left_panel/heart/label", arg_6_0.blurPanel)
	arg_6_0.btnLike = arg_6_0:findTF("adapt/detail_left_panel/heart/btnLike", arg_6_0.blurPanel)
	arg_6_0.btnChangeSkin = arg_6_0:findTF("adapt/detail_left_panel/change_skin", arg_6_0.blurPanel)
	arg_6_0.changeSkinToggle = ChangeSkinToggle.New(findTF(arg_6_0.btnChangeSkin, "toggle_ui"))
	arg_6_0.btnLikeAct = arg_6_0.btnLike:Find("like")
	arg_6_0.btnLikeDisact = arg_6_0.btnLike:Find("unlike")
	arg_6_0.obtainBtn = arg_6_0:findTF("bottom/others/obtain_btn")
	arg_6_0.evaBtn = arg_6_0:findTF("bottom/others/eva_btn")
	arg_6_0.viewBtn = arg_6_0:findTF("bottom/others/view_btn")
	arg_6_0.shareBtn = arg_6_0:findTF("bottom/others/share_btn")
	arg_6_0.rotateBtn = arg_6_0:findTF("bottom/others/rotate_btn")
	arg_6_0.cryptolaliaBtn = arg_6_0:findTF("bottom/others/cryptolalia_btn")
	arg_6_0.equipCodeBtn = arg_6_0:findTF("bottom/others/equip_code_btn")
	arg_6_0.leftProfile = arg_6_0:findTF("adapt/profile_left_panel", arg_6_0.blurPanel)
	arg_6_0.modelContainer = arg_6_0:findTF("model", arg_6_0.leftProfile)
	arg_6_0.live2DBtn = ShipProfileLive2dBtn.New(arg_6_0:findTF("L2D_btn", arg_6_0.blurPanel))

	GetComponent(arg_6_0:findTF("L2D_btn", arg_6_0.blurPanel), typeof(Image)):SetNativeSize()
	GetComponent(arg_6_0:findTF("L2D_btn/img", arg_6_0.blurPanel), typeof(Image)):SetNativeSize()

	arg_6_0.spinePaintingBtn = arg_6_0:findTF("SP_btn", arg_6_0.blurPanel)

	GetComponent(arg_6_0.spinePaintingBtn, typeof(Image)):SetNativeSize()
	GetComponent(arg_6_0:findTF("SP_btn/img", arg_6_0.blurPanel), typeof(Image)):SetNativeSize()
	GetComponent(arg_6_0:findTF("adapt/top/title", arg_6_0.blurPanel), typeof(Image)):SetNativeSize()

	arg_6_0.spinePaintingToggle = arg_6_0.spinePaintingBtn:Find("toggle")
	arg_6_0.cvLoader = ShipProfileCVLoader.New()
	arg_6_0.pageTFs = arg_6_0:findTF("pages")
	arg_6_0.paintingView = ShipProfilePaintingView.New(arg_6_0._tf, arg_6_0.painting)
	arg_6_0.toggles = {
		arg_6_0:findTF("bottom/detail"),
		arg_6_0:findTF("bottom/profile")
	}

	local var_6_0 = ShipProfileInformationPage.New(arg_6_0.pageTFs, arg_6_0.event)
	local var_6_1 = ShipProfileDetailPage.New(arg_6_0.pageTFs, arg_6_0.event)

	var_6_0:SetCvLoader(arg_6_0.cvLoader)
	var_6_0:SetCallback(function(arg_7_0)
		arg_6_0:OnCVBtnClick(arg_7_0)
	end)

	arg_6_0.pages = {
		var_6_1,
		var_6_0
	}
	arg_6_0.UISkinList = UIItemList.New(arg_6_0.leftProfile:Find("scroll/Viewport/skin_container"), arg_6_0.leftProfile:Find("scroll/Viewport/skin_container/skin_tpl"))
end

function var_0_0.didEnter(arg_8_0)
	onButton(arg_8_0, arg_8_0.btnBack, function()
		arg_8_0:emit(var_0_0.ON_BACK)
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.equipCodeBtn, function()
		arg_8_0:emit(ShipProfileMediator.OPEN_EQUIP_CODE_SHARE, arg_8_0.shipGroup.id)
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.cryptolaliaBtn, function()
		arg_8_0:emit(ShipProfileMediator.OPEN_CRYPTOLALIA, arg_8_0.shipGroup.id)
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.obtainBtn, function()
		local var_12_0 = {
			type = MSGBOX_TYPE_OBTAIN,
			shipId = arg_8_0.shipGroup:getShipConfigId(),
			list = arg_8_0.shipGroup.groupConfig.description,
			mediatorName = ShipProfileMediator.__cname
		}

		pg.MsgboxMgr.GetInstance():ShowMsgBox(var_12_0)
	end)
	onButton(arg_8_0, arg_8_0.evaBtn, function()
		arg_8_0:emit(var_0_0.SHOW_EVALUATION, arg_8_0.shipGroup.id)
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.viewBtn, function()
		if LeanTween.isTweening(arg_8_0.chatTF.gameObject) then
			LeanTween.cancel(arg_8_0.chatTF.gameObject)

			arg_8_0.chatTF.localScale = Vector3(0, 0, 0)

			if arg_8_0.dailogueCallback then
				arg_8_0.dailogueCallback()

				arg_8_0.dailogueCallback = nil
			end
		end

		arg_8_0.paintingView:Start()
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeShipProfile)
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.rotateBtn, function()
		setActive(arg_8_0._tf, false)
		arg_8_0:emit(ShipProfileMediator.CLICK_ROTATE_BTN, arg_8_0.shipGroup, arg_8_0.showTrans, arg_8_0.skin)
	end, SFX_PANEL)
	arg_8_0.live2DBtn:AddListener(function(arg_17_0)
		if arg_17_0 then
			arg_8_0:CreateLive2D()
		end

		setActive(arg_8_0.viewBtn, not arg_17_0)
		setActive(arg_8_0.rotateBtn, not arg_17_0)
		setActive(arg_8_0.commonPainting, not arg_17_0)
		setActive(arg_8_0.l2dRoot, arg_17_0)
		arg_8_0:StopDailogue()

		arg_8_0.l2dActioning = nil

		if arg_8_0.skin then
			arg_8_0.pages[var_0_0.INDEX_PROFILE]:ExecuteAction("Flush", arg_8_0.skin, arg_17_0)
		end
	end)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.toggles) do
		onToggle(arg_8_0, iter_8_1, function(arg_18_0)
			if iter_8_0 == var_0_0.INDEX_DETAIL then
				arg_8_0.live2DBtn:Update(arg_8_0.paintingName, false)

				arg_8_0.spinePaintingisOn = false

				arg_8_0:updateSpinePaintingState()
				arg_8_0:DisplaySpinePainting(false)
			end

			if arg_18_0 then
				arg_8_0:SwitchPage(iter_8_0)
			end
		end, SFX_PANEL)
	end

	arg_8_0:InitCommon()
	arg_8_0.live2DBtn:Update(arg_8_0.paintingName, false)
	arg_8_0:updateSpinePaintingState()
	onButton(arg_8_0, arg_8_0.btnChangeSkin, function()
		local var_19_0 = arg_8_0.skin

		if ShipGroup.IsChangeSkin(var_19_0.id) then
			local var_19_1 = ShipGroup.GetChangeSkinNextId(var_19_0.id)
			local var_19_2 = pg.ship_skin_template[var_19_1]

			arg_8_0:showSkinProfile(arg_8_0.contextData.skinIndex, var_19_2, arg_8_0.prevSkinBtn)
		end
	end, SFX_CONFIRM)
	setActive(arg_8_0.bottomTF, false)
	triggerToggle(arg_8_0.toggles[var_0_0.INDEX_DETAIL], true)
end

function var_0_0.InitSkinList(arg_20_0)
	arg_20_0.skinBtns = {}

	arg_20_0.UISkinList:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			local var_21_0 = arg_20_0.groupSkinList[arg_21_1 + 1]
			local var_21_1 = ShipProfileSkinBtn.New(arg_21_2)

			table.insert(arg_20_0.skinBtns, var_21_1)
			var_21_1:Update(var_21_0, arg_20_0.shipGroup, table.contains(arg_20_0.ownedSkinList, var_21_0.id))
			onButton(arg_20_0, var_21_1._tf, function()
				if not var_21_1.unlock then
					pg.TipsMgr.GetInstance():ShowTips(i18n("ship_profile_skin_locked"))

					return
				end

				arg_20_0:showSkinProfile(arg_21_1, var_21_0, var_21_1)
			end, SFX_PANEL)
			setActive(arg_21_2, var_21_0.skin_type == ShipSkin.SKIN_TYPE_DEFAULT or not HXSet.isHxSkin())
		end
	end)
	arg_20_0.UISkinList:align(#arg_20_0.groupSkinList)
end

function var_0_0.showSkinProfile(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = ShipGroup.IsChangeSkin(arg_23_2.id) and true or false

	setActive(arg_23_0.btnChangeSkin, var_23_0)

	if var_23_0 then
		arg_23_0.changeSkinToggle:setSkinData(arg_23_2.id)
	end

	arg_23_0.contextData.skinIndex = arg_23_1 + 1

	arg_23_0:ShiftSkin(arg_23_2)

	if arg_23_0.prevSkinBtn then
		arg_23_0.prevSkinBtn:UnShift()
	end

	arg_23_3:Shift()

	arg_23_0.prevSkinBtn = arg_23_3
end

function var_0_0.InitCommon(arg_24_0)
	arg_24_0:LoadSkinBg(arg_24_0.shipGroup:rarity2bgPrintForGet(arg_24_0.showTrans))
	setImageSprite(arg_24_0.shipType, GetSpriteFromAtlas("shiptype", arg_24_0.shipGroup:getShipType(arg_24_0.showTrans)))

	arg_24_0.labelName.text = arg_24_0.shipGroup:getName(arg_24_0.showTrans)

	local var_24_0 = arg_24_0.shipGroup.shipConfig

	arg_24_0.labelEnName.text = var_24_0.english_name

	for iter_24_0 = 1, var_24_0.star do
		cloneTplTo(arg_24_0.star, arg_24_0.stars)
	end

	arg_24_0:FlushHearts()

	local var_24_1 = arg_24_0.shipGroup:GetSkin(arg_24_0.showTrans).id

	arg_24_0:SetPainting(var_24_1, arg_24_0.showTrans)
end

function var_0_0.SetPainting(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:RecyclePainting()

	if arg_25_2 and arg_25_0.shipGroup.trans then
		arg_25_1 = arg_25_0.shipGroup.groupConfig.trans_skin
	end

	local var_25_0 = pg.ship_skin_template[arg_25_1].painting

	setPaintingPrefabAsync(arg_25_0.painting, var_25_0, "chuanwu")

	arg_25_0.paintingName = var_25_0

	arg_25_0:UpdateCryptolaliaBtn(arg_25_1)
end

function var_0_0.RecyclePainting(arg_26_0)
	if arg_26_0.paintingName then
		retPaintingPrefab(arg_26_0.painting, arg_26_0.paintingName)
	end
end

function var_0_0.FlushHearts(arg_27_0)
	local var_27_0 = arg_27_0.shipGroup.hearts

	setText(arg_27_0.labelHeart, var_27_0 > 999 and "999+" or var_27_0)

	arg_27_0.labelHeart:GetComponent("Text").color = arg_27_0.shipGroup.iheart and Color.New(1, 0.6, 0.6) or Color.New(1, 1, 1)

	setActive(arg_27_0.btnLikeDisact, not arg_27_0.shipGroup.iheart)
	setActive(arg_27_0.btnLikeAct, arg_27_0.shipGroup.iheart)
end

function var_0_0.LoadSkinBg(arg_28_0, arg_28_1)
	arg_28_0.bluePintBg = arg_28_0.isBluePrintGroup and arg_28_0.shipGroup:rarity2bgPrintForGet(arg_28_0.showTrans)
	arg_28_0.metaMainBg = arg_28_0.isMetaGroup and arg_28_0.shipGroup:rarity2bgPrintForGet(arg_28_0.showTrans)

	if arg_28_0.shipSkinBg ~= arg_28_1 then
		arg_28_0.shipSkinBg = arg_28_1

		local function var_28_0(arg_29_0)
			rtf(arg_29_0).localPosition = Vector3(0, 0, 200)
		end

		local function var_28_1()
			PoolMgr.GetInstance():GetUI("raritydesign" .. arg_28_0.shipGroup:getRarity(arg_28_0.showTrans), true, function(arg_31_0)
				arg_28_0.designBg = arg_31_0
				arg_28_0.designName = "raritydesign" .. arg_28_0.shipGroup:getRarity(arg_28_0.showTrans)

				arg_31_0.transform:SetParent(arg_28_0.staticBg, false)

				arg_31_0.transform.localPosition = Vector3(1, 1, 1)
				arg_31_0.transform.localScale = Vector3(1, 1, 1)

				arg_31_0.transform:SetSiblingIndex(1)

				local var_31_0 = arg_31_0:GetComponent("Canvas")

				if var_31_0 then
					var_31_0.sortingOrder = -90
				end

				setActive(arg_31_0, true)
			end)
		end

		local function var_28_2()
			PoolMgr.GetInstance():GetUI("raritymeta" .. arg_28_0.shipGroup:getRarity(arg_28_0.showTrans), true, function(arg_33_0)
				arg_28_0.metaBg = arg_33_0
				arg_28_0.metaName = "raritymeta" .. arg_28_0.shipGroup:getRarity(arg_28_0.showTrans)

				arg_33_0.transform:SetParent(arg_28_0.staticBg, false)

				arg_33_0.transform.localPosition = Vector3(1, 1, 1)
				arg_33_0.transform.localScale = Vector3(1, 1, 1)

				arg_33_0.transform:SetSiblingIndex(1)
				setActive(arg_33_0, true)
			end)
		end

		local function var_28_3(arg_34_0)
			if arg_28_0.bluePintBg and arg_28_1 == arg_28_0.bluePintBg then
				if arg_28_0.metaBg then
					setActive(arg_28_0.metaBg, false)
				end

				if arg_28_0.designBg and arg_28_0.designName ~= "raritydesign" .. arg_28_0.shipGroup:getRarity(arg_28_0.showTrans) then
					PoolMgr.GetInstance():ReturnUI(arg_28_0.designName, arg_28_0.designBg)

					arg_28_0.designBg = nil
				end

				if not arg_28_0.designBg then
					var_28_1()
				else
					setActive(arg_28_0.designBg, true)
				end
			elseif arg_28_0.metaMainBg and arg_28_1 == arg_28_0.metaMainBg then
				if arg_28_0.designBg then
					setActive(arg_28_0.designBg, false)
				end

				if arg_28_0.metaBg and arg_28_0.metaName ~= "raritymeta" .. arg_28_0.shipGroup:getRarity(arg_28_0.showTrans) then
					PoolMgr.GetInstance():ReturnUI(arg_28_0.metaName, arg_28_0.metaBg)

					arg_28_0.metaBg = nil
				end

				if not arg_28_0.metaBg then
					var_28_2()
				else
					setActive(arg_28_0.metaBg, true)
				end
			else
				if arg_28_0.designBg then
					setActive(arg_28_0.designBg, false)
				end

				if arg_28_0.metaBg then
					setActive(arg_28_0.metaBg, false)
				end
			end
		end

		pg.DynamicBgMgr.GetInstance():LoadBg(arg_28_0, arg_28_1, arg_28_0.bg, arg_28_0.staticBg, var_28_0, var_28_3)
	end
end

function var_0_0.SwitchPage(arg_35_0, arg_35_1)
	if arg_35_0.index ~= arg_35_1 then
		seriesAsync({
			function(arg_36_0)
				pg.UIMgr.GetInstance():OverlayPanel(arg_35_0.blurPanel, {
					groupName = LayerWeightConst.GROUP_SHIP_PROFILE
				})
				arg_36_0()
			end,
			function(arg_37_0)
				local var_37_0 = arg_35_0.pages[arg_35_1]
				local var_37_1 = arg_35_1 == var_0_0.INDEX_PROFILE and not var_37_0:GetLoaded()

				var_37_0:ExecuteAction("Update", arg_35_0.shipGroup, arg_35_0.showTrans, function()
					if var_37_1 then
						arg_35_0:InitSkinList()
					end

					arg_37_0()
				end)
			end,
			function(arg_39_0)
				if not arg_35_0.index then
					arg_39_0()

					return
				end

				arg_35_0.pages[arg_35_0.index]:ExecuteAction("ExistAnim", var_0_1)
				arg_39_0()
			end,
			function(arg_40_0)
				local var_40_0 = arg_35_0.pages[arg_35_1]

				SetParent(arg_35_0.bottomTF, var_40_0._tf)
				setActive(arg_35_0.bottomTF, true)
				setAnchoredPosition(arg_35_0.bottomTF, {
					z = 0,
					x = -7,
					y = 24
				})
				var_40_0:ExecuteAction("EnterAnim", var_0_1)
				arg_35_0:TweenPage(arg_35_1)
				arg_40_0()
			end,
			function(arg_41_0)
				arg_35_0.index = arg_35_1

				local var_41_0 = arg_35_0.contextData.skinIndex or 1

				if arg_35_1 == var_0_0.INDEX_PROFILE and var_41_0 <= #arg_35_0.skinBtns then
					triggerButton(arg_35_0.skinBtns[var_41_0]._tf)
				end
			end
		})
	end
end

function var_0_0.TweenPage(arg_42_0, arg_42_1)
	if arg_42_1 == var_0_0.INDEX_DETAIL then
		LeanTween.moveX(rtf(arg_42_0.leftProfile), -700, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveY(rtf(arg_42_0.live2DBtn._tf), -70, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveY(rtf(arg_42_0.spinePaintingBtn), -70, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveX(rtf(arg_42_0.painting), arg_42_0.paintingInitPos.x, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveX(rtf(arg_42_0.name), arg_42_0.nameInitPos.x, var_0_1):setEase(LeanTweenType.easeInOutSine)
	elseif arg_42_1 == var_0_0.INDEX_PROFILE then
		LeanTween.moveX(rtf(arg_42_0.leftProfile), 0, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveY(rtf(arg_42_0.live2DBtn._tf), 60, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveY(rtf(arg_42_0.spinePaintingBtn), 60, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveX(rtf(arg_42_0.painting), arg_42_0.paintingInitPos.x + 50, var_0_1):setEase(LeanTweenType.easeInOutSine)
		LeanTween.moveX(rtf(arg_42_0.name), arg_42_0.nameInitPos.x + 50, var_0_1):setEase(LeanTweenType.easeInOutSine)
	end
end

function var_0_0.ShiftSkin(arg_43_0, arg_43_1)
	if arg_43_0.index ~= var_0_0.INDEX_PROFILE or arg_43_0.skin and arg_43_1.id == arg_43_0.skin.id then
		return
	end

	arg_43_0.skin = arg_43_1

	arg_43_0:LoadModel(arg_43_1)
	arg_43_0:SetPainting(arg_43_1.id, false)
	arg_43_0.live2DBtn:Disable()
	arg_43_0.live2DBtn:Update(arg_43_0.paintingName, false)

	local var_43_0
	local var_43_1 = arg_43_1 and arg_43_1.spine_use_live2d == 1 and "spine_painting_bg" or "live2d_bg"

	LoadSpriteAtlasAsync("ui/share/btn_l2d_atlas", var_43_1, function(arg_44_0)
		GetComponent(arg_43_0:findTF("L2D_btn", arg_43_0.blurPanel), typeof(Image)).sprite = arg_44_0
		GetComponent(arg_43_0:findTF("L2D_btn/img", arg_43_0.blurPanel), typeof(Image)).sprite = arg_44_0

		GetComponent(arg_43_0:findTF("L2D_btn", arg_43_0.blurPanel), typeof(Image)):SetNativeSize()
		GetComponent(arg_43_0:findTF("L2D_btn/img", arg_43_0.blurPanel), typeof(Image)):SetNativeSize()
	end)

	arg_43_0.spinePaintingisOn = false

	arg_43_0:updateSpinePaintingState()
	arg_43_0:DestroySpinePainting()
	arg_43_0.pages[var_0_0.INDEX_PROFILE]:ExecuteAction("Flush", arg_43_1, false)

	local var_43_2
	local var_43_3 = PlayerPrefs.GetInt("paint_hide_other_obj_" .. arg_43_0.skin.painting, 0) == 0

	if arg_43_0.skin.bg_sp and arg_43_0.skin.bg_sp ~= "" and var_43_3 then
		var_43_2 = arg_43_0.skin.bg_sp
	elseif arg_43_0.skin.bg and arg_43_0.skin.bg ~= "" then
		var_43_2 = arg_43_0.skin.bg
	else
		var_43_2 = arg_43_0.shipGroup:rarity2bgPrintForGet(arg_43_0.showTrans, arg_43_0.skin.id)
	end

	arg_43_0:LoadSkinBg(var_43_2)

	arg_43_0.haveOp = checkABExist("ui/skinunlockanim/star_level_unlock_anim_" .. arg_43_0.skin.id)
end

function var_0_0.UpdateCryptolaliaBtn(arg_45_0, arg_45_1)
	local var_45_0 = ShipSkin.New({
		id = arg_45_1
	}):getConfig("ship_group")

	setActive(arg_45_0.cryptolaliaBtn, getProxy(PlayerProxy):getRawData():ExistCryptolalia(var_45_0))
end

function var_0_0.LoadModel(arg_46_0, arg_46_1)
	if arg_46_0.inLoading then
		return
	end

	arg_46_0:ReturnModel()

	local var_46_0 = arg_46_1.prefab

	arg_46_0.inLoading = true

	PoolMgr.GetInstance():GetSpineChar(var_46_0, true, function(arg_47_0)
		arg_46_0.inLoading = false
		arg_47_0.name = var_46_0
		arg_47_0.transform.localPosition = Vector3.zero
		arg_47_0.transform.localScale = Vector3(0.8, 0.8, 1)

		arg_47_0.transform:SetParent(arg_46_0.modelContainer, false)
		arg_47_0:GetComponent(typeof(SpineAnimUI)):SetAction(arg_46_1.show_skin or "stand", 0)

		arg_46_0.characterModel = arg_47_0
		arg_46_0.modelName = var_46_0
	end)
end

function var_0_0.ReturnModel(arg_48_0)
	if not IsNil(arg_48_0.characterModel) then
		PoolMgr.GetInstance():ReturnSpineChar(arg_48_0.modelName, arg_48_0.characterModel)
	end
end

function var_0_0.CreateLive2D(arg_49_0)
	arg_49_0.live2DBtn:SetEnable(false)

	if arg_49_0.l2dChar then
		arg_49_0.l2dChar:Dispose()
	end

	local var_49_0 = arg_49_0.shipGroup:getShipConfigId()
	local var_49_1 = pg.ship_skin_template[arg_49_0.skin.id].live2d_offset_profile
	local var_49_2

	if var_49_1 and type(var_49_1) ~= "string" then
		var_49_2 = Vector3(0 + var_49_1[1], -40 + var_49_1[2], 100 + var_49_1[3])
	else
		var_49_2 = Vector3(0, -40, 100)
	end

	local var_49_3 = Live2D.GenerateData({
		ship = Ship.New({
			configId = var_49_0,
			skin_id = arg_49_0.skin.id,
			propose = arg_49_0.shipGroup.married
		}),
		scale = Vector3(52, 52, 52),
		position = var_49_2,
		parent = arg_49_0.l2dRoot
	})

	arg_49_0.l2dChar = Live2D.New(var_49_3, function()
		arg_49_0.live2DBtn:SetEnable(true)
	end)

	if isHalfBodyLive2D(arg_49_0.skin.prefab) then
		setAnchoredPosition(arg_49_0.l2dRoot, {
			y = -37 - (arg_49_0.painting.rect.height - arg_49_0.l2dRoot.rect.height * 1.5) / 2
		})
	else
		setAnchoredPosition(arg_49_0.l2dRoot, {
			y = 0
		})
	end

	if Live2dConst.UnLoadL2dPating then
		Live2dConst.UnLoadL2dPating()
	end
end

function var_0_0.GetModelAction(arg_51_0, arg_51_1)
	local var_51_0

	if not arg_51_1.spine_action or arg_51_1.spine_action == "" then
		return "stand"
	else
		return arg_51_1.spine_action
	end
end

function var_0_0.OnCVBtnClick(arg_52_0, arg_52_1)
	if arg_52_0.l2dActioning then
		return
	end

	local var_52_0 = arg_52_1.voice

	local function var_52_1()
		local var_53_0

		if arg_52_1:isEx() then
			local var_53_1 = var_52_0.l2d_action .. "_ex"

			if arg_52_0.l2dChar and arg_52_0.l2dChar:checkActionExist(var_53_1) then
				var_53_0 = var_53_1
			else
				var_53_0 = var_52_0.l2d_action
			end
		else
			var_53_0 = var_52_0.l2d_action
		end

		if arg_52_0.l2dChar and not arg_52_0.l2dChar:enablePlayAction(var_53_0) then
			return
		end

		arg_52_0:UpdatePaintingFace(arg_52_1)

		if arg_52_0.characterModel then
			local var_53_2 = arg_52_0:GetModelAction(var_52_0)

			arg_52_0.characterModel:GetComponent(typeof(SpineAnimUI)):SetAction(var_53_2, 0)
		end

		local var_53_3 = {
			var_0_0.CHAT_SHOW_TIME
		}

		if arg_52_0.live2DBtn.isOn and arg_52_0.l2dChar then
			if arg_52_0.l2dChar:IsLoaded() then
				arg_52_0.l2dActioning = true

				if not arg_52_1:L2dHasEvent() then
					parallelAsync({
						function(arg_54_0)
							arg_52_0:RemoveLive2DTimer()

							arg_52_0.l2dActioning = arg_52_0.l2dChar:TriggerAction(var_53_0, arg_54_0)
						end,
						function(arg_55_0)
							arg_52_0:PlayVoice(arg_52_1, var_53_3)
							arg_52_0:ShowDailogue(arg_52_1, var_53_3, arg_55_0)
						end
					}, function()
						arg_52_0.l2dActioning = false
					end)
				else
					seriesAsync({
						function(arg_57_0)
							arg_52_0:RemoveLive2DTimer()

							arg_52_0.l2dActioning = arg_52_0.l2dChar:TriggerAction(var_53_0, arg_57_0, nil, function(arg_58_0)
								arg_52_0:PlayVoice(arg_52_1, var_53_3)
								arg_52_0:ShowDailogue(arg_52_1, var_53_3, arg_57_0)
							end)
						end
					}, function()
						arg_52_0.l2dActioning = false
					end)
				end
			end
		else
			arg_52_0:PlayVoice(arg_52_1, var_53_3)
			arg_52_0:ShowDailogue(arg_52_1, var_53_3)
		end
	end

	if var_52_0.key == "unlock" and arg_52_0.haveOp then
		arg_52_0:playOpening(var_52_1)
	else
		var_52_1()
	end
end

function var_0_0.UpdatePaintingFace(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_1.wordData
	local var_60_1 = var_60_0.mainIndex ~= nil
	local var_60_2 = arg_60_1.voice.key

	if var_60_1 then
		var_60_2 = "main_" .. var_60_0.mainIndex
	end

	if arg_60_0.paintingFitter.childCount > 0 then
		ShipExpressionHelper.SetExpression(arg_60_0.paintingFitter:GetChild(0), arg_60_0.paintingName, var_60_2, var_60_0.maxfavor, arg_60_1.skin.id)
	end

	if arg_60_0.spinePainting then
		local var_60_3 = ShipExpressionHelper.GetExpression(arg_60_0.paintingName, var_60_2, var_60_0.maxfavor, arg_60_1.skin.id)

		if var_60_3 ~= "" then
			arg_60_0.spinePainting:SetAction(var_60_3, 1)
		else
			arg_60_0.spinePainting:SetEmptyAction(1)
		end
	end
end

function var_0_0.PlayVoice(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = arg_61_1.wordData
	local var_61_1 = arg_61_1.skin
	local var_61_2 = arg_61_1.words

	arg_61_0:RemoveCvTimer()

	if not var_61_0.cvPath or var_61_0.cvPath == "" then
		return
	end

	if var_61_2.voice_key >= ShipWordHelper.CV_KEY_REPALCE or var_61_2.voice_key_2 >= ShipWordHelper.CV_KEY_REPALCE or var_61_2.voice_key == ShipWordHelper.CV_KEY_BAN_NEW then
		local var_61_3 = 0

		if arg_61_1.isLive2d and arg_61_0.l2dChar and var_61_0.voiceCalibrate then
			var_61_3 = var_61_0.voiceCalibrate
		end

		arg_61_0.cvLoader:DelayPlaySound(var_61_0.cvPath, var_61_3, function(arg_62_0)
			if arg_62_0 then
				arg_61_2[1] = long2int(arg_62_0.length) * 0.001
			end
		end)
	end

	local var_61_4 = var_61_0.se

	if arg_61_1.isLive2d and arg_61_0.l2dChar and var_61_4 then
		arg_61_0.cvLoader:RawPlaySound("event:/ui/" .. var_61_4[1], var_61_4[2])
	end
end

function var_0_0.RemoveCvSeTimer(arg_63_0)
	if arg_63_0.cvSeTimer then
		arg_63_0.cvSeTimer:Stop()

		arg_63_0.cvSeTimer = nil
	end
end

function var_0_0.RemoveCvTimer(arg_64_0)
	if arg_64_0.cvTimer then
		arg_64_0.cvTimer:Stop()

		arg_64_0.cvTimer = nil
	end
end

function var_0_0.RemoveLive2DTimer(arg_65_0)
	if arg_65_0.Live2DTimer then
		LeanTween.cancel(arg_65_0.Live2DTimer)

		arg_65_0.Live2DTimer = nil
	end
end

function var_0_0.ShowDailogue(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	arg_66_0.dailogueCallback = arg_66_3 or function()
		return
	end

	local var_66_0 = arg_66_1.wordData.textContent

	if not var_66_0 or var_66_0 == "" or var_66_0 == "nil" then
		if arg_66_0.dailogueCallback then
			arg_66_0.dailogueCallback()

			arg_66_0.dailogueCallback = nil
		end

		return
	end

	local var_66_1 = arg_66_1.wordData.voiceCalibrate
	local var_66_2 = arg_66_0.chatText:GetComponent(typeof(Text))

	setText(arg_66_0.chatText, SwitchSpecialChar(var_66_0))

	var_66_2.alignment = #var_66_2.text > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

	local var_66_3 = var_66_2.preferredHeight + 120

	arg_66_0.chatBg.sizeDelta = var_66_3 > arg_66_0.initChatBgH and Vector2.New(arg_66_0.chatBg.sizeDelta.x, var_66_3) or Vector2.New(arg_66_0.chatBg.sizeDelta.x, arg_66_0.initChatBgH)

	arg_66_0:StopDailogue()
	setActive(arg_66_0.chatTF, true)
	LeanTween.scale(rtf(arg_66_0.chatTF.gameObject), Vector3.New(1, 1, 1), var_0_0.CHAT_ANIMATION_TIME):setEase(LeanTweenType.easeOutBack):setDelay(var_66_1 and var_66_1 or 0):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(arg_66_0.chatTF.gameObject), Vector3.New(0, 0, 1), var_0_0.CHAT_ANIMATION_TIME):setEase(LeanTweenType.easeInBack):setDelay(var_0_0.CHAT_ANIMATION_TIME + arg_66_2[1]):setOnComplete(System.Action(function()
			if arg_66_0.dailogueCallback then
				arg_66_0.dailogueCallback()

				arg_66_0.dailogueCallback = nil
			end

			if arg_66_0.spinePainting then
				arg_66_0.spinePainting:SetEmptyAction(1)
			end
		end))
	end))
end

function var_0_0.StopDailogue(arg_70_0)
	LeanTween.cancel(arg_70_0.chatTF.gameObject)

	arg_70_0.chatTF.localScale = Vector3(0, 0)
end

function var_0_0.onBackPressed(arg_71_0)
	if arg_71_0.paintingView.isPreview then
		arg_71_0.paintingView:Finish(true)

		return
	end

	triggerButton(arg_71_0.btnBack)
end

function var_0_0.playOpening(arg_72_0, arg_72_1)
	local var_72_0 = "star_level_unlock_anim_" .. arg_72_0.skin.id

	if checkABExist("ui/skinunlockanim/" .. var_72_0) then
		pg.CpkPlayMgr.GetInstance():PlayCpkMovie(function()
			return
		end, function()
			if arg_72_1 then
				arg_72_1()
			end
		end, "ui/skinunlockanim", var_72_0, true, false, nil)
	elseif arg_72_1 then
		arg_72_1()
	end
end

function var_0_0.updateSpinePaintingState(arg_75_0)
	local var_75_0 = HXSet.autoHxShiftPath("spinepainting/" .. arg_75_0.paintingName)

	if checkABExist(var_75_0) then
		setActive(arg_75_0.spinePaintingBtn, true)
		setActive(arg_75_0.spinePaintingToggle:Find("on"), arg_75_0.spinePaintingisOn)
		setActive(arg_75_0.spinePaintingToggle:Find("off"), not arg_75_0.spinePaintingisOn)
		removeOnButton(arg_75_0.spinePaintingBtn)
		onButton(arg_75_0, arg_75_0.spinePaintingBtn, function()
			arg_75_0.spinePaintingisOn = not arg_75_0.spinePaintingisOn

			setActive(arg_75_0.spinePaintingToggle:Find("on"), arg_75_0.spinePaintingisOn)
			setActive(arg_75_0.spinePaintingToggle:Find("off"), not arg_75_0.spinePaintingisOn)

			if arg_75_0.spinePaintingisOn then
				arg_75_0:CreateSpinePainting()
			end

			setActive(arg_75_0.viewBtn, not arg_75_0.spinePaintingisOn)
			setActive(arg_75_0.rotateBtn, not arg_75_0.spinePaintingisOn)
			setActive(arg_75_0.commonPainting, not arg_75_0.spinePaintingisOn)
			setActive(arg_75_0.spinePaintingRoot, arg_75_0.spinePaintingisOn)
			setActive(arg_75_0.spinePaintingBgRoot, arg_75_0.spinePaintingisOn)
			arg_75_0:StopDailogue()

			if arg_75_0.skin then
				arg_75_0.pages[var_0_0.INDEX_PROFILE]:ExecuteAction("Flush", arg_75_0.skin, false)
			end
		end, SFX_PANEL)
	else
		setActive(arg_75_0.spinePaintingBtn, false)
	end
end

function var_0_0.CreateSpinePainting(arg_77_0)
	if arg_77_0.skin.id ~= arg_77_0.preSkinId then
		arg_77_0:DestroySpinePainting()

		local var_77_0 = arg_77_0.shipGroup:getShipConfigId()
		local var_77_1 = SpinePainting.GenerateData({
			ship = Ship.New({
				configId = var_77_0,
				skin_id = arg_77_0.skin.id
			}),
			position = Vector3(0, 0, 0),
			parent = arg_77_0.spinePaintingRoot,
			effectParent = arg_77_0.spinePaintingBgRoot
		})

		arg_77_0.spinePainting = SpinePainting.New(var_77_1, function()
			return
		end)
		arg_77_0.preSkinId = arg_77_0.skin.id
	end

	arg_77_0:DisplaySpinePainting(true)
end

function var_0_0.DestroySpinePainting(arg_79_0)
	if arg_79_0.spinePainting then
		arg_79_0.spinePainting:Dispose()

		arg_79_0.spinePainting = nil
	end

	arg_79_0.preSkinId = nil
end

function var_0_0.onWeddingReview(arg_80_0, arg_80_1)
	if not arg_80_1 and arg_80_0.exitLoadL2d then
		arg_80_0.exitLoadL2d = false

		arg_80_0.live2DBtn:Update(arg_80_0.paintingName, true)
	else
		arg_80_0.live2DBtn:Update(arg_80_0.paintingName, false)
	end

	arg_80_0.live2DBtn:SetEnable(not arg_80_1)

	if arg_80_0.l2dChar and arg_80_1 then
		arg_80_0.l2dChar:Dispose()

		arg_80_0.l2dChar = nil
		arg_80_0.l2dActioning = false
		arg_80_0.cvLoader.prevCvPath = nil

		arg_80_0:StopDailogue()
		arg_80_0.cvLoader:StopSound()

		arg_80_0.exitLoadL2d = true
	end

	if arg_80_0.spinePaintingRoot.childCount > 0 then
		setActive(arg_80_0.commonPainting, not arg_80_0.spinePaintingisOn)
	end
end

function var_0_0.DisplaySpinePainting(arg_81_0, arg_81_1)
	setActive(arg_81_0.spinePaintingRoot, arg_81_1)
	setActive(arg_81_0.spinePaintingBgRoot, arg_81_1)
end

function var_0_0.willExit(arg_82_0)
	pg.CpkPlayMgr.GetInstance():DisposeCpkMovie()
	SetParent(arg_82_0.bottomTF, arg_82_0._tf)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_82_0.blurPanel, arg_82_0._tf)

	for iter_82_0, iter_82_1 in ipairs(arg_82_0.pages) do
		iter_82_1:Destroy()
	end

	if arg_82_0.l2dChar then
		arg_82_0.l2dChar:Dispose()
	end

	arg_82_0:DestroySpinePainting()
	arg_82_0.paintingView:Dispose()
	arg_82_0.live2DBtn:Dispose()
	arg_82_0.cvLoader:Dispose()
	arg_82_0:ReturnModel()
	arg_82_0:RecyclePainting()
	_.each(arg_82_0.skinBtns or {}, function(arg_83_0)
		arg_83_0:Dispose()
	end)
	arg_82_0:RemoveCvTimer()
	arg_82_0:RemoveCvSeTimer()
	arg_82_0:RemoveLive2DTimer()
end

return var_0_0
