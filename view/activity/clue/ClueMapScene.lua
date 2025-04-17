local var_0_0 = class("ClueMapScene", import("view.base.BaseUI"))
local var_0_1 = pg.activity_single_enemy
local var_0_2 = pg.activity_clue

function var_0_0.getUIName(arg_1_0)
	return "ClueMapUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.ui = arg_2_0:findTF("ui")
	arg_2_0.closeBtn = arg_2_0:findTF("ui/top/back_button")
	arg_2_0.homeBtn = arg_2_0:findTF("ui/top/home_button")
	arg_2_0.bgs = {
		arg_2_0:findTF("bgs/bg1"),
		arg_2_0:findTF("bgs/bg2"),
		arg_2_0:findTF("bgs/bg3")
	}
	arg_2_0.mapsSwitch = {
		arg_2_0:findTF("ui/mapsSwitch/map1"),
		arg_2_0:findTF("ui/mapsSwitch/map2"),
		arg_2_0:findTF("ui/mapsSwitch/map3")
	}
	arg_2_0.chapters = {
		arg_2_0:findTF("ui/chapters/t1"),
		arg_2_0:findTF("ui/chapters/t2"),
		arg_2_0:findTF("ui/chapters/t3"),
		arg_2_0:findTF("ui/chapters/t4")
	}
	arg_2_0.chapterSp = arg_2_0:findTF("ui/chapterSp")
	arg_2_0.pt = arg_2_0:findTF("ui/pt")
	arg_2_0.explore = arg_2_0:findTF("ui/exploreTarget")
	arg_2_0.taskBtn = arg_2_0:findTF("ui/taskBtn")
	arg_2_0.bookBtn = arg_2_0:findTF("ui/bookBtn")

	setText(arg_2_0:findTF("total", arg_2_0.pt), i18n("clue_pt_tip"))
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:InitData()
	arg_3_0:ShowResUI()
	arg_3_0:InitMapsSwitch()
	arg_3_0:UpdateCluePanel()
	setText(arg_3_0:findTF("Text", arg_3_0.pt), arg_3_0.ptData.count)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:StopBgm()
		arg_3_0:closeView()
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.homeBtn, function()
		arg_3_0:emit(var_0_0.ON_HOME)
	end, SFX_CANCEL)
	setActive(arg_3_0:findTF("tip", arg_3_0.taskBtn), ClueTasksLayer.ShouldShowTip())
	onButton(arg_3_0, arg_3_0.taskBtn, function()
		arg_3_0:emit(ClueMapMediator.OPEN_CLUE_TASk, function()
			if arg_3_0._tf then
				setActive(arg_3_0:findTF("tip", arg_3_0.taskBtn), ClueTasksLayer.ShouldShowTip())

				arg_3_0.ptActivity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_PT_ACT_ID)
				arg_3_0.ptData = ActivityPtData.New(arg_3_0.ptActivity)

				setText(arg_3_0:findTF("Text", arg_3_0.pt), arg_3_0.ptData.count)

				arg_3_0.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)

				setText(arg_3_0:findTF("ticket/count", arg_3_0.chapterSp), "X " .. arg_3_0.activity.data1)
			end
		end)
	end, SFX_PANEL)
	setActive(arg_3_0:findTF("tip", arg_3_0.bookBtn), ClueBookLayer.ShouldShowTip())
	onButton(arg_3_0, arg_3_0.bookBtn, function()
		arg_3_0:emit(ClueMapMediator.OPEN_CLUE_BOOK, function()
			if arg_3_0._tf then
				arg_3_0:UpdateCluePanel()
				setActive(arg_3_0:findTF("tip", arg_3_0.bookBtn), ClueBookLayer.ShouldShowTip())

				arg_3_0.ptActivity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_PT_ACT_ID)
				arg_3_0.ptData = ActivityPtData.New(arg_3_0.ptActivity)

				setText(arg_3_0:findTF("Text", arg_3_0.pt), arg_3_0.ptData.count)

				arg_3_0.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)

				setText(arg_3_0:findTF("ticket/count", arg_3_0.chapterSp), "X " .. arg_3_0.activity.data1)
			end
		end)
	end, SFX_PANEL)
	pg.NewStoryMgr.GetInstance():Play(arg_3_0.enterStory)
	arg_3_0:SubmitClueTask()

	if getProxy(ContextProxy):getContextByMediator(ClueMapMediator).cleanChild and arg_3_0.contextData.bookOpen then
		triggerButton(arg_3_0.bookBtn)
	end
