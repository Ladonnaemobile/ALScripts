ys = ys or {}

local var_0_0 = ys
local var_0_1 = var_0_0.Battle.BattleConst
local var_0_2 = var_0_0.Battle.BattleConfig
local var_0_3 = var_0_0.Battle.BattleFormulas
local var_0_4 = var_0_1.WeaponSuppressType
local var_0_5 = var_0_1.WeaponSearchType
local var_0_6 = var_0_0.Battle.BattleDataFunction
local var_0_7 = var_0_0.Battle.BattleAttr
local var_0_8 = var_0_0.Battle.BattleTargetChoise
local var_0_9 = class("BattleWeaponUnit")

var_0_0.Battle.BattleWeaponUnit = var_0_9
var_0_9.__name = "BattleWeaponUnit"
var_0_9.INTERNAL = "internal"
var_0_9.EXTERNAL = "external"
var_0_9.EMITTER_NORMAL = "BattleBulletEmitter"
var_0_9.EMITTER_SHOTGUN = "BattleShotgunEmitter"
var_0_9.STATE_DISABLE = "DISABLE"
var_0_9.STATE_READY = "READY"
var_0_9.STATE_PRECAST = "PRECAST"
var_0_9.STATE_PRECAST_FINISH = "STATE_PRECAST_FINISH"
var_0_9.STATE_ATTACK = "ATTACK"
var_0_9.STATE_OVER_HEAT = "OVER_HEAT"

function var_0_9.Ctor(arg_1_0)
	var_0_0.EventDispatcher.AttachEventDispatcher(arg_1_0)

	arg_1_0._currentState = arg_1_0.STATE_READY
	arg_1_0._equipmentIndex = -1
	arg_1_0._dataProxy = var_0_0.Battle.BattleDataProxy.GetInstance()
	arg_1_0._tempEmittersList = {}
	arg_1_0._dumpedEmittersList = {}
	arg_1_0._reloadFacotrList = {}
	arg_1_0._diveEnabled = true
	arg_1_0._comboIDList = {}
	arg_1_0._jammingTime = 0
	arg_1_0._reloadBoostList = {}
	arg_1_0._CLDCount = 0
	arg_1_0._damageSum = 0
	arg_1_0._CTSum = 0
	arg_1_0._ACCSum = 0
end

function var_0_9.HostOnEnemy(arg_2_0)
	arg_2_0._hostOnEnemy = true
end

function var_0_9.SetPotentialFactor(arg_3_0, arg_3_1)
	arg_3_0._potential = arg_3_1

	if arg_3_0._correctedDMG then
		arg_3_0._correctedDMG = var_0_3.WeaponDamagePreCorrection(arg_3_0)
	end
end

function var_0_9.GetEquipmentLabel(arg_4_0)
	return arg_4_0._equipmentLabelList or {}
end

function var_0_9.SetEquipmentLabel(arg_5_0, arg_5_1)
	arg_5_0._equipmentLabelList = arg_5_1
end

function var_0_9.SetTemplateData(arg_6_0, arg_6_1)
	arg_6_0._potential = arg_6_0._potential or 1
	arg_6_0._tmpData = arg_6_1
	arg_6_0._maxRangeSqr = arg_6_1.range
	arg_6_0._minRangeSqr = arg_6_1.min_range
	arg_6_0._fireFXFlag = arg_6_1.fire_fx_loop_type
	arg_6_0._oxyList = arg_6_1.oxy_type
	arg_6_0._bulletList = arg_6_1.bullet_ID
	arg_6_0._majorEmitterList = {}

	arg_6_0:ShiftBarrage(arg_6_1.barrage_ID)

	arg_6_0._GCD = arg_6_1.recover_time
	arg_6_0._preCastInfo = arg_6_1.precast_param
	arg_6_0._correctedDMG = var_0_3.WeaponDamagePreCorrection(arg_6_0)
	arg_6_0._convertedAtkAttr = var_0_3.WeaponAtkAttrPreRatio(arg_6_0)

	arg_6_0:FlushReloadMax(1)
end

