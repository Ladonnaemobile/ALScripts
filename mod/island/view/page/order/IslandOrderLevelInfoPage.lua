local var_0_0 = class("IslandOrderLevelInfoPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandOrderLevelInfoUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.levelTxt = arg_2_0:findTF("frame/level"):GetComponent(typeof(Text))
	arg_2_0.expTr = arg_2_0:findTF("frame/slider")
	arg_2_0.expTxt = arg_2_0:findTF("frame/exp"):GetComponent(typeof(Text))
	arg_2_0.cntTxt = arg_2_0:findTF("frame/cnt"):GetComponent(typeof(Text))
	arg_2_0.uiItemList = UIItemList.New(arg_2_0:findTF("frame/rect/content"), arg_2_0:findTF("frame/rect/content/tpl"))
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()
	end, SFX_PANEL)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddListener(IslandOrderAgency.ORDER_FINISH_UPDATE, arg_5_0.OnReset)
end

function var_0_0.RemoveListener(arg_6_0)
	arg_6_0:RemoveListener(IslandOrderAgency.ORDER_FINISH_UPDATE, arg_6_0.OnReset)
end

function var_0_0.OnReset(arg_7_0)
	arg_7_0:Flush()
end

function var_0_0.Show(arg_8_0)
	var_0_0.super.Show(arg_8_0)
	arg_8_0:Flush()
end

function var_0_0.Flush(arg_9_0)
	local var_9_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency()

	arg_9_0:FlushLevelInfo(var_9_0)
	arg_9_0:FlushList(var_9_0)
	arg_9_0:FlushCnt(var_9_0)
end

function var_0_0.FlushCnt(arg_10_0, arg_10_1)
	arg_10_0.cntTxt.text = i18n1("本周加急订单剩余：") .. arg_10_1:GetLeftUrgentCnt()
end

function var_0_0.FlushLevelInfo(arg_11_0, arg_11_1)
	arg_11_0.levelTxt.text = "Lv." .. arg_11_1:GetLevel()

	if arg_11_1:IsMaxLevel() then
		setSlider(arg_11_0.expTr, 0, 1, 1)

		arg_11_0.expTxt.text = "MAX"
	else
		local var_11_0 = arg_11_1:GetExp()
		local var_11_1 = math.max(1, arg_11_1:GetNextTargetExp())

		setSlider(arg_11_0.expTr, 0, 1, var_11_0 / var_11_1)

		arg_11_0.expTxt.text = "<size=60><color=#ffaf1b>" .. var_11_0 .. "</color></size><color=#979797>/" .. var_11_1 .. "</color>"
	end
end

function var_0_0.FlushList(arg_12_0, arg_12_1)
	local var_12_0 = pg.island_order_favor.all
	local var_12_1 = 1

	arg_12_0.uiItemList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = var_12_0[arg_13_1 + 1]

			arg_12_0:UpdateCard(arg_12_1, arg_13_2, var_13_0)

			if arg_12_1:IsGotAward(var_13_0) then
				var_12_1 = arg_13_1 + 1
			end
		end
	end)
	arg_12_0.uiItemList:align(#var_12_0)
	scrollTo(arg_12_0.uiItemList.container.parent, 0, 1)
	arg_12_0:ScrollTo(var_12_1, var_12_0)
end

function var_0_0.ScrollTo(arg_14_0, arg_14_1, arg_14_2)
	onNextTick(function()
		local var_15_0 = math.min(arg_14_1, #arg_14_2 * 0.5 - 1)
		local var_15_1 = arg_14_0.uiItemList.container:GetChild(0)
		local var_15_2 = arg_14_0.uiItemList.container:GetChild(var_15_0)
		local var_15_3 = math.abs(var_15_2.localPosition.x - var_15_1.localPosition.x)
		local var_15_4 = arg_14_0.uiItemList.container.localPosition

		arg_14_0.uiItemList.container.localPosition = Vector3(var_15_4.x - var_15_3, var_15_4.y, 0)
	end)
end

function var_0_0.UpdateCard(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0:UpdateAwards(arg_16_2, arg_16_3)

	local var_16_0 = arg_16_1:IsGotAward(arg_16_3)
	local var_16_1 = arg_16_1:CanGetAward(arg_16_3)
	local var_16_2 = var_16_1 or var_16_0

	setActive(arg_16_2:Find("got"), var_16_0)
	setActive(arg_16_2:Find("finish"), var_16_2)

	local var_16_3 = arg_16_3 < 10 and "0" .. arg_16_3 or arg_16_3

	setText(arg_16_2:Find("num"), setColorStr(var_16_3, var_16_2 and "#FFFFFF" or "#979797"))
	onButton(arg_16_0, arg_16_2, function()
		if var_16_1 and not var_16_0 then
			arg_16_0:emit(IslandMediator.ON_GET_ORDER_EXP_AWARD, arg_16_3)
		end
	end, SFX_PANEL)
end

function var_0_0.UpdateAwards(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = pg.island_order_favor[arg_18_2].award_display
	local var_18_1 = UIItemList.New(arg_18_1:Find("awards"), arg_18_1:Find("awards/IslandItemTpl"))

	var_18_1:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = var_18_0[arg_19_1 + 1]
			local var_19_1 = Drop.Create(var_19_0)

			updateDrop(arg_19_2, var_19_1)
		end
	end)
	var_18_1:align(math.min(2, #var_18_0))
end

function var_0_0.OnDestroy(arg_20_0)
	return
end

return var_0_0
