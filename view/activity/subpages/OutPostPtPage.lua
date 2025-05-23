local var_0_0 = class("OutPostPtPage", import(".MaoziPtPage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.getBtn1 = arg_1_0:findTF("AD/switcher/phase2/get_btn")
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	setActive(arg_2_0.displayBtn, true)

	local var_2_0 = arg_2_0.displayBtn:Find("Image1")
	local var_2_1 = arg_2_0.displayBtn:Find("Image2")
	local var_2_2, var_2_3 = arg_2_0:GetActTask()
	local var_2_4 = var_2_2 and var_2_2:isReceive() and var_2_3

	setActive(var_2_0, not var_2_4)
	setActive(var_2_1, var_2_4)

	if var_2_2 and not var_2_2:isReceive() then
		blinkAni(go(var_2_0), 0.8, -1, 0.3)
	else
		LeanTween.cancel(go(var_2_0))
	end

	onButton(arg_2_0, arg_2_0.displayBtn, function()
		if var_2_2 and var_2_2:isReceive() and not var_2_4 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("undermist_tip"))

			return
		end

		if var_2_2 and not var_2_4 then
			arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = "activity",
				targetId = var_2_2.id
			})
		end
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.getBtn1, function()
		triggerButton(arg_2_0.getBtn)
	end, SFX_PANEL)
end

function var_0_0.OnUpdateFlush(arg_5_0)
	var_0_0.super.OnUpdateFlush(arg_5_0)

	local var_5_0 = arg_5_0.ptData:CanGetAward()

	setActive(arg_5_0.getBtn1, var_5_0)
end

function var_0_0.GetActTask(arg_6_0)
	local var_6_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.OUTPOST_TASK)

	if not var_6_0 or var_6_0:isEnd() then
		return
	end

	local var_6_1 = _.flatten(var_6_0:getConfig("config_data"))
	local var_6_2 = getProxy(TaskProxy)
	local var_6_3
	local var_6_4 = false

	for iter_6_0 = #var_6_1, 1, -1 do
		local var_6_5 = var_6_1[iter_6_0]
		local var_6_6 = var_6_2:getTaskById(var_6_5) or var_6_2:getFinishTaskById(var_6_5)

		if var_6_6 then
			var_6_3 = var_6_6

			if iter_6_0 == #var_6_1 then
				var_6_4 = true
			end

			break
		end
	end

	return var_6_3, var_6_4
end

return var_0_0
