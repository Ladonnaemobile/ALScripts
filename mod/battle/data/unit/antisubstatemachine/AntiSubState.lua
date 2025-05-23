ys = ys or {}

local var_0_0 = ys
local var_0_1 = var_0_0.Battle.BattleConst.ActionName

var_0_0.Battle.AntiSubState = class("AntiSubState")
var_0_0.Battle.AntiSubState.__name = "AntiSubState"

local var_0_2 = var_0_0.Battle.AntiSubState

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._client = arg_1_1
	arg_1_0._calmState = var_0_0.Battle.CalmAntiSubState.New()
	arg_1_0._suspiciousState = var_0_0.Battle.SuspiciousAntiSubState.New()
	arg_1_0._vigilantState = var_0_0.Battle.VigilantAntiSubState.New()
	arg_1_0._engageState = var_0_0.Battle.EngageAntiSubState.New()
	arg_1_0._currentState = arg_1_0._calmState
	arg_1_0._vigilantValue = 0
	arg_1_0._vigilantDecayTimeStamp = nil
	arg_1_0._decayFlag = false
	arg_1_0._engageRage = false
	arg_1_0._lastSonarDected = false
end

function var_0_2.Update(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 > 0 and arg_2_0:checkDecayRage() then
		arg_2_0:OnEngageState()
	end

	if arg_2_1 + arg_2_2 > 0 then
		arg_2_0:resetVigilantDecay()
	end

	local var_2_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	if arg_2_0._vigilantDecayTimeStamp then
		arg_2_0:updateVigilantDecay(var_2_0)
	elseif arg_2_0._currentState:CanDecay() and arg_2_1 + arg_2_2 == 0 then
		arg_2_0._vigilantDecayTimeStamp = var_2_0
	end

	local var_2_1 = arg_2_0._currentState:GetMeterSpeed()

	if arg_2_0._decayFlag then
		var_2_1 = math.min(0, var_2_1)
	end

	arg_2_0._vigilantValue = math.clamp(arg_2_0._vigilantValue + var_2_1, 0, 100)

	if arg_2_0._vigilantValue >= 100 and arg_2_0._currentState ~= arg_2_0._engageState then
		arg_2_0:OnEngageState()
	end
end

function var_0_2.updateVigilantDecay(arg_3_0, arg_3_1)
	if arg_3_1 - arg_3_0._vigilantDecayTimeStamp >= arg_3_0._currentState:DecayDuration() then
		arg_3_0._vigilantValue = arg_3_0._vigilantValue - 0.01

		arg_3_0._currentState:ToPreLevel(arg_3_0)

		arg_3_0._decayFlag = true
	end
end

function var_0_2.resetVigilantDecay(arg_4_0)
	arg_4_0._vigilantDecayTimeStamp = nil
	arg_4_0._decayFlag = false
end

function var_0_2.checkDecayRage(arg_5_0)
	return arg_5_0._vigilantDecayTimeStamp and arg_5_0._engageRage
end

function var_0_2.HateChain(arg_6_0)
	arg_6_0:resetVigilantDecay()
	arg_6_0._currentState:OnHateChain(arg_6_0)
end

function var_0_2.InitCheck(arg_7_0, arg_7_1)
	if arg_7_1 > 0 then
		arg_7_0:SubmarineFloat()
	end
end

function var_0_2.MineExplode(arg_8_0)
	if arg_8_0:checkDecayRage() then
		arg_8_0:OnEngageState()

		return
	end

	arg_8_0:resetVigilantDecay()
	arg_8_0._currentState:OnMineExplode(arg_8_0)
end

function var_0_2.SubmarineFloat(arg_9_0)
	if arg_9_0:checkDecayRage() then
		arg_9_0:OnEngageState()

		return
	end

	arg_9_0:resetVigilantDecay()
	arg_9_0._currentState:OnSubmarinFloat(arg_9_0)
end

function var_0_2.VigilantAreaEngage(arg_10_0)
	arg_10_0:resetVigilantDecay()
	arg_10_0._currentState:OnVigilantEngage(arg_10_0)
end

function var_0_2.SonarDetect(arg_11_0, arg_11_1)
	arg_11_0:DispatchSonarCheck()

	local var_11_0 = arg_11_1 > 0

	if arg_11_0._lastSonarDected and var_11_0 then
		arg_11_0:OnEngageState()
	elseif var_11_0 then
		arg_11_0:OnVigilantState()
	end

	arg_11_0._lastSonarDected = var_11_0
end

function var_0_2.OnCalmState(arg_12_0)
	arg_12_0:resetVigilantDecay()

	arg_12_0._currentState = arg_12_0._calmState
	arg_12_0._engageRage = false

	arg_12_0:DispatchStateChange()
end

function var_0_2.OnSuspiciousState(arg_13_0)
	arg_13_0:resetVigilantDecay()

	arg_13_0._currentState = arg_13_0._suspiciousState

	arg_13_0:DispatchStateChange()
end

function var_0_2.OnVigilantState(arg_14_0)
	arg_14_0:resetVigilantDecay()

	arg_14_0._currentState = arg_14_0._vigilantState

	arg_14_0:DispatchStateChange()
end

function var_0_2.OnEngageState(arg_15_0, arg_15_1)
	arg_15_0:resetVigilantDecay()

	arg_15_0._currentState = arg_15_0._engageState
	arg_15_0._engageRage = true

	arg_15_0:DispatchStateChange()

	if not arg_15_1 then
		arg_15_0:DispatchHateChain()
	end
end

function var_0_2.IsWeaponUseable(arg_16_0)
	return #arg_16_0._currentState:GetWeaponUseable() > 0
end

function var_0_2.GetVigilantRate(arg_17_0)
	return arg_17_0._vigilantValue * 0.01
end

function var_0_2.DispatchStateChange(arg_18_0)
	local var_18_0 = var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CHANGE_ANTI_SUB_VIGILANCE)

	arg_18_0._client:DispatchEvent(var_18_0)
end

function var_0_2.DispatchSonarCheck(arg_19_0)
	local var_19_0 = var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ANTI_SUB_VIGILANCE_SONAR_CHECK)

	arg_19_0._client:DispatchEvent(var_19_0)
end

function var_0_2.DispatchHateChain(arg_20_0)
	local var_20_0 = var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ANTI_SUB_VIGILANCE_HATE_CHAIN)

	arg_20_0._client:DispatchEvent(var_20_0)
end

function var_0_2.GetVigilantMark(arg_21_0)
	return arg_21_0._currentState:GetWarnMark()
end
