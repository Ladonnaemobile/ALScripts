local var_0_0 = class("ClueBookLayer", import("view.base.BaseUI"))
local var_0_1 = pg.activity_clue
local var_0_2 = pg.activity_clue_group
local var_0_3 = pg.activity_clue_ending

function var_0_0.getUIName(arg_1_0)
	return "ClueBookUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.closeBtn = arg_2_0:findTF("frame/close")
	arg_2_0.pageTgs = {
		arg_2_0:findTF("frame/toggles/sitePageTg"),
		arg_2_0:findTF("frame/toggles/charaPageTg"),
		arg_2_0:findTF("frame/toggles/endingPageTg"),
		arg_2_0:findTF("frame/toggles/storyPageTg")
	}
	arg_2_0.pages = arg_2_0:findTF("frame/pages")
	arg_2_0.sitePage = arg_2_0:findTF("sitePage", arg_2_0.pages)
	arg_2_0.charaPage = arg_2_0:findTF("charaPage", arg_2_0.pages)
	arg_2_0.endingPage = arg_2_0:findTF("endingPage", arg_2_0.pages)
	arg_2_0.storyPage = arg_2_0:findTF("storyPage", arg_2_0.pages)
	arg_2_0.award = arg_2_0:findTF("frame/award")

	setText(arg_2_0:findTF("Text", arg_2_0.pageTgs[1]), i18n("clue_title_1"))
	setText(arg_2_0:findTF("selected/Text", arg_2_0.pageTgs[1]), i18n("clue_title_1"))
	setText(arg_2_0:findTF("Text", arg_2_0.pageTgs[2]), i18n("clue_title_2"))
	setText(arg_2_0:findTF("selected/Text", arg_2_0.pageTgs[2]), i18n("clue_title_2"))
	setText(arg_2_0:findTF("Text", arg_2_0.pageTgs[3]), i18n("clue_title_3"))
	setText(arg_2_0:findTF("selected/Text", arg_2_0.pageTgs[3]), i18n("clue_title_3"))
	setText(arg_2_0:findTF("Text", arg_2_0.pageTgs[4]), i18n("clue_title_4"))
	setText(arg_2_0:findTF("selected/Text", arg_2_0.pageTgs[4]), i18n("clue_title_4"))

	for iter_2_0 = 1, 3 do
		setText(arg_2_0:findTF("right/Viewport/Content/siteGroup" .. iter_2_0 .. "/goBtn/Text", arg_2_0.sitePage), i18n("clue_task_goto"))
	end

	setText(arg_2_0:findTF("right/goBtn/Text", arg_2_0.charaPage), i18n("clue_task_goto"))
	setText(arg_2_0:findTF("doing/Text", arg_2_0.award), i18n("clue_get"))
	setText(arg_2_0:findTF("get/Text", arg_2_0.award), i18n("clue_get"))
	setText(arg_2_0:findTF("got/Text", arg_2_0.award), i18n("clue_got"))
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:InitData()
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:StopBgm()
		arg_3_0:closeView()
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0:findTF("mask"), function()
		arg_3_0:StopBgm()
		arg_3_0:closeView()
	end, SFX_PANEL)
	arg_3_0:InitView()
	arg_3_0:UpdateView()
	pg.BgmMgr.GetInstance():Push(arg_3_0.__cname, arg_3_0.bgm)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf, false)
end

function var_0_0.InitData(arg_6_0)
	arg_6_0.activityId = ActivityConst.Valleyhospital_ACT_ID
	arg_6_0.taskActivityId = ActivityConst.Valleyhospital_TASK_ID
	arg_6_0.activity = getProxy(ActivityProxy):getActivityById(arg_6_0.activityId)
	arg_6_0.taskProxy = getProxy(TaskProxy)

	local var_6_0 = arg_6_0.activity:getConfig("config_client")

	arg_6_0.clueSite = var_6_0.clue_site
	arg_6_0.clueChara = var_6_0.clue_chara
	arg_6_0.clueEnding = var_6_0.clue_ending
	arg_6_0.story = var_6_0.story
	arg_6_0.storyTaskId = var_6_0.storyTaskId
	arg_6_0.afterStory = var_6_0.afterStory
	arg_6_0.bgm = var_6_0.bgm2
	arg_6_0.pageIndex = 1
	arg_6_0.subPageSiteIndex = 1
	arg_6_0.subPageCharaIndex = 1
	arg_6_0.subPageEndingIndex = 1
	arg_6_0.endingIndex = 1
	arg_6_0.storyIndex = 1
	arg_6_0.playerId = getProxy(PlayerProxy):getRawData().id
	arg_6_0.investigatingGroupId = PlayerPrefs.GetInt("investigatingGroupId_" .. arg_6_0.activityId .. "_" .. arg_6_0.playerId)
