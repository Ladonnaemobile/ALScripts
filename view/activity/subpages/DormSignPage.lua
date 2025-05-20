local var_0_0 = class("DormSignPage", import("view.base.BaseActivityPage"))

function var_0_0.getUIName(arg_1_0)
	return "DormSignPage"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.bg = arg_2_0:findTF("AD")
	arg_2_0.items = arg_2_0:findTF("items", arg_2_0.bg)
	arg_2_0.uilist = UIItemList.New(arg_2_0.items, arg_2_0:findTF("tpl", arg_2_0.items))
	arg_2_0.goBtn = arg_2_0:findTF("btn_go", arg_2_0.bg)
	arg_2_0.lockTF = arg_2_0:findTF("lock", arg_2_0.bg)
end

function var_0_0.OnDataSetting(arg_3_0)
	arg_3_0.actTaskProxy = getProxy(ActivityTaskProxy)
	arg_3_0.taskGroup = underscore.flatten(arg_3_0.activity:getConfig("config_data"))
	arg_3_0.taskConfig = pg.task_data_template
end

function var_0_0.UpdateTaskData(arg_4_0)
	arg_4_0.taskVOs = arg_4_0.actTaskProxy:getTaskById(arg_4_0.activity.id)
	arg_4_0.finishTaksVOs = arg_4_0.actTaskProxy:getFinishTaskById(arg_4_0.activity.id)
	arg_4_0.taskDic = {}

	_.each(arg_4_0.taskVOs, function(arg_5_0)
		arg_4_0.taskDic[arg_5_0.id] = arg_5_0
	end)
	_.each(arg_4_0.finishTaksVOs, function(arg_6_0)
		arg_4_0.taskDic[arg_6_0.id] = arg_6_0
	end)
end

function var_0_0.OnFirstFlush(arg_7_0)
	arg_7_0.uilist:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventInit then
			local var_8_0 = arg_8_1 + 1
			local var_8_1 = arg_7_0.taskGroup[var_8_0]
			local var_8_2 = arg_7_0:findTF("item", arg_8_2)
			local var_8_3 = Drop.Create(arg_7_0.taskConfig[var_8_1].award_display[1])

			if var_8_0 > 1 then
				updateDrop(var_8_2, var_8_3)
			end

			onButton(arg_7_0, arg_8_2, function()
				if arg_7_0.taskDic[var_8_1] and arg_7_0.taskDic[var_8_1]:getTaskStatus() == 1 and not arg_7_0.taskDic[var_8_1]:isOver() then
					arg_7_0:emit(ActivityMediator.ON_ACTIVITY_TASK_SUBMIT, {
						activityId = arg_7_0.activity.id,
						id = var_8_1
					})
				else
					arg_7_0:emit(BaseUI.ON_DROP, var_8_3)
				end
			end, SFX_PANEL)
		elseif arg_8_0 == UIItemList.EventUpdate then
			local var_8_4 = arg_8_1 + 1
			local var_8_5 = arg_7_0.taskGroup[var_8_4]
			local var_8_6 = arg_7_0.taskDic[var_8_5]

			setActive(arg_7_0:findTF("got", arg_8_2), var_8_6 and var_8_6:isOver())
			setActive(arg_7_0:findTF("tip", arg_8_2), var_8_6 and var_8_6:getTaskStatus() == 1 and not var_8_6:isOver())
		end
	end)
	onButton(arg_7_0, arg_7_0.goBtn, function()
		arg_7_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.DORM3DSELECT)
	end, SFX_PANEL)

	local var_7_0 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "SelectDorm3DMediator")

	setActive(arg_7_0.goBtn, var_7_0)
	setActive(arg_7_0.lockTF, not var_7_0)
	setActive(arg_7_0.goBtn:Find("tip"), var_0_0.IsShowGoRed())
	PlayerPrefs.SetString("DormSignPage", var_0_0.GetDate())
end

function var_0_0.OnUpdateFlush(arg_11_0)
	arg_11_0:UpdateTaskData()
	arg_11_0.uilist:align(#arg_11_0.taskGroup)
end

function var_0_0.GetDate()
	return pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d")
end

function var_0_0.IsShowRed()
	return var_0_0.IsShowGoRed() or var_0_0.IsShowAwardRed()
end

function var_0_0.IsShowGoRed()
	return PlayerPrefs.GetString("DormSignPage", "") ~= var_0_0.GetDate()
end

function var_0_0.IsShowAwardRed()
	local var_15_0 = getProxy(ActivityTaskProxy):getTaskById(ActivityConst.DORM_SIGN_ID)

	return _.any(var_15_0, function(arg_16_0)
		return arg_16_0:getTaskStatus() == 1
	end)
end

return var_0_0
