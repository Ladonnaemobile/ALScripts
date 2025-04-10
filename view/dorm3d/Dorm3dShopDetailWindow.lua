local var_0_0 = class("Dorm3dShopDetailWindow", import("view.base.BaseUI"))

var_0_0.SELECTED_WIDTH = 52
var_0_0.UNSELECTED_WIDTH = 12
var_0_0.LOOP_DURATION = 5

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dShopDetailWindow"
end

function var_0_0.init(arg_2_0)
	arg_2_0.previewTf = arg_2_0._tf:Find("Window/Preview")
	arg_2_0.bubbleContent = arg_2_0._tf:Find("Window/Bubbles/content")
	arg_2_0.bubbleTpl = arg_2_0._tf:Find("Window/Bubbles/tpl")
	arg_2_0.bubbleList = UIItemList.New(arg_2_0.bubbleContent, arg_2_0.bubbleTpl)
	arg_2_0.scrollSnap = BannerScrollRect4Dorm.New(arg_2_0._tf:Find("Window/banner/mask/content"), arg_2_0._tf:Find("Window/banner/dots"))

	setActive(arg_2_0.bubbleTpl, false)

	arg_2_0.minusBtn = arg_2_0:findTF("Window/countList/minusBtn")
	arg_2_0.addBtn = arg_2_0:findTF("Window/countList/addBtn")
	arg_2_0.maxBtn = arg_2_0:findTF("Window/countList/maxBtn")
	arg_2_0.countText = arg_2_0:findTF("Window/countList/count/Text")
	arg_2_0.shopCfg = arg_2_0.contextData.shopCfg
	arg_2_0.unlockTips = pg.dorm3d_gift[arg_2_0.shopCfg.item_id].unlock_tips or {}

	local var_2_0 = arg_2_0.shopCfg.room_id

	arg_2_0.unlockBanners = arg_2_0.shopCfg.banners
	arg_2_0.isExclusive = pg.dorm3d_gift[arg_2_0.shopCfg.item_id].ship_group_id ~= 0
	arg_2_0.isSpecial = false
	arg_2_0.addFavor = pg.dorm3d_favor_trigger[pg.dorm3d_gift[arg_2_0.shopCfg.item_id].favor_trigger_id].num

	setActive(arg_2_0._tf:Find("Window/Title/gift"), true)

	arg_2_0.curCount = 1
	arg_2_0.buyCount = getProxy(ApartmentProxy):GetGiftShopCount(arg_2_0.shopCfg.item_id)
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("Window/Cancel"), function()
		arg_3_0:closeView()
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("Mask"), function()
		arg_3_0:closeView()
	end)
	arg_3_0:InitUIList()
	arg_3_0:InitDropIcon()
	arg_3_0:InitBanner()

	local var_3_0 = Dorm3dGift.New({
		configId = arg_3_0.shopCfg.item_id
	})
	local var_3_1 = CommonCommodity.New({
		id = var_3_0:GetShopID()
	}, Goods.TYPE_SHOPSTREET)
	local var_3_2, var_3_3, var_3_4 = var_3_1:GetPrice()
	local var_3_5 = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = var_3_1:GetResType(),
		count = var_3_2
	})
	local var_3_6 = arg_3_0:GetGoodPrice(arg_3_0:GetShopId(arg_3_0.buyCount + arg_3_0.curCount))
	local var_3_7 = i18n("dorm3d_shop_buy_tips", "<icon name=" .. var_3_1:GetResIcon() .. " w=1.1 h=1.1/>", "x" .. var_3_6, "x" .. var_3_5.count, arg_3_0.shopCfg.name)
	local var_3_8
	local var_3_9 = 0

	_.each(var_3_0:getConfig("shop_id"), function(arg_6_0)
		local var_6_0 = pg.shop_template[arg_6_0]

		if var_6_0.group_type == 2 then
			var_3_9 = math.max(var_6_0.group_limit, var_3_9)
		end
	end)

	if var_3_9 > 0 then
		var_3_8 = {
			arg_3_0.buyCount,
			var_3_9
		}
	end

	if var_3_8 then
		var_3_7 = var_3_7 .. i18n("dorm3d_purchase_weekly_limit", var_3_8[1], var_3_8[2])
	end

	setText(arg_3_0._tf:Find("Window/Content"), var_3_7)
	setText(arg_3_0._tf:Find("Window/Confirm/Text"), i18n("msgbox_text_confirm"))
	setText(arg_3_0._tf:Find("Window/Cancel/Text"), i18n("msgbox_text_cancel"))
	pg.UIMgr.GetInstance():OverlayPanel(arg_3_0._tf, {
		weight = LayerWeightConst.THIRD_LAYER
	})

	local var_3_10 = var_3_0:GetShopID()

	arg_3_0.itemList = {
		var_3_10
	}
	arg_3_0.sumPrice = arg_3_0:GetGoodPrice(var_3_10)

	setText(arg_3_0.countText, arg_3_0.curCount)

	local var_3_11 = 1

	if var_3_8 then
		var_3_11 = var_3_8[2] - var_3_8[1]
	end

	local function var_3_12(arg_7_0)
		arg_7_0 = math.max(arg_7_0, 1)
		arg_7_0 = math.min(arg_7_0, var_3_11)
		arg_3_0.curCount = arg_7_0

		setText(arg_3_0.countText, arg_7_0)

		local var_7_0 = arg_3_0:GetShopId(arg_3_0.buyCount + arg_3_0.curCount)
		local var_7_1 = arg_3_0:GetGoodPrice(var_7_0)

		arg_3_0.sumPrice = 0

		for iter_7_0 = arg_3_0.buyCount, arg_3_0.buyCount + arg_3_0.curCount - 1 do
			arg_3_0.sumPrice = arg_3_0.sumPrice + arg_3_0:GetGoodPrice(arg_3_0:GetShopId(iter_7_0))
		end

		local var_7_2 = i18n("dorm3d_shop_buy_tips", "<icon name=" .. var_3_1:GetResIcon() .. " w=1.1 h=1.1/>", "x" .. var_7_1, "x" .. arg_3_0.sumPrice, arg_3_0.shopCfg.name)

		if var_3_8 then
			var_7_2 = var_7_2 .. i18n("dorm3d_purchase_weekly_limit", var_3_8[1], var_3_8[2])
		end

		setText(arg_3_0._tf:Find("Window/Content"), var_7_2)
		arg_3_0.contextData.changeCount(arg_7_0)
	end

	onButton(arg_3_0, arg_3_0.minusBtn, function()
		if arg_3_0.curCount - 1 > 0 then
			table.remove(arg_3_0.itemList, #arg_3_0.itemList)
		end

		var_3_12(arg_3_0.curCount - 1)
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.addBtn, function()
		if arg_3_0.buyCount + arg_3_0.curCount + 1 <= var_3_9 then
			table.insert(arg_3_0.itemList, arg_3_0:GetShopId(arg_3_0.buyCount + arg_3_0.curCount))
		end

		var_3_12(arg_3_0.curCount + 1)
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.maxBtn, function()
		arg_3_0.itemList = {}

		for iter_10_0 = arg_3_0.buyCount, var_3_9 - 1 do
			table.insert(arg_3_0.itemList, arg_3_0:GetShopId(iter_10_0))
		end

		var_3_12(var_3_11)
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("Window/Confirm"), function()
		local var_11_0 = getProxy(PlayerProxy):getData()
		local var_11_1 = pg.shop_template[arg_3_0.itemList[1]]

		if var_11_0[id2res(var_11_1.resource_type)] < arg_3_0.sumPrice then
			local var_11_2 = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = var_11_1.resource_type
			}):getName()

			if var_11_1.resource_type == 1 then
				GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
					{
						59001,
						arg_3_0.sumPrice - var_11_0[id2res(var_11_1.resource_type)],
						arg_3_0.sumPrice
					}
				})
			elseif var_11_1.resource_type == 4 or var_11_1.resource_type == 14 then
				GoShoppingMsgBox(i18n("switch_to_shop_tip_3", i18n("word_gem")), ChargeScene.TYPE_DIAMOND)
			elseif not ItemTipPanel.ShowItemTip(DROP_TYPE_RESOURCE, var_11_1.resource_type) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("buyProp_noResource_error", var_11_2))
			end

			arg_3_0:closeView()

			return
		end

		for iter_11_0, iter_11_1 in ipairs(arg_3_0.itemList) do
			arg_3_0:emit(Dorm3dShopDetailMediator.SHOPPING, {
				silentTip = true,
				count = 1,
				shopId = iter_11_1
			})
		end

		arg_3_0:closeView()
	end, SFX_PANEL)