end

function var_0_0.InitView(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.pageTgs) do
		setActive(arg_7_0:findTF("selected", iter_7_1), arg_7_0.pageIndex == iter_7_0)
		onToggle(arg_7_0, iter_7_1, function(arg_8_0)
			if arg_8_0 then
				arg_7_0.pageIndex = iter_7_0

				for iter_8_0 = 0, arg_7_0.pages.childCount - 1 do
					setActive(arg_7_0.pages:GetChild(iter_8_0), iter_8_0 == iter_7_0 - 1)
					setActive(arg_7_0:findTF("tip", arg_7_0.pageTgs[iter_8_0 + 1]), var_0_0.ShouldShowTip(iter_8_0 + 1))
					setActive(arg_7_0:findTF("selected", arg_7_0.pageTgs[iter_8_0 + 1]), arg_7_0.pageIndex == iter_8_0 + 1)
				end

				if iter_7_0 == 1 then
					arg_7_0:ShowSitePage()
				elseif iter_7_0 == 2 then
					arg_7_0:ShowCharaPage()
				elseif iter_7_0 == 3 then
					arg_7_0:ShowEndingPage()
				elseif iter_7_0 == 4 then
					arg_7_0:ShowStoryPage()
				end
			end
		end, SFX_PANEL)
	end
end

function var_0_0.UpdateView(arg_9_0)
	triggerToggle(arg_9_0.pageTgs[arg_9_0.pageIndex], true)
end

