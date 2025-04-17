local var_0_0 = class("ShipGroup", import(".BaseVO"))

var_0_0.REQ_INTERVAL = 60

function var_0_0.GetGroupConfig(arg_1_0)
	local var_1_0 = checkExist(pg.ship_data_group.get_id_list_by_group_type[arg_1_0], {
		1
	})

	return var_1_0 and pg.ship_data_group[var_1_0] or nil
end

function var_0_0.getDefaultShipConfig(arg_2_0)
	local var_2_0

	for iter_2_0 = 4, 1, -1 do
		var_2_0 = pg.ship_data_statistics[tonumber(arg_2_0 .. iter_2_0)]

		if var_2_0 then
			break
		end
	end

	return var_2_0
end

function var_0_0.getDefaultShipNameByGroupID(arg_3_0)
	return var_0_0.getDefaultShipConfig(arg_3_0).name
end

function var_0_0.IsBluePrintGroup(arg_4_0)
	return tobool(pg.ship_data_blueprint[arg_4_0])
end

function var_0_0.IsMetaGroup(arg_5_0)
	return tobool(pg.ship_strengthen_meta[arg_5_0])
end

function var_0_0.IsMotGroup(arg_6_0)
	return var_0_0.getDefaultShipConfig(arg_6_0).nationality == Nation.MOT
end

var_0_0.STATE_LOCK = 0
var_0_0.STATE_NOTGET = 1
var_0_0.STATE_UNLOCK = 2
var_0_0.ENABLE_SKIP_TO_CHAPTER = true

local var_0_1 = pg.ship_data_group

function var_0_0.getState(arg_7_0, arg_7_1, arg_7_2)
	if var_0_0.ENABLE_SKIP_TO_CHAPTER then
		if arg_7_2 and not arg_7_1 then
			return var_0_0.STATE_NOTGET
		end

		if var_0_1[arg_7_0] then
			local var_7_0 = var_0_1[arg_7_0]

			assert(var_7_0.hide, "hide can not be nil in code " .. arg_7_0)

			if not var_7_0.hide then
				return var_0_0.STATE_LOCK
			end

			if var_7_0.hide == 1 then
				return var_0_0.STATE_LOCK
			elseif var_7_0.hide ~= 0 then
				assert(var_7_0.hide == 0 or var_7_0.hide == 1, "hide sign invalid in code " .. arg_7_0)

				return var_0_0.STATE_LOCK
			end
		end

		if arg_7_1 then
			return var_0_0.STATE_UNLOCK
		else
			local var_7_1 = var_0_1[arg_7_0]

			if not var_7_1 then
				return var_0_0.STATE_LOCK
			end

			assert(var_7_1, "code can not be nil" .. arg_7_0)

			local var_7_2 = var_7_1.redirect_id
			local var_7_3 = getProxy(ChapterProxy)
			local var_7_4

			if var_7_2 ~= 0 then
				var_7_4 = var_7_3:getChapterById(var_7_2)
			end

			if var_7_2 == 0 or var_7_4 and var_7_4:isClear() then
				return var_0_0.STATE_NOTGET
			else
				return var_0_0.STATE_LOCK
			end
		end
	else
		return arg_7_1 and var_0_0.STATE_UNLOCK or var_0_0.STATE_LOCK
	end
end

function var_0_0.Ctor(arg_8_0, arg_8_1)
	arg_8_0.id = arg_8_1.id
	arg_8_0.star = arg_8_1.star
	arg_8_0.hearts = arg_8_1.heart_count
	arg_8_0.iheart = (arg_8_1.heart_flag or 0) > 0
	arg_8_0.married = arg_8_1.marry_flag
	arg_8_0.maxIntimacy = arg_8_1.intimacy_max
	arg_8_0.maxLV = arg_8_1.lv_max
	arg_8_0.evaluation = nil
	arg_8_0.equipCodes = nil
	arg_8_0.lastReqStamp = 0
	arg_8_0.trans = false
	arg_8_0.remoulded = arg_8_1.remoulded

	local var_8_0 = var_0_0.getDefaultShipConfig(arg_8_0.id)

	assert(var_8_0, "can not find ship_data_statistics for group " .. arg_8_0.id)

	arg_8_0.shipConfig = setmetatable({}, {
		__index = function(arg_9_0, arg_9_1)
			return var_8_0[arg_9_1]
		end
	})

	local var_8_1 = var_0_0.GetGroupConfig(arg_8_0.id)

	assert(var_8_1, "can not find ship_data_group for group " .. arg_8_0.id)

	arg_8_0.groupConfig = setmetatable({}, {
		__index = function(arg_10_0, arg_10_1)
			return var_8_1[arg_10_1]
		end
	})
