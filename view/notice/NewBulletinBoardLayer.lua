local var_0_0 = class("NewBulletinBoardLayer", import("..base.BaseUI"))

var_0_0.CONTENT_TYPE = {
	BANNER = "BANNER",
	RICHTEXT = "RITCHTEXT"
}
var_0_0.ICON_NAME = {
	"activity_common",
	"activity_summary",
	"activity_time_limit",
	"build_time_limit",
	"equibment_skin_new",
	"furniture_new",
	"info_common",
	"skin_new",
	"system_common"
}
var_0_0.MAIN_TAB_GAMETIP = {
	"Announcements_Event_Notice",
	"Announcements_System_Notice",
	"Announcements_News"
}
var_0_0.TITLE_IMAGE_HEIGHT_DEFAULT = 231
var_0_0.TITLE_IMAGE_HEIGHT_FULL = 734

function var_0_0.getUIName(arg_1_0)
	return "NewBulletinBoardUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0._closeBtn = arg_2_0:findTF("bg/close_btn")
	arg_2_0._mainTabContainer = arg_2_0:findTF("bg/notice_list")
	arg_2_0._subTabGroup = arg_2_0:findTF("bg/title_list/viewport/content"):GetComponent(typeof(ToggleGroup))
	arg_2_0._subTabContainer = arg_2_0:findTF("bg/title_list/viewport/content")
	arg_2_0._tabTpl = arg_2_0:findTF("bg/title_list/tab_btn_tpl")

	SetActive(arg_2_0._tabTpl, false)

	arg_2_0._subTabList = {}
	arg_2_0._contentTF = arg_2_0:findTF("bg/content_view/viewport/content")
	arg_2_0._detailTitleImg = arg_2_0:findTF("title_img", arg_2_0._contentTF)
	arg_2_0._detailTitleImgLayoutElement = arg_2_0._detailTitleImg:GetComponent(typeof(LayoutElement))
	arg_2_0._detailTitle = arg_2_0:findTF("title", arg_2_0._contentTF)
	arg_2_0._detailTitleTxt = arg_2_0:findTF("title/title_txt/mask/scroll_txt", arg_2_0._contentTF)
	arg_2_0._detailTimeTxt = arg_2_0:findTF("title/time_txt", arg_2_0._contentTF)
	arg_2_0._detailLine = arg_2_0:findTF("line", arg_2_0._contentTF)
	arg_2_0._bottom = arg_2_0:findTF("bottom", arg_2_0._contentTF)
	arg_2_0._contentContainer = arg_2_0:findTF("content_container", arg_2_0._contentTF)
	arg_2_0._contentTxtTpl = arg_2_0:findTF("content_txt", arg_2_0._contentTF)

	setActive(arg_2_0._contentTxtTpl, false)

	arg_2_0._contentBannerTpl = arg_2_0:findTF("content_banner", arg_2_0._contentTF)

	setActive(arg_2_0._contentBannerTpl, false)

	arg_2_0._scrollRect = arg_2_0:findTF("bg/content_view"):GetComponent(typeof(ScrollRect))
	arg_2_0._dontshow = arg_2_0:findTF("bg/dont_show")
	arg_2_0._stopRemind = arg_2_0:findTF("bg/dont_show/bottom")
	arg_2_0._subTabAnims = {}
	arg_2_0._mainAnim = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0._bgAnim = arg_2_0:findTF("bg"):GetComponent(typeof(Animation))
	arg_2_0._contentAnim = arg_2_0:findTF("bg/content_view"):GetComponent(typeof(Animation))

	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf, false, {
		weight = LayerWeightConst.SECOND_LAYER
	})

	arg_2_0._loadingFlag = {}
	arg_2_0._contentList = {}
	arg_2_0._noticeDic = {
		{},
		{},
		{}
	}
	arg_2_0._redDic = {
		{},
		{},
		{}
	}
	arg_2_0.noticeKeys = {}
	arg_2_0.noticeVersions = {}
	arg_2_0.LTList = {}
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0._mainAnim:Play("anim_BulletinBoard_in")
	onButton(arg_3_0, arg_3_0._closeBtn, function()
		arg_3_0._mainAnim:Play("anim_BulletinBoard_out")
		LeanTween.delayedCall(0.2, System.Action(function()
			arg_3_0:emit(var_0_0.ON_CLOSE)
		end))
	end, SOUND_BACK)
	onToggle(arg_3_0, arg_3_0._stopRemind, function(arg_6_0)
		arg_3_0:emit(NewBulletinBoardMediator.SET_STOP_REMIND, arg_6_0)
	end)

	local var_3_0 = getProxy(ServerNoticeProxy):getStopRemind()

	triggerToggle(arg_3_0._stopRemind, var_3_0)
	setText(arg_3_0._dontshow, i18n("Announcements_Donotshow"))
	LeanTween.rotateAroundLocal(rtf(arg_3_0._detailTitleImg:Find("loading/Image")), Vector3(0, 0, -1), 360, 5):setLoopClamp()
