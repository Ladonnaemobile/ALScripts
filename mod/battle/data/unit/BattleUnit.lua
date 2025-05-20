ys = ys or {}

local var_0_0 = ys
local var_0_1 = var_0_0.Battle.BattleUnitEvent
local var_0_2 = var_0_0.Battle.BattleBuffEvent
local var_0_3 = var_0_0.Battle.BattleConst
local var_0_4 = var_0_0.Battle.BattleVariable
local var_0_5 = var_0_0.Battle.BattleConfig
local var_0_6 = var_0_0.Battle.BattleAttr
local var_0_7 = var_0_0.Battle.BattleDataFunction
local var_0_8 = var_0_0.Battle.UnitState
local var_0_9 = class("BattleUnit")

var_0_0.Battle.BattleUnit = var_0_9
var_0_9.__name = "BattleUnit"

function var_0_9.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.EventDispatcher.AttachEventDispatcher(arg_1_0)

	arg_1_0._uniqueID = arg_1_1
	arg_1_0._speedExemptKey = "unit_" .. arg_1_1
	arg_1_0._unitState = var_0_0.Battle.UnitState.New(arg_1_0)
	arg_1_0._move = var_0_0.Battle.MoveComponent.New()
	arg_1_0._weaponQueue = var_0_0.Battle.WeaponQueue.New()

	arg_1_0:Init()
	arg_1_0:SetIFF(arg_1_2)

	arg_1_0._distanceBackup = {}
	arg_1_0._battleProxy = var_0_0.Battle.BattleDataProxy.GetInstance()
	arg_1_0._frame = 0
end

function var_0_9.Retreat(arg_2_0)
	arg_2_0:TriggerBuff(var_0_3.BuffEffectType.ON_RETREAT, {})
end

function var_0_9.SetMotion(arg_3_0, arg_3_1)
	arg_3_0._move:SetMotionVO(arg_3_1)
end

function var_0_9.SetBound(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	arg_4_0._move:SetCorpsArea(arg_4_5, arg_4_6)
	arg_4_0._move:SetBorder(arg_4_3, arg_4_4, arg_4_1, arg_4_2)
end

function var_0_9.ActiveCldBox(arg_5_0)
	arg_5_0._cldComponent:SetActive(true)
end

function var_0_9.DeactiveCldBox(arg_6_0)
	arg_6_0._cldComponent:SetActive(false)
end

function var_0_9.SetCldBoxImmune(arg_7_0, arg_7_1)
	arg_7_0._cldComponent:SetImmuneCLD(arg_7_1)
end

function var_0_9.Init(arg_8_0)
	arg_8_0._hostileCldList = {}
	arg_8_0._currentHPRate = 1
	arg_8_0._currentDMGRate = 0
	arg_8_0._tagCount = 0
	arg_8_0._tagIndex = 0
	arg_8_0._tagList = {}
	arg_8_0._aliveState = true
	arg_8_0._isMainFleetUnit = false
	arg_8_0._bulletCache = {}
	arg_8_0._speed = Vector3.zero
	arg_8_0._dir = var_0_3.UnitDir.RIGHT
	arg_8_0._extraInfo = {}
	arg_8_0._GCDTimerList = {}
	arg_8_0._buffList = {}
	arg_8_0._buffStockList = {}
	arg_8_0._labelTagList = {}
	arg_8_0._exposedToSnoar = false
	arg_8_0._moveCast = true
	arg_8_0._remoteBoundBone = {}
end

function var_0_9.Update(arg_9_0, arg_9_1)
	if arg_9_0:IsAlive() and not arg_9_0._isSickness then
		arg_9_0._move:Update()
		arg_9_0._move:FixSpeed(arg_9_0._cldComponent)
		arg_9_0._move:Move(arg_9_0:GetSpeedRatio())
	end

	arg_9_0:UpdateAction()
end

function var_0_9.UpdateWeapon(arg_10_0, arg_10_1)
	if not arg_10_0:IsAlive() or arg_10_0._isSickness then
		return
	end

	if not arg_10_0._antiSubVigilanceState or arg_10_0._antiSubVigilanceState:IsWeaponUseable() then
		local var_10_0 = arg_10_0._move:GetPos()
		local var_10_1 = arg_10_0._weaponRightBound
		local var_10_2 = arg_10_0._weaponLowerBound

		if (var_10_1 == nil or var_10_1 > var_10_0.x) and (var_10_2 == nil or var_10_2 < var_10_0.z) then
			arg_10_0._weaponQueue:Update(arg_10_1)
		end
	end

	if not arg_10_0:IsAlive() then
		return
	end

	arg_10_0:UpdateBuff(arg_10_1)
end

function var_0_9.UpdateAirAssist(arg_11_0)
	if arg_11_0._airAssistList then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0._airAssistList) do
			iter_11_1:Update()
		end
	end
end

function var_0_9.UpdatePhaseSwitcher(arg_12_0)
	if arg_12_0._phaseSwitcher then
		arg_12_0._phaseSwitcher:Update()
	end
end

function var_0_9.SetInterruptSickness(arg_13_0, arg_13_1)
	arg_13_0._isSickness = arg_13_1
end

function var_0_9.SummonSickness(arg_14_0, arg_14_1)
	if arg_14_0._isSickness == true then
		return
	end

	local function var_14_0()
		arg_14_0:RemoveSummonSickness()
	end

	arg_14_0._isSickness = true
	arg_14_0._sicknessTimer = pg.TimeMgr.GetInstance():AddBattleTimer("summonSickness", 0, arg_14_1, var_14_0, true)
end

function var_0_9.RemoveSummonSickness(arg_16_0)
	arg_16_0._isSickness = false

	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_16_0._sicknessTimer)

	arg_16_0._sicknessTimer = nil
end

function var_0_9.GetTargetedPriority(arg_17_0)
	local var_17_0

	if arg_17_0._aimBias then
		local var_17_1 = arg_17_0._aimBias:GetCurrentState()

		if var_17_1 == arg_17_0._aimBias.STATE_SKILL_EXPOSE or var_17_1 == arg_17_0._aimBias.STATE_TOTAL_EXPOSE then
			var_17_0 = arg_17_0:GetTemplate().battle_unit_type
		else
			var_17_0 = -200
		end
	else
		var_17_0 = arg_17_0:GetTemplate().battle_unit_type
	end

	return var_17_0
end

