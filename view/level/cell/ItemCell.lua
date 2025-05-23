local var_0_0 = class("ItemCell", import("view.level.cell.LevelCellView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_0.go.transform
	arg_1_0.line = {
		row = arg_1_2,
		column = arg_1_3
	}
	arg_1_0.assetName = nil

	arg_1_0:OverrideCanvas()
	arg_1_0:ResetCanvasOrder()
end

function var_0_0.Init(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	arg_2_0.info = CreateShell(arg_2_1)
end

function var_0_0.GetInfo(arg_3_0)
	return arg_3_0.info
end

function var_0_0.GetOriginalInfo(arg_4_0)
	local var_4_0 = arg_4_0.info and getmetatable(arg_4_0.info)

	return var_4_0 and var_4_0.__index
end

function var_0_0.Update(arg_5_0)
	local var_5_0 = arg_5_0.info

	arg_5_0.loader:GetPrefabBYStopLoading("chapter/" .. var_5_0.item, var_5_0.item, function(arg_6_0)
		local var_6_0 = arg_6_0.transform

		var_6_0.name = var_5_0.item

		var_6_0:SetParent(arg_5_0.go, false)

		var_6_0.anchoredPosition3D = var_5_0.itemOffset

		arg_5_0:RecordCanvasOrder(var_6_0)
		arg_5_0:AddCanvasOrder(var_6_0, arg_5_0:GetCurrentOrder())
	end, "ChapterItem" .. arg_5_0.line.row .. "_" .. arg_5_0.line.column)
end

function var_0_0.UpdateAsset(arg_7_0, arg_7_1)
	if not arg_7_0.info or not arg_7_1 or arg_7_1 == rawget(arg_7_0.info, "item") then
		return
	end

	arg_7_0.info.item = arg_7_1

	arg_7_0:Update()
end

function var_0_0.ClearLoader(arg_8_0)
	return
end

function var_0_0.Clear(arg_9_0)
	arg_9_0.loader:ClearRequest("ChapterItem" .. arg_9_0.line.row .. "_" .. arg_9_0.line.column)
	var_0_0.super.Clear(arg_9_0)
end

function var_0_0.TransformItemAsset(arg_10_0, arg_10_1)
	if type(arg_10_1) ~= "string" then
		return
	end

	local var_10_0 = arg_10_0:getConfig("ItemTransformPattern")

	if type(var_10_0) ~= "table" then
		return arg_10_1
	end

	_.each(arg_10_0:getExtraFlags(), function(arg_11_0)
		if var_10_0[arg_11_0] and (function()
			local var_12_0 = var_10_0[arg_11_0][3]

			if not var_12_0 then
				return true
			end

			return var_12_0 >= math.random()
		end)() then
			arg_10_1 = string.gsub(arg_10_1, var_10_0[arg_11_0][1], var_10_0[arg_11_0][2])
		end
	end)

	return arg_10_1
end

return var_0_0
