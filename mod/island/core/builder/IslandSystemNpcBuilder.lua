local var_0_0 = class("IslandSystemNpcBuilder", import(".IslandNpcBuilder"))

function var_0_0.GetModule(arg_1_0, arg_1_1, arg_1_2)
	return IslandSystemNpcUnit.New(arg_1_1, arg_1_2)
end

return var_0_0