function var_0_9.PlayFX(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:DispatchEvent(var_0_0.Event.New(var_0_1.PLAY_FX, {
		fxName = arg_18_1,
		notAttach = not arg_18_2
	}))
end

function var_0_9.SwitchShader(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0:DispatchEvent(var_0_0.Event.New(var_0_1.SWITCH_SHADER, {
		shader = arg_19_1,
		color = arg_19_2,
		args = arg_19_3
	}))
end

function var_0_9.SendAttackTrigger(arg_20_0)
	arg_20_0:DispatchEvent(var_0_0.Event.New(var_0_1.SPAWN_CACHE_BULLET, {}))
end

function var_0_9.HandleDamageToDeath(arg_21_0)
	local var_21_0 = {
		isMiss = false,
		isCri = true,
		isHeal = false,
		damageReason = var_0_3.UnitDeathReason.DESTRUCT
	}

	arg_21_0:UpdateHP(math.floor(-arg_21_0._currentHP), var_21_0)
end

function var_0_9.UpdateHP(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:IsAlive()

	if not var_22_0 then
		return 0
	end

	local var_22_1 = arg_22_2.isMiss
	local var_22_2 = arg_22_2.isCri
	local var_22_3 = arg_22_2.isHeal
	local var_22_4 = arg_22_2.isShare
	local var_22_5 = arg_22_2.attr
	local var_22_6 = arg_22_2.damageReason
	local var_22_7 = arg_22_2.font
	local var_22_8 = arg_22_2.cldPos
	local var_22_9 = arg_22_2.incorrupt
	local var_22_10 = arg_22_2.isReflect
	local var_22_11
	local var_22_12

	if not var_22_3 then
		var_22_12 = {
			damage = -arg_22_1,
			isShare = var_22_4,
			miss = var_22_1,
			cri = var_22_2,
			damageSrc = arg_22_2.srcID,
			damageAttr = var_22_5,
			damageReason = var_22_6,
			isReflect = var_22_10
		}

		if not var_22_4 then
			arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_BEFORE_TAKE_DAMAGE, var_22_12)

			if var_22_12.capFlag then
				arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_DAMAGE_FIX, var_22_12)
			end
		end

		var_22_11 = -var_22_12.damage

		arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_TAKE_DAMAGE, var_22_12)

		if arg_22_0._currentHP <= var_22_12.damage then
			arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_BEFORE_FATAL_DAMAGE, {})
		end

		arg_22_1 = -var_22_12.damage

		if var_22_11 ~= arg_22_1 then
			({}).absorb = var_22_11 - arg_22_1

			arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_SHIELD_ABSORB, var_22_12)
		end

		if var_0_6.IsInvincible(arg_22_0) then
			return 0
		end
	else
		var_22_11 = arg_22_1

		local var_22_13 = {
			damage = arg_22_1,
			isHeal = var_22_3,
			incorrupt = var_22_9
		}

		arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_TAKE_HEALING, var_22_13)

		var_22_3 = var_22_13.isHeal
		arg_22_1 = var_22_13.damage

		local var_22_14 = math.max(0, arg_22_0._currentHP + arg_22_1 - arg_22_0:GetMaxHP())

		if var_22_14 > 0 then
			arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_OVER_HEALING, {
				overHealing = var_22_14
			})
		end
	end

	local var_22_15 = math.min(arg_22_0:GetMaxHP(), math.max(0, arg_22_0._currentHP + arg_22_1))
	local var_22_16 = var_22_15 - arg_22_0._currentHP

	arg_22_0:SetCurrentHP(var_22_15)

	local var_22_17 = {
		preShieldHP = var_22_11,
		dHP = arg_22_1,
		validDHP = var_22_16,
		isMiss = var_22_1,
		isCri = var_22_2,
		isHeal = var_22_3,
		font = var_22_7
	}

	if not var_22_3 then
		var_22_12.validDHP = var_22_16

		arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_DAMAGE_CONCLUDE, var_22_12)
	end

	if var_22_8 and not var_22_8:EqualZero() then
		local var_22_18 = arg_22_0:GetPosition()
		local var_22_19 = arg_22_0:GetBoxSize().x
		local var_22_20 = var_22_18.x - var_22_19
		local var_22_21 = var_22_18.x + var_22_19
		local var_22_22 = var_22_8:Clone()

		var_22_22.x = Mathf.Clamp(var_22_22.x, var_22_20, var_22_21)
		var_22_17.posOffset = var_22_18 - var_22_22
	end

	arg_22_0:UpdateHPAction(var_22_17)

	if not arg_22_0:IsAlive() and var_22_0 then
		arg_22_0:SetDeathReason(arg_22_2.damageReason)
		arg_22_0:SetDeathSrcID(arg_22_2.srcID)
		arg_22_0:DeadAction()
	end

	if arg_22_0:IsAlive() then
		arg_22_0:TriggerBuff(var_0_3.BuffEffectType.ON_HP_RATIO_UPDATE, {
			dHP = arg_22_1,
			unit = arg_22_0,
			validDHP = var_22_16
		})
	end

	return arg_22_1
end

function var_0_9.UpdateHPAction(arg_23_0, arg_23_1)
	arg_23_0:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_HP, arg_23_1))
end

function var_0_9.DeadAction(arg_24_0)
	arg_24_0:TriggerBuff(var_0_3.BuffEffectType.ON_SINK, {})
	arg_24_0:DeacActionClear()
end

function var_0_9.DeacActionClear(arg_25_0)
	arg_25_0._aliveState = false

	var_0_6.Spirit(arg_25_0)
	var_0_6.AppendInvincible(arg_25_0)
	arg_25_0:DeadActionEvent()
end

function var_0_9.DeadActionEvent(arg_26_0)
	arg_26_0:DispatchEvent(var_0_0.Event.New(var_0_1.WILL_DIE, {}))
	arg_26_0:DispatchEvent(var_0_0.Event.New(var_0_1.DYING, {}))
end

function var_0_9.SendDeadEvent(arg_27_0)
	arg_27_0:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.DYING, {}))
end

function var_0_9.SetDeathReason(arg_28_0, arg_28_1)
	arg_28_0._deathReason = arg_28_1
end

function var_0_9.GetDeathReason(arg_29_0)
	return arg_29_0._deathReason or var_0_3.UnitDeathReason.KILLED
end

function var_0_9.SetDeathSrcID(arg_30_0, arg_30_1)
	arg_30_0._deathSrcID = arg_30_1
end

function var_0_9.GetDeathSrcID(arg_31_0)
	return arg_31_0._deathSrcID
end

function var_0_9.DispatchScorePoint(arg_32_0, arg_32_1)
	arg_32_0:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.UPDATE_SCORE, {
		score = arg_32_1
	}))
end