end

function var_0_0.updateRed(arg_7_0)
	for iter_7_0 = 1, 3 do
		local var_7_0 = false

		for iter_7_1, iter_7_2 in pairs(arg_7_0._noticeDic[iter_7_0]) do
			arg_7_0._redDic[iter_7_0][iter_7_1] = PlayerPrefs.HasKey(iter_7_2.code)

			if not arg_7_0._redDic[iter_7_0][iter_7_1] then
				var_7_0 = true
			end
		end

		setActive(arg_7_0._mainTabContainer:GetChild(iter_7_0 - 1):Find("Text/red"), var_7_0)
	end

	for iter_7_3 = 1, #arg_7_0._subTabList do
		setActive(arg_7_0._subTabList[iter_7_3]:Find("red"), not arg_7_0._redDic[arg_7_0.currentMainTab][iter_7_3])
	end
end

function var_0_0.checkNotice(arg_8_0, arg_8_1)
	return arg_8_1.type and arg_8_1.type > 0 and arg_8_1.type < 4 and (arg_8_1.paramType == nil or arg_8_1.paramType == 1 and type(arg_8_1.param) == "string" or arg_8_1.paramType == 2 and type(arg_8_1.param) == "string" or arg_8_1.paramType == 3 and type(arg_8_1.param) == "number" or arg_8_1.paramType == 4 and type(arg_8_1.param) == "number" and pg.activity_banner_notice[arg_8_1.param] ~= nil or arg_8_1.paramType == 5)
end

function var_0_0.initNotices(arg_9_0, arg_9_1)
	arg_9_0.defaultMainTab = arg_9_0.contextData.defaultMainTab
	arg_9_0.defaultSubTab = arg_9_0.contextData.defaultSubTab

	local var_9_0
	local var_9_1

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		if arg_9_0:checkNotice(iter_9_1) then
			table.insert(arg_9_0._noticeDic[iter_9_1.type], iter_9_1)
			table.insert(arg_9_0._redDic[iter_9_1.type], PlayerPrefs.HasKey(iter_9_1.code))

			if not var_9_1 or var_9_1 < iter_9_1.priority then
				var_9_1 = iter_9_1.priority
				var_9_0 = iter_9_1.type
			end

			table.insert(arg_9_0.noticeKeys, tostring(iter_9_1.id))
			table.insert(arg_9_0.noticeVersions, iter_9_1.version)
		else
			Debugger.LogWarning("公告配置错误  id = " .. iter_9_1.id)
		end
	end

	for iter_9_2 = 1, 3 do
		local var_9_2 = arg_9_0._mainTabContainer:GetChild(iter_9_2 - 1)
		local var_9_3 = var_9_2:Find("selected"):GetComponent(typeof(Animation))

		setText(var_9_2:Find("Text"), i18n(var_0_0.MAIN_TAB_GAMETIP[iter_9_2]))
		onToggle(arg_9_0, var_9_2, function(arg_10_0)
			if arg_10_0 then
				if arg_9_0.currentMainTab and arg_9_0.currentMainTab == iter_9_2 then
					return
				end

				if arg_9_0.currentMainTab then
					var_9_3:Play(arg_9_0.currentMainTab > iter_9_2 and "anim_BB_toptitle_R_in" or "anim_BB_toptitle_L_in")
					arg_9_0._bgAnim:Play(arg_9_0.currentMainTab > iter_9_2 and "anim_BulletinBoard_Rin_change" or "anim_BulletinBoard_Lin_change")
				end

				arg_9_0.currentMainTab = iter_9_2
				arg_9_0.defaultSubTab = arg_9_0.tempSubTab
				arg_9_0.tempSubTab = nil

				arg_9_0:setNotices(arg_9_0._noticeDic[iter_9_2])
			end
		end)

		if #arg_9_0._noticeDic[iter_9_2] == 0 then
			setActive(var_9_2, false)
		end
	end

	arg_9_0.defaultMainTab = arg_9_0.defaultMainTab or var_9_0

	if arg_9_0.defaultMainTab then
		arg_9_0.tempSubTab = arg_9_0.defaultSubTab

		triggerToggle(arg_9_0._mainTabContainer:GetChild(arg_9_0.defaultMainTab - 1), true)
	end

	BulletinBoardMgr.Inst:ClearCache(arg_9_0.noticeKeys, arg_9_0.noticeVersions)
