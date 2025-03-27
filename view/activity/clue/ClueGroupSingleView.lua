local var_0_0 = class("ClueGroupSingleView", import("view.base.BaseUI"))
local var_0_1 = pg.activity_clue
local var_0_2 = pg.activity_clue_group
local var_0_3 = 0.6
local var_0_4 = 1

function var_0_0.getUIName(arg_1_0)
	return "ClueGroupSingleUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.clueGroupTf = arg_2_0:findTF("clueGroup")

	setText(arg_2_0:findTF("goBtn/Text", arg_2_0.clueGroupTf), i18n("clue_task_goto"))
	setText(arg_2_0:findTF("closeTip"), i18n("clue_close_tip"))

	arg_2_0.timerList = {}
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.activityId = ActivityConst.Valleyhospital_ACT_ID
	arg_3_0.playerId = getProxy(PlayerProxy):getRawData().id
	arg_3_0.investigatingGroupId = PlayerPrefs.GetInt("investigatingGroupId_" .. arg_3_0.activityId .. "_" .. arg_3_0.playerId)
	arg_3_0.taskProxy = getProxy(TaskProxy)

	onButton(arg_3_0, arg_3_0:findTF("mask"), function()
		arg_3_0:closeView()
	end, SFX_PANEL)
	arg_3_0:SetClueGroup()
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf, false)
end

