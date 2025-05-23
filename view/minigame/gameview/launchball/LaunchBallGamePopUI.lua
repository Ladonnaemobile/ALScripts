local var_0_0 = class("LaunchBallGamePopUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2

	arg_1_0:initCountUI()
	arg_1_0:initLeavelUI()
	arg_1_0:initPauseUI()
	arg_1_0:initSettlementUI()
end

function var_0_0.initCountUI(arg_2_0)
	arg_2_0.countUI = findTF(arg_2_0._tf, "pop/CountUI")
	arg_2_0.countAnimator = GetComponent(findTF(arg_2_0.countUI, "count"), typeof(Animator))
	arg_2_0.countDft = GetOrAddComponent(findTF(arg_2_0.countUI, "count"), typeof(DftAniEvent))

	arg_2_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_2_0.countDft:SetEndEvent(function()
		arg_2_0._event:emit(LaunchBallGameView.COUNT_DOWN)
	end)
end

function var_0_0.initLeavelUI(arg_5_0)
	arg_5_0.leaveUI = findTF(arg_5_0._tf, "pop/LeaveUI")

	setActive(arg_5_0.leaveUI, false)
	onButton(arg_5_0._event, findTF(arg_5_0.leaveUI, "ad/btnOk"), function()
		arg_5_0:resumeGame()
		arg_5_0._event:emit(LaunchBallGameView.LEVEL_GAME, true)
	end, SFX_CANCEL)
	onButton(arg_5_0._event, findTF(arg_5_0.leaveUI, "ad/btnCancel"), function()
		arg_5_0:resumeGame()
		arg_5_0._event:emit(LaunchBallGameView.LEVEL_GAME, false)
	end, SFX_CANCEL)
end

function var_0_0.initPauseUI(arg_8_0)
	arg_8_0.pauseUI = findTF(arg_8_0._tf, "pop/pauseUI")

	setActive(arg_8_0.pauseUI, false)
	onButton(arg_8_0._event, findTF(arg_8_0.pauseUI, "ad/btnOk"), function()
		arg_8_0:resumeGame()
		arg_8_0._event:emit(LaunchBallGameView.PAUSE_GAME, false)
	end, SFX_CANCEL)
end

function var_0_0.initSettlementUI(arg_10_0)
	arg_10_0.settlementUI = findTF(arg_10_0._tf, "pop/SettleMentUI")

	setActive(arg_10_0.settlementUI, false)
	onButton(arg_10_0._event, findTF(arg_10_0.settlementUI, "ad/btnOver"), function()
		arg_10_0:clearUI()
		arg_10_0._event:emit(LaunchBallGameView.BACK_MENU)
	end, SFX_CANCEL)
end

function var_0_0.updateSettlementUI(arg_12_0)
	GetComponent(findTF(arg_12_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_12_0 = LaunchBallGameVo.GetMiniGameData():GetRuntimeData("elements")
	local var_12_1 = LaunchBallGameVo.scoreNum
	local var_12_2 = var_12_0 and #var_12_0 > 0 and var_12_0[1] or 0

	setActive(findTF(arg_12_0.settlementUI, "ad/new"), var_12_2 < var_12_1)

	if var_12_2 < var_12_1 then
		var_12_2 = var_12_1

		arg_12_0._event:emit(LaunchBallGameView.STORE_SERVER, var_12_2)
	end

	local var_12_3 = findTF(arg_12_0.settlementUI, "ad/highText")
	local var_12_4 = findTF(arg_12_0.settlementUI, "ad/currentText")

	setText(var_12_3, var_12_2)
	setText(var_12_4, var_12_1)
	arg_12_0._event:emit(LaunchBallGameView.SUBMIT_GAME_SUCCESS)
end

function var_0_0.backPressed(arg_13_0)
	if isActive(arg_13_0.pauseUI) then
		arg_13_0:resumeGame()
		arg_13_0._event:emit(LaunchBallGameView.PAUSE_GAME, false)
	elseif isActive(arg_13_0.leaveUI) then
		arg_13_0:resumeGame()
		arg_13_0._event:emit(LaunchBallGameView.LEVEL_GAME, false)
	elseif not isActive(arg_13_0.pauseUI) and not isActive(arg_13_0.pauseUI) then
		arg_13_0:popPauseUI()
		arg_13_0._event:emit(LaunchBallGameView.PAUSE_GAME, true)
	else
		arg_13_0:resumeGame()
	end
end

function var_0_0.resumeGame(arg_14_0)
	setActive(arg_14_0.leaveUI, false)
	setActive(arg_14_0.pauseUI, false)
end

function var_0_0.popLeaveUI(arg_15_0)
	if isActive(arg_15_0.pauseUI) then
		setActive(arg_15_0.pauseUI, false)
	end

	setActive(arg_15_0.leaveUI, true)
end

function var_0_0.popPauseUI(arg_16_0)
	if isActive(arg_16_0.leaveUI) then
		setActive(arg_16_0.leaveUI, false)
	end

	setActive(arg_16_0.pauseUI, true)
end

function var_0_0.updateGameUI(arg_17_0, arg_17_1)
	setText(arg_17_0.scoreTf, arg_17_1.scoreNum)
	setText(arg_17_0.gameTimeS, math.ceil(arg_17_1.gameTime))
end

function var_0_0.readyStart(arg_18_0)
	arg_18_0:popCountUI(true)
	arg_18_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(LaunchBallGameVo.SFX_COUNT_DOWN)
end

function var_0_0.popCountUI(arg_19_0, arg_19_1)
	setActive(arg_19_0.countUI, arg_19_1)
end

function var_0_0.popSettlementUI(arg_20_0, arg_20_1)
	setActive(arg_20_0.settlementUI, arg_20_1)
end

function var_0_0.clearUI(arg_21_0)
	setActive(arg_21_0.settlementUI, false)
	setActive(arg_21_0.countUI, false)
end

return var_0_0