function var_0_9.SetTemplate(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0._tmpID = arg_33_1
end

function var_0_9.GetTemplateID(arg_34_0)
	return arg_34_0._tmpID
end

function var_0_9.SetOverrideLevel(arg_35_0, arg_35_1)
	arg_35_0._overrideLevel = arg_35_1
end

function var_0_9.SetSkinId(arg_36_0)
	return
end

function var_0_9.SetGearScore(arg_37_0, arg_37_1)
	arg_37_0._GS = arg_37_1
end

function var_0_9.GetGearScore(arg_38_0)
	return arg_38_0._GS or 0
end

function var_0_9.GetSkinID(arg_39_0)
	return arg_39_0._tmpID
end

function var_0_9.GetDefaultSkinID(arg_40_0)
	return arg_40_0._tmpID
end

function var_0_9.GetSkinAttachmentInfo(arg_41_0)
	return arg_41_0._orbitSkinIDList
end

function var_0_9.GetWeaponBoundBone(arg_42_0)
	return arg_42_0._tmpData.bound_bone
end

function var_0_9.ActionKeyOffsetUseable(arg_43_0)
	return true
end

function var_0_9.RemoveRemoteBoundBone(arg_44_0, arg_44_1)
	arg_44_0._remoteBoundBone[arg_44_1] = nil
end

function var_0_9.SetRemoteBoundBone(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	local var_45_0 = arg_45_0._remoteBoundBone[arg_45_1] or {}

	var_45_0[arg_45_2] = arg_45_3
	arg_45_0._remoteBoundBone[arg_45_1] = var_45_0
end

function var_0_9.GetRemoteBoundBone(arg_46_0, arg_46_1)
	for iter_46_0, iter_46_1 in pairs(arg_46_0._remoteBoundBone) do
		local var_46_0 = iter_46_1[arg_46_1]

		if var_46_0 then
			local var_46_1 = var_0_0.Battle.BattleTargetChoise.TargetFleetIndex(arg_46_0, {
				fleetPos = var_46_0
			})[1]

			if var_46_1 and var_46_1:IsAlive() then
				local var_46_2 = Clone(var_46_1:GetPosition())

				var_46_2:Set(var_46_2.x, 1.5, var_46_2.z)

				return var_46_2
			end
		end
	end
end

function var_0_9.GetLabelTag(arg_47_0)
	return arg_47_0._labelTagList
end

function var_0_9.ContainsLabelTag(arg_48_0, arg_48_1)
	if arg_48_0._labelTagList == nil then
		return false
	end

	for iter_48_0, iter_48_1 in ipairs(arg_48_1) do
		if table.contains(arg_48_0._labelTagList, iter_48_1) then
			return true
		end
	end

	return false
end

function var_0_9.AddLabelTag(arg_49_0, arg_49_1)
	table.insert(arg_49_0._labelTagList, arg_49_1)

	local var_49_0 = var_0_6.GetCurrent(arg_49_0, "labelTag")

	var_49_0[arg_49_1] = (var_49_0[arg_49_1] or 0) + 1
end

function var_0_9.RemoveLabelTag(arg_50_0, arg_50_1)
	for iter_50_0, iter_50_1 in ipairs(arg_50_0._labelTagList) do
		if iter_50_1 == arg_50_1 then
			table.remove(arg_50_0._labelTagList, iter_50_0)

			local var_50_0 = var_0_6.GetCurrent(arg_50_0, "labelTag")

			var_50_0[arg_50_1] = var_50_0[arg_50_1] - 1

			break
		end
	end
end

function var_0_9.setStandardLabelTag(arg_51_0)
	local var_51_0 = "N_" .. arg_51_0._tmpData.nationality
	local var_51_1 = "T_" .. arg_51_0._tmpData.type

	arg_51_0:AddLabelTag(var_51_0)
	arg_51_0:AddLabelTag(var_51_1)
end

function var_0_9.GetRarity(arg_52_0)
	return
end

function var_0_9.GetIntimacy(arg_53_0)
	return 0
end

function var_0_9.IsBoss(arg_54_0)
	return false
end

function var_0_9.GetSpeedRatio(arg_55_0)
	return var_0_4.GetSpeedRatio(arg_55_0:GetSpeedExemptKey(), arg_55_0._IFF)
end

function var_0_9.GetSpeedExemptKey(arg_56_0)
	return arg_56_0._speedExemptKey
end

function var_0_9.SetMoveCast(arg_57_0, arg_57_1)
	arg_57_0._moveCast = arg_57_1
end

function var_0_9.IsMoveCast(arg_58_0)
	return arg_58_0._moveCast
end

function var_0_9.SetCrash(arg_59_0, arg_59_1)
	arg_59_0._isCrash = arg_59_1

	if arg_59_1 then
		local var_59_0 = var_0_0.Battle.BattleBuffUnit.New(var_0_5.SHIP_CLD_BUFF)

		arg_59_0:AddBuff(var_59_0)
	else
		arg_59_0:RemoveBuff(var_0_5.SHIP_CLD_BUFF)
	end
end

function var_0_9.IsCrash(arg_60_0)
	return arg_60_0._isCrash
end

function var_0_9.OverrideDeadFX(arg_61_0, arg_61_1)
	arg_61_0._deadFX = arg_61_1
end

function var_0_9.GetDeadFX(arg_62_0)
	return arg_62_0._deadFX
end

function var_0_9.SetEquipment(arg_63_0, arg_63_1)
	arg_63_0._equipmentList = arg_63_1
	arg_63_0._autoWeaponList = {}
	arg_63_0._manualTorpedoList = {}
	arg_63_0._chargeList = {}
	arg_63_0._AAList = {}
	arg_63_0._fleetAAList = {}
	arg_63_0._fleetRangeAAList = {}
	arg_63_0._hiveList = {}
	arg_63_0._totalWeapon = {}

	arg_63_0:setWeapon(arg_63_1)
end

function var_0_9.GetEquipment(arg_64_0)
	return arg_64_0._equipmentList
end

function var_0_9.SetProficiencyList(arg_65_0, arg_65_1)
	arg_65_0._proficiencyList = arg_65_1
end

function var_0_9.SetSpWeapon(arg_66_0, arg_66_1)
	arg_66_0._spWeapon = arg_66_1
end

function var_0_9.GetSpWeapon(arg_67_0)
	return arg_67_0._spWeapon
end

function var_0_9.setWeapon(arg_68_0, arg_68_1)
	for iter_68_0, iter_68_1 in ipairs(arg_68_1) do
		local var_68_0 = iter_68_1.equipment.weapon_id

		for iter_68_2, iter_68_3 in ipairs(var_68_0) do
			if iter_68_3 ~= -1 then
				local var_68_1 = var_0_0.Battle.BattleDataFunction.CreateWeaponUnit(iter_68_3, arg_68_0, nil, iter_68_0)

				arg_68_0._totalWeapon[#arg_68_0._totalWeapon + 1] = var_68_1

				local var_68_2 = var_68_1:GetTemplateData().type

				if var_68_2 == var_0_3.EquipmentType.MANUAL_TORPEDO then
					arg_68_0._manualTorpedoList[#arg_68_0._manualTorpedoList + 1] = var_68_1

					arg_68_0._weaponQueue:AppendWeapon(var_68_1)
				elseif var_68_2 == var_0_3.EquipmentType.STRIKE_AIRCRAFT then
					-- block empty
				else
					assert(#var_68_0 < 2, "自动武器一组不允许配置多个")
					arg_68_0:AddAutoWeapon(var_68_1)
				end

				if var_68_2 == var_0_3.EquipmentType.INTERCEPT_AIRCRAFT or var_68_2 == var_0_3.EquipmentType.STRIKE_AIRCRAFT then
					arg_68_0._hiveList[#arg_68_0._hiveList + 1] = var_68_1
				end

				if var_68_2 == var_0_3.EquipmentType.ANTI_AIR then
					arg_68_0._AAList[#arg_68_0._AAList + 1] = var_68_1
				end
			end
		end
	end
end

function var_0_9.CheckWeaponInitial(arg_69_0)
	arg_69_0._weaponQueue:CheckWeaponInitalCD()

	if arg_69_0._airAssistQueue then
		arg_69_0._airAssistQueue:CheckWeaponInitalCD()
	end

	arg_69_0:DispatchEvent(var_0_0.Event.New(var_0_1.INIT_COOL_DOWN, {}))
end

function var_0_9.FlushReloadingWeapon(arg_70_0)
	arg_70_0._weaponQueue:FlushWeaponReloadRequire()

	if arg_70_0._airAssistQueue then
		arg_70_0._airAssistQueue:FlushWeaponReloadRequire()
	end
end

function var_0_9.AddNewAutoWeapon(arg_71_0, arg_71_1)
	local var_71_0 = var_0_7.CreateWeaponUnit(arg_71_1, arg_71_0)

	arg_71_0:AddAutoWeapon(var_71_0)
	arg_71_0:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleBuffEvent.BUFF_EFFECT_NEW_WEAPON, {
		weapon = var_71_0
	}))

	return var_71_0
end

function var_0_9.AddAutoWeapon(arg_72_0, arg_72_1)
	arg_72_0._autoWeaponList[#arg_72_0._autoWeaponList + 1] = arg_72_1

	arg_72_0._weaponQueue:AppendWeapon(arg_72_1)
end

function var_0_9.RemoveAutoWeapon(arg_73_0, arg_73_1)
	arg_73_0._weaponQueue:RemoveWeapon(arg_73_1)

	local var_73_0 = 1
	local var_73_1 = #arg_73_0._autoWeaponList

	while var_73_0 <= var_73_1 do
		if arg_73_0._autoWeaponList[var_73_0] == arg_73_1 then
			arg_73_0:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_WEAPON, {
				weapon = arg_73_1
			}))
			table.remove(arg_73_0._autoWeaponList, var_73_0)

			break
		end

		var_73_0 = var_73_0 + 1
	end
end

function var_0_9.RemoveAutoWeaponByWeaponID(arg_74_0, arg_74_1)
	for iter_74_0, iter_74_1 in ipairs(arg_74_0._autoWeaponList) do
		if iter_74_1:GetWeaponId() == arg_74_1 then
			iter_74_1:Clear()
			arg_74_0:RemoveAutoWeapon(iter_74_1)

			break
		end
	end
end

function var_0_9.RemoveAllAutoWeapon(arg_75_0)
	local var_75_0 = #arg_75_0._autoWeaponList

	while var_75_0 > 0 do
		local var_75_1 = arg_75_0._autoWeaponList[var_75_0]

		var_75_1:Clear()
		arg_75_0:RemoveAutoWeapon(var_75_1)

		var_75_0 = var_75_0 - 1
	end
end

function var_0_9.AddFleetAntiAirWeapon(arg_76_0, arg_76_1)
	return
end

function var_0_9.RemoveFleetAntiAirWeapon(arg_77_0, arg_77_1)
	return
end

function var_0_9.AttachFleetRangeAAWeapon(arg_78_0, arg_78_1)
	arg_78_0._fleetRangeAA = arg_78_1

	arg_78_0:DispatchEvent(var_0_0.Event.New(var_0_1.CREATE_TEMPORARY_WEAPON, {
		weapon = arg_78_1
	}))
end

function var_0_9.DetachFleetRangeAAWeapon(arg_79_0)
	arg_79_0:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_WEAPON, {
		weapon = arg_79_0._fleetRangeAA
	}))

	arg_79_0._fleetRangeAA = nil
end

function var_0_9.GetFleetRangeAAWeapon(arg_80_0)
	return arg_80_0._fleetRangeAA
end

function var_0_9.ShiftWeapon(arg_81_0, arg_81_1, arg_81_2)
	for iter_81_0, iter_81_1 in ipairs(arg_81_1) do
		arg_81_0:RemoveAutoWeaponByWeaponID(iter_81_1)
	end

	for iter_81_2, iter_81_3 in ipairs(arg_81_2) do
		arg_81_0:AddNewAutoWeapon(iter_81_3):InitialCD()
	end
end

function var_0_9.ExpandWeaponMount(arg_82_0, arg_82_1)
	if arg_82_1 == "airAssist" then
		var_0_7.ExpandAllinStrike(arg_82_0)
	end
end

function var_0_9.ReduceWeaponMount(arg_83_0, arg_83_1)
	return
end

function var_0_9.CeaseAllWeapon(arg_84_0, arg_84_1)
	arg_84_0._ceaseFire = arg_84_1
end

function var_0_9.IsCease(arg_85_0)
	return arg_85_0._ceaseFire
end

function var_0_9.GetAllWeapon(arg_86_0)
	return arg_86_0._totalWeapon
end

function var_0_9.GetTotalWeapon(arg_87_0)
	return arg_87_0._weaponQueue:GetTotalWeaponUnit()
end

function var_0_9.GetAutoWeapons(arg_88_0)
	return arg_88_0._autoWeaponList
end

function var_0_9.GetChargeList(arg_89_0)
	return arg_89_0._chargeList
end

function var_0_9.GetChargeQueue(arg_90_0)
	return arg_90_0._weaponQueue:GetChargeWeaponQueue()
end

function var_0_9.GetAntiAirWeapon(arg_91_0)
	return arg_91_0._AAList
end

function var_0_9.GetFleetAntiAirList(arg_92_0)
	return arg_92_0._fleetAAList
end

function var_0_9.GetFleetRangeAntiAirList(arg_93_0)
	return arg_93_0._fleetRangeAAList
end

function var_0_9.GetTorpedoList(arg_94_0)
	return arg_94_0._manualTorpedoList
end

function var_0_9.GetTorpedoQueue(arg_95_0)
	return arg_95_0._weaponQueue:GetManualTorpedoQueue()
end

function var_0_9.GetWeaponByIndex(arg_96_0, arg_96_1)
	for iter_96_0, iter_96_1 in ipairs(arg_96_0._totalWeapon) do
		if iter_96_1:GetEquipmentIndex() == arg_96_1 then
			return iter_96_1
		end
	end
end

function var_0_9.GetHiveList(arg_97_0)
	return arg_97_0._hiveList
end

function var_0_9.SetAirAssistList(arg_98_0, arg_98_1)
	arg_98_0._airAssistList = arg_98_1
	arg_98_0._airAssistQueue = var_0_0.Battle.ManualWeaponQueue.New(arg_98_0:GetManualWeaponParallel()[var_0_3.ManualWeaponIndex.AIR_ASSIST])

	for iter_98_0, iter_98_1 in ipairs(arg_98_0._airAssistList) do
		arg_98_0._airAssistQueue:AppendWeapon(iter_98_1)
	end
end

function var_0_9.GetAirAssistList(arg_99_0)
	return arg_99_0._airAssistList
end

function var_0_9.GetAirAssistQueue(arg_100_0)
	return arg_100_0._airAssistQueue
end

function var_0_9.GetManualWeaponParallel(arg_101_0)
	return {
		1,
		1,
		1
	}
end

function var_0_9.configWeaponQueueParallel(arg_102_0)
	local var_102_0 = arg_102_0:GetManualWeaponParallel()

	arg_102_0._weaponQueue:ConfigParallel(var_102_0[var_0_3.ManualWeaponIndex.CALIBRATION], var_102_0[var_0_3.ManualWeaponIndex.TORPEDO])
end

function var_0_9.ClearWeapon(arg_103_0)
	arg_103_0._weaponQueue:ClearAllWeapon()

	local var_103_0 = arg_103_0._airAssistList

	if var_103_0 then
		for iter_103_0, iter_103_1 in ipairs(var_103_0) do
			iter_103_1:Clear()
		end
	end
end

function var_0_9.GetSpeed(arg_104_0)
	return arg_104_0._move:GetSpeed()
end

function var_0_9.GetPosition(arg_105_0)
	return arg_105_0._move:GetPos()
end

function var_0_9.GetBornPosition(arg_106_0)
	return arg_106_0._bornPos
end

function var_0_9.GetCLDZCenterPosition(arg_107_0)
	local var_107_0 = arg_107_0._battleProxy.FrameIndex

	if arg_107_0._zCenterFrame ~= var_107_0 then
		arg_107_0._zCenterFrame = var_107_0

		local var_107_1 = arg_107_0:GetCldBox()

		arg_107_0._cldZCenterCache = (var_107_1.min + var_107_1.max) * 0.5
	end

	return arg_107_0._cldZCenterCache
end

function var_0_9.GetBeenAimedPosition(arg_108_0)
	local var_108_0 = arg_108_0:GetCLDZCenterPosition()

	if not var_108_0 then
		return var_108_0
	end

	local var_108_1 = arg_108_0:GetTemplate() and arg_108_0:GetTemplate().aim_offset

	if not var_108_1 then
		return var_108_0
	end

	local var_108_2 = Vector3(var_108_0.x + var_108_1[1], var_108_0.y + var_108_1[2], var_108_0.z + var_108_1[3])

	arg_108_0:biasAimPosition(var_108_2)

	return var_108_2
end

function var_0_9.biasAimPosition(arg_109_0, arg_109_1)
	local var_109_0 = var_0_6.GetCurrent(arg_109_0, "aimBias")

	if var_109_0 > 0 then
		local var_109_1 = var_109_0 * 2
		local var_109_2 = math.random() * var_109_1 - var_109_0
		local var_109_3 = math.random() * var_109_1 - var_109_0

		arg_109_1:Set(arg_109_1.x + var_109_2, arg_109_1.y, arg_109_1.z + var_109_3)
	end

	return arg_109_1
end

function var_0_9.CancelFollowTeam(arg_110_0)
	arg_110_0._move:CancelFormationCtrl()
end

function var_0_9.UpdateFormationOffset(arg_111_0, arg_111_1)
	arg_111_0._move:SetFormationCtrlInfo(Vector3(arg_111_1.x, arg_111_1.y, arg_111_1.z))
end

function var_0_9.GetDistance(arg_112_0, arg_112_1)
	local var_112_0 = arg_112_0._battleProxy.FrameIndex

	if arg_112_0._frame ~= var_112_0 then
		arg_112_0._distanceBackup = {}
		arg_112_0._frame = var_112_0
	end

	local var_112_1 = arg_112_0._distanceBackup[arg_112_1]

	if var_112_1 == nil then
		var_112_1 = Vector3.Distance(arg_112_0:GetPosition(), arg_112_1:GetPosition())
		arg_112_0._distanceBackup[arg_112_1] = var_112_1

		arg_112_1:backupDistance(arg_112_0, var_112_1)
	end

	return var_112_1
end

function var_0_9.backupDistance(arg_113_0, arg_113_1, arg_113_2)
	local var_113_0 = arg_113_0._battleProxy.FrameIndex

	if arg_113_0._frame ~= var_113_0 then
		arg_113_0._distanceBackup = {}
		arg_113_0._frame = var_113_0
	end

	arg_113_0._distanceBackup[arg_113_1] = arg_113_2
end

function var_0_9.GetDirection(arg_114_0)
	return arg_114_0._dir
end

function var_0_9.SetBornPosition(arg_115_0, arg_115_1)
	arg_115_0._bornPos = arg_115_1
end

function var_0_9.SetPosition(arg_116_0, arg_116_1)
	arg_116_0._move:SetPos(arg_116_1)
end

function var_0_9.IsMoving(arg_117_0)
	local var_117_0 = arg_117_0._move:GetSpeed()

	return var_117_0.x ~= 0 or var_117_0.z ~= 0
end

function var_0_9.SetUncontrollableSpeedWithYAngle(arg_118_0, arg_118_1, arg_118_2, arg_118_3)
	local var_118_0 = math.deg2Rad * arg_118_1
	local var_118_1 = Vector3(math.cos(var_118_0), 0, math.sin(var_118_0))

	arg_118_0:SetUncontrollableSpeed(var_118_1, arg_118_2, arg_118_3)
end

function var_0_9.SetUncontrollableSpeedWithDir(arg_119_0, arg_119_1, arg_119_2, arg_119_3)
	local var_119_0 = math.sqrt(arg_119_1.x * arg_119_1.x + arg_119_1.z * arg_119_1.z)

	arg_119_0:SetUncontrollableSpeed(arg_119_1 / var_119_0, arg_119_2, arg_119_3)
end

function var_0_9.SetUncontrollableSpeed(arg_120_0, arg_120_1, arg_120_2, arg_120_3)
	if not arg_120_2 or not arg_120_3 then
		return
	end

	arg_120_0._move:SetForceMove(arg_120_1, arg_120_2, arg_120_3, arg_120_2 / arg_120_3)
end

function var_0_9.ClearUncontrollableSpeed(arg_121_0)
	arg_121_0._move:ClearForceMove()
end

function var_0_9.SetAdditiveSpeed(arg_122_0, arg_122_1)
	arg_122_0._move:UpdateAdditiveSpeed(arg_122_1)
end

function var_0_9.RemoveAdditiveSpeed(arg_123_0)
	arg_123_0._move:RemoveAdditiveSpeed()
end

function var_0_9.Boost(arg_124_0, arg_124_1, arg_124_2, arg_124_3, arg_124_4, arg_124_5)
	arg_124_0._move:SetForceMove(arg_124_1, arg_124_2, arg_124_3, arg_124_4, arg_124_5)
end

function var_0_9.ActiveUnstoppable(arg_125_0, arg_125_1)
	arg_125_0._move:ActiveUnstoppable(arg_125_1)
end

function var_0_9.SetImmuneCommonBulletCLD(arg_126_0)
	arg_126_0._immuneCommonBulletCLD = true
end

function var_0_9.IsImmuneCommonBulletCLD(arg_127_0)
	return arg_127_0._immuneCommonBulletCLD
end

function var_0_9.SetWeaponPreCastBound(arg_128_0, arg_128_1)
	arg_128_0._preCastBound = arg_128_1

	arg_128_0:UpdatePrecastMoveLimit()
end

function var_0_9.EnterGCD(arg_129_0, arg_129_1, arg_129_2)
	if arg_129_0._GCDTimerList[arg_129_2] ~= nil then
		return
	end

	local function var_129_0()
		arg_129_0:RemoveGCDTimer(arg_129_2)
	end

	arg_129_0._weaponQueue:QueueEnterGCD(arg_129_2, arg_129_1)

	arg_129_0._GCDTimerList[arg_129_2] = pg.TimeMgr.GetInstance():AddBattleTimer("weaponGCD", 0, arg_129_1, var_129_0, true)

	arg_129_0:UpdatePrecastMoveLimit()
end

function var_0_9.RemoveGCDTimer(arg_131_0, arg_131_1)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_131_0._GCDTimerList[arg_131_1])

	arg_131_0._GCDTimerList[arg_131_1] = nil

	arg_131_0:UpdatePrecastMoveLimit()
end

function var_0_9.UpdatePrecastMoveLimit(arg_132_0)
	arg_132_0:UpdateMoveLimit()
end

function var_0_9.UpdateMoveLimit(arg_133_0)
	local var_133_0 = arg_133_0:IsMoveAble()

	arg_133_0._move:SetStaticState(not var_133_0)
end

function var_0_9.AddBuff(arg_134_0, arg_134_1, arg_134_2)
	local var_134_0 = arg_134_1:GetID()
	local var_134_1 = {
		unit_id = arg_134_0._uniqueID,
		buff_id = var_134_0
	}
	local var_134_2 = arg_134_0:GetBuff(var_134_0)

	if var_134_2 then
		if arg_134_2 then
			local var_134_3 = arg_134_0._buffStockList[var_134_0] or {}

			table.insert(var_134_3, arg_134_1)

			arg_134_0._buffStockList[var_134_0] = var_134_3
		else
			local var_134_4 = var_134_2:GetLv()
			local var_134_5 = arg_134_1:GetLv()
			local var_134_6 = var_134_2:GetGroupLevel()
			local var_134_7 = arg_134_1:GetGroupLevel()

			var_134_1.buff_level = math.max(var_134_4, var_134_5)

			if var_134_2:IsForceStack() or var_134_7 <= var_134_6 then
				var_134_2:Stack(arg_134_0)

				var_134_1.stack_count = var_134_2:GetStack()

				arg_134_0:DispatchEvent(var_0_0.Event.New(var_0_2.BUFF_STACK, var_134_1))
			else
				arg_134_0:DispatchEvent(var_0_0.Event.New(var_0_2.BUFF_CAST, var_134_1))
				arg_134_0:RemoveBuff(var_134_0)

				arg_134_0._buffList[var_134_0] = arg_134_1

				arg_134_1:Attach(arg_134_0)
				arg_134_0:DispatchEvent(var_0_0.Event.New(var_0_2.BUFF_ATTACH, var_134_1))
			end
		end
	else
		arg_134_0:DispatchEvent(var_0_0.Event.New(var_0_2.BUFF_CAST, var_134_1))

		arg_134_0._buffList[var_134_0] = arg_134_1

		arg_134_1:Attach(arg_134_0)

		var_134_1.buff_level = arg_134_1:GetLv()

		arg_134_0:DispatchEvent(var_0_0.Event.New(var_0_2.BUFF_ATTACH, var_134_1))
	end

	arg_134_0:TriggerBuff(var_0_3.BuffEffectType.ON_BUFF_ADDED, {
		buffID = var_134_0
	})
end

function var_0_9.SetBuffStack(arg_135_0, arg_135_1, arg_135_2, arg_135_3)
	if arg_135_3 <= 0 then
		arg_135_0:RemoveBuff(arg_135_1)
	else
		local var_135_0 = arg_135_0:GetBuff(arg_135_1)

		if var_135_0 then
			var_135_0:UpdateStack(arg_135_0, arg_135_3)

			return var_135_0
		else
			local var_135_1 = var_0_0.Battle.BattleBuffUnit.New(arg_135_1, arg_135_2)

			arg_135_0:AddBuff(var_135_1)
			var_135_1:UpdateStack(arg_135_0, arg_135_3)

			return var_135_1
		end
	end
end

function var_0_9.UpdateBuff(arg_136_0, arg_136_1)
	local var_136_0 = arg_136_0._buffList

	for iter_136_0, iter_136_1 in pairs(var_136_0) do
		iter_136_1:Update(arg_136_0, arg_136_1)

		if not arg_136_0:IsAlive() then
			break
		end
	end
end

function var_0_9.ConsumeBuffStack(arg_137_0, arg_137_1, arg_137_2)
	local var_137_0 = arg_137_0:GetBuff(arg_137_1)

	if var_137_0 then
		if not arg_137_2 then
			arg_137_0:RemoveBuff(arg_137_1)
		else
			local var_137_1 = var_137_0:GetStack()
			local var_137_2 = math.max(0, var_137_1 - arg_137_2)

			if var_137_2 == 0 then
				arg_137_0:RemoveBuff(arg_137_1)
			else
				var_137_0:UpdateStack(arg_137_0, var_137_2)
			end
		end
	end
end

function var_0_9.RemoveBuff(arg_138_0, arg_138_1, arg_138_2)
	if arg_138_2 and arg_138_0._buffStockList[arg_138_1] then
		local var_138_0 = table.remove(arg_138_0._buffStockList[arg_138_1])

		if var_138_0 then
			var_138_0:Clear()

			return
		end
	end

	local var_138_1 = arg_138_0:GetBuff(arg_138_1)

	if var_138_1 then
		var_138_1:Remove()
	end

	arg_138_0:TriggerBuff(var_0_3.BuffEffectType.ON_BUFF_REMOVED, {
		buffID = arg_138_1
	})
end

function var_0_9.ClearBuff(arg_139_0)
	local var_139_0 = arg_139_0._buffList

	for iter_139_0, iter_139_1 in pairs(var_139_0) do
		iter_139_1:Clear()
	end

	local var_139_1 = arg_139_0._buffStockList

	for iter_139_2, iter_139_3 in pairs(var_139_1) do
		for iter_139_4, iter_139_5 in pairs(iter_139_3) do
			iter_139_5:Clear()
		end
	end
end

function var_0_9.TriggerBuff(arg_140_0, arg_140_1, arg_140_2)
	var_0_0.Battle.BattleBuffUnit.Trigger(arg_140_0, arg_140_1, arg_140_2)
end

function var_0_9.GetBuffList(arg_141_0)
	return arg_141_0._buffList
end

function var_0_9.GetBuff(arg_142_0, arg_142_1)
	arg_142_0._buffList = arg_142_0._buffList

	return arg_142_0._buffList[arg_142_1]
end

function var_0_9.DispatchSkillFloat(arg_143_0, arg_143_1, arg_143_2, arg_143_3)
	local var_143_0 = {
		coverHrzIcon = arg_143_3,
		commander = arg_143_2,
		skillName = arg_143_1
	}

	arg_143_0:DispatchEvent(var_0_0.Event.New(var_0_1.SKILL_FLOAT, var_143_0))
end

function var_0_9.DispatchCutIn(arg_144_0, arg_144_1, arg_144_2)
	local var_144_0 = {
		caster = arg_144_0,
		skill = arg_144_1
	}

	arg_144_0:DispatchEvent(var_0_0.Event.New(var_0_1.CUT_INT, var_144_0))
end

function var_0_9.DispatchCastClock(arg_145_0, arg_145_1, arg_145_2, arg_145_3, arg_145_4, arg_145_5)
	local var_145_0 = {
		isActive = arg_145_1,
		buffEffect = arg_145_2,
		iconType = arg_145_3,
		interrupt = arg_145_4,
		reverse = arg_145_5
	}

	arg_145_0:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_BUFF_CLOCK, var_145_0))
