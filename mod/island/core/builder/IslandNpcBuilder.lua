local var_0_0 = class("IslandNpcBuilder", import(".IslandUnitBuilder"))

function var_0_0.GetModule(arg_1_0, arg_1_1, arg_1_2)
	return IslandNpcUnit.New(arg_1_1, arg_1_2)
end

function var_0_0.SetTag(arg_2_0, arg_2_1)
	arg_2_1.tag = IslandConst.TAG_NPC
end

function var_0_0.AddComponents(arg_3_0, arg_3_1)
	local var_3_0 = GetOrAddComponent(arg_3_1, typeof(CharacterController))

	var_3_0.slopeLimit = 50
	var_3_0.stepOffset = 0.3
	var_3_0.stepOffset = 0.08
	var_3_0.minMoveDistance = 0
	var_3_0.height = 1.76
	var_3_0.stepOffset = 0.4
	var_3_0.center = Vector3(0, 0.96, 0)
end

return var_0_0