end

function var_0_0.getName(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.shipConfig.name

	if arg_11_1 and arg_11_0.trans then
		local var_11_1 = arg_11_0.groupConfig.trans_skin

		var_11_0 = pg.ship_skin_template[var_11_1].name
	end

	return var_11_0
end

function var_0_0.getNation(arg_12_0)
	return arg_12_0.shipConfig.nationality
end

function var_0_0.getRarity(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.shipConfig.rarity

	if arg_13_1 and arg_13_0.trans then
		var_13_0 = var_13_0 + 1
	end

	return var_13_0
end

function var_0_0.getTeamType(arg_14_0)
	return TeamType.GetTeamFromShipType(arg_14_0:getShipType())
end

function var_0_0.getPainting(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.shipConfig.skin_id

	if arg_15_1 and arg_15_0.trans then
		var_15_0 = arg_15_0.groupConfig.trans_skin
	end

	local var_15_1 = pg.ship_skin_template[var_15_0]

	assert(var_15_1, "ship_skin_template not exist: " .. var_15_0)

	return var_15_1.painting
end

function var_0_0.getPaintingId(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.shipConfig.skin_id

	if arg_16_1 and arg_16_0.trans then
		var_16_0 = arg_16_0.groupConfig.trans_skin
	end

	return var_16_0
end

function var_0_0.getShipType(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.shipConfig.type

	if arg_17_1 and arg_17_0.trans then
		local var_17_1 = Ship.getTransformShipId(arg_17_0.shipConfig.id)

		if var_17_1 then
			var_17_0 = pg.ship_data_statistics[var_17_1].type
		end
	end

	return var_17_0
end

function var_0_0.getShipConfigId(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.shipConfig.id

	if arg_18_1 and arg_18_0.trans then
		local var_18_1 = Ship.getTransformShipId(arg_18_0.shipConfig.id)

		if var_18_1 then
			var_18_0 = pg.ship_data_statistics[var_18_1].id
		end
	end

	return var_18_0
end

function var_0_0.getSkinList(arg_19_0)
	return ShipSkin.GetAllSkinByGroup(arg_19_0)
end

function var_0_0.GetDisplayableSkinList(arg_20_0)
	local var_20_0 = {}

	local function var_20_1(arg_21_0)
		return arg_21_0.skin_type == ShipSkin.SKIN_TYPE_OLD or arg_21_0.skin_type == ShipSkin.SKIN_TYPE_NOT_HAVE_HIDE and not getProxy(ShipSkinProxy):hasSkin(arg_21_0.id)
	end

	local function var_20_2(arg_22_0)
		return getProxy(ShipSkinProxy):InShowTime(arg_22_0)
	end

	for iter_20_0, iter_20_1 in ipairs(pg.ship_skin_template.all) do
		local var_20_3 = pg.ship_skin_template[iter_20_1]

		if var_20_3.ship_group == arg_20_0 and var_20_3.no_showing ~= "1" and not var_20_1(var_20_3) and var_20_2(var_20_3.id) then
			table.insert(var_20_0, var_20_3)
		end
	end

	for iter_20_2 = #var_20_0, 1, -1 do
		local var_20_4 = var_20_0[iter_20_2]

		if ShipGroup.GetChangeSkinGroupId(var_20_4.id) and ShipGroup.GetChangeSkinIndex(var_20_4.id) ~= 1 then
			table.remove(var_20_0, iter_20_2)
		end
	end

	return var_20_0
end

function var_0_0.getDefaultSkin(arg_23_0)
	return ShipSkin.GetSkinByType(arg_23_0, ShipSkin.SKIN_TYPE_DEFAULT)
end

function var_0_0.getProposeSkin(arg_24_0)
	return ShipSkin.GetSkinByType(arg_24_0, ShipSkin.SKIN_TYPE_PROPOSE)
end

function var_0_0.getModSkin(arg_25_0)
	local var_25_0 = pg.ship_data_trans[arg_25_0]

	if var_25_0 then
		return pg.ship_skin_template[var_25_0.skin_id]
	end

	return nil
end

function var_0_0.GetSkin(arg_26_0, arg_26_1)
	if not arg_26_1 then
		return var_0_0.getDefaultSkin(arg_26_0.id)
	else
		return var_0_0.getModSkin(arg_26_0.id)
	end
end

function var_0_0.updateMaxIntimacy(arg_27_0, arg_27_1)
	arg_27_0.maxIntimacy = math.max(arg_27_1, arg_27_0.maxIntimacy)
end

function var_0_0.updateMarriedFlag(arg_28_0)
	arg_28_0.married = 1
end

function var_0_0.isBluePrintGroup(arg_29_0)
	return var_0_0.IsBluePrintGroup(arg_29_0.id)
end

function var_0_0.getBluePrintChangeSkillList(arg_30_0)
	assert(arg_30_0:isBluePrintGroup(), "ShipGroup " .. arg_30_0.id .. "isn't BluePrint")

	return pg.ship_data_blueprint[arg_30_0.id].change_skill
end

function var_0_0.GetNationTxt(arg_31_0)
	local var_31_0 = arg_31_0.shipConfig.nationality

	return Nation.Nation2facionName(var_31_0) .. "-" .. Nation.Nation2Name(var_31_0)
end

var_0_0.CONDITION_FORBIDDEN = -1
var_0_0.CONDITION_CLEAR = 0
var_0_0.CONDITION_INTIMACY = 1
var_0_0.CONDITION_MARRIED = 2

function var_0_0.VoiceReplayCodition(arg_32_0, arg_32_1)
	local var_32_0 = true
	local var_32_1 = ""

	if arg_32_0:isBluePrintGroup() then
		local var_32_2 = getProxy(TechnologyProxy):getBluePrintById(arg_32_0.id)

		assert(var_32_2, "blueprint can not be nil >>" .. arg_32_0.id)

		local var_32_3 = var_32_2:getUnlockVoices()

		if not table.contains(var_32_3, arg_32_1.key) then
			local var_32_4 = var_32_2:getUnlockLevel(arg_32_1.key)

			if var_32_4 > 0 then
				var_32_0 = false

				return var_32_0, i18n("ship_profile_voice_locked_design", var_32_4)
			end
		end
	end

	if arg_32_0:isMetaGroup() then
		local var_32_5 = getProxy(BayProxy):getMetaShipByGroupId(arg_32_0.id):getMetaCharacter()
		local var_32_6 = var_32_5:getUnlockedVoiceList()

		if not table.contains(var_32_6, arg_32_1.key) then
			local var_32_7 = var_32_5:getUnlockVoiceRepairPercent(arg_32_1.key)

			if var_32_7 > 0 then
				var_32_0 = false

				return var_32_0, i18n("ship_profile_voice_locked_meta", var_32_7)
			end
		end
	end

	if arg_32_1.unlock_condition[1] == var_0_0.CONDITION_INTIMACY then
		if arg_32_0.maxIntimacy < arg_32_1.unlock_condition[2] then
			var_32_0 = false
			var_32_1 = i18n("ship_profile_voice_locked_intimacy", math.floor(arg_32_1.unlock_condition[2] / 100))
		end
	elseif arg_32_1.unlock_condition[1] == var_0_0.CONDITION_MARRIED and arg_32_0.married == 0 then
		var_32_0 = false

		if arg_32_0:IsXIdol() then
			var_32_1 = i18n("ship_profile_voice_locked_propose_imas")
		else
			var_32_1 = i18n("ship_profile_voice_locked_propose")
		end
	end

	return var_32_0, var_32_1
end

function var_0_0.GetMaxIntimacy(arg_33_0)
	return arg_33_0.maxIntimacy / 100 + (arg_33_0.married and arg_33_0.married * 1000 or 0)
end

function var_0_0.isSpecialFilter(arg_34_0)
	for iter_34_0, iter_34_1 in ipairs(arg_34_0.shipConfig.tag_list) do
		if iter_34_1 == "special" then
			return true
		end
	end

	return false
end

function var_0_0.getGroupId(arg_35_0)
	return arg_35_0.id
end

function var_0_0.isRemoulded(arg_36_0)
	return arg_36_0.remoulded
end

function var_0_0.isMetaGroup(arg_37_0)
	return var_0_0.IsMetaGroup(arg_37_0.id)
end

local var_0_2 = {
	feeling2 = true,
	feeling3 = true,
	feeling5 = true,
	feeling4 = true,
	propose = true,
	feeling1 = true
}

function var_0_0.getIntimacyName(arg_38_0, arg_38_1)
	if not var_0_2[arg_38_1] then
		return
	end

	if arg_38_0:isMetaGroup() then
		return i18n("meta_voice_name_" .. arg_38_1)
	elseif arg_38_0:IsXIdol() then
		return i18n("idolmaster_voice_name_" .. arg_38_1)
	end
end

function var_0_0.getProposeType(arg_39_0)
	if arg_39_0:isMetaGroup() then
		return "meta"
	elseif arg_39_0:IsXIdol() then
		return "imas"
	else
		return "default"
	end
end

function var_0_0.IsXIdol(arg_40_0)
	return arg_40_0:getNation() == Nation.IDOL_LINK
end

function var_0_0.CanUseShareSkin(arg_41_0)
	return arg_41_0.groupConfig.share_group_id and #arg_41_0.groupConfig.share_group_id > 0
end

function var_0_0.rarity2bgPrint(arg_42_0, arg_42_1)
	return shipRarity2bgPrint(arg_42_0:getRarity(arg_42_1), arg_42_0:isBluePrintGroup(), arg_42_0:isMetaGroup())
end

function var_0_0.rarity2bgPrintForGet(arg_43_0, arg_43_1, arg_43_2)
	return skinId2bgPrint(arg_43_2 or arg_43_0:GetSkin(arg_43_1).id) or arg_43_0:rarity2bgPrint(arg_43_1)
end

function var_0_0.setEquipCodes(arg_44_0, arg_44_1)
	arg_44_0.equipCodes = arg_44_1
end

function var_0_0.getEquipCodes(arg_45_0)
	return arg_45_0.equipCodes
end

function var_0_0.GetAllChangeSkinIds(arg_46_0)
	if not ShipGroup.IsChangeSkin(arg_46_0) then
		return {
			arg_46_0
		}
	end

	local var_46_0 = ShipGroup.GetChangeSkinMainId(arg_46_0)
	local var_46_1 = {
		var_46_0
	}
	local var_46_2 = arg_46_0

	for iter_46_0 = 1, 10 do
		local var_46_3 = ShipGroup.GetChangeSkinNextId(var_46_2)

		if not table.contains(var_46_1, var_46_3) then
			table.insert(var_46_1, var_46_3)
		end

		var_46_2 = var_46_3

		if ShipGroup.GetChangeSkinIndex(var_46_2) == 1 then
			return var_46_1
		end
	end

	return var_46_1
end

function var_0_0.IsChangeSkin(arg_47_0)
	return var_0_0.GetChangeSkinData(arg_47_0)
end

function var_0_0.GetChangeSkinMainId(arg_48_0)
	if not var_0_0.IsChangeSkin(arg_48_0) then
		return arg_48_0
	end

	local var_48_0 = pg.ship_skin_template[arg_48_0].ship_group
	local var_48_1 = var_0_0.GetChangeSkinGroupId(arg_48_0)

	if var_0_0.GetChangeSkinIndex(arg_48_0) == 1 then
		return arg_48_0
	end

	local var_48_2 = ShipSkin.GetAllSkinByGroup(var_48_0)

	for iter_48_0, iter_48_1 in ipairs(var_48_2) do
		if var_0_0.IsChangeSkin(iter_48_1.id) then
			local var_48_3 = var_0_0.GetChangeSkinGroupId(iter_48_1.id)
			local var_48_4 = var_0_0.GetChangeSkinIndex(iter_48_1.id)

			if var_48_3 == var_48_1 and var_48_4 == 1 then
				print("获得到了skinId :" .. arg_48_0 .. " 的A面皮肤id" .. iter_48_1.id)

				return iter_48_1.id
			end
		end
	end

	return arg_48_0
end

function var_0_0.GetChangeSkinData(arg_49_0)
	local var_49_0 = pg.ship_skin_template[arg_49_0]

	if var_49_0 and var_49_0.change_skin and var_49_0.change_skin ~= "" and table.contains(var_49_0.tag, ShipSkin.WITH_CHANGE) then
		return var_49_0.change_skin
	end

	return nil
end

function var_0_0.IsSameChangeSkinGroup(arg_50_0, arg_50_1)
	if not ShipGroup.IsChangeSkin(arg_50_0) or not ShipGroup.IsChangeSkin(arg_50_1) then
		return false
	end

	return ShipGroup.GetChangeSkinGroupId(arg_50_0) == ShipGroup.GetChangeSkinGroupId(arg_50_1)
end

function var_0_0.GetChangeSkinGroupId(arg_51_0)
	return var_0_0.GetChangeSkinData(arg_51_0) and var_0_0.GetChangeSkinData(arg_51_0).group or nil
end

function var_0_0.GetChangeSkinNextId(arg_52_0)
	return var_0_0.GetChangeSkinData(arg_52_0) and var_0_0.GetChangeSkinData(arg_52_0).next or nil
end

function var_0_0.GetChangeSkinIndex(arg_53_0)
	return var_0_0.GetChangeSkinData(arg_53_0) and var_0_0.GetChangeSkinData(arg_53_0).index or nil
end

function var_0_0.GetChangeSkinState(arg_54_0)
	return var_0_0.GetChangeSkinData(arg_54_0) and var_0_0.GetChangeSkinData(arg_54_0).state or nil
end

function var_0_0.GetChangeSkinAction(arg_55_0)
	return var_0_0.GetChangeSkinData(arg_55_0) and var_0_0.GetChangeSkinData(arg_55_0).action or nil
end

function var_0_0.GetStoreChangeSkinId(arg_56_0, arg_56_1)
	if not arg_56_1 or arg_56_1 == 0 then
		return nil
	end

	print("尝试获取group_id = " .. tostring(arg_56_0) .. "ship id =" .. tostring(arg_56_1))

	local var_56_0 = var_0_0.GetStoreChangeSkinPrefsName(arg_56_0, arg_56_1)
	local var_56_1 = PlayerPrefs.GetInt(var_56_0)

	if not var_56_1 or var_56_1 == 0 then
		return nil
	end

	return var_56_1
end

function var_0_0.SetStoreChangeSkinId(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = var_0_0.GetStoreChangeSkinPrefsName(arg_57_0, arg_57_1)

	PlayerPrefs.SetInt(var_57_0, arg_57_2)
end

function var_0_0.GetStoreChangeSkinPrefsName(arg_58_0, arg_58_1)
	local var_58_0 = "change_skin_group_$1_$2"
	local var_58_1 = string.gsub(var_58_0, "%$1", arg_58_1)

	return (string.gsub(var_58_1, "%$2", arg_58_0))
end

function var_0_0.SetShipChangeSkin(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	local var_59_0 = getProxy(BayProxy):getShipById(arg_59_0)

	if not var_59_0 then
		return
	end

	ShipGroup.SetStoreChangeSkinId(arg_59_1, arg_59_0, arg_59_2)

	if var_59_0.id == arg_59_0 and arg_59_3 then
		var_59_0:updateSkinId(arg_59_2)
		getProxy(BayProxy):updateShip(var_59_0)
	end

	pg.m02:sendNotification(GAME.CHANGE_SKIN_UPDATE, var_59_0)
end

return var_0_0