end

function var_0_9.SetAI(arg_146_0, arg_146_1)
	local var_146_0 = var_0_7.GetAITmpDataFromID(arg_146_1)

	arg_146_0._autoPilotAI = var_0_0.Battle.AutoPilot.New(arg_146_0, var_146_0), arg_146_0._move:CancelFormationCtrl()
end

function var_0_9.AddPhaseSwitcher(arg_147_0, arg_147_1)
	arg_147_0._phaseSwitcher = arg_147_1
end

function var_0_9.GetPhaseSwitcher(arg_148_0)
	return arg_148_0._phaseSwitcher
end

function var_0_9.StateChange(arg_149_0, arg_149_1, arg_149_2)
	arg_149_0._unitState:ChangeState(arg_149_1, arg_149_2)
end

function var_0_9.UpdateAction(arg_150_0)
	local var_150_0 = arg_150_0:GetSpeed().x * arg_150_0._IFF

	if arg_150_0._oxyState and arg_150_0._oxyState:GetCurrentDiveState() == var_0_3.OXY_STATE.DIVE then
		if var_150_0 >= 0 then
			arg_150_0._unitState:ChangeState(var_0_8.STATE_DIVE)
		else
			arg_150_0._unitState:ChangeState(var_0_8.STATE_DIVELEFT)
		end
	elseif var_150_0 >= 0 then
		arg_150_0._unitState:ChangeState(var_0_8.STATE_MOVE)
	else
		arg_150_0._unitState:ChangeState(var_0_8.STATE_MOVELEFT)
	end
