ys = ys or {}

local var_0_0 = ys

var_0_0.Battle.BattleLockTag = class("BattleLockTag")
var_0_0.Battle.BattleLockTag.__name = "BattleLockTag"

local var_0_1 = var_0_0.Battle.BattleLockTag

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._markGO = arg_1_1
	arg_1_0._markTF = arg_1_1.transform
	arg_1_0._controller = arg_1_0._markTF:GetComponent("LockTag")
	arg_1_0._flag = true
end

function var_0_1.Mark(arg_2_0, arg_2_1)
	arg_2_0._markTime = pg.TimeMgr.GetInstance():GetCombatTime()
	arg_2_0._requiredTime = arg_2_1

	SetActive(arg_2_0._markGO, true)

	arg_2_0._controller.enabled = true
end

function var_0_1.Update(arg_3_0, arg_3_1)
	local var_3_0 = (arg_3_1 - arg_3_0._markTime) / arg_3_0._requiredTime

	if var_3_0 >= 1 and arg_3_0._flag then
		arg_3_0._controller:SetRate(1)

		arg_3_0._controller.enabled = false
		arg_3_0._markTF:GetComponent(typeof(Animator)).enabled = true
		arg_3_0._flag = false
	elseif arg_3_0._flag then
		arg_3_0._controller:SetRate(var_3_0)
	end
end

function var_0_1.SetPosition(arg_4_0, arg_4_1)
	arg_4_0._markTF.position = arg_4_1
end

function var_0_1.SetTagCount(arg_5_0, arg_5_1)
	arg_5_0._controller.count = arg_5_1
end

function var_0_1.Dispose(arg_6_0)
	Object.Destroy(arg_6_0._markGO)
end