end

function var_0_0.InitBanner(arg_12_0)
	for iter_12_0 = 1, #arg_12_0.unlockBanners do
		local var_12_0 = arg_12_0.scrollSnap:AddChild()

		LoadImageSpriteAsync("dorm3dbanner/" .. arg_12_0.unlockBanners[iter_12_0], var_12_0)
	end

	arg_12_0.scrollSnap:SetUp()
end

function var_0_0.InitUIList(arg_13_0)
	arg_13_0.bubbleList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventInit then
			local var_14_0 = arg_14_1 + 1
			local var_14_1 = arg_13_0.unlockTips[var_14_0]

			LoadImageSpriteAtlasAsync("ui/shoptip_atlas", "icon_" .. var_14_1, arg_14_2:Find("icon/icon"), true)
			setText(arg_14_2:Find("bubble/Text"), i18n("dorm3d_shop_tag" .. var_14_1))
			setActive(arg_14_2:Find("bubble"), false)
			onToggle(arg_13_0, arg_14_2, function(arg_15_0)
				setActive(arg_14_2:Find("icon/select"), arg_15_0)
				setActive(arg_14_2:Find("icon/unselect"), not arg_15_0)
				setActive(arg_14_2:Find("bubble"), arg_15_0)
			end)
		end
	end)
	arg_13_0.bubbleList:align(#arg_13_0.unlockTips)
end

function var_0_0.InitDropIcon(arg_16_0)
	local var_16_0 = Drop.New({
		type = DROP_TYPE_DORM3D_GIFT,
		id = arg_16_0.shopCfg.item_id,
		count = getProxy(ApartmentProxy):getGiftCount(arg_16_0.shopCfg.item_id)
	})

	LoadImageSpriteAtlasAsync(var_16_0:getIcon(), "", arg_16_0._tf:Find("Window/Item/Dorm3dIconTpl/icon"), true)
	GetImageSpriteFromAtlasAsync("weaponframes", "dorm3d_" .. ItemRarity.Rarity2Print(arg_16_0.shopCfg.rarity), arg_16_0._tf:Find("Window/Item/Dorm3dIconTpl"))
	setActive(arg_16_0._tf:Find("Window/Item/sp"), arg_16_0.isExclusive or arg_16_0.isSpecial)

	if arg_16_0.isSpecial then
		setText(arg_16_0._tf:Find("Window/Item/sp/Text"), i18n("dorm3d_purchase_label_special"))
	elseif arg_16_0.isExclusive then
		setText(arg_16_0._tf:Find("Window/Item/sp/Text"), i18n("dorm3d_purchase_confirm_tip"))
	end

	if arg_16_0.addFavor then
		setActive(arg_16_0._tf:Find("Window/Item/gift"), true)
		setText(arg_16_0._tf:Find("Window/Item/gift/Text"), "+" .. arg_16_0.addFavor)
	end
end

function var_0_0.GetShopId(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.shopCfg.shop_id

	for iter_17_0 = 1, #var_17_0 - 1 do
		local var_17_1 = var_17_0[iter_17_0]
		local var_17_2 = pg.shop_template[var_17_1]
		local var_17_3 = var_17_2.limit_args[1]

		if not var_17_3 and var_17_2.group_type == 0 then
			return var_17_1
		elseif var_17_3 and (var_17_3[1] == "dailycount" or var_17_3[1] == "count") then
			if arg_17_1 < var_17_3[3] then
				return var_17_1
			end
		elseif var_17_2.group_type == 2 then
			if arg_17_1 < var_17_2.group_limit then
				return var_17_1
			end
		else
			return var_17_1
		end
	end

	return var_17_0[#var_17_0] or 0
end

function var_0_0.GetGoodPrice(arg_18_0, arg_18_1)
	return (CommonCommodity.New({
		id = arg_18_1
	}, Goods.TYPE_SHOPSTREET):GetPrice())
end

function var_0_0.willExit(arg_19_0)
	if arg_19_0.timerRefreshTime then
		arg_19_0.timerRefreshTime:Stop()

		arg_19_0.timerRefreshTime = nil
	end

	arg_19_0.scrollSnap:Dispose()

	arg_19_0.scrollSnap = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_19_0._tf)
end

return var_0_0
