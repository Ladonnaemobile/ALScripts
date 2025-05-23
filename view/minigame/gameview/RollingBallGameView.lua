local var_0_0 = class("RollingBallGameView", import("..BaseMiniGameView"))
local var_0_1 = "event:/ui/ddldaoshu2"
local var_0_2 = "event:/ui/boat_drag"
local var_0_3 = "event:/ui/break_out_full"
local var_0_4 = "event:/ui/sx-good"
local var_0_5 = "event:/ui/sx-perfect"
local var_0_6 = "event:/ui/sx-jishu"
local var_0_7 = "event:/ui/furnitrue_save"

function var_0_0.getUIName(arg_1_0)
	return "RollingBallGameUI"
end

function var_0_0.init(arg_2_0)
	local var_2_0 = arg_2_0:GetMGData()
	local var_2_1 = arg_2_0:GetMGHubData()

	arg_2_0.tplScoreTip = findTF(arg_2_0._tf, "tplScoreTip")
	arg_2_0.tplRemoveEffect = findTF(arg_2_0._tf, "sanxiaoxiaoshi")
	arg_2_0.effectUI = findTF(arg_2_0._tf, "effectUI")
	arg_2_0.tplEffect = findTF(arg_2_0._tf, "tplEffect")
	arg_2_0.effectPoolTf = findTF(arg_2_0._tf, "effectPool")
	arg_2_0.effectPool = {}
	arg_2_0.effectDatas = {}
	arg_2_0.effectTargetPosition = findTF(arg_2_0.effectUI, "effectTargetPos").localPosition
	arg_2_0.rollingUI = findTF(arg_2_0._tf, "rollingUI")
	arg_2_0.rollingEffectUI = findTF(arg_2_0._tf, "rollingEffectUI")
	arg_2_0.tplGrid = findTF(arg_2_0._tf, "tplRollingGrid")
	arg_2_0.gridPoolTf = findTF(arg_2_0._tf, "gridPool")
	arg_2_0.gridsPool = {}
	arg_2_0.gridDic = {}
	arg_2_0.fillGridDic = {}
	arg_2_0.startFlag = false

	local var_2_2 = findTF(arg_2_0.rollingUI, "dragAlphaGrid")

	arg_2_0.dragAlphaGrid = RollingBallGrid.New(var_2_2)

	setActive(arg_2_0.dragAlphaGrid:getTf(), false)

	arg_2_0.timer = Timer.New(function()
		arg_2_0:onTimer()
	end, 0.016666666666666666, -1)

	for iter_2_0 = 1, RollingBallConst.horizontal do
		arg_2_0.gridDic[iter_2_0] = {}
		arg_2_0.fillGridDic[iter_2_0] = {}

		for iter_2_1 = 1, RollingBallConst.vertical do
			table.insert(arg_2_0.gridDic[iter_2_0], false)
		end
	end

	arg_2_0.goodEffect = arg_2_0:findTF("sanxiaoGood")
	arg_2_0.greatEffect = arg_2_0:findTF("sanxiaoGreat")
	arg_2_0.perfectEffect = arg_2_0:findTF("sanxiaoPerfect")
	arg_2_0.caidaiTf = findTF(arg_2_0._tf, "zhuanzhu_caidai")

	setActive(arg_2_0.caidaiTf, false)

	arg_2_0.startUI = findTF(arg_2_0._tf, "startUI")

	onButton(arg_2_0, findTF(arg_2_0.startUI, "btnStart"), function()
		if not arg_2_0.startFlag then
			setActive(arg_2_0.startUI, false)
			arg_2_0:gameStart()
		end
	end, SFX_CONFIRM)
	onButton(arg_2_0, findTF(arg_2_0.startUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_rollingBallGame.tip
		})
	end, SFX_CONFIRM)
	setActive(arg_2_0.startUI, true)

	arg_2_0.scoreUI = findTF(arg_2_0._tf, "scoreUI")
	arg_2_0.labelCurScore = findTF(arg_2_0.scoreUI, "labelCur")
	arg_2_0.labelHigh = findTF(arg_2_0.scoreUI, "labelHigh")
	arg_2_0.scoreNew = findTF(arg_2_0.scoreUI, "new")

	onButton(arg_2_0, findTF(arg_2_0.scoreUI, "btnEnd"), function()
		setActive(arg_2_0.scoreUI, false)
		setActive(arg_2_0.startUI, true)
	end, SFX_CANCEL)
	setActive(arg_2_0.scoreUI, false)

	arg_2_0.downProgress = findTF(arg_2_0._tf, "downProgress")
	arg_2_0.downTimeSlider = findTF(arg_2_0.downProgress, "Slider"):GetComponent(typeof(Slider))
	arg_2_0.labelGameTime = findTF(arg_2_0._tf, "labelGameTime")
	arg_2_0.labelGameScore = findTF(arg_2_0._tf, "labelGameScore")
	arg_2_0.endLess = findTF(arg_2_0._tf, "endLess")

	setActive(arg_2_0.endLess, true)

	arg_2_0.closeUI = findTF(arg_2_0._tf, "closeUI")

	setActive(arg_2_0.closeUI, false)
	onButton(arg_2_0, findTF(arg_2_0.closeUI, "btnOk"), function()
		if not arg_2_0.countStart then
			arg_2_0:closeView()
		end
	end, SFX_CONFIRM)
	onButton(arg_2_0, findTF(arg_2_0.closeUI, "btnCancel"), function()
		setActive(arg_2_0.closeUI, false)
	end, SFX_CANCEL)

	arg_2_0.overLight = findTF(arg_2_0._tf, "overLight")

	setActive(arg_2_0.overLight, false)
	onButton(arg_2_0, findTF(arg_2_0._tf, "btnClose"), function()
		if not arg_2_0.startFlag then
			arg_2_0:closeView()
		else
			setActive(arg_2_0.closeUI, true)
		end
	end, SFX_CANCEL)
end

function var_0_0.getGameTimes(arg_10_0)
	return arg_10_0:GetMGHubData().count
end

