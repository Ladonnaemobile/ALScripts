local var_0_0 = class("MainMeshImagePainting", import(".MainBasePainting"))

var_0_0.DEFAULT_HEIGHT = 0
var_0_0.TOUCH_HEIGHT = 20
var_0_0.TOUCH_LOOP = 1
var_0_0.TOUCH_DURATION = 0.1
var_0_0.CHAT_HEIGHT = 15
var_0_0.CHAT_DURATION = 0.3
var_0_0.BREATH_HEIGHT = -10
var_0_0.BREATH_DURATION = 2.3
var_0_0.PAINTING_VARIANT_NORMAL = 0
var_0_0.PAINTING_VARIANT_EX = 1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
end

function var_0_0.StaticGetPaintingName(arg_2_0)
	local var_2_0 = arg_2_0

	if checkABExist("painting/" .. var_2_0 .. "_n") and PlayerPrefs.GetInt("paint_hide_other_obj_" .. var_2_0, 0) ~= 0 then
		var_2_0 = var_2_0 .. "_n"
	end

	if HXSet.isHx() then
		return var_2_0
	end

	local var_2_1 = getProxy(SettingsProxy):GetMainPaintingVariantFlag(arg_2_0) == var_0_0.PAINTING_VARIANT_EX

	if var_2_1 and not checkABExist("painting/" .. var_2_0 .. "_ex") then
		return var_2_0
	end

	return var_2_1 and var_2_0 .. "_ex" or var_2_0
end

function var_0_0.GetPaintingName(arg_3_0)
	return var_0_0.StaticGetPaintingName(arg_3_0.paintingName)
end