function var_0_0.SetClueGroup(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = var_0_2[arg_10_1]
	local var_10_1 = var_0_1.get_id_list_by_group[arg_10_1]
	local var_10_2 = {
		var_0_1[var_10_1[1]],
		var_0_1[var_10_1[2]],
		var_0_1[var_10_1[3]]
	}
	local var_10_3 = {}
	local var_10_4 = arg_10_0.taskProxy:getTaskVO(tonumber(var_10_2[3].task_id)):getProgress()

	for iter_10_0 = 1, 3 do
		var_10_3[iter_10_0] = arg_10_0.taskProxy:getFinishTaskById(tonumber(var_10_2[iter_10_0].task_id))
	end

	setText(arg_10_0:findTF("title/Text", arg_10_2), var_10_0.title)
	setActive(arg_10_0:findTF("title/Text", arg_10_2), var_10_3[1] or var_10_3[2] or var_10_3[3])
	setActive(arg_10_0:findTF("title/lock", arg_10_2), not var_10_3[1] and not var_10_3[2] and not var_10_3[3])
	LoadImageSpriteAsync("cluepictures/" .. var_10_0.pic, arg_10_0:findTF("picture", arg_10_2), false)
	setActive(arg_10_0:findTF("picture/lock", arg_10_2), not var_10_3[1] and not var_10_3[2] and not var_10_3[3])

	for iter_10_1 = 1, 3 do
		if var_10_3[iter_10_1] then
			setText(arg_10_0:findTF("clue" .. iter_10_1, arg_10_2), var_10_2[iter_10_1].desc)
		elseif arg_10_0.investigatingGroupId == arg_10_1 then
			setText(arg_10_0:findTF("clue" .. iter_10_1, arg_10_2), "<color=#858593>" .. var_10_2[iter_10_1].unlock_desc .. var_10_2[iter_10_1].unlock_num .. i18n("clue_task_tip", var_10_4) .. "</color>")
		else
			setText(arg_10_0:findTF("clue" .. iter_10_1, arg_10_2), "<color=#858593>？？？</color>")
		end
	end

	setActive(arg_10_0:findTF("goBtn", arg_10_2), not var_10_3[1] or not var_10_3[2] or not var_10_3[3])
	setActive(arg_10_0:findTF("goBtn/selected", arg_10_2), arg_10_0.investigatingGroupId == arg_10_1)
	onButton(arg_10_0, arg_10_0:findTF("goBtn", arg_10_2), function()
		arg_10_0.investigatingGroupId = arg_10_1

		PlayerPrefs.SetInt("investigatingGroupId_" .. arg_10_0.activityId .. "_" .. arg_10_0.playerId, arg_10_1)
		setActive(arg_10_0:findTF("goBtn/selected", arg_10_2), true)

		if arg_10_0.pageIndex == 1 then
			arg_10_0:ShowSitePage()
		elseif arg_10_0.pageIndex == 2 then
			arg_10_0:ShowCharaPage()
		end

		arg_10_0:OpenChapter(arg_10_1)
		arg_10_0:StopBgm()
		arg_10_0:closeView()
	end, SFX_PANEL)
end

function var_0_0.SetAward(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.taskProxy:getTaskVO(arg_12_1)
	local var_12_1 = var_12_0:getConfig("award_display")[1]
	local var_12_2 = {
		type = var_12_1[1],
		id = var_12_1[2],
		count = var_12_1[3]
	}

	updateDrop(arg_12_0:findTF("mask/IconTpl", arg_12_0.award), var_12_2)
	onButton(arg_12_0, arg_12_0:findTF("mask", arg_12_0.award), function()
		arg_12_0:emit(BaseUI.ON_DROP, var_12_2)
	end, SFX_PANEL)

	local var_12_3 = var_12_0:getTaskStatus()

	setText(arg_12_0:findTF("Text", arg_12_0.award), var_12_0:getConfig("desc"))
	setActive(arg_12_0:findTF("mask/IconTpl/mask", arg_12_0.award), var_12_3 == 2)
	setActive(arg_12_0:findTF("doing", arg_12_0.award), var_12_3 == 0)
	setActive(arg_12_0:findTF("get", arg_12_0.award), var_12_3 == 1)
	setActive(arg_12_0:findTF("got", arg_12_0.award), var_12_3 == 2)

	if arg_12_2 then
		onButton(arg_12_0, arg_12_0:findTF("get", arg_12_0.award), function()
			arg_12_0:emit(ClueBookMediator.ON_TASK_SUBMIT_ONESTEP, arg_12_0.taskActivityId, {
				arg_12_1
			}, function(arg_15_0)
				if arg_15_0 then
					arg_12_2()
				end
			end)
		end, SFX_PANEL)
	else
		onButton(arg_12_0, arg_12_0:findTF("get", arg_12_0.award), function()
			arg_12_0:emit(ClueBookMediator.ON_TASK_SUBMIT_ONESTEP, arg_12_0.taskActivityId, {
				arg_12_1
			})
		end, SFX_PANEL)
	end
end

function var_0_0.ShowSitePage(arg_17_0)
	local var_17_0 = UIItemList.New(arg_17_0:findTF("left/Viewport/Content", arg_17_0.sitePage), arg_17_0:findTF("left/Viewport/Content/pageTg", arg_17_0.sitePage))

	var_17_0:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			local var_18_0 = arg_17_0.clueSite[arg_18_1 + 1]
			local var_18_1 = tonumber(var_0_2[var_18_0[1]].task_id)
			local var_18_2 = arg_17_0.taskProxy:getTaskVO(var_18_1):getTaskStatus()

			setText(arg_18_2:Find("Text"), "PAGE  " .. string.format("%02d", arg_18_1 + 1))
			setText(arg_18_2:Find("selected/Text"), "PAGE  " .. string.format("%02d", arg_18_1 + 1))
			setActive(arg_18_2:Find("Text"), arg_17_0.subPageSiteIndex ~= arg_18_1 + 1)
			setActive(arg_18_2:Find("selected"), arg_17_0.subPageSiteIndex == arg_18_1 + 1)
			setActive(arg_18_2:Find("completed"), var_18_2 == 2)
			setActive(arg_18_2:Find("tip"), var_18_2 == 1)
			onToggle(arg_17_0, arg_18_2, function(arg_19_0)
				if arg_19_0 then
					arg_17_0.subPageSiteIndex = arg_18_1 + 1

					for iter_19_0 = 1, #arg_17_0.clueSite do
						setActive(arg_17_0:findTF("left/Viewport/Content", arg_17_0.sitePage):GetChild(iter_19_0 - 1):Find("Text"), arg_17_0.subPageSiteIndex ~= iter_19_0)
						setActive(arg_17_0:findTF("left/Viewport/Content", arg_17_0.sitePage):GetChild(iter_19_0 - 1):Find("selected"), arg_17_0.subPageSiteIndex == iter_19_0)
					end

					for iter_19_1 = 1, 3 do
						local var_19_0 = var_18_0[iter_19_1]

						arg_17_0:SetClueGroup(var_19_0, arg_17_0:findTF("right/Viewport/Content/siteGroup" .. iter_19_1, arg_17_0.sitePage))
					end

					arg_17_0:SetAward(var_18_1)
				end
			end, SFX_PANEL)

			if arg_17_0.subPageSiteIndex == arg_18_1 + 1 then
				triggerToggle(arg_18_2, true)
			end
		end
	end)
	var_17_0:align(#arg_17_0.clueSite)
end

function var_0_0.ShowCharaPage(arg_20_0)
	local var_20_0 = UIItemList.New(arg_20_0:findTF("left/Viewport/Content", arg_20_0.charaPage), arg_20_0:findTF("left/Viewport/Content/pageTg", arg_20_0.charaPage))

	var_20_0:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			local var_21_0 = arg_20_0.clueChara[arg_21_1 + 1][1]
			local var_21_1 = tonumber(var_0_2[var_21_0].task_id)
			local var_21_2 = arg_20_0.taskProxy:getTaskVO(var_21_1):getTaskStatus()

			if arg_20_0:GetGroupClueCompleteCount(var_21_0) == 0 then
				setText(arg_21_2:Find("Text"), "？？？")
				setText(arg_21_2:Find("selected/Text"), "？？？")
			else
				setText(arg_21_2:Find("Text"), var_0_2[var_21_0].title)
				setText(arg_21_2:Find("selected/Text"), var_0_2[var_21_0].title)
			end

			setActive(arg_21_2:Find("Text"), arg_20_0.subPageCharaIndex ~= arg_21_1 + 1)
			setActive(arg_21_2:Find("selected"), arg_20_0.subPageCharaIndex == arg_21_1 + 1)
			setActive(arg_21_2:Find("Text/completed"), var_21_2 == 2)
			setActive(arg_21_2:Find("selected/Text/completed"), var_21_2 == 2)
			setActive(arg_21_2:Find("tip"), var_21_2 == 1)
			onToggle(arg_20_0, arg_21_2, function(arg_22_0)
				if arg_22_0 then
					arg_20_0.subPageCharaIndex = arg_21_1 + 1

					for iter_22_0 = 1, #arg_20_0.clueChara do
						setActive(arg_20_0:findTF("left/Viewport/Content", arg_20_0.charaPage):GetChild(iter_22_0 - 1):Find("Text"), arg_20_0.subPageCharaIndex ~= iter_22_0)
						setActive(arg_20_0:findTF("left/Viewport/Content", arg_20_0.charaPage):GetChild(iter_22_0 - 1):Find("selected"), arg_20_0.subPageCharaIndex == iter_22_0)
					end

					arg_20_0:SetClueGroup(var_21_0, arg_20_0:findTF("right", arg_20_0.charaPage))
					arg_20_0:SetAward(var_21_1)
				end
			end, SFX_PANEL)

			if arg_20_0.subPageCharaIndex == arg_21_1 + 1 then
				triggerToggle(arg_21_2, true)
			end
		end
	end)
	var_20_0:align(#arg_20_0.clueChara)
	onScroll(arg_20_0, arg_20_0:findTF("left", arg_20_0.charaPage), function(arg_23_0)
		setActive(arg_20_0:findTF("triangle", arg_20_0.charaPage), arg_23_0.y > 0.01)
	end)
end

function var_0_0.GetGroupClueCompleteCount(arg_24_0, arg_24_1)
	local var_24_0 = var_0_1.get_id_list_by_group[arg_24_1]
	local var_24_1 = {
		var_0_1[var_24_0[1]],
		var_0_1[var_24_0[2]],
		var_0_1[var_24_0[3]]
	}
	local var_24_2 = 0

	for iter_24_0 = 1, 3 do
		if arg_24_0.taskProxy:getFinishTaskById(tonumber(var_24_1[iter_24_0].task_id)) then
			var_24_2 = var_24_2 + 1
		end
	end

	return var_24_2
end

function var_0_0.ShowEndingPage(arg_25_0)
	local var_25_0 = UIItemList.New(arg_25_0:findTF("left/Viewport/Content", arg_25_0.endingPage), arg_25_0:findTF("left/Viewport/Content/pageTg", arg_25_0.endingPage))

	var_25_0:make(function(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_0 == UIItemList.EventUpdate then
			local var_26_0 = arg_25_0.clueEnding[arg_26_1 + 1][1]
			local var_26_1 = arg_25_0.clueEnding[arg_26_1 + 1][2]
			local var_26_2 = arg_25_0.taskProxy:getTaskVO(var_26_1):getTaskStatus()

			setText(arg_26_2:Find("Text"), var_0_3[var_26_0[#var_26_0]].title2)
			setText(arg_26_2:Find("selected/Text"), var_0_3[var_26_0[#var_26_0]].title2)
			setActive(arg_26_2:Find("Text"), arg_25_0.subPageEndingIndex ~= arg_26_1 + 1)
			setActive(arg_26_2:Find("selected"), arg_25_0.subPageEndingIndex == arg_26_1 + 1)
			setActive(arg_26_2:Find("Text/completed"), var_26_2 == 2)
			setActive(arg_26_2:Find("selected/Text/completed"), var_26_2 == 2)
			setActive(arg_26_2:Find("tip"), var_26_2 == 1)
			onToggle(arg_25_0, arg_26_2, function(arg_27_0)
				if arg_27_0 then
					arg_25_0.subPageEndingIndex = arg_26_1 + 1

					for iter_27_0 = 1, #arg_25_0.clueEnding do
						setActive(arg_25_0:findTF("left/Viewport/Content", arg_25_0.endingPage):GetChild(iter_27_0 - 1):Find("Text"), arg_25_0.subPageEndingIndex ~= iter_27_0)
						setActive(arg_25_0:findTF("left/Viewport/Content", arg_25_0.endingPage):GetChild(iter_27_0 - 1):Find("selected"), arg_25_0.subPageEndingIndex == iter_27_0)
					end

					table.sort(var_26_0, function(arg_28_0, arg_28_1)
						local var_28_0 = var_0_3[arg_28_0]
						local var_28_1 = var_0_3[arg_28_1]

						return var_28_0.unlock_pre < var_28_1.unlock_pre
					end)

					local var_27_0 = true

					for iter_27_1 = 1, #var_26_0 do
						local var_27_1 = var_26_0[iter_27_1]
						local var_27_2 = var_0_3[var_27_1]
						local var_27_3 = arg_25_0.taskProxy:getTaskVO(tonumber(var_27_2.task_id)):getTaskStatus()

						setActive(arg_25_0:findTF("right/ending" .. iter_27_1 .. "/icon", arg_25_0.endingPage), var_27_0)
						setActive(arg_25_0:findTF("right/ending" .. iter_27_1 .. "/selected", arg_25_0.endingPage), arg_25_0.endingIndex == iter_27_1)
						setActive(arg_25_0:findTF("right/ending" .. iter_27_1 .. "/lock", arg_25_0.endingPage), not var_27_0)
						setActive(arg_25_0:findTF("right/ending" .. iter_27_1 .. "/tip", arg_25_0.endingPage), var_27_3 == 1 and var_27_0)

						arg_25_0:findTF("right/ending" .. iter_27_1, arg_25_0.endingPage):GetComponent(typeof(CanvasGroup)).alpha = var_27_0 and 1 or 0.8

						if var_27_0 then
							setText(arg_25_0:findTF("right/ending" .. iter_27_1 .. "/title", arg_25_0.endingPage), var_27_2.title)
							onToggle(arg_25_0, arg_25_0:findTF("right/ending" .. iter_27_1, arg_25_0.endingPage), function(arg_29_0)
								if arg_29_0 then
									arg_25_0.endingIndex = iter_27_1

									for iter_29_0 = 1, #var_26_0 do
										setActive(arg_25_0:findTF("right/ending" .. iter_29_0 .. "/selected", arg_25_0.endingPage), iter_29_0 == arg_25_0.endingIndex)
									end

									local var_29_0 = var_27_2.clue
									local var_29_1 = var_27_2.locate

									setText(arg_25_0:findTF("middle/titleBg/Text", arg_25_0.endingPage), var_27_2.title2)
									setText(arg_25_0:findTF("middle/endingDetail/Viewport/Content/detail", arg_25_0.endingPage), var_27_2.desc)
									onScroll(arg_25_0, arg_25_0:findTF("middle/endingDetail", arg_25_0.endingPage), function(arg_30_0)
										setActive(arg_25_0:findTF("middle/triangle", arg_25_0.endingPage), arg_30_0.y > 0.01)
									end)
									setActive(arg_25_0:findTF("right/combine", arg_25_0.endingPage), var_27_3 == 1)
									onButton(arg_25_0, arg_25_0:findTF("right/combine", arg_25_0.endingPage), function()
										arg_25_0:emit(ClueBookMediator.ON_TASK_SUBMIT_ONESTEP, arg_25_0.taskActivityId, {
											tonumber(var_27_2.task_id)
										})
									end, SFX_PANEL)
									setActive(arg_25_0:findTF("middle/cluePanel", arg_25_0.endingPage), var_27_3 ~= 2)

									if var_27_3 ~= 2 then
										local var_29_2 = UIItemList.New(arg_25_0:findTF("middle/cluePanel", arg_25_0.endingPage), arg_25_0:findTF("middle/cluePanel/clueGroup", arg_25_0.endingPage))

										var_29_2:make(function(arg_32_0, arg_32_1, arg_32_2)
											if arg_32_0 == UIItemList.EventUpdate then
												local var_32_0 = var_29_0[arg_32_1 + 1]
												local var_32_1 = var_29_1[arg_32_1 + 1][1]
												local var_32_2 = var_29_1[arg_32_1 + 1][2]
												local var_32_3 = var_29_1[arg_32_1 + 1][3]

												if var_27_2.type == 1 then
													local var_32_4 = var_0_2[var_32_0]

													for iter_32_0 = 1, 4 do
														setActive(arg_32_2:Find("" .. iter_32_0), var_32_1 == iter_32_0)
													end

													setActive(arg_32_2:Find("ending"), false)

													local var_32_5 = arg_32_2:GetChild(var_32_1 - 1)
													local var_32_6 = arg_25_0:GetGroupClueCompleteCount(var_32_0)

													var_32_5:GetComponent(typeof(CanvasGroup)).alpha = var_32_6 == 0 and 0.4 or 1

													if var_32_6 == 0 then
														setText(arg_25_0:findTF("name/Text", var_32_5), "？？？")
													else
														setText(arg_25_0:findTF("name/Text", var_32_5), var_32_4.title)
													end

													setText(arg_25_0:findTF("progress", var_32_5), var_32_6 .. "/3")
													setActive(arg_25_0:findTF("progress", var_32_5), var_32_6 == 1 or var_32_6 == 2)
													setActive(arg_25_0:findTF("complete", var_32_5), var_32_6 == 3)
													onButton(arg_25_0, arg_32_2, function()
														arg_25_0:emit(ClueBookMediator.OPEN_SINGLE_CLUE_GROUP, var_32_0)
													end, SFX_PANEL)
												else
													local var_32_7 = var_0_3[var_32_0]

													setText(arg_32_2:Find("ending/name"), var_32_7.title2)

													for iter_32_1 = 1, 4 do
														setActive(arg_32_2:Find("" .. iter_32_1), false)
													end

													setActive(arg_32_2:Find("ending"), true)

													for iter_32_2 = 1, 3 do
														setActive(arg_32_2:Find("ending/icon" .. iter_32_2), arg_32_1 + 1 == iter_32_2)
													end

													onButton(arg_25_0, arg_32_2, function()
														triggerToggle(arg_25_0:findTF("right/ending" .. arg_32_1 + 1, arg_25_0.endingPage), true)
													end, SFX_PANEL)
												end

												arg_32_2.anchoredPosition = Vector2(var_32_2[1], var_32_2[2])
												arg_32_2.localScale = Vector3(var_32_3, var_32_3, 1)
											end
										end)
										var_29_2:align(#var_29_0)
									end
								end
							end, SFX_PANEL)
						else
							local var_27_4 = "64646a"

							if iter_27_1 == #var_26_0 then
								var_27_4 = "6683cf"
							end

							setText(arg_25_0:findTF("right/ending" .. iter_27_1 .. "/title", arg_25_0.endingPage), "<color=#" .. var_27_4 .. ">" .. var_27_2.title .. "</color>")
							removeOnToggle(arg_25_0:findTF("right/ending" .. iter_27_1, arg_25_0.endingPage))
						end

						if var_27_3 ~= 2 then
							var_27_0 = false
						end
					end

					triggerToggle(arg_25_0:findTF("right/ending" .. arg_25_0.endingIndex, arg_25_0.endingPage), true)
					arg_25_0:SetAward(var_26_1)
				end
			end, SFX_PANEL)

			if arg_25_0.subPageEndingIndex == arg_26_1 + 1 then
				triggerToggle(arg_26_2, true)
			end
		end
	end)
	var_25_0:align(#arg_25_0.clueEnding)
end

function var_0_0.ShowStoryPage(arg_35_0)
	local function var_35_0()
		setText(arg_35_0:findTF("pageIndex/Text", arg_35_0.storyPage), arg_35_0.storyIndex .. "/2")
		setActive(arg_35_0:findTF("leftBtn", arg_35_0.storyPage), arg_35_0.storyIndex == 2)
		setActive(arg_35_0:findTF("rightBtn", arg_35_0.storyPage), arg_35_0.storyIndex == 1)
		setActive(arg_35_0:findTF("subPages/page1", arg_35_0.storyPage), arg_35_0.storyIndex == 1)
		setActive(arg_35_0:findTF("subPages/page2", arg_35_0.storyPage), arg_35_0.storyIndex == 2)
	end

	var_35_0()
	onButton(arg_35_0, arg_35_0:findTF("leftBtn", arg_35_0.storyPage), function()
		arg_35_0.storyIndex = 1

		var_35_0()
	end, SFX_PANEL)
	onButton(arg_35_0, arg_35_0:findTF("rightBtn", arg_35_0.storyPage), function()
		arg_35_0.storyIndex = 2

		var_35_0()
	end, SFX_PANEL)

	for iter_35_0 = 1, #arg_35_0.story do
		local var_35_1

		if iter_35_0 <= 5 then
			var_35_1 = arg_35_0:findTF("subPages/page1", arg_35_0.storyPage):GetChild(iter_35_0 - 1)
		else
			var_35_1 = arg_35_0:findTF("subPages/page2", arg_35_0.storyPage):GetChild(iter_35_0 - 6)
		end

		local var_35_2 = arg_35_0.story[iter_35_0]
		local var_35_3 = var_35_2[1]
		local var_35_4 = var_35_2[2]
		local var_35_5 = var_35_2[3]
		local var_35_6 = var_35_2[4]
		local var_35_7 = arg_35_0.taskProxy:getTaskVO(var_35_5):getTaskStatus()

		if var_35_3 == 1 then
			setText(arg_35_0:findTF("lock/Text", var_35_1), i18n("clue_lock_tip1"))
		else
			setText(arg_35_0:findTF("lock/Text", var_35_1), i18n("clue_lock_tip2", var_0_3[var_35_4].title))
		end

		setActive(arg_35_0:findTF("lock", var_35_1), var_35_7 == 0)
		setActive(arg_35_0:findTF("canGet", var_35_1), var_35_7 == 1)

		var_35_1:GetComponent(typeof(CanvasGroup)).alpha = var_35_7 == 0 and 0.4 or 1

		if var_35_7 == 1 then
			onButton(arg_35_0, var_35_1, function()
				arg_35_0:emit(ClueBookMediator.ON_TASK_SUBMIT_ONESTEP, arg_35_0.taskActivityId, {
					var_35_5
				}, function(arg_40_0)
					if arg_40_0 then
						pg.NewStoryMgr.GetInstance():Play(var_35_6)
					end
				end)
			end, SFX_PANEL)
		elseif var_35_7 == 2 then
			onButton(arg_35_0, var_35_1, function()
				pg.NewStoryMgr.GetInstance():Play(var_35_6, nil, true)
			end, SFX_PANEL)
		else
			removeOnButton(var_35_1)
		end
	end

	arg_35_0:SetAward(arg_35_0.storyTaskId, function()
		pg.NewStoryMgr.GetInstance():Play(arg_35_0.afterStory)
	end)
end

function var_0_0.OpenChapter(arg_43_0, arg_43_1)
	arg_43_0:emit(ClueBookMediator.OPEN_CLUE_JUMP, arg_43_1)
end

function var_0_0.willExit(arg_44_0)
	return
end

function var_0_0.onBackPressed(arg_45_0)
	arg_45_0:StopBgm()
	arg_45_0:closeView()
end

function var_0_0.ShouldShowTip(arg_46_0)
	local var_46_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)
	local var_46_1 = getProxy(TaskProxy)
	local var_46_2 = var_46_0:getConfig("config_client")
	local var_46_3 = var_46_2.clue_site
	local var_46_4 = var_46_2.clue_chara
	local var_46_5 = var_46_2.clue_ending
	local var_46_6 = var_46_2.story
	local var_46_7 = var_46_2.storyTaskId

	if not arg_46_0 or arg_46_0 == 1 then
		for iter_46_0 = 1, #var_46_3 do
			local var_46_8 = var_46_3[iter_46_0]
			local var_46_9 = tonumber(var_0_2[var_46_8[1]].task_id)

			if var_46_1:getTaskVO(var_46_9):getTaskStatus() == 1 then
				return true
			end
		end
	end

	if not arg_46_0 or arg_46_0 == 2 then
		for iter_46_1 = 1, #var_46_4 do
			local var_46_10 = var_46_4[iter_46_1][1]
			local var_46_11 = tonumber(var_0_2[var_46_10].task_id)

			if var_46_1:getTaskVO(var_46_11):getTaskStatus() == 1 then
				return true
			end
		end
	end

	if not arg_46_0 or arg_46_0 == 3 then
		for iter_46_2 = 1, #var_46_5 do
			local var_46_12 = var_46_5[iter_46_2][1]
			local var_46_13 = var_46_5[iter_46_2][2]

			if var_46_1:getTaskVO(var_46_13):getTaskStatus() == 1 then
				return true
			end

			local var_46_14 = true

			for iter_46_3 = 1, #var_46_12 do
				local var_46_15 = var_46_12[iter_46_3]
				local var_46_16 = var_0_3[var_46_15]
				local var_46_17 = var_46_1:getTaskVO(tonumber(var_46_16.task_id)):getTaskStatus()

				if var_46_17 == 1 and var_46_14 then
					return true
				end

				if var_46_17 ~= 2 then
					var_46_14 = false
				end
			end
		end
	end

	if not arg_46_0 or arg_46_0 == 4 then
		if var_46_1:getTaskVO(var_46_7):getTaskStatus() == 1 then
			return true
		end

		for iter_46_4 = 1, #var_46_6 do
			local var_46_18 = var_46_6[iter_46_4][3]

			if var_46_1:getTaskVO(var_46_18):getTaskStatus() == 1 then
				return true
			end
		end
	end

	return false
end

return var_0_0