end

function var_0_0.InitData(arg_10_0)
	arg_10_0.easyChapters = {}
	arg_10_0.normalChapters = {}
	arg_10_0.hardChapters = {}
	arg_10_0.spChapter = nil

	for iter_10_0, iter_10_1 in ipairs(var_0_1.all) do
		local var_10_0 = var_0_1[iter_10_1]

		if var_10_0.activity_type == 2 then
			if var_10_0.type == 1 then
				table.insert(arg_10_0.easyChapters, var_10_0)
			elseif var_10_0.type == 2 then
				table.insert(arg_10_0.normalChapters, var_10_0)
			elseif var_10_0.type == 3 then
				table.insert(arg_10_0.hardChapters, var_10_0)
			elseif var_10_0.type == 4 then
				arg_10_0.spChapter = var_10_0
			end
		end
	end

	arg_10_0.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)
	arg_10_0.ptActivity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_PT_ACT_ID)
	arg_10_0.ptData = ActivityPtData.New(arg_10_0.ptActivity)
	arg_10_0.contextData.mapIndex = defaultValue(arg_10_0.contextData.mapIndex, 1)
	arg_10_0.submitGroupIds = {}
	arg_10_0.canSubmitTaskIds = {}
	arg_10_0.submitClueIds = {}

	for iter_10_2, iter_10_3 in pairs(var_0_2.get_id_list_by_group) do
		local var_10_1 = false

		for iter_10_4, iter_10_5 in ipairs(iter_10_3) do
			local var_10_2 = var_0_2[iter_10_5]
			local var_10_3 = tonumber(var_10_2.task_id)

			if getProxy(TaskProxy):getTaskVO(var_10_3):getTaskStatus() == 1 then
				if not arg_10_0.canSubmitTaskIds[iter_10_2] then
					arg_10_0.canSubmitTaskIds[iter_10_2] = {}
					arg_10_0.submitClueIds[iter_10_2] = {}
				end

				table.insert(arg_10_0.canSubmitTaskIds[iter_10_2], var_10_3)
				table.insert(arg_10_0.submitClueIds[iter_10_2], iter_10_5)

				var_10_1 = true
			end
		end

		if var_10_1 then
			table.insert(arg_10_0.submitGroupIds, iter_10_2)
		end
	end

	local var_10_4 = arg_10_0.activity:getConfig("config_client")

	arg_10_0.enterStory = var_10_4.enterStory
	arg_10_0.bgms = var_10_4.bgm1
end

function var_0_0.RefreshPtAndTicket(arg_11_0)
	arg_11_0.ptActivity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_PT_ACT_ID)
	arg_11_0.ptData = ActivityPtData.New(arg_11_0.ptActivity)

	setText(arg_11_0:findTF("Text", arg_11_0.pt), arg_11_0.ptData.count)

	arg_11_0.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)

	setText(arg_11_0:findTF("ticket/count", arg_11_0.chapterSp), "X " .. arg_11_0.activity.data1)
end

