local var_0_0 = class("ItemInfoMediator", import("..base.ContextMediator"))

var_0_0.USE_ITEM = "ItemInfoMediator:USE_ITEM"
var_0_0.COMPOSE_ITEM = "ItemInfoMediator:COMPOSE_ITEM"
var_0_0.SELL_BLUEPRINT = "sell blueprint"
var_0_0.EXCHANGE_LOVE_LETTER_ITEM = "ItemInfoMediator.EXCHANGE_LOVE_LETTER_ITEM"
var_0_0.CHECK_LOVE_LETTER_MAIL = "ItemInfoMediator.CHECK_LOVE_LETTER_MAIL"
var_0_0.REPAIR_LOVE_LETTER_MAIL = "ItemInfoMediator.REPAIR_LOVE_LETTER_MAIL"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.SELL_BLUEPRINT, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.FRAG_SELL, {
			arg_2_1
		})
	end)
	arg_1_0:bind(var_0_0.USE_ITEM, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = getProxy(BagProxy):getItemById(arg_3_1)

		if not UseItemCommand.Check(var_3_0, arg_3_2) then
			arg_1_0.viewComponent:closeView()

			return
		end

		arg_1_0.viewComponent:PlayOpenBox(var_3_0:getConfig("display_effect"), function()
			arg_1_0:sendNotification(GAME.USE_ITEM, {
				id = arg_3_1,
				count = arg_3_2,
				isEquipBox = var_3_0:getConfig("type") == Item.EQUIPMENT_BOX_TYPE_5
			})
		end)
	end)
	arg_1_0:bind(var_0_0.COMPOSE_ITEM, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:sendNotification(GAME.COMPOSE_ITEM, {
			id = arg_5_1,
			count = arg_5_2
		})
	end)
	arg_1_0:bind(var_0_0.EXCHANGE_LOVE_LETTER_ITEM, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.EXCHANGE_LOVE_LETTER_ITEM, {
			activity_id = arg_6_1
		})
	end)
	arg_1_0:bind(var_0_0.CHECK_LOVE_LETTER_MAIL, function(arg_7_0, arg_7_1, arg_7_2)
		arg_1_0:sendNotification(GAME.LOVE_ITEM_MAIL_CHECK, {
			item_id = arg_7_1,
			group_id = arg_7_2
		})
	end)
	arg_1_0:bind(var_0_0.REPAIR_LOVE_LETTER_MAIL, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		arg_1_0:sendNotification(GAME.LOVE_ITEM_MAIL_REPAIR, {
			item_id = arg_8_1,
			year = arg_8_2,
			group_id = arg_8_3
		})
	end)
	arg_1_0.viewComponent:setDrop(arg_1_0.contextData.drop)
end

function var_0_0.listNotificationInterests(arg_9_0)
	return {
		BagProxy.ITEM_UPDATED,
		GAME.USE_ITEM_DONE,
		GAME.FRAG_SELL_DONE,
		GAME.LOVE_ITEM_MAIL_CHECK_DONE
	}
end

function var_0_0.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1:getBody()

	if var_10_0 == BagProxy.ITEM_UPDATED then
		local var_10_2 = arg_10_0.viewComponent.itemVO

		if var_10_1.id == var_10_2.id then
			if var_10_1.count <= 0 or var_10_2.extra and not getProxy(BagProxy):hasExtraData(var_10_2.id, var_10_2.extra) then
				arg_10_0.viewComponent:closeView()
			else
				arg_10_0.viewComponent:setItem(Drop.New({
					type = DROP_TYPE_ITEM,
					id = var_10_1.id,
					count = var_10_1.count,
					extra = var_10_1.extra
				}))
			end
		end
	elseif var_10_0 == GAME.USE_ITEM_DONE then
		arg_10_0.viewComponent:SetOperateCount(1)
	elseif var_10_0 == GAME.FRAG_SELL_DONE then
		arg_10_0.viewComponent:SetOperateCount(1)
	elseif var_10_0 == GAME.LOVE_ITEM_MAIL_CHECK_DONE then
		arg_10_0.viewComponent:setDrop(arg_10_0.contextData.drop)
	end
end

return var_0_0