end

function var_0_9.SetActionKeyOffset(arg_151_0, arg_151_1)
	arg_151_0._actionKeyOffset = arg_151_1

	arg_151_0._unitState:FreshActionKeyOffset()
end

function var_0_9.GetActionKeyOffset(arg_152_0)
	return arg_152_0._actionKeyOffset
end

function var_0_9.GetCurrentState(arg_153_0)
	return arg_153_0._unitState:GetCurrentStateName()
end

function var_0_9.NeedWeaponCache(arg_154_0)
	return arg_154_0._unitState:NeedWeaponCache()
end

function var_0_9.CharacterActionTriggerCallback(arg_155_0)
	arg_155_0._unitState:OnActionTrigger()
end

function var_0_9.CharacterActionEndCallback(arg_156_0)
	arg_156_0._unitState:OnActionEnd()
end

function var_0_9.CharacterActionStartCallback(arg_157_0)
	return
end

function var_0_9.DispatchChat(arg_158_0, arg_158_1, arg_158_2, arg_158_3)
	if not arg_158_1 or #arg_158_1 == 0 then
		return
	end

	local var_158_0 = {
		content = HXSet.hxLan(arg_158_1),
		duration = arg_158_2,
		key = arg_158_3
	}

	arg_158_0:DispatchEvent(var_0_0.Event.New(var_0_1.POP_UP, var_158_0))