function var_0_0.ShowResUI(arg_12_0)
	local var_12_0 = getProxy(PlayerProxy):getRawData()

	arg_12_0.goldMax = findTF(arg_12_0._tf, "ui/top/res/gold/max"):GetComponent(typeof(Text))
	arg_12_0.goldValue = findTF(arg_12_0._tf, "ui/top/res/gold/Text"):GetComponent(typeof(Text))
	arg_12_0.oilMax = findTF(arg_12_0._tf, "ui/top/res/oil/max"):GetComponent(typeof(Text))
	arg_12_0.oilValue = findTF(arg_12_0._tf, "ui/top/res/oil/Text"):GetComponent(typeof(Text))
	arg_12_0.gemValue = findTF(arg_12_0._tf, "ui/top/res/gem/Text"):GetComponent(typeof(Text))

	PlayerResUI.StaticFlush(var_12_0, arg_12_0.goldMax, arg_12_0.goldValue, arg_12_0.oilMax, arg_12_0.oilValue, arg_12_0.gemValue)
	onButton(arg_12_0, findTF(arg_12_0._tf, "ui/top/res/gold"), function()
		pg.playerResUI:ClickGold()
	end, SFX_PANEL)
	onButton(arg_12_0, findTF(arg_12_0._tf, "ui/top/res/oil"), function()
		pg.playerResUI:ClickOil()
	end, SFX_PANEL)
	onButton(arg_12_0, findTF(arg_12_0._tf, "ui/top/res/gem"), function()
		pg.playerResUI:ClickGem()
	end, SFX_PANEL)
end

function var_0_0.UpdateCluePanel(arg_16_0)
	local var_16_0 = ActivityConst.Valleyhospital_ACT_ID
	local var_16_1 = getProxy(PlayerProxy):getRawData().id
	local var_16_2 = PlayerPrefs.GetInt("investigatingGroupId_" .. var_16_0 .. "_" .. var_16_1, 0)
	local var_16_3 = true
	local var_16_4
	local var_16_5 = 0

	if var_16_2 ~= 0 then
		local var_16_6 = var_0_2.get_id_list_by_group[var_16_2]

		var_16_4 = {
			var_0_2[var_16_6[1]],
			var_0_2[var_16_6[2]],
			var_0_2[var_16_6[3]]
		}
		var_16_5 = getProxy(TaskProxy):getTaskVO(tonumber(var_16_4[3].task_id)):getProgress()

		for iter_16_0 = 1, 3 do
			if not getProxy(TaskProxy):getFinishTaskById(tonumber(var_16_4[iter_16_0].task_id)) then
				var_16_3 = false

				break
			end
		end
	end

	if var_16_3 then
		setText(arg_16_0:findTF("target/Text", arg_16_0.explore), i18n("clue_unselect_tip"))
	else
		setText(arg_16_0:findTF("target/Text", arg_16_0.explore), var_16_4[1].unlock_desc .. var_16_4[1].unlock_num .. "/" .. var_16_4[2].unlock_num .. "/" .. var_16_4[3].unlock_num .. i18n("clue_task_tip", var_16_5))
	end
end

