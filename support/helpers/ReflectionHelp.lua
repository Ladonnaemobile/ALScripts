local var_0_0 = {}
local var_0_1 = System.Reflection.BindingFlags
local var_0_2 = bit.bor(var_0_1.Instance, var_0_1.Public, var_0_1.NonPublic, var_0_1.FlattenHierarchy, var_0_1.Static)

function var_0_0.RefCallStaticMethod(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0
	local var_1_1

	if arg_1_2 then
		var_1_0 = tolua.gettypemethod(arg_1_0, arg_1_1, var_0_2, Type.DefaultBinder, arg_1_2, {})
		var_1_1 = var_1_0:Call(unpack(arg_1_3))
	else
		var_1_0 = tolua.gettypemethod(arg_1_0, arg_1_1, var_0_2)
		var_1_1 = var_1_0:Call()
	end

	var_1_0:Destroy()

	return var_1_1
end

function var_0_0.RefCallStaticMethodEx(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0
	local var_2_1
	local var_2_2 = tolua.gettypemethod(arg_2_0, arg_2_1, arg_2_2)
	local var_2_3 = var_2_2:Call(unpack(arg_2_3))

	var_2_2:Destroy()

	return var_2_3
end

function var_0_0.RefCallMethod(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0
	local var_3_1

	if arg_3_3 then
		var_3_0 = tolua.gettypemethod(arg_3_0, arg_3_1, var_0_2, Type.DefaultBinder, arg_3_3, {})
		var_3_1 = var_3_0:Call(arg_3_2, unpack(arg_3_4))
	else
		var_3_0 = tolua.gettypemethod(arg_3_0, arg_3_1, var_0_2)
		var_3_1 = var_3_0:Call(arg_3_2)
	end

	var_3_0:Destroy()

	return var_3_1
end

function var_0_0.RefCallMethodEx(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0
	local var_4_1
	local var_4_2 = tolua.gettypemethod(arg_4_0, arg_4_1, arg_4_3)
	local var_4_3 = var_4_2:Call(arg_4_2, unpack(arg_4_4))

	var_4_2:Destroy()

	return var_4_3
end

function var_0_0.RefGetField(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = tolua.getfield(arg_5_0, arg_5_1, var_0_2)
	local var_5_1 = var_5_0:Get(arg_5_2)

	var_5_0:Destroy()

	return var_5_1
end

function var_0_0.RefSetField(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = tolua.getfield(arg_6_0, arg_6_1, var_0_2)

	var_6_0:Set(arg_6_2, arg_6_3)
	var_6_0:Destroy()
end

function var_0_0.RefGetProperty(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = tolua.getproperty(arg_7_0, arg_7_1, var_0_2)
	local var_7_1 = var_7_0:Get(arg_7_2, null)

	var_7_0:Destroy()

	return var_7_1
end

function var_0_0.RefSetProperty(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = tolua.getproperty(arg_8_0, arg_8_1, var_0_2)

	var_8_0:Set(arg_8_2, arg_8_3, null)
	var_8_0:Destroy()
end

return var_0_0