end

function var_0_0.setNotices(arg_11_0, arg_11_1)
	arg_11_0:clearTab()

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		local var_11_0 = cloneTplTo(arg_11_0._tabTpl, arg_11_0._subTabContainer)

		SetActive(var_11_0, true)
		table.insert(arg_11_0._subTabList, var_11_0)
		table.insert(arg_11_0._subTabAnims, var_11_0:Find("select_state"):GetComponent(typeof(Animation)))
		setScrollText(var_11_0:Find("common_state/mask/Text"), iter_11_1.btnTitle)
		setScrollText(var_11_0:Find("select_state/mask/Text"), iter_11_1.btnTitle)
		GetSpriteFromAtlasAsync("ui/newbulletinboardui_atlas", var_0_0.ICON_NAME[iter_11_1.icon], function(arg_12_0)
			setImageSprite(var_11_0:Find("common_state/icon"), arg_12_0)
		end)
		GetSpriteFromAtlasAsync("ui/newbulletinboardui_atlas", var_0_0.ICON_NAME[iter_11_1.icon] .. "_selected", function(arg_13_0)
			setImageSprite(var_11_0:Find("select_state/icon"), arg_13_0)
		end)
		onToggle(arg_11_0, var_11_0, function(arg_14_0)
			if arg_14_0 then
				setActive(var_11_0:Find("select_state"), true)

				if arg_11_0.currentSubTab and arg_11_0.currentSubTab == iter_11_0 then
					return
				end

				if arg_11_0.currentSubTab then
					local var_14_0 = arg_11_0.currentSubTab

					arg_11_0._subTabAnims[iter_11_0]:Play(var_14_0 > iter_11_0 and "anim_BB_lefttitle_B_in" or "anim_BB_lefttitle_T_in")
					arg_11_0._subTabAnims[var_14_0]:Play(var_14_0 > iter_11_0 and "anim_BB_lefttitle_T_out" or "anim_BB_lefttitle_B_out")

					arg_11_0.subTabLT = LeanTween.delayedCall(0.26, System.Action(function()
						setActive(arg_11_0._subTabList[var_14_0]:Find("select_state"), false)
					end)).uniqueId

					arg_11_0._contentAnim:Play(var_14_0 > iter_11_0 and "anim_BB_view_B_in" or "anim_BB_view_T_in")
				end

				arg_11_0.currentSubTab = iter_11_0

				PlayerPrefs.SetInt(arg_11_0._noticeDic[arg_11_0.currentMainTab][iter_11_0].code, 0)
				arg_11_0:updateRed()
				arg_11_0:setNoticeDetail(iter_11_1)
			end
		end, SFX_PANEL)
	end

	arg_11_0.defaultSubTab = arg_11_0.defaultSubTab or 1

	triggerToggle(arg_11_0._subTabList[arg_11_0.defaultSubTab], true)
end