function var_0_9.createMajorEmitter(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local function var_7_0(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		local var_8_0 = arg_7_0._emitBulletIDList[arg_7_2]
		local var_8_1 = arg_7_0:Spawn(var_8_0, arg_8_4, var_0_9.INTERNAL)

		var_8_1:SetOffsetPriority(arg_8_3)
		var_8_1:SetShiftInfo(arg_8_0, arg_8_1)

		if arg_7_0._tmpData.aim_type == var_0_1.WeaponAimType.AIM and arg_8_4 ~= nil then
			var_8_1:SetRotateInfo(arg_8_4:GetBeenAimedPosition(), arg_7_0:GetBaseAngle(), arg_8_2)
		else
			var_8_1:SetRotateInfo(nil, arg_7_0:GetBaseAngle(), arg_8_2)
		end

		arg_7_0:DispatchBulletEvent(var_8_1)

		return var_8_1
	end

	local function var_7_1()
		for iter_9_0, iter_9_1 in ipairs(arg_7_0._majorEmitterList) do
			if iter_9_1:GetState() ~= iter_9_1.STATE_STOP then
				return
			end
		end

		arg_7_0:EnterCoolDown()
	end

	arg_7_3 = arg_7_3 or var_0_9.EMITTER_NORMAL

	local var_7_2 = var_0_0.Battle[arg_7_3].New(arg_7_4 or var_7_0, arg_7_5 or var_7_1, arg_7_1)

	arg_7_0._majorEmitterList[#arg_7_0._majorEmitterList + 1] = var_7_2

	return var_7_2
end

function var_0_9.interruptAllEmitter(arg_10_0)
	if arg_10_0._majorEmitterList then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._majorEmitterList) do
			iter_10_1:Interrupt()
		end
	end

	for iter_10_2, iter_10_3 in ipairs(arg_10_0._tempEmittersList) do
		for iter_10_4, iter_10_5 in ipairs(iter_10_3) do
			iter_10_5:Interrupt()
		end
	end

	for iter_10_6, iter_10_7 in ipairs(arg_10_0._dumpedEmittersList) do
		for iter_10_8, iter_10_9 in ipairs(iter_10_7) do
			iter_10_9:Interrupt()
		end
	end
end

function var_0_9.cacheSectorData(arg_11_0)
	local var_11_0 = arg_11_0:GetAttackAngle() / 2

	arg_11_0._upperEdge = math.deg2Rad * var_11_0
	arg_11_0._lowerEdge = -1 * arg_11_0._upperEdge

	local var_11_1 = math.deg2Rad * arg_11_0._tmpData.axis_angle

	if arg_11_0:GetDirection() == var_0_1.UnitDir.LEFT then
		arg_11_0._normalizeOffset = math.pi - var_11_1
	elseif arg_11_0:GetDirection() == var_0_1.UnitDir.RIGHT then
		arg_11_0._normalizeOffset = var_11_1
	end

	arg_11_0._wholeCircle = math.pi - arg_11_0._normalizeOffset
	arg_11_0._negativeCircle = -math.pi - arg_11_0._normalizeOffset
	arg_11_0._wholeCircleNormalizeOffset = arg_11_0._normalizeOffset - math.pi * 2
	arg_11_0._negativeCircleNormalizeOffset = arg_11_0._normalizeOffset + math.pi * 2
end

function var_0_9.cacheSquareData(arg_12_0)
	arg_12_0._frontRange = arg_12_0._tmpData.angle
	arg_12_0._backRange = arg_12_0._tmpData.axis_angle
	arg_12_0._upperRange = arg_12_0._tmpData.min_range
	arg_12_0._lowerRange = arg_12_0._tmpData.range
end

function var_0_9.SetModelID(arg_13_0, arg_13_1)
	arg_13_0._modelID = arg_13_1
end

function var_0_9.SetSkinData(arg_14_0, arg_14_1)
	arg_14_0._skinID = arg_14_1

	local var_14_0, var_14_1, var_14_2, var_14_3, var_14_4, var_14_5 = var_0_6.GetEquipSkin(arg_14_0._skinID)

	arg_14_0:SetModelID(var_14_0)

	if var_14_4 ~= "" then
		arg_14_0._skinFireFX = var_14_4
	end

	if var_14_5 ~= "" then
		arg_14_0._skinHitFX = var_14_5
	end

	local var_14_6, var_14_7 = var_0_6.GetEquipSkinSFX(arg_14_0._skinID)

	arg_14_0._skinHixSFX = var_14_6
	arg_14_0._skinMissSFX = var_14_7
end

function var_0_9.SetDerivateSkin(arg_15_0, arg_15_1)
	arg_15_0._derivateSkinID = arg_15_1

	local var_15_0, var_15_1, var_15_2, var_15_3, var_15_4, var_15_5 = var_0_6.GetEquipSkin(arg_15_0._derivateSkinID)

	arg_15_0._derivateBullet = var_15_1
	arg_15_0._derivateTorpedo = var_15_2
	arg_15_0._derivateBoom = var_15_3
	arg_15_0._derviateHitFX = var_15_5

	local var_15_6, var_15_7 = var_0_6.GetEquipSkinSFX(arg_15_0._derivateSkinID)

	arg_15_0._skinHixSFX = var_15_6
	arg_15_0._skinMissSFX = var_15_7
end

function var_0_9.GetSkinID(arg_16_0)
	return arg_16_0._skinID
end

function var_0_9.setBulletSkin(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0._derivateSkinID then
		local var_17_0 = var_0_6.GetBulletTmpDataFromID(arg_17_2).type

		if var_17_0 == var_0_1.BulletType.BOMB and arg_17_0._derivateBoom ~= "" then
			arg_17_1:SetModleID(arg_17_0._derivateBoom, nil, arg_17_0._derviateHitFX)
		elseif var_17_0 == var_0_1.BulletType.TORPEDO and arg_17_0._derivateTorpedo ~= "" then
			arg_17_1:SetModleID(arg_17_0._derivateTorpedo, nil, arg_17_0._derviateHitFX)
		elseif arg_17_0._derivateBullet ~= "" then
			arg_17_1:SetModleID(arg_17_0._derivateBullet, nil, arg_17_0._derviateHitFX)
		end

		arg_17_1:SetSFXID(arg_17_0._skinHixSFX, arg_17_0._skinMissSFX)
	elseif arg_17_0._modelID then
		local var_17_1 = 0

		if arg_17_0._skinID then
			var_17_1 = var_0_6.GetEquipSkinDataFromID(arg_17_0._skinID).mirror
		end

		arg_17_1:SetModleID(arg_17_0._modelID, var_17_1, arg_17_0._skinHitFX)
		arg_17_1:SetSFXID(arg_17_0._skinHixSFX, arg_17_0._skinMissSFX)
	end
end

function var_0_9.SetSrcEquipmentID(arg_18_0, arg_18_1)
	arg_18_0._srcEquipID = arg_18_1
end

function var_0_9.SetEquipmentIndex(arg_19_0, arg_19_1)
	arg_19_0._equipmentIndex = arg_19_1
end

function var_0_9.GetEquipmentIndex(arg_20_0)
	return arg_20_0._equipmentIndex
end

function var_0_9.SetHostData(arg_21_0, arg_21_1)
	arg_21_0._host = arg_21_1
	arg_21_0._hostUnitType = arg_21_0._host:GetUnitType()
	arg_21_0._hostIFF = arg_21_1:GetIFF()

	if arg_21_0._tmpData.search_type == var_0_5.SECTOR then
		arg_21_0:cacheSectorData()

		arg_21_0.outOfFireRange = arg_21_0.IsOutOfAngle
		arg_21_0.IsOutOfFireArea = arg_21_0.IsOutOfSector
	elseif arg_21_0._tmpData.search_type == var_0_5.SQUARE then
		arg_21_0:cacheSquareData()

		arg_21_0.outOfFireRange = arg_21_0.IsOutOfSquare
		arg_21_0.IsOutOfFireArea = arg_21_0.IsOutOfSquare
	end

	if arg_21_0:GetDirection() == var_0_1.UnitDir.RIGHT then
		arg_21_0._baseAngle = 0
	else
		arg_21_0._baseAngle = 180
	end
end

function var_0_9.SetStandHost(arg_22_0, arg_22_1)
	arg_22_0._standHost = arg_22_1
end

function var_0_9.OverrideGCD(arg_23_0, arg_23_1)
	arg_23_0._GCD = arg_23_1
end

function var_0_9.updateMovementInfo(arg_24_0)
	arg_24_0._hostPos = arg_24_0._host:GetPosition()
end

function var_0_9.GetWeaponId(arg_25_0)
	return arg_25_0._tmpData.id
end

function var_0_9.GetTemplateData(arg_26_0)
	return arg_26_0._tmpData
end

function var_0_9.GetType(arg_27_0)
	return arg_27_0._tmpData.type
end

function var_0_9.GetPotential(arg_28_0)
	return arg_28_0._potential or 1
end

function var_0_9.GetSrcEquipmentID(arg_29_0)
	return arg_29_0._srcEquipID
end

function var_0_9.SetFixedFlag(arg_30_0)
	arg_30_0._isFixedWeapon = true
end

function var_0_9.IsFixedWeapon(arg_31_0)
	return arg_31_0._isFixedWeapon
end

function var_0_9.IsAttacking(arg_32_0)
	return arg_32_0._currentState == var_0_9.STATE_ATTACK or arg_32_0._currentState == arg_32_0.STATE_PRECAST
end

function var_0_9.Update(arg_33_0)
	arg_33_0:UpdateReload()

	if not arg_33_0._diveEnabled then
		return
	end

	if arg_33_0._currentState == arg_33_0.STATE_READY then
		arg_33_0:updateMovementInfo()

		if arg_33_0._tmpData.suppress == var_0_4.SUPPRESSION or arg_33_0:CheckPreCast() then
			if arg_33_0._preCastInfo.time == nil or not arg_33_0._hostOnEnemy then
				arg_33_0._currentState = arg_33_0.STATE_PRECAST_FINISH
			else
				arg_33_0:PreCast()
			end
		end
	end

	if arg_33_0._currentState == arg_33_0.STATE_PRECAST_FINISH then
		arg_33_0:updateMovementInfo()
		arg_33_0:Fire(arg_33_0:Tracking())
	end
end

function var_0_9.CheckReloadTimeStamp(arg_34_0)
	return arg_34_0._CDstartTime and arg_34_0:GetReloadFinishTimeStamp() <= pg.TimeMgr.GetInstance():GetCombatTime()
end

function var_0_9.UpdateReload(arg_35_0)
	if arg_35_0._CDstartTime and not arg_35_0._jammingStartTime then
		if arg_35_0:GetReloadFinishTimeStamp() <= pg.TimeMgr.GetInstance():GetCombatTime() then
			arg_35_0:handleCoolDown()
		else
			return
		end
	end
end

function var_0_9.CheckPreCast(arg_36_0)
	for iter_36_0, iter_36_1 in pairs(arg_36_0:GetFilteredList()) do
		return true
	end

	return false
end

function var_0_9.ChangeDiveState(arg_37_0)
	if arg_37_0._host:GetOxyState() then
		local var_37_0 = arg_37_0._host:GetOxyState():GetWeaponType()

		for iter_37_0, iter_37_1 in ipairs(arg_37_0._oxyList) do
			if table.contains(var_37_0, iter_37_1) then
				arg_37_0._diveEnabled = true

				return
			end
		end

		arg_37_0._diveEnabled = false
	end
end

function var_0_9.getTrackingHost(arg_38_0)
	return arg_38_0._host
end

var_0_9.TrackingFunc = {
	farthest = var_0_9.TrackingFarthest,
	leastHP = var_0_9.TrackingLeastHP
}

function var_0_9.Tracking(arg_39_0)
	local var_39_0 = var_0_7.GetCurrentTargetSelect(arg_39_0._host)
	local var_39_1
	local var_39_2 = arg_39_0:GetFilteredList()

	if var_39_0 then
		local var_39_3 = var_0_9.TrackingFunc[var_39_0]

		if var_39_3 then
			var_39_1 = var_39_3(arg_39_0, var_39_2)
		else
			var_39_1 = arg_39_0:TrackingTag(var_39_2, var_39_0)
		end
	else
		var_39_1 = arg_39_0:TrackingNearest(var_39_2)
	end

	if var_39_1 and var_0_7.GetCurrentGuardianID(var_39_1) then
		local var_39_4 = var_0_7.GetCurrentGuardianID(var_39_1)

		for iter_39_0, iter_39_1 in ipairs(var_39_2) do
			if iter_39_1:GetUniqueID() == var_39_4 then
				var_39_1 = iter_39_1

				break
			end
		end
	end

	return var_39_1
end

function var_0_9.GetFilteredList(arg_40_0)
	local var_40_0 = arg_40_0:FilterTarget()

	if arg_40_0._tmpData.search_type == var_0_5.SECTOR then
		var_40_0 = arg_40_0:FilterRange(var_40_0)
		var_40_0 = arg_40_0:FilterAngle(var_40_0)
	elseif arg_40_0._tmpData.search_type == var_0_5.SQUARE then
		var_40_0 = arg_40_0:FilterSquare(var_40_0)
	end

	return var_40_0
end

function var_0_9.FixWeaponRange(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	arg_41_0._maxRangeSqr = arg_41_1 or arg_41_0._tmpData.range
	arg_41_0._minRangeSqr = arg_41_3 or arg_41_0._tmpData.min_range
	arg_41_0._fixBulletRange = arg_41_2
	arg_41_0._bulletRangeOffset = arg_41_4
end

function var_0_9.GetWeaponMaxRange(arg_42_0)
	return arg_42_0._maxRangeSqr
end

function var_0_9.GetWeaponMinRange(arg_43_0)
	return arg_43_0._minRangeSqr
end

function var_0_9.GetFixBulletRange(arg_44_0)
	return arg_44_0._fixBulletRange, arg_44_0._bulletRangeOffset
end

function var_0_9.TrackingNearest(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0._maxRangeSqr
	local var_45_1

	for iter_45_0, iter_45_1 in ipairs(arg_45_1) do
		local var_45_2 = arg_45_0:getTrackingHost():GetDistance(iter_45_1)

		if var_45_2 <= var_45_0 then
			var_45_0 = var_45_2
			var_45_1 = iter_45_1
		end
	end

	return var_45_1
end

function var_0_9.TrackingFarthest(arg_46_0, arg_46_1)
	local var_46_0 = 0
	local var_46_1

	for iter_46_0, iter_46_1 in ipairs(arg_46_1) do
		local var_46_2 = arg_46_0:getTrackingHost():GetDistance(iter_46_1)

		if var_46_0 < var_46_2 then
			var_46_0 = var_46_2
			var_46_1 = iter_46_1
		end
	end

	return var_46_1
end

function var_0_9.TrackingLeastHP(arg_47_0, arg_47_1)
	local var_47_0 = math.huge
	local var_47_1

	for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
		local var_47_2 = iter_47_1:GetCurrentHP()

		if var_47_2 < var_47_0 then
			var_47_1 = iter_47_1
			var_47_0 = var_47_2
		end
	end

	return var_47_1
end

function var_0_9.TrackingRandom(arg_48_0, arg_48_1)
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in pairs(arg_48_1) do
		table.insert(var_48_0, iter_48_1)
	end

	local var_48_1 = #var_48_0

	if #var_48_0 == 0 then
		return nil
	else
		return var_48_0[math.random(#var_48_0)]
	end
end

function var_0_9.TrackingTag(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
		if iter_49_1:ContainsLabelTag({
			arg_49_2
		}) then
			table.insert(var_49_0, iter_49_1)
		end
	end

	if #var_49_0 == 0 then
		return arg_49_0:TrackingNearest(arg_49_1)
	else
		return var_49_0[math.random(#var_49_0)]
	end
end

function var_0_9.FilterTarget(arg_50_0)
	local var_50_0 = var_0_8.LegalWeaponTarget(arg_50_0._host)
	local var_50_1 = {}
	local var_50_2 = 1
	local var_50_3 = arg_50_0._tmpData.search_condition

	for iter_50_0, iter_50_1 in pairs(var_50_0) do
		local var_50_4 = iter_50_1:GetCurrentOxyState()

		if var_0_7.IsCloak(iter_50_1) then
			-- block empty
		elseif not table.contains(var_50_3, var_50_4) then
			-- block empty
		else
			local var_50_5 = true

			if var_50_4 == var_0_1.OXY_STATE.FLOAT then
				-- block empty
			elseif var_50_4 == var_0_1.OXY_STATE.DIVE and not iter_50_1:IsRunMode() and not iter_50_1:GetDiveDetected() and iter_50_1:GetDiveInvisible() then
				var_50_5 = false
			end

			if var_50_5 then
				var_50_1[var_50_2] = iter_50_1
				var_50_2 = var_50_2 + 1
			end
		end
	end

	return var_50_1
end

function var_0_9.FilterAngle(arg_51_0, arg_51_1)
	if arg_51_0:GetAttackAngle() >= 360 then
		return arg_51_1
	end

	for iter_51_0 = #arg_51_1, 1, -1 do
		if arg_51_0:IsOutOfAngle(arg_51_1[iter_51_0]) then
			table.remove(arg_51_1, iter_51_0)
		end
	end

	return arg_51_1
end

function var_0_9.FilterRange(arg_52_0, arg_52_1)
	for iter_52_0 = #arg_52_1, 1, -1 do
		if arg_52_0:IsOutOfRange(arg_52_1[iter_52_0]) then
			table.remove(arg_52_1, iter_52_0)
		end
	end

	return arg_52_1
end

function var_0_9.FilterSquare(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0:GetDirection()
	local var_53_1 = arg_53_0._host:GetPosition().x + arg_53_0._backRange * var_53_0 * -1
	local var_53_2 = {
		lineX = var_53_1,
		dir = var_53_0
	}
	local var_53_3 = var_0_8.TargetInsideArea(arg_53_0._host, var_53_2, arg_53_1)
	local var_53_4 = var_0_8.TargetWeightiest(arg_53_0._host, nil, var_53_3)

	for iter_53_0 = #arg_53_1, 1, -1 do
		if arg_53_0:IsOutOfSquare(arg_53_1[iter_53_0]) then
			table.remove(arg_53_1, iter_53_0)
		end
	end

	for iter_53_1 = #arg_53_1, 1, -1 do
		if not table.contains(var_53_4, arg_53_1[iter_53_1]) then
			table.remove(arg_53_1, iter_53_1)
		end
	end

	return arg_53_1
end

function var_0_9.GetAttackAngle(arg_54_0)
	return arg_54_0._tmpData.angle
end

function var_0_9.IsOutOfAngle(arg_55_0, arg_55_1)
	if arg_55_0:GetAttackAngle() >= 360 then
		return false
	end

	local var_55_0 = arg_55_1:GetPosition()
	local var_55_1 = math.atan2(var_55_0.z - arg_55_0._hostPos.z, var_55_0.x - arg_55_0._hostPos.x)

	if var_55_1 > arg_55_0._wholeCircle then
		var_55_1 = var_55_1 + arg_55_0._wholeCircleNormalizeOffset
	elseif var_55_1 < arg_55_0._negativeCircle then
		var_55_1 = var_55_1 + arg_55_0._negativeCircleNormalizeOffset
	else
		var_55_1 = var_55_1 + arg_55_0._normalizeOffset
	end

	if var_55_1 > arg_55_0._lowerEdge and var_55_1 < arg_55_0._upperEdge then
		return false
	else
		return true
	end
end

function var_0_9.IsOutOfRange(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_0:getTrackingHost():GetDistance(arg_56_1)

	return var_56_0 > arg_56_0._maxRangeSqr or var_56_0 < arg_56_0:GetMinimumRange()
end

function var_0_9.IsOutOfSector(arg_57_0, arg_57_1)
	return arg_57_0:IsOutOfRange(arg_57_1) or arg_57_0:IsOutOfAngle(arg_57_1)
end

function var_0_9.IsOutOfSquare(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_1:GetPosition()
	local var_58_1 = false
	local var_58_2 = (var_58_0.x - arg_58_0._hostPos.x) * arg_58_0:GetDirection()

	if arg_58_0._backRange < 0 then
		if var_58_2 > 0 and var_58_2 <= arg_58_0._frontRange and var_58_2 >= math.abs(arg_58_0._backRange) then
			var_58_1 = true
		end
	elseif var_58_2 > 0 and var_58_2 <= arg_58_0._frontRange or var_58_2 < 0 and math.abs(var_58_2) < arg_58_0._backRange then
		var_58_1 = true
	end

	if not var_58_1 then
		return true
	else
		return false
	end
end

function var_0_9.PreCast(arg_59_0)
	arg_59_0._currentState = arg_59_0.STATE_PRECAST

	arg_59_0:AddPreCastTimer()

	if arg_59_0._preCastInfo.armor then
		arg_59_0._precastArmor = arg_59_0._preCastInfo.armor
	end

	local var_59_0 = arg_59_0._preCastInfo
	local var_59_1 = var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.WEAPON_PRE_CAST, var_59_0)

	arg_59_0._host:SetWeaponPreCastBound(arg_59_0._preCastInfo.isBound)
	arg_59_0:DispatchEvent(var_59_1)
end

function var_0_9.Fire(arg_60_0, arg_60_1)
	if arg_60_0._host:IsCease() then
		return false
	else
		arg_60_0:DispatchGCD()

		arg_60_0._currentState = arg_60_0.STATE_ATTACK

		if arg_60_0._tmpData.action_index == "" then
			arg_60_0:DoAttack(arg_60_1)
		else
			arg_60_0:DispatchFireEvent(arg_60_1, arg_60_0._tmpData.action_index)
		end
	end

	return true
end

function var_0_9.DoAttack(arg_61_0, arg_61_1)
	if arg_61_1 == nil or not arg_61_1:IsAlive() or arg_61_0:outOfFireRange(arg_61_1) then
		arg_61_1 = nil
	end

	local var_61_0 = arg_61_0:GetDirection()
	local var_61_1 = arg_61_0:GetAttackAngle()

	arg_61_0:cacheBulletID()
	arg_61_0:TriggerBuffOnSteday()

	for iter_61_0, iter_61_1 in ipairs(arg_61_0._majorEmitterList) do
		iter_61_1:Ready()
	end

	for iter_61_2, iter_61_3 in ipairs(arg_61_0._majorEmitterList) do
		iter_61_3:Fire(arg_61_1, var_61_0, var_61_1)
	end

	arg_61_0._host:CloakExpose(arg_61_0._tmpData.expose)
	var_0_0.Battle.PlayBattleSFX(arg_61_0._tmpData.fire_sfx)
	arg_61_0:TriggerBuffOnFire()
	arg_61_0:CheckAndShake()
end

function var_0_9.TriggerBuffOnSteday(arg_62_0)
	arg_62_0._host:TriggerBuff(var_0_1.BuffEffectType.ON_WEAPON_STEDAY, {
		equipIndex = arg_62_0._equipmentIndex
	})
end

function var_0_9.TriggerBuffOnFire(arg_63_0)
	arg_63_0._host:TriggerBuff(var_0_1.BuffEffectType.ON_FIRE, {
		equipIndex = arg_63_0._equipmentIndex
	})
end

function var_0_9.TriggerBuffOnReady(arg_64_0)
	return
end

function var_0_9.UpdateCombo(arg_65_0, arg_65_1)
	if arg_65_0._hostUnitType ~= var_0_1.UnitType.PLAYER_UNIT or not arg_65_0._host:IsAlive() then
		return
	end

	if #arg_65_1 > 0 then
		local var_65_0 = 0

		for iter_65_0, iter_65_1 in ipairs(arg_65_1) do
			if table.contains(arg_65_0._comboIDList, iter_65_1) then
				var_65_0 = var_65_0 + 1
			end

			arg_65_0._host:TriggerBuff(var_0_1.BuffEffectType.ON_COMBO, {
				equipIndex = arg_65_0._equipmentIndex,
				matchUnitCount = var_65_0
			})

			break
		end

		arg_65_0._comboIDList = arg_65_1
	end
end

function var_0_9.SingleFire(arg_66_0, arg_66_1, arg_66_2, arg_66_3, arg_66_4)
	local var_66_0 = {}

	arg_66_0._tempEmittersList[#arg_66_0._tempEmittersList + 1] = var_66_0

	if arg_66_1 and arg_66_1:IsAlive() then
		-- block empty
	else
		arg_66_1 = nil
	end

	arg_66_2 = arg_66_2 or var_0_9.EMITTER_NORMAL

	for iter_66_0, iter_66_1 in ipairs(arg_66_0._barrageList) do
		local function var_66_1(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
			local var_67_0 = (arg_66_4 and arg_66_0._tmpData.bullet_ID or arg_66_0._bulletList)[iter_66_0]
			local var_67_1 = arg_66_0:Spawn(var_67_0, arg_66_1, var_0_9.EXTERNAL)

			var_67_1:SetOffsetPriority(arg_67_3)
			var_67_1:SetShiftInfo(arg_67_0, arg_67_1)

			if arg_66_1 ~= nil then
				var_67_1:SetRotateInfo(arg_66_1:GetBeenAimedPosition(), arg_66_0:GetBaseAngle(), arg_67_2)
			else
				var_67_1:SetRotateInfo(nil, arg_66_0:GetBaseAngle(), arg_67_2)
			end

			arg_66_0:DispatchBulletEvent(var_67_1)
		end

		local function var_66_2()
			for iter_68_0, iter_68_1 in ipairs(var_66_0) do
				if iter_68_1:GetState() ~= iter_68_1.STATE_STOP then
					return
				end
			end

			for iter_68_2, iter_68_3 in ipairs(var_66_0) do
				iter_68_3:Destroy()
			end

			local var_68_0

			for iter_68_4, iter_68_5 in ipairs(arg_66_0._tempEmittersList) do
				if iter_68_5 == var_66_0 then
					var_68_0 = iter_68_4
				end
			end

			table.remove(arg_66_0._tempEmittersList, var_68_0)

			var_66_0 = nil
			arg_66_0._fireFXFlag = arg_66_0._tmpData.fire_fx_loop_type

			if arg_66_3 then
				arg_66_3()
			end
		end

		local var_66_3 = var_0_0.Battle[arg_66_2].New(var_66_1, var_66_2, iter_66_1)

		var_66_0[#var_66_0 + 1] = var_66_3
	end

	for iter_66_2, iter_66_3 in ipairs(var_66_0) do
		iter_66_3:Ready()
		iter_66_3:Fire(arg_66_1, arg_66_0:GetDirection(), arg_66_0:GetAttackAngle())
	end

	arg_66_0._host:CloakExpose(arg_66_0._tmpData.expose)
	arg_66_0:CheckAndShake()
end

function var_0_9.SetModifyInitialCD(arg_69_0)
	arg_69_0._modInitCD = true
end

function var_0_9.GetModifyInitialCD(arg_70_0)
	return arg_70_0._modInitCD
end

function var_0_9.InitialCD(arg_71_0)
	if arg_71_0._tmpData.initial_over_heat == 1 then
		arg_71_0:AddCDTimer(arg_71_0:GetReloadTime())
	end
end

function var_0_9.EnterCoolDown(arg_72_0)
	arg_72_0._fireFXFlag = arg_72_0._tmpData.fire_fx_loop_type

	arg_72_0:AddCDTimer(arg_72_0:GetReloadTime())
end

function var_0_9.UpdatePrecastArmor(arg_73_0, arg_73_1)
	if arg_73_0._currentState ~= var_0_9.STATE_PRECAST or not arg_73_0._precastArmor then
		return
	end

	arg_73_0._precastArmor = arg_73_0._precastArmor + arg_73_1

	if arg_73_0._precastArmor <= 0 then
		arg_73_0:Interrupt()
	end
end

function var_0_9.Interrupt(arg_74_0)
	local var_74_0 = arg_74_0._preCastInfo
	local var_74_1 = var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.WEAPON_PRE_CAST_FINISH, var_74_0)

	arg_74_0:DispatchEvent(var_74_1)

	local var_74_2 = var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.WEAPON_INTERRUPT, var_74_0)

	arg_74_0:DispatchEvent(var_74_2)
	arg_74_0:TriggerBuffWhenPrecastFinish(var_0_1.BuffEffectType.ON_WEAPON_INTERRUPT)
	arg_74_0:RemovePrecastTimer()
	arg_74_0:EnterCoolDown()
end

function var_0_9.Cease(arg_75_0)
	if arg_75_0._currentState == var_0_9.STATE_ATTACK or arg_75_0._currentState == var_0_9.STATE_PRECAST or arg_75_0._currentState == var_0_9.STATE_PRECAST_FINISH then
		arg_75_0:interruptAllEmitter()
		arg_75_0:EnterCoolDown()
	end
end

function var_0_9.AppendReloadBoost(arg_76_0)
	return
end

function var_0_9.DispatchGCD(arg_77_0)
	if arg_77_0._GCD > 0 then
		arg_77_0._host:EnterGCD(arg_77_0._GCD, arg_77_0._tmpData.queue)
	end
end

function var_0_9.Clear(arg_78_0)
	arg_78_0:RemovePrecastTimer()

	if arg_78_0._majorEmitterList then
		for iter_78_0, iter_78_1 in ipairs(arg_78_0._majorEmitterList) do
			iter_78_1:Destroy()
		end
	end

	for iter_78_2, iter_78_3 in ipairs(arg_78_0._tempEmittersList) do
		for iter_78_4, iter_78_5 in ipairs(iter_78_3) do
			iter_78_5:Destroy()
		end
	end

	for iter_78_6, iter_78_7 in ipairs(arg_78_0._dumpedEmittersList) do
		for iter_78_8, iter_78_9 in ipairs(iter_78_7) do
			iter_78_9:Destroy()
		end
	end

	if arg_78_0._currentState ~= arg_78_0.STATE_OVER_HEAT then
		arg_78_0._currentState = arg_78_0.STATE_DISABLE
	end
end

function var_0_9.Dispose(arg_79_0)
	var_0_0.EventDispatcher.DetachEventDispatcher(arg_79_0)
	arg_79_0:RemovePrecastTimer()

	arg_79_0._dataProxy = nil
end

function var_0_9.AddCDTimer(arg_80_0, arg_80_1)
	arg_80_0._currentState = arg_80_0.STATE_OVER_HEAT
	arg_80_0._CDstartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	arg_80_0._reloadRequire = arg_80_1
end

function var_0_9.GetCDStartTimeStamp(arg_81_0)
	return arg_81_0._CDstartTime
end

function var_0_9.handleCoolDown(arg_82_0)
	arg_82_0._currentState = arg_82_0.STATE_READY
	arg_82_0._CDstartTime = nil
	arg_82_0._jammingTime = 0
end

function var_0_9.OverHeat(arg_83_0)
	arg_83_0._currentState = arg_83_0.STATE_OVER_HEAT
end

function var_0_9.RemovePrecastTimer(arg_84_0)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_84_0._precastTimer)
	arg_84_0._host:SetWeaponPreCastBound(false)

	arg_84_0._precastArmor = nil
	arg_84_0._precastTimer = nil
end

function var_0_9.AddPreCastTimer(arg_85_0)
	local function var_85_0()
		arg_85_0._currentState = arg_85_0.STATE_PRECAST_FINISH

		arg_85_0:RemovePrecastTimer()

		local var_86_0 = arg_85_0._preCastInfo
		local var_86_1 = var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.WEAPON_PRE_CAST_FINISH, var_86_0)

		arg_85_0:DispatchEvent(var_86_1)
		arg_85_0:TriggerBuffWhenPrecastFinish(var_0_1.BuffEffectType.ON_WEAPON_SUCCESS)
		arg_85_0:Tracking()
	end

	arg_85_0._precastTimer = pg.TimeMgr.GetInstance():AddBattleTimer("weaponPrecastTimer", 0, arg_85_0._preCastInfo.time, var_85_0, true)
end

function var_0_9.Spawn(arg_87_0, arg_87_1, arg_87_2)
	local var_87_0

	if arg_87_2 == nil then
		var_87_0 = Vector3.zero
	else
		var_87_0 = arg_87_2:GetBeenAimedPosition() or arg_87_2:GetPosition()
	end

	local var_87_1 = arg_87_0._dataProxy:CreateBulletUnit(arg_87_1, arg_87_0._host, arg_87_0, var_87_0)

	arg_87_0:setBulletSkin(var_87_1, arg_87_1)
	arg_87_0:setBulletOrb(var_87_1)
	arg_87_0:TriggerBuffWhenSpawn(var_87_1)

	return var_87_1
end

function var_0_9.FixAmmo(arg_88_0, arg_88_1)
	arg_88_0._fixedAmmo = arg_88_1
end

function var_0_9.GetFixAmmo(arg_89_0)
	return arg_89_0._fixedAmmo
end

function var_0_9.ShiftBullet(arg_90_0, arg_90_1)
	local var_90_0 = {}

	for iter_90_0 = 1, #arg_90_0._bulletList do
		var_90_0[iter_90_0] = arg_90_1
	end

	arg_90_0._bulletList = var_90_0
end

function var_0_9.RevertBullet(arg_91_0)
	arg_91_0._bulletList = arg_91_0._tmpData.bullet_ID
end

function var_0_9.cacheBulletID(arg_92_0)
	arg_92_0._emitBulletIDList = arg_92_0._bulletList
end

function var_0_9.setBulletOrb(arg_93_0, arg_93_1)
	if not arg_93_0._orbID then
		return
	end

	local var_93_0 = {
		buff_id = arg_93_0._orbID,
		rant = arg_93_0._orbRant,
		level = arg_93_0._orbLevel
	}

	arg_93_1:AppendAttachBuff(var_93_0)
end

function var_0_9.SetBulletOrbData(arg_94_0, arg_94_1)
	arg_94_0._orbID = arg_94_1.buffID
	arg_94_0._orbRant = arg_94_1.rant
	arg_94_0._orbLevel = arg_94_1.level
end

function var_0_9.ShiftBarrage(arg_95_0, arg_95_1)
	for iter_95_0, iter_95_1 in ipairs(arg_95_0._majorEmitterList) do
		table.insert(arg_95_0._dumpedEmittersList, iter_95_1)
	end

	arg_95_0._majorEmitterList = {}

	if type(arg_95_1) == "number" then
		local var_95_0 = {}

		for iter_95_2 = 1, #arg_95_0._barrageList do
			var_95_0[iter_95_2] = arg_95_1
		end

		arg_95_0._barrageList = var_95_0
	elseif type(arg_95_1) == "table" then
		arg_95_0._barrageList = arg_95_1
	end

	for iter_95_3, iter_95_4 in ipairs(arg_95_0._barrageList) do
		arg_95_0:createMajorEmitter(iter_95_4, iter_95_3)
	end
end

function var_0_9.RevertBarrage(arg_96_0)
	arg_96_0:ShiftBarrage(arg_96_0._tmpData.barrage_ID)
end

function var_0_9.GetPrimalAmmoType(arg_97_0)
	return var_0_6.GetBulletTmpDataFromID(arg_97_0._tmpData.bullet_ID[1]).ammo_type
end

function var_0_9.TriggerBuffWhenSpawn(arg_98_0, arg_98_1, arg_98_2)
	local var_98_0 = arg_98_2 or var_0_1.BuffEffectType.ON_BULLET_CREATE
	local var_98_1 = {
		_bullet = arg_98_1,
		equipIndex = arg_98_0._equipmentIndex,
		bulletTag = arg_98_1:GetExtraTag()
	}

	arg_98_0._host:TriggerBuff(var_98_0, var_98_1)
end

function var_0_9.TriggerBuffWhenPrecastFinish(arg_99_0, arg_99_1)
	if arg_99_0._preCastInfo.armor then
		local var_99_0 = {
			weaponID = arg_99_0._tmpData.id
		}

		arg_99_0._host:TriggerBuff(arg_99_1, var_99_0)
	end
end

function var_0_9.DispatchBulletEvent(arg_100_0, arg_100_1, arg_100_2)
	local var_100_0 = arg_100_2
	local var_100_1 = arg_100_0._tmpData
	local var_100_2

	if arg_100_0._fireFXFlag ~= 0 then
		var_100_2 = arg_100_0._skinFireFX or var_100_1.fire_fx

		if arg_100_0._fireFXFlag ~= -1 then
			arg_100_0._fireFXFlag = arg_100_0._fireFXFlag - 1
		end
	end

	if type(var_100_1.spawn_bound) == "table" and not var_100_0 then
		local var_100_3 = arg_100_0._dataProxy:GetStageInfo().mainUnitPosition

		if var_100_3 and var_100_3[arg_100_0._hostIFF] then
			var_100_0 = Clone(var_100_3[arg_100_0._hostIFF][var_100_1.spawn_bound[1]])
		else
			var_100_0 = Clone(var_0_2.MAIN_UNIT_POS[arg_100_0._hostIFF][var_100_1.spawn_bound[1]])
		end
	end

	local var_100_4 = {
		spawnBound = var_100_1.spawn_bound,
		bullet = arg_100_1,
		fireFxID = var_100_2,
		position = var_100_0
	}
	local var_100_5 = var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CREATE_BULLET, var_100_4)

	arg_100_0:DispatchEvent(var_100_5)
end

function var_0_9.DispatchFireEvent(arg_101_0, arg_101_1, arg_101_2)
	local var_101_0 = {
		target = arg_101_1,
		actionIndex = arg_101_2
	}
	local var_101_1 = var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.FIRE, var_101_0)

	arg_101_0:DispatchEvent(var_101_1)
end

function var_0_9.CheckAndShake(arg_102_0)
	if arg_102_0._tmpData.shakescreen ~= 0 then
		var_0_0.Battle.BattleCameraUtil.GetInstance():StartShake(pg.shake_template[arg_102_0._tmpData.shakescreen])
	end
end

function var_0_9.GetBaseAngle(arg_103_0)
	return arg_103_0._baseAngle
end

function var_0_9.GetHost(arg_104_0)
	return arg_104_0._host
end

function var_0_9.GetStandHost(arg_105_0)
	return arg_105_0._standHost
end

function var_0_9.GetPosition(arg_106_0)
	return arg_106_0._hostPos
end

function var_0_9.GetDirection(arg_107_0)
	return arg_107_0._host:GetDirection()
end

function var_0_9.GetCurrentState(arg_108_0)
	return arg_108_0._currentState
end

function var_0_9.GetReloadTime(arg_109_0)
	local var_109_0 = var_0_7.GetCurrent(arg_109_0._host, "loadSpeed")

	if arg_109_0._reloadMax ~= arg_109_0._cacheReloadMax or var_109_0 ~= arg_109_0._cacheHostReload then
		arg_109_0._cacheReloadMax = arg_109_0._reloadMax
		arg_109_0._cacheHostReload = var_109_0
		arg_109_0._cacheReloadTime = var_0_3.CalculateReloadTime(arg_109_0._reloadMax, var_0_7.GetCurrent(arg_109_0._host, "loadSpeed"))
	end

	return arg_109_0._cacheReloadTime
end

function var_0_9.GetReloadTimeByRate(arg_110_0, arg_110_1)
	local var_110_0 = var_0_7.GetCurrent(arg_110_0._host, "loadSpeed")
	local var_110_1 = arg_110_0._cacheReloadMax * arg_110_1

	return (var_0_3.CalculateReloadTime(var_110_1, var_110_0))
end

function var_0_9.GetReloadFinishTimeStamp(arg_111_0)
	local var_111_0 = 0

	for iter_111_0, iter_111_1 in ipairs(arg_111_0._reloadBoostList) do
		var_111_0 = var_111_0 + iter_111_1
	end

	return arg_111_0._reloadRequire + arg_111_0._CDstartTime + arg_111_0._jammingTime + var_111_0
end

function var_0_9.AppendFactor(arg_112_0, arg_112_1)
	return
end

function var_0_9.StartJamming(arg_113_0)
	if arg_113_0._currentState ~= var_0_9.STATE_READY then
		arg_113_0._jammingStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	end
end

function var_0_9.JammingEliminate(arg_114_0)
	if not arg_114_0._jammingStartTime then
		return
	end

	arg_114_0._jammingTime = pg.TimeMgr.GetInstance():GetCombatTime() - arg_114_0._jammingStartTime
	arg_114_0._jammingStartTime = nil
end

function var_0_9.FlushReloadMax(arg_115_0, arg_115_1)
	local var_115_0 = arg_115_0._tmpData.reload_max

	arg_115_1 = arg_115_1 or 1
	arg_115_0._reloadMax = var_115_0 * arg_115_1

	if not arg_115_0._CDstartTime or arg_115_0._reloadRequire == 0 then
		return true
	end

	local var_115_1 = var_0_7.GetCurrent(arg_115_0._host, "loadSpeed")

	arg_115_0._reloadRequire = var_0_9.FlushRequireByInverse(arg_115_0, var_115_1)
end

function var_0_9.AppendReloadFactor(arg_116_0, arg_116_1, arg_116_2)
	arg_116_0._reloadFacotrList[arg_116_1] = arg_116_2
end

function var_0_9.RemoveReloadFactor(arg_117_0, arg_117_1)
	if arg_117_0._reloadFacotrList[arg_117_1] then
		arg_117_0._reloadFacotrList[arg_117_1] = nil
	end
end

function var_0_9.GetReloadFactorList(arg_118_0)
	return arg_118_0._reloadFacotrList
end

function var_0_9.FlushReloadRequire(arg_119_0)
	if not arg_119_0._CDstartTime or arg_119_0._reloadRequire == 0 then
		return true
	end

	local var_119_0 = var_0_3.CaclulateReloadAttr(arg_119_0._reloadMax, arg_119_0._reloadRequire)

	arg_119_0._reloadRequire = var_0_9.FlushRequireByInverse(arg_119_0, var_119_0)
end

function var_0_9.GetMinimumRange(arg_120_0)
	return arg_120_0._minRangeSqr
end

function var_0_9.GetCorrectedDMG(arg_121_0)
	return arg_121_0._correctedDMG
end

function var_0_9.GetConvertedAtkAttr(arg_122_0)
	return arg_122_0._convertedAtkAttr
end

function var_0_9.SetAtkAttrTrasnform(arg_123_0, arg_123_1, arg_123_2, arg_123_3)
	arg_123_0._atkAttrTrans = arg_123_1
	arg_123_0._atkAttrTransA = arg_123_2
	arg_123_0._atkAttrTransB = arg_123_3
end

function var_0_9.GetAtkAttrTrasnform(arg_124_0, arg_124_1)
	local var_124_0

	if arg_124_0._atkAttrTrans then
		local var_124_1 = arg_124_1[arg_124_0._atkAttrTrans] or 0

		var_124_0 = math.min(var_124_1 / arg_124_0._atkAttrTransA, arg_124_0._atkAttrTransB)
	end

	return var_124_0
end

function var_0_9.IsReady(arg_125_0)
	return arg_125_0._currentState == arg_125_0.STATE_READY
end

function var_0_9.FlushRequireByInverse(arg_126_0, arg_126_1)
	local var_126_0 = pg.TimeMgr.GetInstance():GetCombatTime() - arg_126_0._CDstartTime
	local var_126_1 = var_0_3.CaclulateReloaded(var_126_0, arg_126_1)
	local var_126_2 = arg_126_0._reloadMax - var_126_1

	return var_126_0 + var_0_3.CalculateReloadTime(var_126_2, var_0_7.GetCurrent(arg_126_0._host, "loadSpeed"))
end

function var_0_9.SetCardPuzzleDamageEnhance(arg_127_0, arg_127_1)
	arg_127_0._cardPuzzleEnhance = arg_127_1
end

function var_0_9.GetCardPuzzleDamageEnhance(arg_128_0)
	return arg_128_0._cardPuzzleEnhance or 1
end

function var_0_9.GetReloadRate(arg_129_0)
	if arg_129_0._currentState == arg_129_0.STATE_READY then
		return 0
	elseif arg_129_0._CDstartTime then
		return (arg_129_0:GetReloadFinishTimeStamp() - pg.TimeMgr.GetInstance():GetCombatTime()) / arg_129_0._reloadRequire
	else
		return 1
	end
end

function var_0_9.WeaponStatistics(arg_130_0, arg_130_1, arg_130_2, arg_130_3)
	arg_130_0._CLDCount = arg_130_0._CLDCount + 1
	arg_130_0._damageSum = arg_130_1 + arg_130_0._damageSum

	if arg_130_2 then
		arg_130_0._CTSum = arg_130_0._CTSum + 1
	end

	if not arg_130_3 then
		arg_130_0._ACCSum = arg_130_0._ACCSum + 1
	end
end

function var_0_9.GetDamageSUM(arg_131_0)
	return arg_131_0._damageSum
end

function var_0_9.GetCTRate(arg_132_0)
	return arg_132_0._CTSum / arg_132_0._CLDCount
end

function var_0_9.GetACCRate(arg_133_0)
	return arg_133_0._ACCSum / arg_133_0._CLDCount
end