function var_0_0.OnLoad(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetPaintingName()

	arg_4_0:ClearScalePart()
	LoadPaintingPrefabAsync(arg_4_0.container, arg_4_0.paintingName, var_4_0, "mainNormal", function()
		if arg_4_0:IsExited() then
			arg_4_0:UnLoad()

			return
		end

		arg_4_0.loadPaintingName = var_4_0

		local var_5_0 = arg_4_0:InitSpecialTouch()

		arg_4_0:InitSpecialDrag(var_5_0)

		if arg_4_0.expression then
			ShipExpressionHelper.UpdateExpression(findTF(arg_4_0.container, "fitter"):GetChild(0), arg_4_0.paintingName, arg_4_0.expression)
		end

		arg_4_0:Breath()
		arg_4_0:InitScalePart()
		arg_4_1()
	end)
end

function var_0_0.GetCenterPos(arg_6_0)
	if arg_6_0:IsLoaded() then
		local var_6_0 = arg_6_0.container:Find("fitter"):GetChild(0)
		local var_6_1 = (0.5 - var_6_0.pivot.x) * var_6_0.sizeDelta.x
		local var_6_2 = var_6_0.localPosition + Vector3(var_6_1, 0, 0)

		return (var_6_0:TransformPoint(var_6_2))
	else
		return var_0_0.super.GetCenterPos(arg_6_0)
	end
end

function var_0_0.PlayChangeSkinActionIn(arg_7_0, arg_7_1)
	if arg_7_1 and arg_7_1.callback then
		arg_7_1.callback({
			flag = true
		})
	end
end

function var_0_0.PlayChangeSkinActionOut(arg_8_0, arg_8_1)
	if arg_8_1 and arg_8_1.callback then
		arg_8_1.callback({
			flag = true
		})
	end
end

function var_0_0.InitSpecialTouch(arg_9_0)
	local var_9_0 = findTF(findTF(arg_9_0.container, "fitter"):GetChild(0), "Touch")

	if not var_9_0 then
		return
	end

	setActive(var_9_0, true)

	local var_9_1 = {}

	eachChild(var_9_0, function(arg_10_0)
		onButton(arg_9_0, arg_10_0, function()
			local var_11_0 = arg_9_0:GetSpecialTouchEvent(arg_10_0.name)

			arg_9_0:TriggerEvent(var_11_0)
			arg_9_0:TriggerPersonalTask(arg_9_0.ship.groupId)
		end)

		var_9_1[arg_10_0] = arg_10_0.rect
	end)

	return var_9_1
end

function var_0_0.InitSpecialDrag(arg_12_0, arg_12_1)
	local var_12_0 = findTF(findTF(arg_12_0.container, "fitter"):GetChild(0), "Drag")

	if not var_12_0 then
		return
	end

	if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
		setActive(var_12_0, false)

		return
	end

	setActive(var_12_0, true)

	local var_12_1 = GetOrAddComponent(var_12_0, typeof(EventTriggerListener))
	local var_12_2 = Vector2(0, 0)

	arg_12_0.isDrag = false

	var_12_1:AddBeginDragFunc(function(arg_13_0, arg_13_1)
		arg_12_0.isDrag = true
		var_12_2 = arg_13_1.position
	end)
	var_12_1:AddDragEndFunc(function(arg_14_0, arg_14_1)
		arg_12_0.isDrag = false

		local var_14_0 = arg_14_1.position - var_12_2

		if math.abs(var_14_0.x) > 50 or math.abs(var_14_0.y) > 50 then
			arg_12_0:SwitchToVariant(var_12_0)
		end
	end)

	if arg_12_1 and table.getCount(arg_12_1) > 0 then
		var_12_1:AddPointUpFunc(function(arg_15_0, arg_15_1)
			if arg_12_0.isDrag then
				return
			end

			local var_15_0

			for iter_15_0, iter_15_1 in pairs(arg_12_1) do
				local var_15_1 = LuaHelper.ScreenToLocal(iter_15_0, arg_15_1.position, arg_12_0.uiCamera)

				if iter_15_1:Contains(var_15_1) then
					var_15_0 = iter_15_0

					break
				end
			end

			if var_15_0 then
				triggerButton(var_15_0)
			else
				triggerButton(arg_12_0.container)
			end
		end)
	end

	local var_12_3 = GetOrAddComponent(var_12_0, "UILongPressTrigger").onLongPressed

	var_12_3:RemoveAllListeners()
	var_12_3:AddListener(function()
		arg_12_0:OnLongPress()
	end)
end

function var_0_0.SwitchToVariant(arg_17_0, arg_17_1)
	pg.UIMgr.GetInstance():LoadingOn(false)
	getProxy(SettingsProxy):SwitchMainPaintingVariantFlag(arg_17_0.paintingName)
	seriesAsync({
		function(arg_18_0)
			local var_18_0 = arg_17_0:GetPaintingName()

			PoolMgr.GetInstance():PreloadPainting(var_18_0, arg_18_0)
		end,
		function(arg_19_0)
			arg_17_0:PlayVariantEffect(arg_17_1, arg_19_0)
		end,
		function(arg_20_0)
			onDelayTick(arg_20_0, 0.5)
		end,
		function(arg_21_0)
			arg_17_0:UnloadOnlyPainting()
			arg_17_0:Load(arg_17_0.ship, true)
			onDelayTick(arg_21_0, 1)
		end
	}, function()
		arg_17_0:ClearEffect()
		pg.UIMgr.GetInstance():LoadingOff()
	end)
end

function var_0_0.PlayVariantEffect(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = getProxy(SettingsProxy):GetMainPaintingVariantFlag(arg_23_0.paintingName) == var_0_0.PAINTING_VARIANT_EX
	local var_23_1 = var_23_0 and "lihui_qiehuan01" or "lihui_qiehuan02"

	pg.PoolMgr.GetInstance():GetPrefab("ui/" .. var_23_1, "", true, function(arg_24_0)
		pg.ViewUtils.SetLayer(arg_24_0.transform, Layer.UI)

		arg_23_0.effectGo = arg_24_0
		arg_23_0.effectGo.name = var_23_1

		if arg_23_0:IsExited() then
			arg_23_0:ClearEffect()

			return
		end

		setParent(arg_24_0, arg_23_0.container)

		arg_23_0.effectGo.transform.position = arg_23_1.position

		if var_23_0 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_EXPLOSIVE_SKIN)
		else
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_ANTI_EXPLOSIVE_SKIN)
		end

		arg_23_2()
	end)
end

function var_0_0.ClearEffect(arg_25_0)
	if arg_25_0.effectTimer then
		arg_25_0.effectTimer:Stop()

		arg_25_0.effectTimer = nil
	end

	if arg_25_0.effectGo then
		pg.PoolMgr.GetInstance():ReturnPrefab("ui/" .. arg_25_0.effectGo.name, "", arg_25_0.effectGo)

		arg_25_0.effectGo = nil
	end
end

function var_0_0.ClearSpecialDrag(arg_26_0)
	if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
		return
	end

	local var_26_0 = findTF(findTF(arg_26_0.container, "fitter"):GetChild(0), "Drag")

	if not var_26_0 then
		return
	end

	local var_26_1 = GetOrAddComponent(var_26_0, typeof(EventTriggerListener))

	var_26_1:AddBeginDragFunc(nil)
	var_26_1:AddDragEndFunc(nil)
	var_26_1:AddPointUpFunc(nil)
	GetOrAddComponent(var_26_0, "UILongPressTrigger").onLongPressed:RemoveAllListeners()
end

