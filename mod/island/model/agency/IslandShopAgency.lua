local var_0_0 = class("IslandShopAgency", import(".IslandBaseAgency"))
local var_0_1 = pg.island_shop_template
local var_0_2 = pg.island_shop_goods
local var_0_3 = pg.island_shop_normal_template

function var_0_0.OnInit(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.shop_list

	arg_1_0:SetShops(var_1_0)
end

function var_0_0.SetShops(arg_2_0, arg_2_1)
	arg_2_0.shops = {}
	arg_2_0.shopIds = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = IslandShopp.New(iter_2_1, arg_2_0:GetHost())

		table.insert(arg_2_0.shops, var_2_0)
		table.insert(arg_2_0.shopIds, iter_2_1.id)
	end
end

function var_0_0.IsShowShop(arg_3_0, arg_3_1)
	return table.contains(arg_3_0.shopIds, arg_3_1)
end

function var_0_0.GetShopById(arg_4_0, arg_4_1)
	if not arg_4_0:IsShowShop(arg_4_1) then
		return nil
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.shops) do
		if iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end
end

function var_0_0.GetShopCommodity(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:GetShopById(arg_5_1)

	if var_5_0 then
		return var_5_0:GetCommodityById(arg_5_2)
	end
end

function var_0_0.RefreshShopData(arg_6_0, arg_6_1)
	arg_6_0:sendNotification(GAME.ISLAND_SHOP_OP, {
		operation = IslandConst.SHOP_GET_DATA,
		shopId = arg_6_1
	})
end

function var_0_0.UpdateShop(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:GetShopById(arg_7_1)

	if var_7_0 then
		if arg_7_2 ~= nil then
			var_7_0:UpdateData(arg_7_2)
		else
			table.remove(arg_7_0.shops, var_7_0)
			table.remove(arg_7_0.shopIds, arg_7_1)
		end
	elseif arg_7_2 ~= nil then
		local var_7_1 = IslandShopp.New(arg_7_2, arg_7_0:GetHost())

		table.insert(arg_7_0.shops, var_7_1)
		table.insert(arg_7_0.shopIds, arg_7_2.id)
	end
end

function var_0_0.UpdateShopCommodity(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0:GetShopById(arg_8_1)

	if var_8_0 then
		var_8_0:UpdateCommodity(arg_8_2, arg_8_3)
	end
end

function var_0_0.GetSortedShopConfigs(arg_9_0, arg_9_1)
	table.sort(arg_9_1, function(arg_10_0, arg_10_1)
		return arg_10_0.order < arg_10_1.order
	end)

	return arg_9_1
end

function var_0_0.ShouldShowFirstShop(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1.shop_type ~= 0 and arg_11_0:IsShowShop(arg_11_1.id) and table.contains(arg_11_2, arg_11_1.show_type) then
		return true
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.shops) do
		if iter_11_1:GetFirstShopId() == arg_11_1.id and table.contains(arg_11_2, iter_11_1:GetShowType()) then
			return true
		end
	end

	return false
end

function var_0_0.ShouldShowSecondShop(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1.shop_type ~= 0 and arg_12_0:IsShowShop(arg_12_1.id) and table.contains(arg_12_2, arg_12_1.show_type) then
		return true
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.shops) do
		if iter_12_1:GetSecondShopId() == arg_12_1.id and table.contains(arg_12_2, iter_12_1:GetShowType()) then
			return true
		end
	end

	return false
end

function var_0_0.GetFirstShopConfigs(arg_13_0, arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(var_0_1.all) do
		local var_13_1 = var_0_1[iter_13_1]

		if var_13_1.tag_type == 1 and arg_13_0:ShouldShowFirstShop(var_13_1, arg_13_1) then
			table.insert(var_13_0, var_13_1)
		end
	end

	return arg_13_0:GetSortedShopConfigs(var_13_0)
end

function var_0_0.GetSecondShopConfigs(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}

	if arg_14_2 == 0 then
		return var_14_0
	end

	for iter_14_0, iter_14_1 in ipairs(var_0_1.get_id_list_by_first_shop[arg_14_2]) do
		local var_14_1 = var_0_1[iter_14_1]

		if var_14_1.tag_type == 2 and arg_14_0:ShouldShowSecondShop(var_14_1, arg_14_1) then
			table.insert(var_14_0, var_14_1)
		end
	end

	return arg_14_0:GetSortedShopConfigs(var_14_0)
end

function var_0_0.GetThirdShopConfigs(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}

	if arg_15_2 == 0 then
		return var_15_0
	end

	for iter_15_0, iter_15_1 in ipairs(var_0_1.get_id_list_by_second_shop[arg_15_2]) do
		local var_15_1 = var_0_1[iter_15_1]

		if var_15_1.tag_type == 3 and arg_15_0:IsShowShop(iter_15_1) and table.contains(arg_15_1, var_15_1.show_type) then
			table.insert(var_15_0, var_15_1)
		end
	end

	return arg_15_0:GetSortedShopConfigs(var_15_0)
end

function var_0_0.GetInitShowingShop(arg_16_0, arg_16_1)
	local var_16_0
	local var_16_1 = arg_16_0:GetFirstShopConfigs(arg_16_1)[1]

	if var_16_1.shop_type == 0 then
		local var_16_2 = arg_16_0:GetSecondShopConfigs(arg_16_1, var_16_1.id)[1]

		if var_16_2.shop_type == 0 then
			var_16_0 = arg_16_0:GetThirdShopConfigs(arg_16_1, var_16_2.id)[1]
		else
			var_16_0 = var_16_2
		end
	else
		var_16_0 = var_16_1
	end

	if var_16_0 then
		return arg_16_0:GetShopById(var_16_0.id)
	else
		return nil
	end
end

function var_0_0.GetNewOrOverdueShopIds(arg_17_0)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(var_0_3.all) do
		local var_17_1 = var_0_3[iter_17_1]
		local var_17_2 = pg.TimeMgr.GetInstance():inTime(var_17_1.exist_time)

		if arg_17_0:IsShowShop(iter_17_1) and not var_17_2 or not arg_17_0:IsShowShop(iter_17_1) and var_17_2 then
			table.insert(var_17_0, iter_17_1)
		end
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.shops) do
		if not (pg.TimeMgr.GetInstance():GetServerTime() < iter_17_3.existTime) then
			table.insert(var_17_0, iter_17_3.id)
		end
	end

	return var_17_0
end

return var_0_0