function var_0_0.InitMapsSwitch(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.mapsSwitch) do
		onToggle(arg_17_0, iter_17_1, function(arg_18_0)
			if arg_18_0 then
				arg_17_0.contextData.mapIndex = iter_17_0

				for iter_18_0 = 1, 3 do
					setActive(arg_17_0.bgs[iter_18_0], iter_18_0 == iter_17_0)

					arg_17_0.mapsSwitch[iter_18_0]:GetComponent(typeof(CanvasGroup)).alpha = iter_18_0 == iter_17_0 and 1 or 0.4
				end

				if iter_17_0 == 1 then
					for iter_18_1, iter_18_2 in ipairs(arg_17_0.chapters) do
						setActive(arg_17_0:findTF("dusk", iter_18_2), iter_17_0 == 2)
						setActive(arg_17_0:findTF("night", iter_18_2), iter_17_0 == 3)
						setActive(arg_17_0:findTF("title", iter_18_2), true)
						setActive(arg_17_0:findTF("title2", iter_18_2), false)
						onButton(arg_17_0, iter_18_2, function()
							arg_17_0:OpenChapterLayer(arg_17_0.easyChapters[iter_18_1].id)
						end, SFX_PANEL)
					end
				elseif iter_17_0 == 2 then
					for iter_18_3, iter_18_4 in ipairs(arg_17_0.chapters) do
						setActive(arg_17_0:findTF("dusk", iter_18_4), iter_17_0 == 2)
						setActive(arg_17_0:findTF("night", iter_18_4), iter_17_0 == 3)
						setActive(arg_17_0:findTF("title", iter_18_4), true)
						setActive(arg_17_0:findTF("title2", iter_18_4), false)
						onButton(arg_17_0, iter_18_4, function()
							arg_17_0:OpenChapterLayer(arg_17_0.normalChapters[iter_18_3].id)
						end, SFX_PANEL)
					end
				else
					for iter_18_5, iter_18_6 in ipairs(arg_17_0.chapters) do
						setActive(arg_17_0:findTF("dusk", iter_18_6), iter_17_0 == 2)
						setActive(arg_17_0:findTF("night", iter_18_6), iter_17_0 == 3)
						setActive(arg_17_0:findTF("title", iter_18_6), false)
						setActive(arg_17_0:findTF("title2", iter_18_6), true)
						onButton(arg_17_0, iter_18_6, function()
							arg_17_0:OpenChapterLayer(arg_17_0.hardChapters[iter_18_5].id)
						end, SFX_PANEL)
					end
				end

				setActive(arg_17_0:findTF("dusk", arg_17_0.chapterSp), iter_17_0 == 2)
				setActive(arg_17_0:findTF("night", arg_17_0.chapterSp), iter_17_0 == 3)
				GetImageSpriteFromAtlasAsync(pg.item_virtual_data_statistics[arg_17_0.spChapter.enter_cost].icon, "", arg_17_0:findTF("ticket/icon", arg_17_0.chapterSp), false)

				arg_17_0.activity = getProxy(ActivityProxy):getActivityById(ActivityConst.Valleyhospital_ACT_ID)

				setText(arg_17_0:findTF("ticket/count", arg_17_0.chapterSp), "X " .. arg_17_0.activity.data1)
				onButton(arg_17_0, arg_17_0.chapterSp, function()
					arg_17_0:OpenChapterLayer(arg_17_0.spChapter.id)
				end, SFX_PANEL)
				pg.BgmMgr.GetInstance():Push(arg_17_0.__cname, arg_17_0.bgms[arg_17_0.contextData.mapIndex])
			end
		end, SFX_PANEL)

		if arg_17_0.contextData.mapIndex == iter_17_0 then
			triggerToggle(iter_17_1, true)
		end
	end
end

function var_0_0.OpenChapterLayer(arg_23_0, arg_23_1)
	arg_23_0:emit(ClueMapMediator.OPEN_STAGE, arg_23_1)
end

function var_0_0.SubmitClueTask(arg_24_0)
	if #arg_24_0.submitGroupIds > 0 then
		local var_24_0 = ActivityConst.Valleyhospital_TASK_ID

		arg_24_0:emit(ClueMapMediator.ON_TASK_SUBMIT_ONESTEP, var_24_0, arg_24_0.canSubmitTaskIds[arg_24_0.submitGroupIds[1]], function(arg_25_0)
			if arg_25_0 then
				arg_24_0:UpdateCluePanel()
				arg_24_0:OpenSingleClueGroupPanel()
			end
		end)

		arg_24_0.showClueGroupId = table.remove(arg_24_0.submitGroupIds, 1)
	end
end

function var_0_0.OpenSingleClueGroupPanel(arg_26_0)
	arg_26_0:emit(ClueMapMediator.OPEN_SINGLE_CLUE_GROUP, arg_26_0.showClueGroupId, arg_26_0.submitClueIds[arg_26_0.showClueGroupId], function()
		arg_26_0:SubmitClueTask()
		arg_26_0:UpdateCluePanel()
		setActive(arg_26_0:findTF("tip", arg_26_0.bookBtn), ClueBookLayer.ShouldShowTip())
	end)
end

function var_0_0.willExit(arg_28_0)
	return
end

function var_0_0.onBackPressed(arg_29_0)
	arg_29_0:StopBgm()
	arg_29_0:closeView()
end

return var_0_0