end

function var_0_9.DispatchVoice(arg_159_0, arg_159_1)
	local var_159_0 = arg_159_0:GetIntimacy()
	local var_159_1, var_159_2, var_159_3 = ShipWordHelper.GetWordAndCV(arg_159_0:GetSkinID(), arg_159_1, 1, true, var_159_0)

	if var_159_2 then
		local var_159_4 = {
			content = var_159_2,
			key = arg_159_1
		}

		arg_159_0:DispatchEvent(var_0_0.Event.New(var_0_1.VOICE, var_159_4))
	end
end

function var_0_9.GetHostileCldList(arg_160_0)
	return arg_160_0._hostileCldList
end

function var_0_9.AppendHostileCld(arg_161_0, arg_161_1, arg_161_2)
	arg_161_0._hostileCldList[arg_161_1] = arg_161_2
end

function var_0_9.RemoveHostileCld(arg_162_0, arg_162_1)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_162_0._hostileCldList[arg_162_1])

	arg_162_0._hostileCldList[arg_162_1] = nil
end

function var_0_9.GetExtraInfo(arg_163_0)
	return arg_163_0._extraInfo
end

function var_0_9.GetTemplate(arg_164_0)
	return nil
end

function var_0_9.GetTemplateValue(arg_165_0, arg_165_1)
	return arg_165_0:GetTemplate()[arg_165_1]
end

function var_0_9.GetUniqueID(arg_166_0)
	return arg_166_0._uniqueID
end

function var_0_9.SetIFF(arg_167_0, arg_167_1)
	arg_167_0._IFF = arg_167_1

	if arg_167_1 == var_0_5.FRIENDLY_CODE then
		arg_167_0._dir = var_0_3.UnitDir.RIGHT
	elseif arg_167_1 == var_0_5.FOE_CODE then
		arg_167_0._dir = var_0_3.UnitDir.LEFT
	end
end

function var_0_9.GetIFF(arg_168_0)
	return arg_168_0._IFF
end

function var_0_9.GetUnitType(arg_169_0)
	return arg_169_0._type
end

function var_0_9.GetHPRate(arg_170_0)
	return arg_170_0._currentHPRate
end

function var_0_9.GetHP(arg_171_0)
	return arg_171_0._currentHP, arg_171_0:GetMaxHP()
end

function var_0_9.GetCurrentHP(arg_172_0)
	return arg_172_0._currentHP
end

function var_0_9.SetCurrentHP(arg_173_0, arg_173_1)
	arg_173_0._currentHP = arg_173_1
	arg_173_0._currentHPRate = arg_173_0._currentHP / arg_173_0:GetMaxHP()
	arg_173_0._currentDMGRate = 1 - arg_173_0._currentHPRate

	var_0_6.SetCurrent(arg_173_0, "HPRate", arg_173_0._currentHPRate)
	var_0_6.SetCurrent(arg_173_0, "DMGRate", arg_173_0._currentDMGRate)
end

function var_0_9.GetAttr(arg_174_0)
	return var_0_6.GetAttr(arg_174_0)
end

function var_0_9.GetAttrByName(arg_175_0, arg_175_1)
	return var_0_6.GetCurrent(arg_175_0, arg_175_1)
end

function var_0_9.GetMaxHP(arg_176_0)
	return arg_176_0:GetAttrByName("maxHP")
end

function var_0_9.GetReload(arg_177_0)
	return arg_177_0:GetAttrByName("loadSpeed")
end

function var_0_9.GetTorpedoPower(arg_178_0)
	return arg_178_0:GetAttrByName("torpedoPower")
end

function var_0_9.CanDoAntiSub(arg_179_0)
	return arg_179_0:GetAttrByName("antiSubPower") > 0
end

function var_0_9.IsShowHPBar(arg_180_0)
	return false
end

function var_0_9.IsAlive(arg_181_0)
	local var_181_0 = arg_181_0:GetCurrentHP()

	return arg_181_0._aliveState and var_181_0 > 0
end

function var_0_9.SetMainFleetUnit(arg_182_0)
	arg_182_0._isMainFleetUnit = true

	arg_182_0:SetMainUnitStatic(true)
end

function var_0_9.IsMainFleetUnit(arg_183_0)
	return arg_183_0._isMainFleetUnit
end

function var_0_9.SetMainUnitStatic(arg_184_0, arg_184_1)
	arg_184_0._isMainStatic = arg_184_1

	arg_184_0._move:SetStaticState(arg_184_1)
end

function var_0_9.SetMainUnitIndex(arg_185_0, arg_185_1)
	arg_185_0._mainUnitIndex = arg_185_1
end

function var_0_9.GetMainUnitIndex(arg_186_0)
	return arg_186_0._mainUnitIndex or 1
end

function var_0_9.IsMoveAble(arg_187_0)
	local var_187_0 = table.getCount(arg_187_0._GCDTimerList) > 0 or arg_187_0._preCastBound
	local var_187_1 = var_0_6.IsStun(arg_187_0)
	local var_187_2 = arg_187_0:IsMoveCast()

	return not arg_187_0._isMainStatic and (var_187_2 or not var_187_0) and not var_187_1
end

function var_0_9.Reinforce(arg_188_0)
	arg_188_0._isReinforcement = true
end

function var_0_9.IsReinforcement(arg_189_0)
	return arg_189_0._isReinforcement
end

function var_0_9.SetReinforceCastTime(arg_190_0, arg_190_1)
	arg_190_0._reinforceCastTime = arg_190_1
end

function var_0_9.GetReinforceCastTime(arg_191_0)
	return arg_191_0._reinforceCastTime
end

function var_0_9.GetFleetVO(arg_192_0)
	return
end

function var_0_9.SetFormationIndex(arg_193_0, arg_193_1)
	return
end

function var_0_9.SetMaster(arg_194_0)
	return
end

function var_0_9.GetMaster(arg_195_0)
	return nil
end

function var_0_9.IsSpectre(arg_196_0)
	return
end

function var_0_9.Clear(arg_197_0)
	arg_197_0._aliveState = false

	for iter_197_0, iter_197_1 in pairs(arg_197_0._hostileCldList) do
		arg_197_0:RemoveHostileCld(iter_197_0)
	end

	arg_197_0:ClearWeapon()
	arg_197_0:ClearBuff()

	arg_197_0._distanceBackup = {}
end

function var_0_9.Dispose(arg_198_0)
	arg_198_0._exposedList = nil
	arg_198_0._phaseSwitcher = nil

	arg_198_0._weaponQueue:Dispose()

	if arg_198_0._airAssistQueue then
		arg_198_0._airAssistQueue:Clear()

		arg_198_0._airAssistQueue = nil
	end

	arg_198_0._equipmentList = nil
	arg_198_0._totalWeapon = nil

	local var_198_0 = arg_198_0._airAssistList

	if var_198_0 then
		for iter_198_0, iter_198_1 in ipairs(var_198_0) do
			iter_198_1:Dispose()
		end
	end

	for iter_198_2, iter_198_3 in ipairs(arg_198_0._fleetAAList) do
		iter_198_3:Dispose()
	end

	for iter_198_4, iter_198_5 in ipairs(arg_198_0._fleetRangeAAList) do
		iter_198_5:Dispose()
	end

	local var_198_1 = arg_198_0._buffList

	for iter_198_6, iter_198_7 in pairs(var_198_1) do
		iter_198_7:Dispose()
	end

	local var_198_2 = arg_198_0._buffStockList

	for iter_198_8, iter_198_9 in pairs(var_198_2) do
		for iter_198_10, iter_198_11 in pairs(iter_198_9) do
			iter_198_11:Clear()
		end
	end

	arg_198_0._fleetRangeAA = nil
	arg_198_0._aimBias = nil
	arg_198_0._buffList = nil
	arg_198_0._buffStockList = nil
	arg_198_0._cldZCenterCache = nil
	arg_198_0._remoteBoundBone = nil

	arg_198_0:RemoveSummonSickness()
	var_0_0.EventDispatcher.DetachEventDispatcher(arg_198_0)