function var_0_0.showScoreUI(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:GetMGData():GetRuntimeData("elements")
	local var_11_1 = var_11_0 and #var_11_0 > 0 and var_11_0[1] or 0

	if var_11_1 < arg_11_1 then
		setActive(arg_11_0.scoreNew, true)
	else
		setActive(arg_11_0.scoreNew, false)
	end

	var_11_1 = arg_11_1 < var_11_1 and var_11_1 or arg_11_1

	setActive(arg_11_0.scoreUI, true)
	setText(arg_11_0.labelCurScore, arg_11_1)
	setText(arg_11_0.labelHigh, var_11_1)
	arg_11_0:StoreDataToServer({
		var_11_1
	})

	if arg_11_0:getGameTimes() > 0 then
		arg_11_0:SendSuccess(0)
	end
end

function var_0_0.showCountStart(arg_12_0, arg_12_1)
	local var_12_0 = findTF(arg_12_0._tf, "count")

	setActive(var_12_0, true)

	arg_12_0.countIndex = 3
	arg_12_0.countStart = true

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1)

	local function var_12_1(arg_13_0)
		local var_13_0 = arg_12_0.countIndex

		arg_12_0.countIndex = arg_12_0.countIndex - 1

		local var_13_1 = findTF(var_12_0, "show")
		local var_13_2 = GetComponent(var_13_1, typeof(CanvasGroup))

		seriesAsync({
			function(arg_14_0)
				GetSpriteFromAtlasAsync(RollingBallConst.ui_atlas, "count_" .. var_13_0, function(arg_15_0)
					setImageSprite(var_13_1, arg_15_0, true)
				end)
				LeanTween.value(go(var_13_1), 0, 1, 0.5):setOnUpdate(System.Action_float(function(arg_16_0)
					var_13_2.alpha = arg_16_0
				end)):setOnComplete(System.Action(function()
					arg_14_0()
				end))
			end,
			function(arg_18_0)
				LeanTween.value(go(var_13_1), 1, 0, 0.5):setOnUpdate(System.Action_float(function(arg_19_0)
					var_13_2.alpha = arg_19_0
				end)):setOnComplete(System.Action(function()
					arg_18_0()
				end))
			end
		}, arg_13_0)
	end

	local var_12_2 = {}

	for iter_12_0 = 1, 3 do
		table.insert(var_12_2, var_12_1)
	end

	seriesAsync(var_12_2, function()
		arg_12_0.countStart = false

		setActive(var_12_0, false)
		arg_12_1()
	end)
end

function var_0_0.gameStart(arg_22_0)
	arg_22_0.startFlag = true

	seriesAsync({
		function(arg_23_0)
			arg_22_0:showCountStart(arg_23_0)
		end,
		function(arg_24_0)
			arg_22_0.moveDatas = {}
			arg_22_0.selectGrid = nil
			arg_22_0.selectEnterGrid = nil
			arg_22_0.dragOffsetPos = Vector3(0, 0, 0)
			arg_22_0.changeGridsDic = nil
			arg_22_0.downTime = RollingBallConst.downTime
			arg_22_0.comboAmount = 0
			arg_22_0.stopFlag = false
			arg_22_0.onBeginDragTime = nil

			if arg_22_0:getGameTimes() > 0 then
				arg_22_0.gameTime = RollingBallConst.gameTime
			else
				arg_22_0.gameTime = RollingBallConst.finishGameTime
			end

			arg_22_0.gameTimeReal = Time.realtimeSinceStartup
			arg_22_0.gameTimeFlag = true

			setActive(arg_22_0.endLess, false)

			arg_22_0.gameScore = 0

			arg_22_0:firstInitGrid()
			arg_22_0:moveGridsBySelfPos(arg_22_0.gridDic)
			arg_22_0:timerStart()
		end
	}, nil)
end

function var_0_0.gameStop(arg_25_0)
	arg_25_0:timerStop()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_7)

	for iter_25_0 = #arg_25_0.effectDatas, 1, -1 do
		arg_25_0:returnEffect(arg_25_0.effectDatas[iter_25_0].tf)
		table.remove(arg_25_0.effectDatas, iter_25_0)
	end

	for iter_25_1 = 1, RollingBallConst.horizontal do
		for iter_25_2 = 1, RollingBallConst.vertical do
			if arg_25_0.gridDic[iter_25_1][iter_25_2] then
				arg_25_0.gridDic[iter_25_1][iter_25_2]:setEventActive(false)
			end
		end
	end

	arg_25_0:clearUI()
	arg_25_0:showScoreUI(arg_25_0.gameScore)
end

function var_0_0.timerStart(arg_26_0)
	if not arg_26_0.timer.running then
		arg_26_0.timer:Start()
	end
end

function var_0_0.timerStop(arg_27_0)
	if arg_27_0.timer.running then
		arg_27_0.timer:Stop()
	end
end

function var_0_0.fallingGridDic(arg_28_0)
	local function var_28_0(arg_29_0, arg_29_1)
		for iter_29_0 = arg_29_1 + 1, RollingBallConst.vertical do
			if arg_28_0.gridDic[arg_29_0][iter_29_0] then
				return iter_29_0
			end
		end

		return 0
	end

	for iter_28_0 = 1, RollingBallConst.horizontal do
		for iter_28_1 = 1, RollingBallConst.vertical do
			if not arg_28_0.gridDic[iter_28_0][iter_28_1] and RollingBallConst.vertical - iter_28_1 > 0 then
				local var_28_1 = var_28_0(iter_28_0, iter_28_1)

				if var_28_1 > 0 then
					local var_28_2 = arg_28_0.gridDic[iter_28_0][var_28_1]

					arg_28_0.gridDic[iter_28_0][var_28_1] = false
					arg_28_0.gridDic[iter_28_0][iter_28_1] = var_28_2

					arg_28_0.gridDic[iter_28_0][iter_28_1]:setPosData(iter_28_0, iter_28_1)
				end
			end
		end
	end
end

