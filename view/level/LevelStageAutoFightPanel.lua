local var_0_0 = class("LevelStageAutoFightPanel", BaseSubView)

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	arg_1_0.buffer = setmetatable({}, {
		__index = function(arg_2_0, arg_2_1)
			return function(arg_3_0, ...)
				arg_1_0:ActionInvoke(arg_2_1, ...)
			end
		end,
		__newindex = function()
			errorMsg("Cant write Data in ActionInvoke buffer")
		end
	})
	arg_1_0.isFrozen = nil

	arg_1_0:bind(LevelUIConst.ON_FROZEN, function()
		arg_1_0.isFrozen = true
	end)
	arg_1_0:bind(LevelUIConst.ON_UNFROZEN, function()
		arg_1_0.isFrozen = nil
	end)

	arg_1_0.loader = AutoLoader.New()
	arg_1_0.isCO = false
end

function var_0_0.getUIName(arg_7_0)
	return "LevelStageAutoFightPanel"
end

function var_0_0.OnInit(arg_8_0)
	arg_8_0.btnOn = arg_8_0._tf:Find("On")
	arg_8_0.btnOff = arg_8_0._tf:Find("Off")

	onButton(arg_8_0, arg_8_0.btnOn, function()
		local var_9_0 = getProxy(ChapterProxy)
		local var_9_1 = "chapter_autofight_flag_" .. arg_8_0.contextData.chapterVO.id

		var_9_0:SetChapterAutoFlag(arg_8_0.contextData.chapterVO.id, false, ChapterConst.AUTOFIGHT_STOP_REASON.MANUAL)
		PlayerPrefs.SetInt(var_9_1, 0)
		PlayerPrefs.Save()
		arg_8_0:UpdateAutoFightMark()
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.btnOff, function()
		local var_10_0 = getProxy(ChapterProxy)
		local var_10_1 = "chapter_autofight_flag_" .. arg_8_0.contextData.chapterVO.id

		var_10_0:SetChapterAutoFlag(arg_8_0.contextData.chapterVO.id, true)
		PlayerPrefs.SetInt(var_10_1, 1)
		PlayerPrefs.Save()
		arg_8_0:UpdateAutoFightMark()

		if not arg_8_0.isFrozen then
			arg_8_0:emit(LevelUIConst.TRIGGER_ACTION)
		end
	end, SFX_PANEL)

	arg_8_0.restTime = arg_8_0.btnOn:Find("Rest")

	local var_8_0 = i18n("multiple_sorties_rest_time")
	local var_8_1 = string.split(var_8_0, "$1/$2")

	setText(arg_8_0.restTime:Find("Text"), var_8_1[1])
	setText(arg_8_0.restTime:Find("Text (2)"), var_8_1[2])
end

function var_0_0.UpdateAutoFightMark(arg_11_0)
	local var_11_0 = getProxy(ChapterProxy):GetChapterAutoFlag(arg_11_0.contextData.chapterVO.id) == 1

	setActive(arg_11_0.btnOn, var_11_0)
	setActive(arg_11_0.btnOff, not var_11_0)
	arg_11_0:UpdateContinuousOperation()
	arg_11_0:emit(LevelUIConst.STRATEGY_PANEL_AUTOFIGHT_ACTIVE, var_11_0)
end

function var_0_0.UpdateContinuousOperation(arg_12_0)
	local var_12_0 = getProxy(ChapterProxy):GetContinuousData(SYSTEM_SCENARIO)

	if var_12_0 and var_12_0:IsActive() then
		local var_12_1 = var_12_0:GetTotalBattleTime() - var_12_0:GetRestBattleTime() + 1
		local var_12_2 = "$1/$2"

		for iter_12_0, iter_12_1 in ipairs({
			var_12_1,
			var_12_0:GetTotalBattleTime()
		}) do
			var_12_2 = string.gsub(var_12_2, "$" .. iter_12_0, iter_12_1)
		end

		setText(arg_12_0.restTime:Find("Count"), var_12_2)
		setActive(arg_12_0.restTime, true)

		if not arg_12_0.isCO then
			arg_12_0.loader:GetSprite("ui/levelstageview_atlas", "continuous_operation_on", arg_12_0.btnOn)

			arg_12_0.isCO = true
		end
	else
		setActive(arg_12_0.restTime, false)

		if arg_12_0.isCO then
			arg_12_0.loader:GetSprite("ui/levelstageview_atlas", "continuous_operation_on", arg_12_0.btnOn)

			arg_12_0.isCO = false
		end
	end
end

function var_0_0.OnDestroy(arg_13_0)
	arg_13_0.loader:Clear()
	var_0_0.super.OnDestroy(arg_13_0)
end

return var_0_0
