local var_0_0 = class("CastStep", import(".StoryStep"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.layout = arg_1_1.layout
	arg_1_0.time = arg_1_1.time or 5
	arg_1_0.spacing = arg_1_1.spacing or 35
end

function var_0_0.GetMode(arg_2_0)
	return Story.MODE_CAST
end

function var_0_0.DataToLayout(arg_3_0, arg_3_1)
	if arg_3_1[1] == var_0_1 then
		return {
			type = var_0_1,
			text = arg_3_1[2]
		}
	elseif arg_3_1[1] == var_0_2 then
		local var_3_0 = Vector2(arg_3_1[3] or 0, arg_3_1[4] or 0)

		return {
			type = var_0_2,
			path = arg_3_1[2],
			size = var_3_0
		}
	elseif arg_3_1[1] == var_0_3 then
		local var_3_1 = {}
		local var_3_2 = arg_3_1[2]
		local var_3_3 = arg_3_0:ShouldReplacePlayer()

		for iter_3_0 = 1, #var_3_2 do
			local var_3_4 = var_3_2[iter_3_0]

			if var_3_3 then
				var_3_4 = arg_3_0:ReplacePlayerName(var_3_4)
			end

			local var_3_5 = HXSet.hxLan(var_3_4)

			table.insert(var_3_1, var_3_5)
		end

		return {
			type = var_0_3,
			names = var_3_1,
			column = arg_3_1[3] or 2,
			evenColumnColor = arg_3_1[4] or "#c2c2c2"
		}
	elseif arg_3_1[1] == var_0_4 then
		return {
			type = var_0_4
		}
	end
end

function var_0_0.GetLayout(arg_4_0)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.layout or {}) do
		local var_4_1 = arg_4_0:DataToLayout(iter_4_1)

		table.insert(var_4_0, var_4_1)
	end

	return var_4_0
end

function var_0_0.GetSpacing(arg_5_0)
	return arg_5_0.spacing
end

function var_0_0.GetPlayTime(arg_6_0)
	return arg_6_0.time
end

return var_0_0
