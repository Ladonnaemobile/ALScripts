local var_0_0 = class("IslandRoleDelegationReward")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0:UpdateData(arg_1_1)
end

function var_0_0.UpdateData(arg_2_0, arg_2_1)
	arg_2_0.formula_id = arg_2_1.formula_id
	arg_2_0.formula_drop_list = arg_2_1.formula_drop_list
end

function var_0_0.GetState(arg_3_0)
	return
end

return var_0_0