function var_0_0.SetClueGroup(arg_5_0)
	local var_5_0 = arg_5_0.contextData.clueGroupId
	local var_5_1 = arg_5_0.contextData.submitClueIds
	local var_5_2 = arg_5_0.clueGroupTf
	local var_5_3 = var_0_2[var_5_0]
	local var_5_4 = var_0_1.get_id_list_by_group[var_5_0]
	local var_5_5 = {
		var_0_1[var_5_4[1]],
		var_0_1[var_5_4[2]],
		var_0_1[var_5_4[3]]
	}
	local var_5_6 = arg_5_0.taskProxy:getTaskVO(tonumber(var_5_5[3].task_id)):getProgress()
	local var_5_7 = {}

	for iter_5_0 = 1, 3 do
		var_5_7[iter_5_0] = arg_5_0.taskProxy:getFinishTaskById(tonumber(var_5_5[iter_5_0].task_id))
	end

	setText(arg_5_0:findTF("title/Text", var_5_2), var_5_3.title)
	setActive(arg_5_0:findTF("title/Text", var_5_2), var_5_7[1] or var_5_7[2] or var_5_7[3])
	setActive(arg_5_0:findTF("title/lock", var_5_2), not var_5_7[1] and not var_5_7[2] and not var_5_7[3])
	LoadImageSpriteAsync("cluepictures/" .. var_5_3.pic, arg_5_0:findTF("picture", var_5_2), true)

	if var_5_3.type == 1 then
		arg_5_0:findTF("picture", var_5_2).localScale = Vector3(1, 1, 1)
	else
		arg_5_0:findTF("picture", var_5_2).localScale = Vector3(0.6, 0.6, 1)
	end

	setActive(arg_5_0:findTF("picture/lockSite", var_5_2), var_5_3.type == 1 and not var_5_7[1] and not var_5_7[2] and not var_5_7[3])
	setActive(arg_5_0:findTF("picture/lockChara", var_5_2), var_5_3.type == 2 and not var_5_7[1] and not var_5_7[2] and not var_5_7[3])

	for iter_5_1 = 1, 3 do
		if var_5_7[iter_5_1] then
			setText(arg_5_0:findTF("clueScroll/Viewport/Content/clue" .. iter_5_1, var_5_2), var_5_5[iter_5_1].desc)
		elseif arg_5_0.investigatingGroupId == var_5_0 then
			setText(arg_5_0:findTF("clueScroll/Viewport/Content/clue" .. iter_5_1, var_5_2), "<color=#858593>" .. var_5_5[iter_5_1].unlock_desc .. var_5_5[iter_5_1].unlock_num .. i18n("clue_task_tip", var_5_6) .. "</color>")
		else
			setText(arg_5_0:findTF("clueScroll/Viewport/Content/clue" .. iter_5_1, var_5_2), "<color=#858593>？？？</color>")
		end
	end

	setActive(arg_5_0:findTF("goBtn/selected", var_5_2), arg_5_0.investigatingGroupId == var_5_0)
	onButton(arg_5_0, arg_5_0:findTF("goBtn", var_5_2), function()
		arg_5_0.investigatingGroupId = var_5_0

		PlayerPrefs.SetInt("investigatingGroupId_" .. arg_5_0.activityId .. "_" .. arg_5_0.playerId, var_5_0)
		setActive(arg_5_0:findTF("goBtn/selected", var_5_2), true)

		if arg_5_0.pageIndex == 1 then
			arg_5_0:ShowSitePage()
		elseif arg_5_0.pageIndex == 2 then
			arg_5_0:ShowCharaPage()
		end

		arg_5_0:OpenChapter(var_5_0)
		arg_5_0:closeView()
	end, SFX_PANEL)

	if not var_5_7[1] and not var_5_7[2] and not var_5_7[3] then
		setActive(arg_5_0:findTF("triangle", arg_5_0.clueGroupTf), false)
	else
		setActive(arg_5_0:findTF("triangle", arg_5_0.clueGroupTf), true)
		setActive(arg_5_0:findTF("triangle", arg_5_0.clueGroupTf), arg_5_0:findTF("clueScroll", arg_5_0.clueGroupTf):GetComponent(typeof(ScrollRect)).normalizedPosition.y > 0.01)
		onScroll(arg_5_0, arg_5_0:findTF("clueScroll", arg_5_0.clueGroupTf), function(arg_7_0)
			setActive(arg_5_0:findTF("triangle", arg_5_0.clueGroupTf), arg_7_0.y > 0.01)
		end)
	end

	setActive(arg_5_0:findTF("top"), var_5_1 and #var_5_1 > 0)

	if var_5_1 and #var_5_1 > 0 then
		if table.contains(var_5_1, var_5_4[1]) then
			setActive(arg_5_0:findTF("title/Text", var_5_2), false)
			setActive(arg_5_0:findTF("title/lock", var_5_2), true)
			setActive(arg_5_0:findTF("picture/lockSite", var_5_2), var_5_3.type == 1)
			setActive(arg_5_0:findTF("picture/lockChara", var_5_2), var_5_3.type == 2)

			for iter_5_2 = 1, #var_5_1 do
				if arg_5_0.investigatingGroupId == var_5_0 then
					setText(arg_5_0:findTF("clueScroll/Viewport/Content/clue" .. iter_5_2, var_5_2), "<color=#858593>" .. var_5_5[iter_5_2].unlock_desc .. var_5_5[iter_5_2].unlock_num .. "</color>")
				else
					setText(arg_5_0:findTF("clueScroll/Viewport/Content/clue" .. iter_5_2, var_5_2), "<color=#858593>？？？</color>")
				end
			end

			arg_5_0:StartTimer(function()
				setActive(arg_5_0:findTF("title/Text", var_5_2), true)

				local var_8_0 = arg_5_0:findTF("title", var_5_2):GetComponent(typeof(Animation)):Play("anim_clue_single_unlock1")

				arg_5_0:SetEndAniEvent(arg_5_0:findTF("title", var_5_2), function()
					setActive(arg_5_0:findTF("title/lock", var_5_2), false)
				end)
			end, var_0_3)
			arg_5_0:StartTimer(function()
				local var_10_0 = arg_5_0:findTF("picture", var_5_2):GetComponent(typeof(Animation)):Play("anim_clue_single_unlock")

				arg_5_0:SetEndAniEvent(arg_5_0:findTF("picture", var_5_2), function()
					setActive(arg_5_0:findTF("picture/lockSite", var_5_2), false)
					setActive(arg_5_0:findTF("picture/lockChara", var_5_2), false)
				end)
			end, var_0_3)

			for iter_5_3 = 1, #var_5_1 do
				arg_5_0:StartTimer(function()
					setText(arg_5_0:findTF("clueScroll/Viewport/Content/clue" .. iter_5_3, var_5_2), var_5_5[iter_5_3].desc)
				end, var_0_4 * iter_5_3 + var_0_3)
			end
		else
			local var_5_8 = table.indexof(var_5_4, var_5_1[1])

			for iter_5_4 = var_5_8, 3 do
				if arg_5_0.investigatingGroupId == var_5_0 then
					setText(arg_5_0:findTF("clueScroll/Viewport/Content/clue" .. iter_5_4, var_5_2), "<color=#858593>" .. var_5_5[iter_5_4].unlock_desc .. var_5_5[iter_5_4].unlock_num .. "</color>")
				else
					setText(arg_5_0:findTF("clueScroll/Viewport/Content/clue" .. iter_5_4, var_5_2), "<color=#858593>？？？</color>")
				end
			end

			local var_5_9 = 1

			for iter_5_5 = var_5_8, var_5_8 + #var_5_1 - 1 do
				arg_5_0:StartTimer(function()
					setText(arg_5_0:findTF("clueScroll/Viewport/Content/clue" .. iter_5_5, var_5_2), var_5_5[iter_5_5].desc)
				end, var_0_4 * var_5_9)

				var_5_9 = var_5_9 + 1
			end
		end

		setActive(arg_5_0:findTF("goBtn", var_5_2), false)
	else
		setActive(arg_5_0:findTF("goBtn", var_5_2), not var_5_7[1] or not var_5_7[2] or not var_5_7[3])
	end
end

function var_0_0.OpenChapter(arg_14_0, arg_14_1)
	arg_14_0:emit(ClueGroupSingleMediator.OPEN_CLUE_JUMP, arg_14_1)
end

function var_0_0.StartTimer(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = Timer.New(arg_15_1, arg_15_2, 1)

	var_15_0:Start()
	table.insert(arg_15_0.timerList, var_15_0)
end

function var_0_0.RemoveAllTimer(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.timerList) do
		iter_16_1:Stop()
	end

	arg_16_0.timerList = {}
end

function var_0_0.SetEndAniEvent(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1:GetComponent(typeof(DftAniEvent))

	if var_17_0 then
		var_17_0:SetEndEvent(function()
			arg_17_2()
			var_17_0:SetEndEvent(nil)
		end)
	end
end

function var_0_0.willExit(arg_19_0)
	arg_19_0:RemoveAllTimer()
end

function var_0_0.onBackPressed(arg_20_0)
	arg_20_0:closeView()
end

return var_0_0
