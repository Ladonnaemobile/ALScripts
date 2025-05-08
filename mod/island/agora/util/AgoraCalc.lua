local var_0_0 = class("AgoraCalc")

function var_0_0.GetSizeCoord(arg_1_0)
	local var_1_0 = (arg_1_0.x - 1) / 2
	local var_1_1 = (arg_1_0.y - 1) / 2
	local var_1_2 = math.ceil(var_1_0)
	local var_1_3 = math.floor(var_1_0) * -1
	local var_1_4 = math.ceil(var_1_1)
	local var_1_5 = math.floor(var_1_1) * -1

	return Vector4(var_1_3, var_1_4, var_1_2, var_1_5)
end

function var_0_0.GetArea(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1 = var_0_0.GetSizeCoord(arg_2_1)

	for iter_2_0 = var_2_1.x, var_2_1.z do
		for iter_2_1 = var_2_1.w, var_2_1.y do
			table.insert(var_2_0, Vector2(iter_2_0, iter_2_1) + arg_2_0)
		end
	end

	return var_2_0
end

function var_0_0.GetAreaCenterPos(arg_3_0)
	local var_3_0 = math.huge
	local var_3_1 = -math.huge
	local var_3_2 = math.huge
	local var_3_3 = -math.huge

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		if var_3_1 < iter_3_1.x then
			var_3_1 = iter_3_1.x
		end

		if var_3_0 > iter_3_1.x then
			var_3_0 = iter_3_1.x
		end

		if var_3_3 < iter_3_1.y then
			var_3_3 = iter_3_1.y
		end

		if var_3_2 > iter_3_1.y then
			var_3_2 = iter_3_1.y
		end
	end

	local var_3_4 = (var_3_1 + var_3_0) * 0.5
	local var_3_5 = (var_3_2 + var_3_3) * 0.5

	return Vector3(var_3_4, 0, var_3_5)
end

function var_0_0.GetCenterScreenPos()
	local var_4_0 = IslandCameraMgr.instance._mainCamera

	return (var_0_0.CameraPosToHitPoint(var_4_0, IslandConst.LAYER_AGORA))
end

function var_0_0.ScreenPostion2MapPosition(arg_5_0)
	local var_5_0 = IslandCameraMgr.instance._mainCamera
	local var_5_1 = var_0_0.ScreenToHitPoint(var_5_0, arg_5_0, IslandConst.LAYER_AGORA)

	if var_5_1 then
		return var_0_0.WorldPosition2MapPosition(var_5_1)
	else
		return nil
	end
end

function var_0_0.WorldPosition2MapPosition(arg_6_0)
	return Vector2(math.ceil(arg_6_0.x), math.ceil(arg_6_0.z))
end

function var_0_0.WorldPosition2ScreenPosition(arg_7_0)
	return IslandCameraMgr.instance._mainCamera:WorldToScreenPoint(arg_7_0)
end

function var_0_0.ScreenPosition2LocalPosition(arg_8_0, arg_8_1)
	local var_8_0 = pg.UIMgr.GetInstance().uiCameraComp
	local var_8_1 = IslandCameraMgr.instance._mainCamera:ScreenToViewportPoint(arg_8_1)
	local var_8_2 = var_8_0:ViewportToScreenPoint(var_8_1)
	local var_8_3 = arg_8_0:GetComponent("RectTransform")

	return (LuaHelper.ScreenToLocal(var_8_3, var_8_2, var_8_0))
end

function var_0_0.GetCenterMapPos()
	local var_9_0 = var_0_0.GetCenterScreenPos()

	if var_9_0 then
		return var_0_0.WorldPosition2MapPosition(var_9_0)
	else
		return nil
	end
end

function var_0_0.MapPosition2WorldPosition(arg_10_0)
	return Vector3(arg_10_0.x, 0, arg_10_0.y)
end

function var_0_0.CameraPosToHitPoint(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.transform.position
	local var_11_1 = arg_11_0.transform.forward
	local var_11_2 = LuaHelper.NameToLayer(arg_11_1)
	local var_11_3, var_11_4 = Physics.Raycast(var_11_0, var_11_1, nil, math.huge, var_11_2)

	if var_11_3 then
		return var_11_4.point
	else
		return nil
	end
end

function var_0_0.ScreenToHitPoint(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = pg.UIMgr.GetInstance().uiCameraComp
	local var_12_1 = arg_12_1
	local var_12_2 = var_12_0:ScreenToViewportPoint(Vector3(var_12_1.x, var_12_1.y, 0))
	local var_12_3 = arg_12_0:ViewportPointToRay(var_12_2)
	local var_12_4 = LuaHelper.NameToLayer(arg_12_2)
	local var_12_5, var_12_6 = Physics.Raycast(var_12_3, nil, math.huge, var_12_4)

	if var_12_5 then
		return var_12_6.point
	else
		return nil
	end
end

function var_0_0.GetUniqueId(arg_13_0)
	return arg_13_0 * 100
end

return var_0_0
