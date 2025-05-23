local var_0_0 = class("SpWeaponSkillInfoLayer", import("view.ship.SkillInfoLayer"))

function var_0_0.getUIName(arg_1_0)
	return "SkillInfoUI"
end

function var_0_0.didEnter(arg_2_0)
	onButton(arg_2_0, arg_2_0._tf, function()
		arg_2_0:emit(var_0_0.ON_CLOSE)
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0.backBtn, function()
		arg_2_0:emit(var_0_0.ON_CLOSE)
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0:findTF("panel/buttonList/ok_button"), function()
		arg_2_0:emit(var_0_0.ON_CLOSE)
	end, SFX_CONFIRM)
	onButton(arg_2_0, arg_2_0.upgradeBtn, function()
		arg_2_0:emit(SkillInfoMediator.WARP_TO_TACTIC)
	end, SFX_UI_CLICK)
	onButton(arg_2_0, arg_2_0.metaBtn, function()
		local var_7_0 = arg_2_0.contextData.shipId
		local var_7_1
		local var_7_2

		if var_7_0 then
			var_7_2 = getProxy(BayProxy):getShipById(arg_2_0.contextData.shipId)
			var_7_1 = var_7_2:isMetaShip()
		end

		if var_7_1 then
			arg_2_0:emit(SkillInfoMediator.WARP_TO_META_TACTICS, var_7_2.configId)
		end
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.btnTypeNormal, function()
		arg_2_0:showInfo(false)
		arg_2_0:flushTypeBtn()
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.btnTypeWorld, function()
		arg_2_0:showInfo(true)
		arg_2_0:flushTypeBtn()
	end, SFX_PANEL)

	if tobool(pg.skill_world_display[arg_2_0.contextData.skillId]) then
		arg_2_0:flushTypeBtn()
	else
		setActive(arg_2_0.btnTypeNormal, false)
		setActive(arg_2_0.btnTypeWorld, false)
	end

	arg_2_0:showBase()
	arg_2_0:showInfo(false)
	setText(arg_2_0:findTF("panel/top/title_list/infomation/title"), i18n("words_information"))
	setText(arg_2_0.buttonList:Find("ok_button/Image"), i18n("text_confirm"))
	setText(arg_2_0.buttonList:Find("level_button/Image"), i18n("msgbox_text_upgrade"))
end

function var_0_0.flushTypeBtn(arg_10_0)
	setActive(arg_10_0.btnTypeNormal, arg_10_0.isWorld)
	setActive(arg_10_0.btnTypeWorld, not arg_10_0.isWorld)
end

function var_0_0.showBase(arg_11_0)
	local var_11_0 = arg_11_0.contextData.skillId
	local var_11_1 = arg_11_0.contextData.unlock
	local var_11_2 = getSkillName(var_11_0)

	if not var_11_1 then
		var_11_2 = setColorStr(var_11_2, "#a2a2a2")
	end

	setText(arg_11_0.skillInfoName, var_11_2)

	local var_11_3 = getSkillConfig(var_11_0)

	assert(var_11_3)
	LoadImageSpriteAsync("skillicon/" .. var_11_3.icon, arg_11_0.skillInfoIcon)
	setActive(arg_11_0.upgradeBtn, false)
	setActive(arg_11_0.metaBtn, false)
end

function var_0_0.showInfo(arg_12_0, arg_12_1)
	arg_12_0.isWorld = arg_12_1

	local var_12_0 = arg_12_0.contextData.skillId
	local var_12_1 = arg_12_0.contextData.skillOnShip
	local var_12_2 = arg_12_0.contextData.unlock
	local var_12_3 = var_12_1 and var_12_1.level or 1

	setText(arg_12_0.skillInfoLv, "Lv." .. var_12_3)

	local var_12_4 = getSkillDesc(var_12_0, var_12_3, arg_12_1)

	if not var_12_2 then
		var_12_4 = setColorStr(i18n("spweapon_tip_skill_locked") .. var_12_4, "#a2a2a2")
	end

	setText(arg_12_0.skillInfoIntro, var_12_4)
end

function var_0_0.willExit(arg_13_0)
	pg.UIMgr.GetInstance():UnblurPanel(arg_13_0._tf)

	if arg_13_0.contextData.onExit then
		arg_13_0.contextData.onExit()
	end
end

return var_0_0