end

function var_0_9.InitCldComponent(arg_199_0)
	local var_199_0 = arg_199_0:GetTemplate().cld_box
	local var_199_1 = arg_199_0:GetTemplate().cld_offset
	local var_199_2 = var_199_1[1]

	if arg_199_0:GetDirection() == var_0_3.UnitDir.LEFT then
		var_199_2 = var_199_2 * -1
	end

	arg_199_0._cldComponent = var_0_0.Battle.BattleCubeCldComponent.New(var_199_0[1], var_199_0[2], var_199_0[3], var_199_2, var_199_1[3] + var_199_0[3] / 2)
end

function var_0_9.GetBoxSize(arg_200_0)
	return arg_200_0._cldComponent:GetCldBoxSize()
end

function var_0_9.GetCldBox(arg_201_0)
	return arg_201_0._cldComponent:GetCldBox(arg_201_0:GetPosition())
end

function var_0_9.GetCldData(arg_202_0)
	return arg_202_0._cldComponent:GetCldData()
end

function var_0_9.ShiftCldComponent(arg_203_0, arg_203_1, arg_203_2)
	arg_203_0:updateCldComponet(arg_203_1, arg_203_2)
end

function var_0_9.ResetCldComponent(arg_204_0)
	local var_204_0 = arg_204_0:GetTemplate().cld_box
	local var_204_1 = arg_204_0:GetTemplate().cld_offset

	arg_204_0:updateCldComponet(var_204_0, var_204_1)
end

function var_0_9.updateCldComponet(arg_205_0, arg_205_1, arg_205_2)
	local var_205_0 = arg_205_2[1]

	if arg_205_0:GetDirection() == var_0_3.UnitDir.LEFT then
		var_205_0 = var_205_0 * -1
	end

	arg_205_0._cldComponent:ResetOffset(var_205_0, arg_205_2[3] + arg_205_1[3] / 2)
	arg_205_0._cldComponent:ResetSize(arg_205_1[1], arg_205_1[2], arg_205_1[3])
end

function var_0_9.InitOxygen(arg_206_0)
	arg_206_0._maxOxy = arg_206_0:GetAttrByName("oxyMax")
	arg_206_0._currentOxy = arg_206_0:GetAttrByName("oxyMax")
	arg_206_0._oxyRecovery = arg_206_0:GetAttrByName("oxyRecovery")
	arg_206_0._oxyRecoveryBench = arg_206_0:GetAttrByName("oxyRecoveryBench")
	arg_206_0._oxyRecoverySurface = arg_206_0:GetAttrByName("oxyRecoverySurface")
	arg_206_0._oxyConsume = arg_206_0:GetAttrByName("oxyCost")
	arg_206_0._oxyState = var_0_0.Battle.OxyState.New(arg_206_0)

	arg_206_0._oxyState:OnDiveState()
	arg_206_0:ConfigBubbleFX()

	return arg_206_0._oxyState
end

function var_0_9.UpdateOxygen(arg_207_0, arg_207_1)
	if arg_207_0._oxyState then
		arg_207_0._lastOxyUpdateStamp = arg_207_0._lastOxyUpdateStamp or arg_207_1

		arg_207_0._oxyState:UpdateOxygen()

		if arg_207_0._oxyState:GetNextBubbleStamp() and arg_207_1 > arg_207_0._oxyState:GetNextBubbleStamp() then
			arg_207_0._oxyState:FlashBubbleStamp(arg_207_1)
			arg_207_0:PlayFX(arg_207_0._bubbleFX, true)
		end

		arg_207_0._lastOxyUpdateStamp = arg_207_1

		arg_207_0:updateSonarExposeTag()
	end
end

function var_0_9.OxyRecover(arg_208_0, arg_208_1)
	local var_208_0

	if arg_208_1 == var_0_0.Battle.OxyState.STATE_FREE_BENCH then
		var_208_0 = arg_208_0._oxyRecoveryBench
	elseif arg_208_1 == var_0_0.Battle.OxyState.STATE_FREE_FLOAT then
		var_208_0 = arg_208_0._oxyRecovery
	else
		var_208_0 = arg_208_0._oxyRecoverySurface
	end

	local var_208_1 = pg.TimeMgr.GetInstance():GetCombatTime() - arg_208_0._lastOxyUpdateStamp

	arg_208_0._currentOxy = math.min(arg_208_0._maxOxy, arg_208_0._currentOxy + var_208_0 * var_208_1)
end

function var_0_9.OxyConsume(arg_209_0)
	local var_209_0 = pg.TimeMgr.GetInstance():GetCombatTime() - arg_209_0._lastOxyUpdateStamp

	arg_209_0._currentOxy = math.max(0, arg_209_0._currentOxy - arg_209_0._oxyConsume * var_209_0)
end

function var_0_9.ChangeOxygenState(arg_210_0, arg_210_1)
	arg_210_0._oxyState:ChangeState(arg_210_1)
end

function var_0_9.ChangeWeaponDiveState(arg_211_0)
	for iter_211_0, iter_211_1 in ipairs(arg_211_0._autoWeaponList) do
		iter_211_1:ChangeDiveState()
	end
end

function var_0_9.GetOxygenProgress(arg_212_0)
	return arg_212_0._currentOxy / arg_212_0._maxOxy
end

function var_0_9.GetCuurentOxygen(arg_213_0)
	return arg_213_0._currentOxy or 0
end

function var_0_9.ConfigBubbleFX(arg_214_0)
	return
end

function var_0_9.SetDiveInvisible(arg_215_0, arg_215_1)
	arg_215_0._diveInvisible = arg_215_1

	arg_215_0:DispatchEvent(var_0_0.Event.New(var_0_1.SUBMARINE_VISIBLE))
	arg_215_0:DispatchEvent(var_0_0.Event.New(var_0_1.SUBMARINE_DETECTED))
	arg_215_0:dispatchDetectedTrigger()
end

function var_0_9.GetDiveInvisible(arg_216_0)
	return arg_216_0._diveInvisible
end

function var_0_9.GetOxygenVisible(arg_217_0)
	return arg_217_0._oxyState and arg_217_0._oxyState:GetBarVisible()
end

function var_0_9.SetForceVisible(arg_218_0)
	arg_218_0:DispatchEvent(var_0_0.Event.New(var_0_1.SUBMARINE_FORCE_DETECTED))
end

function var_0_9.Detected(arg_219_0, arg_219_1)
	local var_219_0

	if arg_219_0._exposedToSnoar == false and not arg_219_0._exposedOverTimeStamp then
		var_219_0 = true
	end

	if arg_219_1 then
		arg_219_0:updateExposeTimeStamp(arg_219_1)
	else
		arg_219_0._exposedToSnoar = true
	end

	if var_219_0 then
		arg_219_0:DispatchEvent(var_0_0.Event.New(var_0_1.SUBMARINE_DETECTED, {}))
		arg_219_0:dispatchDetectedTrigger()
	end
end

function var_0_9.Undetected(arg_220_0)
	arg_220_0._exposedToSnoar = false

	arg_220_0:updateExposeTimeStamp(var_0_5.SUB_EXPOSE_LASTING_DURATION)
end

function var_0_9.RemoveSonarExpose(arg_221_0)
	arg_221_0._exposedToSnoar = false
	arg_221_0._exposedOverTimeStamp = nil
end

function var_0_9.updateSonarExposeTag(arg_222_0)
	if arg_222_0._exposedOverTimeStamp and not arg_222_0._exposedToSnoar and pg.TimeMgr.GetInstance():GetCombatTime() > arg_222_0._exposedOverTimeStamp then
		arg_222_0._exposedOverTimeStamp = nil

		arg_222_0:DispatchEvent(var_0_0.Event.New(var_0_1.SUBMARINE_DETECTED, {
			detected = false
		}))
		arg_222_0:dispatchDetectedTrigger()
	end
end