function var_0_0.setImage(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_4:Find("img"):GetComponent(typeof(Image))
	local var_16_1 = arg_16_4:Find("loading")

	var_16_0.color = Color.New(0, 0, 0, 0.4)

	setActive(var_16_1, true)

	arg_16_0._loadingFlag[arg_16_3] = true

	BulletinBoardMgr.Inst:GetSprite(arg_16_1, arg_16_2, arg_16_3, UnityEngine.Events.UnityAction_UnityEngine_Sprite(function(arg_17_0)
		if arg_16_0._loadingFlag == nil then
			return
		end

		arg_16_0._loadingFlag[arg_16_3] = nil

		if arg_17_0 ~= nil and not IsNil(arg_16_4) then
			setImageSprite(var_16_0, arg_17_0, false)

			var_16_0.color = Color.New(1, 1, 1)

			setActive(var_16_1, false)
		end
	end))
end

function var_0_0.setNoticeDetail(arg_18_0, arg_18_1)
	local function var_18_0(arg_19_0)
		local var_19_0 = cloneTplTo(arg_18_0._contentBannerTpl, arg_18_0._contentContainer)

		table.insert(arg_18_0._contentList, var_19_0)
		arg_18_0:setImage(arg_18_1.id, arg_18_1.version, arg_19_0, var_19_0, true, nil)
	end

	local function var_18_1(arg_20_0)
		local var_20_0 = cloneTplTo(arg_18_0._contentTxtTpl, arg_18_0._contentContainer)

		table.insert(arg_18_0._contentList, var_20_0)
		setText(var_20_0, SwitchSpecialChar(arg_20_0, true))
		var_20_0:GetComponent("RichText"):AddListener(function(arg_21_0, arg_21_1)
			if arg_21_0 == "url" then
				Application.OpenURL(arg_21_1)
			end
		end)
	end

	arg_18_0:clearLoadingPic()
	arg_18_0:clearLeanTween()
	arg_18_0:clearContent()

	if arg_18_1.paramType then
		setActive(arg_18_0._detailTitle, false)
		setActive(arg_18_0._detailLine, false)
		setActive(arg_18_0._contentContainer, false)
		setActive(arg_18_0._bottom, false)

		arg_18_0._detailTitleImgLayoutElement.preferredHeight = var_0_0.TITLE_IMAGE_HEIGHT_FULL

		arg_18_0:setImage(arg_18_1.id, arg_18_1.version, arg_18_1.titleImage, arg_18_0._detailTitleImg)
		onButton(arg_18_0, arg_18_0._detailTitleImg, function()
			if arg_18_1.paramType == 1 then
				Application.OpenURL(arg_18_1.param)
				arg_18_0:emit(NewBulletinBoardMediator.TRACK_OPEN_URL, arg_18_1.track)
			elseif arg_18_1.paramType == 2 then
				arg_18_0:emit(NewBulletinBoardMediator.GO_SCENE, arg_18_1.param)
			elseif arg_18_1.paramType == 3 then
				arg_18_0:emit(NewBulletinBoardMediator.GO_SCENE, SCENE.ACTIVITY, {
					id = arg_18_1.param
				})
			elseif arg_18_1.paramType == 4 then
				local var_22_0 = pg.activity_banner_notice[arg_18_1.param].param

				arg_18_0:emit(NewBulletinBoardMediator.GO_SCENE, var_22_0[1], var_22_0[2])
			elseif arg_18_1.paramType == 5 then
				if not pg.NewStoryMgr.GetInstance():IsPlayed("JIARIBIESHUCHOUBEIZHONG5") then
					arg_18_0:emit(NewBulletinBoardMediator.GO_SCENE, SCENE.ACTIVITY, {
						id = 5922
					})
				else
					arg_18_0:emit(NewBulletinBoardMediator.GO_SCENE, SCENE.HOLIDAY_VILLA_MAP)
				end
			end

			arg_18_0.contextData.defaultMainTab = arg_18_0.currentMainTab
			arg_18_0.contextData.defaultSubTab = arg_18_0.currentSubTab
		end, SFX_PANEL)
	else
		setActive(arg_18_0._detailTitle, true)
		setActive(arg_18_0._detailLine, true)
		setActive(arg_18_0._contentContainer, true)
		setActive(arg_18_0._bottom, true)
		setScrollText(arg_18_0._detailTitleTxt, arg_18_1.pageTitle)
		setText(arg_18_0._detailTimeTxt, arg_18_1.timeDes)

		arg_18_0._detailTitleImgLayoutElement.preferredHeight = var_0_0.TITLE_IMAGE_HEIGHT_DEFAULT

		arg_18_0:setImage(arg_18_1.id, arg_18_1.version, arg_18_1.titleImage, arg_18_0._detailTitleImg)
		removeOnButton(arg_18_0._detailTitleImg)

		local function var_18_2(arg_23_0)
			local var_23_0 = #arg_23_0

			if #arg_23_0 == 0 then
				return ""
			end

			local var_23_1, var_23_2 = string.find(arg_23_0, "^[ ]*\n")

			var_23_2 = var_23_2 or 0

			local var_23_3 = string.find(arg_23_0, "\n[ ]*$") or var_23_0 + 1

			return string.sub(arg_23_0, var_23_2 + 1, var_23_3 - 1)
		end

		arg_18_0._contentInfo = {}

		local var_18_3 = 1

		for iter_18_0 in string.gmatch(arg_18_1.content, "<banner>%S-</banner>") do
			local var_18_4, var_18_5 = string.find(iter_18_0, "<banner>")
			local var_18_6, var_18_7 = string.find(iter_18_0, "</banner>")
			local var_18_8 = string.sub(iter_18_0, var_18_5 + 1, var_18_6 - 1)
			local var_18_9, var_18_10 = string.find(arg_18_1.content, iter_18_0, var_18_3, true)

			if var_18_9 ~= nil then
				local var_18_11 = var_18_2(string.sub(arg_18_1.content, var_18_3, var_18_9 - 1))

				if #var_18_11 > 0 then
					table.insert(arg_18_0._contentInfo, {
						type = var_0_0.CONTENT_TYPE.RICHTEXT,
						text = var_18_11
					})
				end
			end

			table.insert(arg_18_0._contentInfo, {
				type = var_0_0.CONTENT_TYPE.BANNER,
				text = var_18_8
			})

			var_18_3 = var_18_10 + 1
		end

		if var_18_3 < #arg_18_1.content then
			table.insert(arg_18_0._contentInfo, {
				type = var_0_0.CONTENT_TYPE.RICHTEXT,
				text = var_18_2(string.sub(arg_18_1.content, var_18_3, #arg_18_1.content))
			})
		end

		for iter_18_1, iter_18_2 in pairs(arg_18_0._contentInfo) do
			if iter_18_2.type == var_0_0.CONTENT_TYPE.RICHTEXT then
				var_18_1(iter_18_2.text)
			elseif iter_18_2.type == var_0_0.CONTENT_TYPE.BANNER then
				var_18_0(iter_18_2.text)
			end
		end

		arg_18_0:bannerRotate()
	end
end

function var_0_0.bannerRotate(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0._contentList) do
		local var_24_0 = iter_24_1:Find("loading/Image")

		if var_24_0 then
			table.insert(arg_24_0.LTList, LeanTween.rotateAroundLocal(rtf(var_24_0), Vector3(0, 0, -1), 360, 5):setLoopClamp().uniqueId)
		end
	end
end

function var_0_0.clearLeanTween(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.LTList or {}) do
		LeanTween.cancel(iter_25_1)
	end
end

function var_0_0.clearContent(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0._contentList) do
		Destroy(iter_26_1)
	end

	arg_26_0._contentList = {}
end

function var_0_0.clearTab(arg_27_0)
	if arg_27_0.subTabLT then
		LeanTween.cancel(arg_27_0.subTabLT)

		arg_27_0.subTabLT = nil
	end

	arg_27_0.currentSubTab = nil

	for iter_27_0, iter_27_1 in pairs(arg_27_0._subTabList) do
		Destroy(iter_27_1)
	end

	arg_27_0._subTabList = {}
	arg_27_0._subTabAnims = {}
end

function var_0_0.clearLoadingPic(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0._loadingFlag) do
		BulletinBoardMgr.Inst:StopLoader(iter_28_0)

		arg_28_0._loadingFlag[iter_28_0] = nil
	end
end

function var_0_0.willExit(arg_29_0)
	arg_29_0:clearLoadingPic()
	pg.UIMgr.GetInstance():UnblurPanel(arg_29_0._tf)
end

return var_0_0
