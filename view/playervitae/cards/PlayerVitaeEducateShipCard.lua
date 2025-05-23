local var_0_0 = class("PlayerVitaeEducateShipCard", import(".PlayerVitaeEducateBaseCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.paintingTr = arg_1_1:Find("ship_icon/painting")
	arg_1_0.nameTxt = arg_1_1:Find("detail/name_bg/name_mask/name"):GetComponent("ScrollText")
end

function var_0_0.Flush(arg_2_0)
	arg_2_0:Clear()
	onButton(arg_2_0, arg_2_0._tf, function()
		arg_2_0:emit(PlayerVitaeMediator.ON_SEL_EDUCATE_CHAR)
	end, SFX_PANEL)

	local var_2_0 = getProxy(PlayerProxy):getRawData()
	local var_2_1 = VirtualEducateCharShip.New(var_2_0:GetEducateCharacter())

	setPaintingPrefabAsync(arg_2_0.paintingTr, var_2_1:getPainting(), "biandui")
	arg_2_0.nameTxt:SetText(var_2_1.name)

	arg_2_0.ship = var_2_1
end

function var_0_0.Clear(arg_4_0)
	if arg_4_0.ship then
		retPaintingPrefab(arg_4_0.paintingTr, arg_4_0.ship:getPainting())
	end

	removeOnButton(arg_4_0._tf)
end

return var_0_0