function var_0_0.firstInitGrid(arg_30_0)
	for iter_30_0 = 1, RollingBallConst.horizontal do
		arg_30_0.fillGridDic[iter_30_0] = {}

		for iter_30_1 = 1, RollingBallConst.vertical do
			if not arg_30_0.gridDic[iter_30_0][iter_30_1] then
				local var_30_0 = {}

				if iter_30_0 > 2 and arg_30_0.gridDic[iter_30_0 - 2][iter_30_1]:getType() == arg_30_0.gridDic[iter_30_0 - 1][iter_30_1]:getType() then
					table.insert(var_30_0, arg_30_0.gridDic[iter_30_0 - 2][iter_30_1]:getType())
				end

				if iter_30_1 > 2 and arg_30_0.gridDic[iter_30_0][iter_30_1 - 2]:getType() == arg_30_0.gridDic[iter_30_0][iter_30_1 - 1]:getType() then
					table.insert(var_30_0, arg_30_0.gridDic[iter_30_0][iter_30_1 - 2]:getType())
				end

				local var_30_1 = arg_30_0:createGrid(arg_30_0:getRandomType(var_30_0), iter_30_0, iter_30_1)

				arg_30_0.gridDic[iter_30_0][iter_30_1] = var_30_1

				arg_30_0:setFillGridPosition(var_30_1, iter_30_0, #arg_30_0.fillGridDic[iter_30_0])
				table.insert(arg_30_0.fillGridDic[iter_30_0], var_30_1)
			end
		end
	end
end

function var_0_0.fillEmptyGrid(arg_31_0)
	for iter_31_0 = 1, RollingBallConst.horizontal do
		arg_31_0.fillGridDic[iter_31_0] = {}

		for iter_31_1 = 1, RollingBallConst.vertical do
			if not arg_31_0.gridDic[iter_31_0][iter_31_1] then
				local var_31_0 = arg_31_0:createGrid(arg_31_0:getRandomType(), iter_31_0, iter_31_1)

				arg_31_0.gridDic[iter_31_0][iter_31_1] = var_31_0

				arg_31_0:setFillGridPosition(var_31_0, iter_31_0, #arg_31_0.fillGridDic[iter_31_0])
				table.insert(arg_31_0.fillGridDic[iter_31_0], var_31_0)
			end
		end
	end
end

function var_0_0.setFillGridPosition(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = (arg_32_2 - 1) * RollingBallConst.grid_width
	local var_32_1 = (RollingBallConst.vertical + arg_32_3) * RollingBallConst.grid_height

	arg_32_1:setPosition(var_32_0, var_32_1)
end

function var_0_0.onTimer(arg_33_0)
	for iter_33_0 = #arg_33_0.moveDatas, 1, -1 do
		local var_33_0 = arg_33_0.moveDatas[iter_33_0]
		local var_33_1 = var_33_0.grid
		local var_33_2 = var_33_1:getPosition().x
		local var_33_3 = var_33_1:getPosition().y
		local var_33_4 = var_33_0.endX
		local var_33_5 = var_33_0.endY

		if var_33_2 == var_33_4 and var_33_3 == var_33_5 then
			var_33_1:setEventActive(true)
			table.remove(arg_33_0.moveDatas, iter_33_0)
		else
			local var_33_6
			local var_33_7

			if math.abs(var_33_4 - var_33_2) < RollingBallConst.moveSpeed or var_33_4 == var_33_2 then
				var_33_6 = var_33_4 - var_33_2
			elseif var_33_2 < var_33_4 then
				var_33_6 = RollingBallConst.moveSpeed
			elseif var_33_4 < var_33_2 then
				var_33_6 = -RollingBallConst.moveSpeed
			end

			if math.abs(var_33_5 - var_33_3) < RollingBallConst.moveSpeed or var_33_3 == var_33_5 then
				var_33_7 = 0
				var_33_3 = var_33_5
			elseif var_33_3 < var_33_5 then
				var_33_7 = RollingBallConst.moveSpeed
			elseif var_33_5 < var_33_3 then
				var_33_7 = -RollingBallConst.moveSpeed
			end

			var_33_1:setPosition(var_33_2 + var_33_6, var_33_3 + var_33_7)
		end
	end

	for iter_33_1 = #arg_33_0.effectDatas, 1, -1 do
		local var_33_8 = arg_33_0.effectDatas[iter_33_1]
		local var_33_9 = var_33_8.tf.localPosition

		var_33_8.ax = (arg_33_0.effectTargetPosition.x - var_33_9.x) * 0.002
		var_33_8.ay = (arg_33_0.effectTargetPosition.y - var_33_9.y) * 0.002
		var_33_8.vx = var_33_8.vx + var_33_8.ax
		var_33_8.vy = var_33_8.vy + var_33_8.ay
		var_33_9.x = var_33_9.x + var_33_8.vx
		var_33_9.y = var_33_9.y + var_33_8.vy
		var_33_8.tf.localPosition = var_33_9

		if var_33_9.x < arg_33_0.effectTargetPosition.x then
			arg_33_0:returnEffect(var_33_8.tf)
			table.remove(arg_33_0.effectDatas, iter_33_1)
		end
	end

	if arg_33_0.onBeginDragTime and arg_33_0.downTime > 0 then
		local var_33_10 = (Time.realtimeSinceStartup - arg_33_0.onBeginDragTime) * 1000

		arg_33_0.downTime = arg_33_0.downTime - var_33_10
		arg_33_0.onBeginDragTime = Time.realtimeSinceStartup

		if arg_33_0.downTime <= 0 then
			arg_33_0.downTime = 0

			if arg_33_0.selectGrid then
				local var_33_11 = arg_33_0.selectGrid

				var_33_11:onEndDrag()
				arg_33_0:onGridUp(var_33_11)
				var_33_11:addUpCallback(function(arg_34_0, arg_34_1)
					arg_33_0:onGridUp(var_33_11)
				end)
				var_33_11:addDragCallback(function(arg_35_0, arg_35_1)
					arg_33_0:onGridDrag(var_33_11, arg_35_0, arg_35_1)
				end)
			end
		end
	end

	arg_33_0.downTimeSlider.value = arg_33_0.downTime / RollingBallConst.downTime

	if arg_33_0.gameTimeFlag and arg_33_0.gameTime > 0 and not isActive(arg_33_0.closeUI) then
		local var_33_12 = (Time.realtimeSinceStartup - arg_33_0.gameTimeReal) * 1000

		arg_33_0.gameTime = arg_33_0.gameTime - var_33_12

		if arg_33_0.gameTime > 0 and arg_33_0.gameTime <= 8000 and not isActive(arg_33_0.overLight) then
			setActive(arg_33_0.overLight, true)
		end

		if arg_33_0.gameTime <= 0 then
			arg_33_0.gameTime = 0

			setActive(arg_33_0.overLight, false)

			arg_33_0.stopFlag = true
		end
	end

	arg_33_0.gameTimeReal = Time.realtimeSinceStartup

	local var_33_13 = math.floor(arg_33_0.gameTime / 60000)

	var_33_13 = var_33_13 < 10 and "0" .. var_33_13 or var_33_13

	local var_33_14 = math.floor(arg_33_0.gameTime % 60000 / 1000)

	var_33_14 = var_33_14 < 10 and "0" .. var_33_14 or var_33_14

	local var_33_15 = math.floor(math.floor(arg_33_0.gameTime % 1000) / 10)

	var_33_15 = var_33_15 < 10 and "0" .. var_33_15 or var_33_15

	setText(arg_33_0.labelGameTime, var_33_13 .. ":" .. var_33_14 .. ":" .. var_33_15)

	if #arg_33_0.moveDatas == 0 then
		if arg_33_0.stopFlag then
			arg_33_0:gameStop()

			return
		end

		if arg_33_0.checkSuccesFlag then
			arg_33_0.checkSuccesFlag = false

			arg_33_0:checkSuccessGrid()
		end

		if arg_33_0.isMoveing then
			arg_33_0.isMoveing = false
		end
	elseif not arg_33_0.isMoveing then
		arg_33_0.isMoveing = true
	end
end

function var_0_0.moveGridsByChangeDic(arg_36_0)
	arg_36_0.moveDatas = {}

	for iter_36_0 = 1, #arg_36_0.changeGridsDic do
		local var_36_0 = arg_36_0.changeGridsDic[iter_36_0]

		for iter_36_1 = 1, #var_36_0 do
			local var_36_1 = var_36_0[iter_36_1]

			if var_36_1.grid ~= arg_36_0.selectGrid then
				arg_36_0:moveGridToPos(var_36_1.grid, var_36_1.posX, var_36_1.posY)
			end
		end
	end

	if #arg_36_0.moveDatas > 0 then
		arg_36_0:timerStart()
	end
end

function var_0_0.moveGridsBySelfPos(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0.moveDatas = {}

	for iter_37_0 = 1, #arg_37_1 do
		for iter_37_1 = 1, #arg_37_1[iter_37_0] do
			local var_37_0 = arg_37_1[iter_37_0][iter_37_1]

			if var_37_0 and var_37_0 ~= arg_37_2 then
				arg_37_0:moveGridToPos(var_37_0, var_37_0:getPosData())
			end
		end
	end

	if #arg_37_0.moveDatas > 0 then
		arg_37_0:timerStart()
	end
end

function var_0_0.moveGridToPos(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_1:getPosition().x
	local var_38_1 = arg_38_1:getPosition().y
	local var_38_2 = (arg_38_2 - 1) * RollingBallConst.grid_width
	local var_38_3 = (arg_38_3 - 1) * RollingBallConst.grid_height

	if math.floor(var_38_2) == math.floor(arg_38_2) and math.floor(var_38_3) == math.floor(arg_38_3) then
		return
	end

	arg_38_1:setEventActive(false)

	local var_38_4 = {
		grid = arg_38_1,
		endX = var_38_2,
		endY = var_38_3
	}

	table.insert(arg_38_0.moveDatas, var_38_4)
end

function var_0_0.updateMoveGridDic(arg_39_0)
	for iter_39_0 = 1, #arg_39_0.changeGridsDic do
		local var_39_0 = arg_39_0.changeGridsDic[iter_39_0]

		for iter_39_1 = 1, #var_39_0 do
			local var_39_1 = var_39_0[iter_39_1]

			if var_39_1.grid then
				var_39_1.grid:setPosData(var_39_1.posX, var_39_1.posY)
			end
		end
	end

	arg_39_0:sortGridDic()
end

function var_0_0.sortGridDic(arg_40_0)
	local var_40_0 = {}

	local function var_40_1(arg_41_0, arg_41_1)
		for iter_41_0 = 1, #var_40_0 do
			local var_41_0, var_41_1 = var_40_0[iter_41_0]:getPosData()

			if var_41_0 == arg_41_0 and var_41_1 == arg_41_1 then
				return table.remove(var_40_0, iter_41_0)
			end
		end

		return nil
	end

	for iter_40_0 = 1, #arg_40_0.gridDic do
		for iter_40_1 = 1, #arg_40_0.gridDic[iter_40_0] do
			local var_40_2 = arg_40_0.gridDic[iter_40_0][iter_40_1]
			local var_40_3

			if var_40_2 ~= iter_40_0 or var_40_3 ~= iter_40_1 then
				table.insert(var_40_0, arg_40_0.gridDic[iter_40_0][iter_40_1])

				arg_40_0.gridDic[iter_40_0][iter_40_1] = false
			end
		end
	end

	for iter_40_2 = 1, #arg_40_0.gridDic do
		for iter_40_3 = 1, #arg_40_0.gridDic[iter_40_2] do
			if arg_40_0.gridDic[iter_40_2][iter_40_3] == false then
				local var_40_4 = var_40_1(iter_40_2, iter_40_3)

				assert(var_40_4 ~= nil, "异常，位置x:" .. iter_40_2 .. "y:" .. iter_40_3 .. "处珠子不存在，考虑是否在交换位置时设置了错误的格子数据")

				arg_40_0.gridDic[iter_40_2][iter_40_3] = var_40_4
			end
		end
	end
end

function var_0_0.checkSuccessGrid(arg_42_0)
	local var_42_0

	arg_42_0:updateRemoveFlag()

	arg_42_0.gameTimeFlag = false

	local var_42_1 = {}

	seriesAsync({
		function(arg_43_0)
			for iter_43_0 = 1, RollingBallConst.horizontal do
				for iter_43_1 = 1, RollingBallConst.vertical do
					local var_43_0 = arg_42_0.gridDic[iter_43_0][iter_43_1]

					var_43_0:setEventActive(false)

					if var_43_0:getRemoveFlagV() or var_43_0:getRemoveFlagH() then
						local var_43_1 = var_43_0:getRemoveId()
						local var_43_2, var_43_3 = var_43_0:getPosData()

						if not var_42_1[var_43_1] then
							var_42_1[var_43_1] = {
								amount = 0,
								posList = {}
							}
						end

						var_42_1[var_43_1].amount = var_42_1[var_43_1].amount + 1

						table.insert(var_42_1[var_43_1].posList, {
							x = var_43_2,
							y = var_43_3
						})
						arg_42_0:returnGrid(var_43_0)

						arg_42_0.gridDic[iter_43_0][iter_43_1] = false

						if not var_42_0 then
							var_42_0 = true
						end
					end
				end
			end

			arg_43_0()
		end,
		function(arg_44_0)
			if var_42_0 then
				LeanTween.delayedCall(go(arg_42_0.rollingUI), 0.7, System.Action(function()
					arg_44_0()
				end))
				arg_42_0:updateScore(var_42_1)
				arg_42_0:updateCombo()
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)
			else
				arg_42_0.comboAmount = 0

				arg_44_0()
			end
		end,
		function(arg_46_0)
			if not arg_42_0.stopFlag then
				arg_42_0:fallingGridDic()
				arg_42_0:fillEmptyGrid()
				arg_42_0:moveGridsBySelfPos(arg_42_0.gridDic, nil)

				if var_42_0 then
					arg_42_0.checkSuccesFlag = true
				end
			end

			arg_46_0()
		end
	}, function()
		arg_42_0.gameTimeFlag = true
	end)
end

function var_0_0.updateCombo(arg_48_0)
	setActive(arg_48_0.goodEffect, false)
	setActive(arg_48_0.greatEffect, false)
	setActive(arg_48_0.perfectEffect, false)

	if arg_48_0.comboAmount == 2 then
		setActive(arg_48_0.goodEffect, true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)
	elseif arg_48_0.comboAmount == 3 then
		setActive(arg_48_0.greatEffect, true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)
	elseif arg_48_0.comboAmount >= 4 then
		setActive(arg_48_0.perfectEffect, true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_5)
	end

	if arg_48_0.comboAmount > 1 then
		if LeanTween.isTweening(go(arg_48_0.caidaiTf)) then
			LeanTween.cancel(go(arg_48_0.caidaiTf))
		end

		LeanTween.delayedCall(go(arg_48_0.caidaiTf), 3, System.Action(function()
			setActive(arg_48_0.caidaiTf, false)
		end))
		setActive(arg_48_0.caidaiTf, true)
	end
end

function var_0_0.updateScore(arg_50_0, arg_50_1)
	for iter_50_0, iter_50_1 in pairs(arg_50_1) do
		arg_50_0.comboAmount = arg_50_0.comboAmount + 1
	end

	local var_50_0 = 10 * arg_50_0.comboAmount
	local var_50_1 = 0

	for iter_50_2, iter_50_3 in pairs(arg_50_1) do
		local var_50_2
		local var_50_3 = iter_50_3.amount == 3 and 1 or iter_50_3.amount == 4 and 1.5 or 2

		var_50_1 = var_50_1 + var_50_0 * var_50_3 * iter_50_3.amount

		local var_50_4 = var_50_0 * var_50_3

		for iter_50_4 = 1, #iter_50_3.posList do
			arg_50_0:addGridScoreTip(iter_50_3.posList[iter_50_4], var_50_4)
			arg_50_0:addRemoveEffect(iter_50_3.posList[iter_50_4])
		end
	end

	LeanTween.delayedCall(go(arg_50_0.labelGameScore), 0.7, System.Action(function()
		if LeanTween.isTweening(go(arg_50_0.labelGameScore)) then
			LeanTween.cancel(go(arg_50_0.labelGameScore))
		end

		local var_51_0 = arg_50_0.gameScore
		local var_51_1 = arg_50_0.gameScore + var_50_1

		LeanTween.value(go(arg_50_0.labelGameScore), var_51_0, var_51_1, 1.7):setOnUpdate(System.Action_float(function(arg_52_0)
			setText(arg_50_0.labelGameScore, math.floor(arg_52_0))
		end)):setOnComplete(System.Action(function()
			setText(arg_50_0.labelGameScore, var_51_1)
		end))

		arg_50_0.gameScore = var_51_1

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_6)
	end))
end

function var_0_0.updateRemoveFlag(arg_54_0)
	for iter_54_0 = 1, RollingBallConst.horizontal do
		for iter_54_1 = 1, RollingBallConst.vertical do
			local var_54_0 = arg_54_0.gridDic[iter_54_0][iter_54_1]

			arg_54_0:checkGridRemove(var_54_0, iter_54_0, iter_54_1)
		end
	end
end

function var_0_0.checkGridRemove(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	if not arg_55_1:getRemoveFlagH() and arg_55_2 < RollingBallConst.horizontal - 1 then
		local var_55_0 = 0
		local var_55_1 = true
		local var_55_2
		local var_55_3 = {}

		for iter_55_0 = arg_55_2, RollingBallConst.horizontal do
			if arg_55_1:getType() == arg_55_0.gridDic[iter_55_0][arg_55_3]:getType() and var_55_1 then
				var_55_0 = var_55_0 + 1

				table.insert(var_55_3, arg_55_0.gridDic[iter_55_0][arg_55_3])

				if arg_55_0.gridDic[iter_55_0][arg_55_3]:getRemoveId() then
					var_55_2 = arg_55_0.gridDic[iter_55_0][arg_55_3]:getRemoveId()
				end
			else
				var_55_1 = false
			end
		end

		if var_55_0 and var_55_0 >= 3 then
			var_55_2 = var_55_2 or arg_55_0:getGridRemoveId()

			for iter_55_1 = 1, #var_55_3 do
				var_55_3[iter_55_1]:setRemoveFlagH(true, var_55_2)
			end
		end
	end

	if not arg_55_1:getRemoveFlagV() and arg_55_3 < RollingBallConst.vertical - 1 then
		local var_55_4 = 0
		local var_55_5 = true
		local var_55_6
		local var_55_7 = {}

		for iter_55_2 = arg_55_3, RollingBallConst.vertical do
			if arg_55_1:getType() == arg_55_0.gridDic[arg_55_2][iter_55_2]:getType() and var_55_5 then
				var_55_4 = var_55_4 + 1

				table.insert(var_55_7, arg_55_0.gridDic[arg_55_2][iter_55_2])

				if arg_55_0.gridDic[arg_55_2][iter_55_2]:getRemoveId() then
					var_55_6 = arg_55_0.gridDic[arg_55_2][iter_55_2]:getRemoveId()
				end
			else
				var_55_5 = false
			end
		end

		if var_55_4 and var_55_4 >= 3 then
			var_55_6 = var_55_6 or arg_55_0:getGridRemoveId()

			for iter_55_3 = 1, #var_55_7 do
				var_55_7[iter_55_3]:setRemoveFlagV(true, var_55_6)
			end
		end
	end
end

function var_0_0.onGridDown(arg_56_0, arg_56_1)
	if arg_56_0.isMoveing or arg_56_0.selectGrid or #arg_56_0.moveDatas > 0 then
		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

	arg_56_0.selectGrid = arg_56_1

	arg_56_0.selectGrid:getTf():SetAsLastSibling()
end

function var_0_0.onGridUp(arg_57_0, arg_57_1)
	arg_57_0.selectGrid = nil

	if arg_57_0.changeGridsDic then
		arg_57_0:updateMoveGridDic()

		arg_57_0.changeGridsDic = nil
	end

	arg_57_0:clearDragAlpha()

	arg_57_0.onBeginDragTime = nil

	arg_57_0:moveGridsBySelfPos(arg_57_0.gridDic, nil)

	arg_57_0.checkSuccesFlag = true
	arg_57_0.downTime = RollingBallConst.downTime
end

function var_0_0.checkChangePos(arg_58_0, arg_58_1)
	local var_58_0, var_58_1 = arg_58_1:getPosData()
	local var_58_2, var_58_3 = arg_58_0.selectGrid:getPosData()

	if arg_58_1 == arg_58_0.selectGrid or var_58_2 ~= var_58_0 and var_58_3 ~= var_58_1 then
		arg_58_0:moveGridsBySelfPos(arg_58_0.gridDic, arg_58_0.selectGrid)

		arg_58_0.selectEnterGrid = nil
		arg_58_0.changeGridsDic = nil
		arg_58_0.changePosX, arg_58_0.changePosY = nil
	else
		if arg_58_0.changePosX == var_58_0 and arg_58_0.changePosY == var_58_1 then
			return
		end

		arg_58_0.changePosX, arg_58_0.changePosY = var_58_0, var_58_1

		arg_58_0:updateEnterGrid(arg_58_0.changePosX, arg_58_0.changePosY)
		arg_58_0:moveGridsByChangeDic()
	end
end

function var_0_0.onGridBeginDrag(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	if arg_59_0.isMoveing or not arg_59_0.selectGrid or arg_59_1 ~= arg_59_0.selectGrid then
		return
	end

	arg_59_0.onBeginDragTime = Time.realtimeSinceStartup
	arg_59_0.downTime = RollingBallConst.downTime

	local var_59_0 = arg_59_0.selectGrid:getTf()
	local var_59_1, var_59_2 = arg_59_0.selectGrid:getPosData()
	local var_59_3 = arg_59_0.selectGrid:getType()

	arg_59_0:setDragAlpha(var_59_1, var_59_2, var_59_3)

	arg_59_0.changePosX, arg_59_0.changePosY = nil
	arg_59_0.dragOffsetPos.x = arg_59_3.position.x - var_59_0.transform.localPosition.x
	arg_59_0.dragOffsetPos.y = arg_59_3.position.y - var_59_0.transform.localPosition.y
end

function var_0_0.onGridDrag(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	if not arg_60_0.selectGrid or arg_60_1 ~= arg_60_0.selectGrid then
		return
	end

	if not arg_60_0.uiCam then
		arg_60_0.uiCam = GameObject.Find("UICamera"):GetComponent("Camera")
	end

	local var_60_0 = arg_60_0.uiCam:ScreenToWorldPoint(arg_60_3.position)
	local var_60_1 = arg_60_0.rollingUI:InverseTransformPoint(var_60_0)
	local var_60_2 = var_60_1.x - RollingBallConst.grid_width / 2
	local var_60_3 = var_60_1.y - RollingBallConst.grid_height / 2

	if var_60_2 < 0 then
		var_60_2 = 0
	end

	if var_60_3 < 0 then
		var_60_3 = 0
	end

	if var_60_2 > (RollingBallConst.horizontal - 1) * RollingBallConst.grid_width then
		var_60_2 = (RollingBallConst.horizontal - 1) * RollingBallConst.grid_width
	end

	if var_60_3 > (RollingBallConst.vertical - 1) * RollingBallConst.grid_height then
		var_60_3 = (RollingBallConst.vertical - 1) * RollingBallConst.grid_height
	end

	arg_60_0.selectGrid:changePosition(var_60_2, var_60_3)

	local var_60_4 = arg_60_0:getGridByPosition(arg_60_0.selectGrid:getPosition())

	if var_60_4 and var_60_4 ~= arg_60_0.selectGrid then
		local var_60_5, var_60_6 = var_60_4:getPosData()
		local var_60_7, var_60_8 = arg_60_0.selectGrid:getPosData()
		local var_60_9 = var_60_5 - var_60_7
		local var_60_10 = var_60_6 - var_60_8

		if math.abs(var_60_9) + math.abs(var_60_10) == 1 then
			arg_60_0:updateMove(var_60_5, var_60_6)
		elseif math.abs(var_60_9) > math.abs(var_60_10) then
			if var_60_9 > 0 then
				var_60_5 = var_60_7 + 1
			end

			if var_60_9 < 0 then
				var_60_5 = var_60_7 - 1
			end

			arg_60_0:updateMove(var_60_5, var_60_8)
		else
			if var_60_10 > 0 then
				var_60_6 = var_60_8 + 1
			end

			if var_60_10 < 0 then
				var_60_6 = var_60_8 - 1
			end

			arg_60_0:updateMove(var_60_7, var_60_6)
		end
	end
end

function var_0_0.updateMove(arg_61_0, arg_61_1, arg_61_2)
	if arg_61_1 > RollingBallConst.horizontal or arg_61_2 > RollingBallConst.vertical then
		return
	end

	arg_61_0:changeDragGrid(arg_61_1, arg_61_2)
	arg_61_0:updateMoveGridDic()

	arg_61_0.changeGridsDic = nil

	arg_61_0:moveGridsBySelfPos(arg_61_0.gridDic, arg_61_0.selectGrid)
	arg_61_0:setDragAlpha(arg_61_1, arg_61_2, arg_61_0.selectGrid:getType())
end

function var_0_0.getGridByPosition(arg_62_0, arg_62_1)
	local var_62_0 = math.floor((arg_62_1.x + RollingBallConst.grid_width / 2) / RollingBallConst.grid_width) + 1
	local var_62_1 = math.floor((arg_62_1.y + RollingBallConst.grid_height / 2) / RollingBallConst.grid_height) + 1

	if var_62_0 >= 1 and var_62_0 <= RollingBallConst.horizontal and var_62_1 >= 1 and var_62_1 <= RollingBallConst.vertical then
		return arg_62_0.gridDic[var_62_0][var_62_1]
	end

	return nil
end

function var_0_0.updateEnterGrid(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0, var_63_1 = arg_63_0.selectGrid:getPosData()

	arg_63_0.changeGridsDic = {}

	for iter_63_0 = 1, #arg_63_0.gridDic do
		arg_63_0.changeGridsDic[iter_63_0] = {}

		for iter_63_1 = 1, #arg_63_0.gridDic[iter_63_0] do
			if iter_63_0 ~= var_63_0 and iter_63_1 ~= var_63_1 then
				table.insert(arg_63_0.changeGridsDic[iter_63_0], {
					grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
					posX = iter_63_0,
					posY = iter_63_1
				})
			elseif iter_63_0 == var_63_0 and iter_63_1 == var_63_1 then
				table.insert(arg_63_0.changeGridsDic[iter_63_0], {
					grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
					posX = arg_63_1,
					posY = arg_63_2
				})
			elseif iter_63_0 == var_63_0 then
				if var_63_1 < iter_63_1 and iter_63_1 <= arg_63_2 then
					table.insert(arg_63_0.changeGridsDic[iter_63_0], {
						grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0,
						posY = iter_63_1 - 1
					})
				elseif iter_63_1 < var_63_1 and arg_63_2 <= iter_63_1 then
					table.insert(arg_63_0.changeGridsDic[iter_63_0], {
						grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0,
						posY = iter_63_1 + 1
					})
				else
					table.insert(arg_63_0.changeGridsDic[iter_63_0], {
						grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0,
						posY = iter_63_1
					})
				end
			elseif iter_63_1 == var_63_1 then
				if var_63_0 < iter_63_0 and iter_63_0 <= arg_63_1 then
					table.insert(arg_63_0.changeGridsDic[iter_63_0], {
						grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0 - 1,
						posY = iter_63_1
					})
				elseif iter_63_0 < var_63_0 and arg_63_1 <= iter_63_0 then
					table.insert(arg_63_0.changeGridsDic[iter_63_0], {
						grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0 + 1,
						posY = iter_63_1
					})
				else
					table.insert(arg_63_0.changeGridsDic[iter_63_0], {
						grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0,
						posY = iter_63_1
					})
				end
			end
		end
	end
end

function var_0_0.changeDragGrid(arg_64_0, arg_64_1, arg_64_2)
	local var_64_0, var_64_1 = arg_64_0.selectGrid:getPosData()

	arg_64_0.changeGridsDic = {}

	for iter_64_0 = 1, #arg_64_0.gridDic do
		arg_64_0.changeGridsDic[iter_64_0] = {}

		for iter_64_1 = 1, #arg_64_0.gridDic[iter_64_0] do
			if iter_64_0 == arg_64_1 and iter_64_1 == arg_64_2 then
				table.insert(arg_64_0.changeGridsDic[iter_64_0], {
					grid = arg_64_0.gridDic[iter_64_0][iter_64_1],
					posX = var_64_0,
					posY = var_64_1
				})
			elseif iter_64_0 == var_64_0 and iter_64_1 == var_64_1 then
				table.insert(arg_64_0.changeGridsDic[iter_64_0], {
					grid = arg_64_0.gridDic[iter_64_0][iter_64_1],
					posX = arg_64_1,
					posY = arg_64_2
				})
			else
				table.insert(arg_64_0.changeGridsDic[iter_64_0], {
					grid = arg_64_0.gridDic[iter_64_0][iter_64_1],
					posX = iter_64_0,
					posY = iter_64_1
				})
			end
		end
	end
end

function var_0_0.createGrid(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	local var_65_0
	local var_65_1 = #arg_65_0.gridsPool

	if #arg_65_0.gridsPool > 0 then
		var_65_0 = table.remove(arg_65_0.gridsPool, 1)
	else
		var_65_0 = RollingBallGrid.New(tf(Instantiate(arg_65_0.tplGrid)))

		var_65_0:addDownCallback(function(arg_66_0, arg_66_1)
			arg_65_0:onGridDown(var_65_0)
		end)
		var_65_0:addUpCallback(function(arg_67_0, arg_67_1)
			arg_65_0:onGridUp(var_65_0)
		end)
		var_65_0:addBeginDragCallback(function(arg_68_0, arg_68_1)
			arg_65_0:onGridBeginDrag(var_65_0, arg_68_0, arg_68_1)
		end)
		var_65_0:addDragCallback(function(arg_69_0, arg_69_1)
			arg_65_0:onGridDrag(var_65_0, arg_69_0, arg_69_1)
		end)
		setActive(var_65_0:getTf(), true)
	end

	var_65_0:setParent(arg_65_0.rollingUI)
	var_65_0:setType(arg_65_1)
	var_65_0:setPosData(arg_65_2, arg_65_3)

	return var_65_0
end

function var_0_0.setDragAlpha(arg_70_0, arg_70_1, arg_70_2, arg_70_3)
	local var_70_0 = (arg_70_1 - 1) * RollingBallConst.grid_width
	local var_70_1 = (arg_70_2 - 1) * RollingBallConst.grid_height

	arg_70_0.dragAlphaGrid:setPosition(var_70_0, var_70_1)
	arg_70_0.dragAlphaGrid:setType(arg_70_3)
	setActive(arg_70_0.dragAlphaGrid:getTf(), true)
end

function var_0_0.clearDragAlpha(arg_71_0)
	setActive(arg_71_0.dragAlphaGrid:getTf(), false)
end

function var_0_0.returnGrid(arg_72_0, arg_72_1)
	arg_72_0:removeGrid(arg_72_1)
	arg_72_1:clearData()
	arg_72_1:setParent(arg_72_0.gridPoolTf)
	arg_72_1:setEventActive(false)
	table.insert(arg_72_0.gridsPool, arg_72_1)
end

function var_0_0.removeGrid(arg_73_0, arg_73_1)
	local var_73_0, var_73_1 = arg_73_1:getPosData()

	if not arg_73_0.gridDic[var_73_0][var_73_1] then
		arg_73_0.gridDic[var_73_0][var_73_1] = false
	end
end

function var_0_0.getRandomType(arg_74_0, arg_74_1)
	if arg_74_1 then
		local var_74_0 = {}

		for iter_74_0 = 1, RollingBallConst.grid_type_amount do
			if not table.contains(arg_74_1, iter_74_0) then
				table.insert(var_74_0, iter_74_0)
			end
		end

		return var_74_0[math.random(1, #var_74_0)]
	end

	return math.random(1, RollingBallConst.grid_type_amount)
end

function var_0_0.addGridScoreTip(arg_75_0, arg_75_1, arg_75_2)
	local var_75_0 = arg_75_1.x
	local var_75_1 = arg_75_1.y
	local var_75_2 = arg_75_0:getScoreTip()
	local var_75_3 = (var_75_0 - 1) * RollingBallConst.grid_width
	local var_75_4 = (var_75_1 - 1) * RollingBallConst.grid_height

	var_75_2.localPosition = Vector3(var_75_3, var_75_4, 0)

	setText(findTF(var_75_2, "text"), "+" .. arg_75_2)
	LeanTween.moveLocalY(go(var_75_2), var_75_4 + 30, 0.5):setOnComplete(System.Action(function()
		arg_75_0:returnScoreTip(var_75_2)
	end))
end

function var_0_0.addRemoveEffect(arg_77_0, arg_77_1)
	local var_77_0 = arg_77_1.x
	local var_77_1 = arg_77_1.y
	local var_77_2 = arg_77_0:getRemoveEffect()
	local var_77_3 = (var_77_0 - 1) * RollingBallConst.grid_width
	local var_77_4 = (var_77_1 - 1) * RollingBallConst.grid_height

	var_77_2.localPosition = Vector3(var_77_3 + 50, var_77_4 + 50, -350)

	LeanTween.delayedCall(go(var_77_2), 0.7, System.Action(function()
		arg_77_0:returnRemoveEffect(var_77_2)
	end))
end

function var_0_0.getRemoveEffect(arg_79_0)
	if not arg_79_0.removeEffectPool then
		arg_79_0.removeEffectPool = {}
		arg_79_0.removeEffects = {}
	end

	local var_79_0

	if #arg_79_0.removeEffectPool > 1 then
		var_79_0 = table.remove(arg_79_0.removeEffectPool, #arg_79_0.removeEffectPool)
	else
		var_79_0 = tf(Instantiate(arg_79_0.tplRemoveEffect))

		setParent(var_79_0, arg_79_0.rollingEffectUI, false)
		table.insert(arg_79_0.removeEffects, var_79_0)
	end

	setActive(var_79_0, true)

	return var_79_0
end

function var_0_0.returnRemoveEffect(arg_80_0, arg_80_1)
	setActive(arg_80_1, false)
	table.insert(arg_80_0.removeEffectPool, arg_80_1)
end

function var_0_0.getScoreTip(arg_81_0)
	if not arg_81_0.scoreTipPool then
		arg_81_0.scoreTipPool = {}
		arg_81_0.scoreTips = {}
	end

	local var_81_0

	if #arg_81_0.scoreTipPool > 1 then
		var_81_0 = table.remove(arg_81_0.scoreTipPool, #arg_81_0.scoreTipPool)
	else
		var_81_0 = tf(Instantiate(arg_81_0.tplScoreTip))

		setParent(var_81_0, arg_81_0.rollingEffectUI, false)
		table.insert(arg_81_0.scoreTips, var_81_0)
	end

	setActive(var_81_0, true)

	return var_81_0
end

function var_0_0.returnScoreTip(arg_82_0, arg_82_1)
	setActive(arg_82_1, false)
	table.insert(arg_82_0.scoreTipPool, arg_82_1)
end

function var_0_0.addEffect(arg_83_0, arg_83_1)
	local var_83_0 = arg_83_0.effectUI:InverseTransformPoint(arg_83_1)
	local var_83_1 = arg_83_0:getEffect()

	setParent(var_83_1, arg_83_0.effectUI, false)
	setActive(var_83_1, true)

	var_83_1.localPosition = var_83_0

	table.insert(arg_83_0.effectDatas, {
		vy = 2,
		ay = 0,
		vx = 2,
		ax = 0,
		tf = var_83_1
	})
end

function var_0_0.clearUI(arg_84_0)
	arg_84_0.moveDatas = {}
	arg_84_0.startFlag = false
	arg_84_0.stopFlag = false

	setText(arg_84_0.labelGameScore, "0000")
	setText(arg_84_0.labelGameTime, "")
	setActive(arg_84_0.endLess, true)

	arg_84_0.downTimeSlider.value = 1

	setActive(arg_84_0.closeUI, false)
	setActive(arg_84_0.overLight, false)
	arg_84_0:clearDragAlpha()

	for iter_84_0 = #arg_84_0.effectDatas, 1, -1 do
		local var_84_0 = arg_84_0.effectDatas[iter_84_0].tf

		arg_84_0:returnEffect(var_84_0)
		table.remove(arg_84_0.effectDatas, iter_84_0)
	end

	for iter_84_1 = 1, RollingBallConst.horizontal do
		for iter_84_2 = 1, RollingBallConst.vertical do
			if arg_84_0.gridDic[iter_84_1][iter_84_2] then
				arg_84_0:returnGrid(arg_84_0.gridDic[iter_84_1][iter_84_2])

				arg_84_0.gridDic[iter_84_1][iter_84_2] = false
			end
		end
	end
end

function var_0_0.getEffect(arg_85_0)
	if #arg_85_0.effectPool > 0 then
		return table.remove(arg_85_0.effectPool, #arg_85_0.effectPool)
	end

	return (tf(Instantiate(arg_85_0.tplEffect)))
end

function var_0_0.returnEffect(arg_86_0, arg_86_1)
	SetParent(arg_86_1, arg_86_0.effectPoolTf, false)
	table.insert(arg_86_0.effectPool, arg_86_1)
end

function var_0_0.getGridRemoveId(arg_87_0)
	if not arg_87_0.removeId then
		arg_87_0.removeId = 0
	end

	arg_87_0.removeId = arg_87_0.removeId + 1

	return tostring(arg_87_0.removeId)
end

function var_0_0.onBackPressed(arg_88_0)
	if not arg_88_0.startFlag then
		arg_88_0:emit(var_0_0.ON_BACK_PRESSED)
	end
end

function var_0_0.willExit(arg_89_0)
	if arg_89_0.timer and arg_89_0.timer.running then
		arg_89_0.timer:Stop()
	end

	if LeanTween.isTweening(go(arg_89_0.caidaiTf)) then
		LeanTween.cancel(go(arg_89_0.caidaiTf))
	end

	if LeanTween.isTweening(go(arg_89_0.labelGameScore)) then
		LeanTween.cancel(go(arg_89_0.labelGameScore))
	end

	if LeanTween.isTweening(go(arg_89_0.rollingUI)) then
		LeanTween.cancel(go(arg_89_0.rollingUI))
	end

	if arg_89_0.scoreTips then
		for iter_89_0 = 1, #arg_89_0.scoreTips do
			if LeanTween.isTweening(go(arg_89_0.scoreTips[iter_89_0])) then
				LeanTween.cancel(go(arg_89_0.scoreTips[iter_89_0]))
			end
		end
	end

	if arg_89_0.removeEffects then
		for iter_89_1 = 1, #arg_89_0.removeEffects do
			if LeanTween.isTweening(go(arg_89_0.removeEffects[iter_89_1])) then
				LeanTween.cancel(go(arg_89_0.removeEffects[iter_89_1]))
			end
		end
	end

	arg_89_0.timer = nil
end

return var_0_0