function var_0_9.updateExposeTimeStamp(arg_223_0, arg_223_1)
	local var_223_0 = pg.TimeMgr.GetInstance():GetCombatTime() + arg_223_1

	arg_223_0._exposedOverTimeStamp = arg_223_0._exposedOverTimeStamp or 0
	arg_223_0._exposedOverTimeStamp = var_223_0 < arg_223_0._exposedOverTimeStamp and arg_223_0._exposedOverTimeStamp or var_223_0
end

function var_0_9.IsRunMode(arg_224_0)
	return arg_224_0._oxyState and arg_224_0._oxyState:GetRundMode()
end

function var_0_9.GetDiveDetected(arg_225_0)
	return arg_225_0:GetDiveInvisible() and (arg_225_0._exposedOverTimeStamp or arg_225_0._exposedToSnoar)
end

function var_0_9.GetForceExpose(arg_226_0)
	return arg_226_0._oxyState and arg_226_0._oxyState:GetForceExpose()
end

function var_0_9.dispatchDetectedTrigger(arg_227_0)
	if arg_227_0:GetDiveDetected() then
		arg_227_0:TriggerBuff(var_0_3.BuffEffectType.ON_SUB_DETECTED, {})
	else
		arg_227_0:TriggerBuff(var_0_3.BuffEffectType.ON_SUB_UNDETECTED, {})
	end
end

function var_0_9.GetRaidDuration(arg_228_0)
	return arg_228_0:GetAttrByName("oxyMax") / arg_228_0:GetAttrByName("oxyCost")
end

function var_0_9.EnterRaidRange(arg_229_0)
	if arg_229_0:GetPosition().x > arg_229_0._subRaidLine then
		return true
	else
		return false
	end
end

function var_0_9.EnterRetreatRange(arg_230_0)
	if arg_230_0:GetPosition().x < arg_230_0._subRetreatLine then
		return true
	else
		return false
	end
end

function var_0_9.GetOxyState(arg_231_0)
	return arg_231_0._oxyState
end

function var_0_9.GetCurrentOxyState(arg_232_0)
	if not arg_232_0._oxyState then
		return var_0_3.OXY_STATE.FLOAT
	else
		return arg_232_0._oxyState:GetCurrentDiveState()
	end
end

function var_0_9.InitAntiSubState(arg_233_0, arg_233_1, arg_233_2)
	arg_233_0._antiSubVigilanceState = var_0_0.Battle.AntiSubState.New(arg_233_0)

	arg_233_0:DispatchEvent(var_0_0.Event.New(var_0_1.INIT_ANIT_SUB_VIGILANCE, {
		sonarRange = arg_233_1
	}))

	return arg_233_0._antiSubVigilanceState
end

function var_0_9.GetAntiSubState(arg_234_0)
	return arg_234_0._antiSubVigilanceState
end

function var_0_9.UpdateBlindInvisibleBySpectre(arg_235_0)
	local var_235_0, var_235_1 = arg_235_0:IsSpectre()

	if var_235_1 <= var_0_5.SPECTRE_UNIT_TYPE and var_235_1 ~= var_0_5.VISIBLE_SPECTRE_UNIT_TYPE then
		arg_235_0:SetBlindInvisible(true)
	else
		arg_235_0:SetBlindInvisible(false)
	end
end

function var_0_9.SetBlindInvisible(arg_236_0, arg_236_1)
	arg_236_0._exposedList = arg_236_1 and {} or nil
	arg_236_0._blindInvisible = arg_236_1

	arg_236_0:DispatchEvent(var_0_0.Event.New(var_0_1.BLIND_VISIBLE))
end

function var_0_9.GetBlindInvisible(arg_237_0)
	return arg_237_0._blindInvisible
end

function var_0_9.GetExposed(arg_238_0)
	if not arg_238_0._blindInvisible then
		return true
	end

	for iter_238_0, iter_238_1 in pairs(arg_238_0._exposedList) do
		return true
	end
end

function var_0_9.AppendExposed(arg_239_0, arg_239_1)
	if not arg_239_0._blindInvisible then
		return
	end

	local var_239_0 = arg_239_0._exposedList[arg_239_1]

	arg_239_0._exposedList[arg_239_1] = true

	if not var_239_0 then
		arg_239_0:DispatchEvent(var_0_0.Event.New(var_0_1.BLIND_EXPOSE))
	end
end

function var_0_9.RemoveExposed(arg_240_0, arg_240_1)
	if not arg_240_0._blindInvisible then
		return
	end

	arg_240_0._exposedList[arg_240_1] = nil

	arg_240_0:DispatchEvent(var_0_0.Event.New(var_0_1.BLIND_EXPOSE))
end

function var_0_9.SetWorldDeathMark(arg_241_0)
	arg_241_0._worldDeathMark = true
end

function var_0_9.GetWorldDeathMark(arg_242_0)
	return arg_242_0._worldDeathMark
end

function var_0_9.InitCloak(arg_243_0)
	arg_243_0._cloak = var_0_0.Battle.BattleUnitCloakComponent.New(arg_243_0)

	arg_243_0:DispatchEvent(var_0_0.Event.New(var_0_1.INIT_CLOAK))

	return arg_243_0._cloak
end

function var_0_9.CloakOnFire(arg_244_0, arg_244_1)
	if arg_244_0._cloak then
		arg_244_0._cloak:UpdateDotExpose(arg_244_1)
	end
end

function var_0_9.CloakExpose(arg_245_0, arg_245_1)
	if arg_245_0._cloak then
		arg_245_0._cloak:AppendExpose(arg_245_1)
	end
end

function var_0_9.StrikeExpose(arg_246_0)
	if arg_246_0._cloak then
		arg_246_0._cloak:AppendStrikeExpose()
	end
end

function var_0_9.BombardExpose(arg_247_0)
	if arg_247_0._cloak then
		arg_247_0._cloak:AppendBombardExpose()
	end
end

function var_0_9.UpdateCloak(arg_248_0, arg_248_1)
	arg_248_0._cloak:Update(arg_248_1)
end

function var_0_9.UpdateCloakConfig(arg_249_0)
	if arg_249_0._cloak then
		arg_249_0._cloak:UpdateCloakConfig()
		arg_249_0:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_CLOAK_CONFIG))
	end
end

function var_0_9.DispatchCloakStateUpdate(arg_250_0)
	if arg_250_0._cloak then
		arg_250_0:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_CLOAK_STATE))
	end
end

function var_0_9.GetCloak(arg_251_0)
	return arg_251_0._cloak
end

function var_0_9.AttachAimBias(arg_252_0, arg_252_1)
	arg_252_0._aimBias = arg_252_1

	arg_252_0:DispatchEvent(var_0_0.Event.New(var_0_1.INIT_AIMBIAS))
end

function var_0_9.DetachAimBias(arg_253_0)
	arg_253_0:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_AIMBIAS))
	arg_253_0._aimBias:RemoveCrew(arg_253_0)

	arg_253_0._aimBias = nil
end

function var_0_9.ExitSmokeArea(arg_254_0)
	arg_254_0._aimBias:SmokeExitPause()
end

function var_0_9.UpdateAimBiasSkillState(arg_255_0)
	if arg_255_0._aimBias and arg_255_0._aimBias:GetHost() == arg_255_0 then
		arg_255_0._aimBias:UpdateSkillLock()
	end
end

function var_0_9.HostAimBias(arg_256_0)
	if arg_256_0._aimBias then
		arg_256_0:DispatchEvent(var_0_0.Event.New(var_0_1.HOST_AIMBIAS))
	end
end

function var_0_9.GetAimBias(arg_257_0)
	return arg_257_0._aimBias
end

function var_0_9.SwitchSpine(arg_258_0, arg_258_1, arg_258_2)
	arg_258_0:DispatchEvent(var_0_0.Event.New(var_0_1.SWITCH_SPINE, {
		skin = arg_258_1,
		HPBarOffset = arg_258_2
	}))
end

function var_0_9.Freeze(arg_259_0)
	for iter_259_0, iter_259_1 in ipairs(arg_259_0._totalWeapon) do
		iter_259_1:StartJamming()
	end

	if arg_259_0._airAssistList then
		for iter_259_2, iter_259_3 in ipairs(arg_259_0._airAssistList) do
			iter_259_3:StartJamming()
		end
	end
end

function var_0_9.ActiveFreeze(arg_260_0)
	for iter_260_0, iter_260_1 in ipairs(arg_260_0._totalWeapon) do
		iter_260_1:JammingEliminate()
	end

	if arg_260_0._airAssistList then
		for iter_260_2, iter_260_3 in ipairs(arg_260_0._airAssistList) do
			iter_260_3:JammingEliminate()
		end
	end
end

function var_0_9.ActiveWeaponSectorView(arg_261_0, arg_261_1, arg_261_2)
	local var_261_0 = {
		weapon = arg_261_1,
		isActive = arg_261_2
	}

	arg_261_0:DispatchEvent(var_0_0.Event.New(var_0_1.WEAPON_SECTOR, var_261_0))
end
