local var_0_0 = class("IslandMiniShipCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform
	arg_1_0.addBtn = arg_1_0.tf:Find("add")
	arg_1_0.iconTr = arg_1_0.tf:Find("icon")
	arg_1_0.selectGos = {
		arg_1_0.tf:Find("sel"),
		arg_1_0.tf:Find("sel_1")
	}
	arg_1_0.frameImg = arg_1_0.tf:Find("frame"):GetComponent(typeof(Image))
	arg_1_0.selImg = arg_1_0.tf:Find("sel_1"):GetComponent(typeof(Image))
	arg_1_0.redDot = arg_1_0.tf:Find("red_dot")
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.configId = arg_2_1
	arg_2_0.ship = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipByConfigId(arg_2_1)

	setActive(arg_2_0.addBtn, not arg_2_0.ship)

	local var_2_0 = "chaijun"

	GetImageSpriteFromAtlasAsync("IslandQIcon/" .. var_2_0, "", arg_2_0.iconTr)

	local var_2_1 = IslandShip.StaticGetRarity(arg_2_1)

	arg_2_0.frameImg.sprite = GetSpriteFromAtlas("ui/IslandShipUI_atlas", "icon_frame_" .. var_2_1)
	arg_2_0.selImg.sprite = GetSpriteFromAtlas("ui/IslandShipUI_atlas", "icon_frame_" .. var_2_1 .. "_sel")

	arg_2_0:UpdateSelected(arg_2_2)
	arg_2_0:FlushRedDot()
end

function var_0_0.FlushRedDot(arg_3_0)
	setActive(arg_3_0.redDot, arg_3_0.ship and arg_3_0.ship:CanUpgradeMainSkill())
end

function var_0_0.UpdateSelected(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1 == arg_4_0.configId

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.selectGos) do
		setActive(iter_4_1, var_4_0)
	end
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
