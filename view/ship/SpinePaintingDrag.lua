local var_0_0 = class("SpinePaintingDrag")
local var_0_1 = "spine_painting_idle_init_"

function var_0_0.SetPaintingInitIdle(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_1 .. tostring(arg_1_0) .. tostring(arg_1_1)

	PlayerPrefs.SetString(var_1_0, arg_1_2)
end

function var_0_0.GetPaintingInitIdle(arg_2_0, arg_2_1)
	local var_2_0 = var_0_1 .. tostring(arg_2_0) .. tostring(arg_2_1)
	local var_2_1 = PlayerPrefs.GetString(var_2_0)

	if var_2_1 and #var_2_1 > 0 then
		return var_2_1
	end

	return nil
end

return var_0_0