function var_0_0.OnClick(arg_27_0)
	local var_27_0 = arg_27_0:CollectTouchEvents()
	local var_27_1 = var_27_0[math.ceil(math.random(#var_27_0))]

	arg_27_0:TriggerEvent(var_27_1)
end

function var_0_0.OnLongPress(arg_28_0)
	if arg_28_0.isFoldState then
		return
	end

	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
		shipId = arg_28_0.ship.id
	})
end

function var_0_0.OnDisplayWorld(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.ship:getCVIntimacy()
	local var_29_1, var_29_2 = ShipExpressionHelper.SetExpression(findTF(arg_29_0.container, "fitter"):GetChild(0), arg_29_0.paintingName, arg_29_1, var_29_0, arg_29_0.ship.skinId)

	arg_29_0.expression = var_29_2
end

function var_0_0.OnTriggerEvent(arg_30_0)
	arg_30_0:Shake(var_0_0.TOUCH_HEIGHT, var_0_0.TOUCH_DURATION, var_0_0.TOUCH_LOOP)
end

function var_0_0.OnTriggerEventAuto(arg_31_0)
	arg_31_0:Shake(var_0_0.CHAT_HEIGHT, var_0_0.CHAT_DURATION)
end

function var_0_0.GetMeshPainting(arg_32_0)
	local var_32_0 = findTF(arg_32_0.container, "fitter")

	if var_32_0.childCount <= 0 then
		return nil
	end

	return (var_32_0:GetChild(0))
end

function var_0_0.Shake(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0
	local var_33_1 = arg_33_1

	if var_33_0 then
		var_33_1 = arg_33_1 - var_0_0.DEFAULT_HEIGHT + var_33_0
	end

	arg_33_3 = arg_33_3 or math.random(3) - 1

	if arg_33_3 == 0 then
		return
	end

	local var_33_2 = arg_33_0:GetMeshPainting()

	if not var_33_2 then
		return
	end

	LeanTween.cancel(go(var_33_2))
	LeanTween.moveY(rtf(var_33_2), var_33_1, 0.1):setLoopPingPong(arg_33_3):setOnComplete(System.Action(function()
		arg_33_0:Breath()
	end))
end

function var_0_0.Breath(arg_35_0)
	local var_35_0 = arg_35_0:GetMeshPainting()

	if not var_35_0 then
		return
	end

	local var_35_1
	local var_35_2 = var_35_1 or var_0_0.BREATH_HEIGHT
	local var_35_3 = var_35_1 and var_35_1 - 10 or var_0_0.DEFAULT_HEIGHT

	LeanTween.cancel(go(var_35_0))
	LeanTween.moveY(rtf(var_35_0), var_35_3, var_0_0.BREATH_DURATION):setLoopPingPong():setEase(LeanTweenType.easeInOutCubic):setFrom(var_35_2)
end

function var_0_0.StopBreath(arg_36_0)
	local var_36_0 = arg_36_0:GetMeshPainting()

	if not var_36_0 then
		return
	end

	LeanTween.cancel(go(var_36_0))
end

function var_0_0.OnEnableOrDisableDragAndZoom(arg_37_0, arg_37_1)
	if arg_37_1 then
		arg_37_0:StopBreath()
	else
		arg_37_0:Breath()
	end
end

function var_0_0.GetPaintingTransform(arg_38_0)
	return arg_38_0:GetMeshPainting()
end

function var_0_0.GetPartScaleData(arg_39_0)
	return pg.ship_skin_template[arg_39_0.ship.skinId].part_scale.paint
end

function var_0_0.GetPartStateType(arg_40_0)
	return MainPaintingView.STATE_PAINTING
end

function var_0_0.OnFold(arg_41_0, arg_41_1)
	if not arg_41_1 then
		arg_41_0:Breath()
	end
end

function var_0_0.GetOffset(arg_42_0)
	return MainPaintingView.MESH_POSITION_X_OFFSET
end

function var_0_0.OnPuase(arg_43_0)
	arg_43_0:StopBreath()
end

function var_0_0.OnResume(arg_44_0)
	checkCullResume(arg_44_0.container:Find("fitter"):GetChild(0))
	arg_44_0:Breath()
end

function var_0_0.Unload(arg_45_0)
	var_0_0.super.Unload(arg_45_0)

	arg_45_0.expression = nil
end

function var_0_0.OnUnload(arg_46_0)
	arg_46_0:StopBreath()
	arg_46_0:ClearSpecialDrag()

	if arg_46_0.loadPaintingName then
		retPaintingPrefab(arg_46_0.container, arg_46_0.loadPaintingName)

		arg_46_0.loadPaintingName = nil
	end
end

function var_0_0.OnPuase(arg_47_0)
	arg_47_0:ClearEffect()
end

function var_0_0.Dispose(arg_48_0)
	var_0_0.super.Dispose(arg_48_0)
	arg_48_0:ClearEffect()
end

return var_0_0
