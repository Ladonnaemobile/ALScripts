local var_0_0 = class("CourtYardStorey", import("..map.CourtYardPlaceableArea"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_4)

	arg_1_0.id = arg_1_2
	arg_1_0.style = arg_1_3
	arg_1_0.level = 1
	arg_1_0.furnitures = {}
	arg_1_0.ships = {}
	arg_1_0.canEidt = false
	arg_1_0.recoder = CourtYardStoreyRecorder.New(arg_1_0)
	arg_1_0.composeChecker = CourtYardStoreyComposeChecker.New(arg_1_0)
end

function var_0_0.GetStyle(arg_2_0)
	return arg_2_0.style
end

function var_0_0.SetLevel(arg_3_0, arg_3_1)
	arg_3_0.level = arg_3_1

	local var_3_0 = CourtYardConst.MAX_STOREY_LEVEL * CourtYardConst.OPEN_AREA_PRE_LEVEL - (arg_3_0.level - 1) * CourtYardConst.OPEN_AREA_PRE_LEVEL

	arg_3_0:UpdateMinRange(Vector2(var_3_0, var_3_0))
	arg_3_0:DispatchEvent(CourtYardEvent.UPDATE_STOREY, arg_3_1)
end

function var_0_0.LevelUp(arg_4_0)
	local var_4_0 = arg_4_0.level + 1

	arg_4_0:SetLevel(var_4_0)
	arg_4_0:DispatchEvent(CourtYardEvent.UPDATE_FLOORPAPER, arg_4_0.floorPaper)
	arg_4_0:DispatchEvent(CourtYardEvent.UPDATE_WALLPAPER, arg_4_0.wallPaper)
end

function var_0_0.SetWallPaper(arg_5_0, arg_5_1)
	arg_5_0.wallPaper = arg_5_1

	arg_5_0:DispatchEvent(CourtYardEvent.UPDATE_WALLPAPER, arg_5_1)
	arg_5_0.composeChecker:Check()
end

function var_0_0.SetFloorPaper(arg_6_0, arg_6_1)
	arg_6_0.floorPaper = arg_6_1

	arg_6_0:DispatchEvent(CourtYardEvent.UPDATE_FLOORPAPER, arg_6_1)
	arg_6_0.composeChecker:Check()
end

function var_0_0.GetWallPaper(arg_7_0)
	return arg_7_0.wallPaper
end

function var_0_0.GetFloorPaper(arg_8_0)
	return arg_8_0.floorPaper
end

function var_0_0.GetFurnitures(arg_9_0)
	return arg_9_0.furnitures
end

function var_0_0.GetAllFurniture(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0.furnitures) do
		var_10_0[iter_10_1.id] = iter_10_1
	end

	if arg_10_0.floorPaper then
		var_10_0[arg_10_0.floorPaper.id] = arg_10_0.floorPaper
	end

	if arg_10_0.wallPaper then
		var_10_0[arg_10_0.wallPaper.id] = arg_10_0.wallPaper
	end

	return var_10_0
end

function var_0_0.GetShips(arg_11_0)
	return arg_11_0.ships
end

function var_0_0.GetShip(arg_12_0, arg_12_1)
	return arg_12_0.ships[arg_12_1]
end

function var_0_0.GetFurniture(arg_13_0, arg_13_1)
	return arg_13_0.furnitures[arg_13_1]
end

function var_0_0.CanAddFurniture(arg_14_0, arg_14_1)
	return true
end

function var_0_0.AddFurniture(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.furnitures[arg_15_1.id] = arg_15_1

	arg_15_0:DispatchEvent(CourtYardEvent.CREATE_ITEM, arg_15_1, arg_15_2)
	arg_15_0:AddItem(arg_15_1)
	arg_15_0.composeChecker:Check()

	if arg_15_1:CanTouch() and arg_15_1:TriggerTouchDefault() then
		arg_15_0:ClickFurniture(arg_15_1.id)
	end
end

function var_0_0.AddPaper(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1:GetType()

	if var_16_0 == Furniture.TYPE_WALLPAPER then
		arg_16_0:SetWallPaper(arg_16_1)
	elseif var_16_0 == Furniture.TYPE_FLOORPAPER then
		arg_16_0:SetFloorPaper(arg_16_1)
	end
end

function var_0_0.AddChildFurniture(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.furnitures[arg_17_1.id] = arg_17_1

	arg_17_0:DispatchEvent(CourtYardEvent.CREATE_ITEM, arg_17_1)

	local var_17_0 = arg_17_0.furnitures[arg_17_2]

	arg_17_0:DispatchEvent(CourtYardEvent.CHILD_ITEM, arg_17_1, var_17_0)
	var_17_0:AddChild(arg_17_1)
end

function var_0_0.Update(arg_18_0)
	arg_18_0:CheckShipState()
	arg_18_0:CheckFurnitureState()
end

function var_0_0.AddShip(arg_19_0, arg_19_1)
	arg_19_1:ChangeState(CourtYardShip.STATE_IDLE)

	arg_19_0.ships[arg_19_1.id] = arg_19_1

	arg_19_0:DispatchEvent(CourtYardEvent.CREATE_ITEM, arg_19_1)
	arg_19_0:AddItem(arg_19_1)
end

function var_0_0.GetPlaceableArea(arg_20_0, arg_20_1)
	return arg_20_1:HasParent() and arg_20_1:GetParent():GetPlaceableArea() or arg_20_0
end

function var_0_0.RemoveShip(arg_21_0, arg_21_1)
	arg_21_0:GetPlaceableArea(arg_21_1):RemoveItem(arg_21_1)
	arg_21_0.ships[arg_21_1.id]:Dispose()

	arg_21_0.ships[arg_21_1.id] = nil

	arg_21_0:DispatchEvent(CourtYardEvent.DETORY_ITEM, arg_21_1)
end

function var_0_0.ExitShip(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.ships[arg_22_1]

	if var_22_0 then
		arg_22_0:RemoveShip(var_22_0)
	end
end

function var_0_0.CheckShipState(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0:GetShips()) do
		local var_23_0 = iter_23_1:GetState()

		if var_23_0 == CourtYardShip.STATE_MOVE then
			arg_23_0:ReadyMoveShip(iter_23_1.id)
		elseif var_23_0 == CourtYardShip.STATE_MOVING_HALF then
			arg_23_0:MoveShipToNextPosition(iter_23_1.id)
		end
	end
end

function var_0_0.ReadyMoveShip(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.ships[arg_24_1]
	local var_24_1 = false
	local var_24_2 = false
	local var_24_3 = false

	if CourtYardCalcUtil.HalfProbability() then
		if var_24_0:HasParent() and var_24_0:GetParent():IsType(Furniture.TYPE_ARCH) then
			var_24_1 = arg_24_0:ShipExitArch(var_24_0)
		else
			var_24_2 = arg_24_0:ShipEnterArch(var_24_0)

			if not var_24_2 then
				var_24_3 = arg_24_0:ShipAddFollower(var_24_0)
			end
		end
	end

	if not var_24_1 and not var_24_2 and not var_24_3 then
		arg_24_0:RandomNextShipPosition(arg_24_1)
	end
end

function var_0_0.ShipAddFollower(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:GetFurnituresByType(Furniture.TYPE_FOLLOWER)

	local function var_25_1(arg_26_0)
		return _.detect(var_25_0, function(arg_27_0)
			local var_27_0 = arg_27_0:GetArea()

			return _.any(var_27_0, function(arg_28_0)
				return arg_28_0 == arg_26_0
			end)
		end)
	end

	local function var_25_2()
		local var_29_0 = arg_25_1:GetInterActionData()

		if var_29_0 ~= nil then
			var_29_0:Stop()
		end
	end

	for iter_25_0, iter_25_1 in ipairs(arg_25_1:GetAroundPositions()) do
		local var_25_3 = var_25_1(iter_25_1)

		if var_25_3 and var_25_3:CanFollower(arg_25_1) then
			var_25_2()
			arg_25_0:RemoveItemAndRefresh(var_25_3)
			var_25_3:GetInteractionSlot():Occupy(var_25_3, arg_25_1, arg_25_0)

			return true
		end
	end

	return false
end

function var_0_0.ShipExitArch(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:GetNextPositionForMove(arg_30_1)

	if var_30_0 then
		local var_30_1 = arg_30_1:GetParent()

		var_30_1:RemoveChild(arg_30_1)
		arg_30_0:DispatchEvent(CourtYardEvent.UN_CHILD_ITEM, arg_30_1, var_30_1)
		arg_30_0:DispatchEvent(CourtYardEvent.EXIT_ARCH, arg_30_1, var_30_1)
		arg_30_0:LockPosition(var_30_0)
		arg_30_1:UnClear(true)
		arg_30_1:Move(var_30_0)

		return true
	end

	return false
end

function var_0_0.ShipEnterArch(arg_31_0, arg_31_1)
	local function var_31_0(arg_32_0, arg_32_1)
		arg_31_0:RemoveItem(arg_31_1)
		arg_31_0:DispatchEvent(CourtYardEvent.CHILD_ITEM, arg_31_1, arg_32_0)
		arg_31_0:DispatchEvent(CourtYardEvent.ENTER_ARCH, arg_31_1, arg_32_0)
		arg_32_0:AddChild(arg_31_1)
		arg_31_1:Move(arg_32_1)
	end

	for iter_31_0, iter_31_1 in ipairs(arg_31_1:GetAroundPositions()) do
		local var_31_1 = arg_31_0:GetParentForItem(arg_31_1, iter_31_1)

		if var_31_1 and var_31_1:IsType(Furniture.TYPE_ARCH) then
			var_31_0(var_31_1, iter_31_1)

			return true
		end
	end

	return false
end

function var_0_0.RandomNextShipPosition(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.ships[arg_33_1]
	local var_33_1 = arg_33_0:GetPlaceableArea(var_33_0)
	local var_33_2 = var_33_1:GetNextPositionForMove(var_33_0)

	if not var_33_2 then
		var_33_0:ChangeState(CourtYardShip.STATE_IDLE)

		return
	end

	var_33_1:LockPosition(var_33_2)
	var_33_0:Move(var_33_2)
end

function var_0_0.MoveShipToNextPosition(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0.ships[arg_34_1]
	local var_34_1 = arg_34_0:GetPlaceableArea(var_34_0)
	local var_34_2 = var_34_0:GetMarkPosition()

	var_34_1:_ClearLockPosition(var_34_0)

	if var_34_0:IsUnClear() then
		var_34_0:UnClear(false)
	else
		var_34_1:RemoveItem(var_34_0)
	end

	var_34_0:SetPosition(var_34_2)
	var_34_1:AddItem(var_34_0)
	var_34_0:ChangeState(CourtYardShip.STATE_MOVING_ONE)
end

function var_0_0.DragShip(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0.ships[arg_35_1]

	arg_35_0:GetPlaceableArea(var_35_0):_ClearLockPosition(var_35_0)

	local var_35_1 = var_35_0:GetPosition()
	local var_35_2 = var_35_0:GetInterActionData()

	if var_35_2 ~= nil or var_35_0:GetState() == CourtYardShip.STATE_INTERACT then
		if isa(var_35_2, CourtYardFollowerSlot) then
			arg_35_0:RemoveItem(var_35_0)
		end

		var_35_2:Stop()
	elseif var_35_0:HasParent() then
		local var_35_3 = var_35_0:GetParent()

		var_35_3:RemoveChild(var_35_0)
		var_35_0:ChangeState(CourtYardShip.STATE_IDLE)
		arg_35_0:DispatchEvent(CourtYardEvent.UN_CHILD_ITEM, var_35_0, var_35_3)
	else
		arg_35_0:RemoveItem(var_35_0)
	end

	var_35_0:ChangeState(CourtYardShip.STATE_DRAG)

	local var_35_4 = arg_35_0:AreaWithInfo(var_35_0, var_35_1, var_35_0:GetOffset())

	var_35_0:UpdateOpFlag(true)
	arg_35_0:DispatchEvent(CourtYardEvent.SELETED_ITEM, var_35_0, var_35_4)
	arg_35_0:DispatchEvent(CourtYardEvent.DRAG_ITEM, var_35_0)
end

function var_0_0.DragingShip(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_0.ships[arg_36_1]

	if not var_36_0:GetOpFlag() then
		return
	end

	local var_36_1 = arg_36_0:GetParentForItem(var_36_0, arg_36_2)
	local var_36_2 = arg_36_0:GetInterActionFurniture(var_36_0, arg_36_2)
	local var_36_3 = var_36_1 and var_36_1:RawGetOffset() or var_36_0:GetOffset()
	local var_36_4 = arg_36_0:AreaWithInfo(var_36_0, arg_36_2, var_36_3, var_36_2 or var_36_1)

	arg_36_0:DispatchEvent(CourtYardEvent.DRAGING_ITEM, var_36_0, var_36_4, arg_36_2, var_36_3)
end

function var_0_0.DragShipEnd(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0.ships[arg_37_1]

	if not var_37_0:GetOpFlag() then
		return
	end

	local var_37_1 = arg_37_0:LegalPosition(arg_37_2, var_37_0)
	local var_37_2 = arg_37_0:GetInterActionFurniture(var_37_0, arg_37_2)
	local var_37_3 = arg_37_0:GetParentForItem(var_37_0, arg_37_2)
	local var_37_4

	if not var_37_1 and var_37_2 then
		if isa(var_37_2, CourtYardFollowerFurniture) then
			arg_37_0:RemoveItemAndRefresh(var_37_2)
			arg_37_0:ResetShip(var_37_0, arg_37_2)
			var_37_0:ChangeState(CourtYardShip.STATE_MOVE)
		end

		var_37_2:GetInteractionSlot():Occupy(var_37_2, var_37_0, arg_37_0)
	elseif not var_37_1 and var_37_3 then
		var_37_0:SetPosition(arg_37_2)
		arg_37_0:DispatchEvent(CourtYardEvent.CHILD_ITEM, var_37_0, var_37_3)
		var_37_3:AddChild(var_37_0)
		var_37_0:ChangeState(CourtYardShip.STATE_IDLE)

		var_37_4 = var_37_3:AreaWithInfo(var_37_0, arg_37_2, var_37_3:RawGetOffset(), true)
	else
		local var_37_5 = var_37_1 and arg_37_2 or var_37_0:GetPosition()

		arg_37_0:ResetShip(var_37_0, var_37_5)

		var_37_4 = arg_37_0:AreaWithInfo(var_37_0, var_37_5, var_37_0:GetOffset(), true)
	end

	var_37_0:UpdateOpFlag(false)
	arg_37_0:DispatchEvent(CourtYardEvent.DRAG_ITEM_END, var_37_4)
	arg_37_0:DispatchEvent(CourtYardEvent.UNSELETED_ITEM, var_37_0)
end

function var_0_0.GetInterActionFurniture(arg_38_0, arg_38_1, arg_38_2)
	for iter_38_0, iter_38_1 in pairs(arg_38_0.furnitures) do
		if iter_38_1:CanInterAction(arg_38_1) and iter_38_1:IsOverlap(arg_38_2) then
			return iter_38_1
		end
	end

	return nil
end

function var_0_0.TouchShip(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.ships[arg_39_1]

	arg_39_0:GetPlaceableArea(var_39_0):_ClearLockPosition(var_39_0)
	var_39_0:ChangeState(CourtYardShip.STATE_TOUCH)
end

function var_0_0.UpdateShipIntimacy(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0.ships[arg_40_1]

	if not var_40_0 then
		return
	end

	var_40_0:ChangeInimacy(arg_40_2)
end

function var_0_0.UpdateShipCoin(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0.ships[arg_41_1]

	if not var_41_0 then
		return
	end

	var_41_0:ChangeCoin(arg_41_2)
end

function var_0_0.ClearShipIntimacy(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_0.ships[arg_42_1]

	if not var_42_0 then
		return
	end

	arg_42_0:GetPlaceableArea(var_42_0):_ClearLockPosition(var_42_0)
	var_42_0:ClearInimacy(arg_42_2)
end

function var_0_0.ClearShipCoin(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0.ships[arg_43_1]

	if not var_43_0 then
		return
	end

	arg_43_0:GetPlaceableArea(var_43_0):_ClearLockPosition(var_43_0)
	var_43_0:ClearCoin(value)
end

function var_0_0.AddShipExp(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0.ships[arg_44_1]

	if not var_44_0 then
		return
	end

	var_44_0:AddExp(arg_44_2)
end

function var_0_0.ShipAnimtionFinish(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = arg_45_0.ships[arg_45_1]

	if arg_45_2 == CourtYardShip.STATE_TOUCH or arg_45_2 == CourtYardShip.STATE_GETAWARD then
		var_45_0:ChangeState(CourtYardShip.STATE_IDLE)
	elseif arg_45_2 == CourtYardShip.STATE_INTERACT then
		local var_45_1 = var_45_0:GetInterActionData()

		if var_45_1 then
			var_45_1:Continue(var_45_0)
		end
	end
end

function var_0_0.ResetShip(arg_46_0, arg_46_1, arg_46_2)
	local function var_46_0(arg_47_0, arg_47_1)
		arg_47_0:SetPosition(arg_47_1)
		arg_47_0:ChangeState(CourtYardShip.STATE_IDLE)
		arg_46_0:AddItem(arg_47_0)
	end

	if arg_46_0:LegalPosition(arg_46_2, arg_46_1) then
		var_46_0(arg_46_1, arg_46_2)
	else
		local var_46_1 = arg_46_0:GetRandomPosition(arg_46_1)

		if var_46_1 then
			var_46_0(arg_46_1, var_46_1)
		else
			arg_46_0:RemoveShip(arg_46_1)
			arg_46_0:GetHost():SendNotification(CourtYardEvent._NO_POS_TO_ADD_SHIP, arg_46_1.id)
		end
	end
end

function var_0_0.SelectFurniture(arg_48_0, arg_48_1)
	if not arg_48_0.canEidt then
		return
	end

	local var_48_0 = arg_48_0.furnitures[arg_48_1]

	if var_48_0:GetOpFlag() then
		return
	end

	local var_48_1 = _.detect(_.values(arg_48_0.furnitures), function(arg_49_0)
		return arg_49_0:GetOpFlag()
	end)

	if var_48_1 then
		arg_48_0:UnSelectFurniture(var_48_1.id)
	end

	local var_48_2 = var_48_0:GetPosition()
	local var_48_3 = arg_48_0:AreaWithInfo(var_48_0, var_48_2, var_48_0:GetOffset(), true)

	var_48_0:UpdateOpFlag(true)
	arg_48_0:DispatchEvent(CourtYardEvent.SELETED_ITEM, var_48_0, var_48_3)
end

function var_0_0.ClickFurniture(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0.furnitures[arg_50_1]

	if var_50_0:HasDescription() then
		arg_50_0:DispatchEvent(CourtYardEvent.SHOW_FURNITURE_DESC, var_50_0)
	elseif var_50_0:CanTouch() then
		if var_50_0:GetTouchBg() then
			arg_50_0:CheckFurnitureTouchBG(var_50_0)
		end

		if not var_50_0:IsTouchState() then
			var_50_0:ChangeState(CourtYardFurniture.STATE_TOUCH)
			arg_50_0:DispatchEvent(CourtYardEvent.ON_TOUCH_ITEM, var_50_0)
		else
			var_50_0:ChangeState(CourtYardFurniture.STATE_IDLE)
			arg_50_0:DispatchEvent(CourtYardEvent.ON_CANCEL_TOUCH_ITEM, var_50_0)
		end
	end
end

function var_0_0.CheckFurnitureTouchBG(arg_51_0, arg_51_1)
	for iter_51_0, iter_51_1 in pairs(arg_51_0.furnitures) do
		if iter_51_1.id ~= arg_51_1.id and iter_51_1:IsTouchState() and iter_51_1:GetTouchBg() then
			iter_51_1:ChangeState(CourtYardFurniture.STATE_IDLE)
			arg_51_0:DispatchEvent(CourtYardEvent.ON_CANCEL_TOUCH_ITEM, iter_51_1)
		end
	end
end

function var_0_0.PlayMusicalInstruments(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0.furnitures[arg_52_1]

	arg_52_0:MuteAll()
	arg_52_0:DispatchEvent(CourtYardEvent.FURNITURE_PLAY_MUSICALINSTRUMENTS, var_52_0)
end

function var_0_0.StopPlayMusicalInstruments(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0.furnitures[arg_53_1]

	arg_53_0:DispatchEvent(CourtYardEvent.FURNITURE_STOP_PLAY_MUSICALINSTRUMENTS, var_53_0)
end

function var_0_0.PlayFurnitureVoice(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_0.furnitures[arg_54_1]
	local var_54_1 = _.select(var_54_0.musicDatas, function(arg_55_0)
		return arg_55_0.voiceType == 1
	end)

	if #var_54_1 > 0 then
		local var_54_2 = var_54_1[math.random(1, #var_54_1)]

		arg_54_0:DispatchEvent(CourtYardEvent.ON_ITEM_PLAY_MUSIC, var_54_2.voice, var_54_2.voiceType)
	end
end

function var_0_0.PlayFurnitureBg(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_0.furnitures[arg_56_1]
	local var_56_1 = arg_56_0:StopPrevFurnitureVoice()

	if var_56_1 and var_56_1.id == var_56_0.id then
		return
	end

	var_56_0:ChangeState(CourtYardFurniture.STATE_PLAY_MUSIC)

	local var_56_2 = var_56_0:GetMusicData()

	if var_56_2 then
		arg_56_0:DispatchEvent(CourtYardEvent.ON_ITEM_PLAY_MUSIC, var_56_2.voice, var_56_2.voiceType)
	end
end

function var_0_0.MuteAll(arg_57_0)
	for iter_57_0, iter_57_1 in pairs(arg_57_0.furnitures) do
		if iter_57_1:GetMusicData() then
			local var_57_0 = iter_57_1:GetMusicData()

			arg_57_0:DispatchEvent(CourtYardEvent.ON_ITEM_STOP_MUSIC, var_57_0.voice, var_57_0.voiceType)
			iter_57_1:ChangeState(CourtYardFurniture.STATE_STOP_MUSIC)
		end
	end

	arg_57_0:DispatchEvent(CourtYardEvent.FURNITURE_MUTE_ALL)
end

function var_0_0.StopPrevFurnitureVoice(arg_58_0)
	local var_58_0

	for iter_58_0, iter_58_1 in pairs(arg_58_0.furnitures) do
		local var_58_1 = iter_58_1:GetMusicData()

		if var_58_1 and var_58_1.voiceType == 2 then
			var_58_0 = iter_58_1
		end
	end

	if var_58_0 then
		local var_58_2 = var_58_0:GetMusicData()

		arg_58_0:DispatchEvent(CourtYardEvent.ON_ITEM_STOP_MUSIC, var_58_2.voice, var_58_2.voiceType)
		var_58_0:ChangeState(CourtYardFurniture.STATE_STOP_MUSIC)
	end

	return var_58_0
end

function var_0_0.FurnitureAnimtionFinish(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = arg_59_0.furnitures[arg_59_1]

	if arg_59_2 == CourtYardFurniture.STATE_TOUCH then
		var_59_0:ChangeState(CourtYardFurniture.STATE_IDLE)
	elseif arg_59_2 == CourtYardFurniture.STATE_INTERACT then
		local var_59_1 = var_59_0:GetUsingSlots()

		_.each(var_59_1, function(arg_60_0)
			arg_60_0:Continue(var_59_0)
		end)
	elseif arg_59_2 == CourtYardFurniture.STATE_TOUCH_PREPARE then
		var_59_0:_ChangeState(CourtYardFurniture.STATE_TOUCH)
	end
end

function var_0_0.BeginDragFurniture(arg_61_0, arg_61_1)
	if not arg_61_0.canEidt then
		return
	end

	local var_61_0 = arg_61_0.furnitures[arg_61_1]

	if not var_61_0:GetOpFlag() then
		return
	end

	var_61_0:ChangeState(CourtYardFurniture.STATE_DRAG)

	if var_61_0:HasParent() then
		local var_61_1 = var_61_0:GetParent()

		var_61_1:RemoveChild(var_61_0)
		arg_61_0:DispatchEvent(CourtYardEvent.UN_CHILD_ITEM, var_61_0, var_61_1)
	else
		arg_61_0:RemoveItem(var_61_0)
		arg_61_0:DispatchEvent(CourtYardEvent.DRAG_ITEM, var_61_0)
	end
end

function var_0_0.DragingFurniture(arg_62_0, arg_62_1, arg_62_2)
	if not arg_62_0.canEidt then
		return
	end

	local var_62_0 = arg_62_0.furnitures[arg_62_1]

	if not var_62_0:GetOpFlag() then
		return
	end

	if isa(var_62_0, CourtYardWallFurniture) then
		arg_62_2 = var_62_0:NormalizePosition(arg_62_2, arg_62_0.minSizeX)
	end

	local var_62_1 = arg_62_0:GetParentForItem(var_62_0, arg_62_2)
	local var_62_2 = var_62_1 and var_62_1:RawGetOffset() or var_62_0:GetOffset()
	local var_62_3 = var_62_1 and var_62_1:AreaWithInfo(var_62_0, arg_62_2, var_62_2) or arg_62_0:AreaWithInfo(var_62_0, arg_62_2, var_62_2)

	arg_62_0:DispatchEvent(CourtYardEvent.DRAGING_ITEM, var_62_0, var_62_3, arg_62_2, var_62_2)
end

function var_0_0.GetParentForItem(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = _.select(_.values(arg_63_0.furnitures), function(arg_64_0)
		return isa(arg_64_0, CourtYardCanPutFurniture) and arg_64_0:CanPutChildInPosition(arg_63_1, arg_63_2)
	end)

	table.sort(var_63_0, function(arg_65_0, arg_65_1)
		return (arg_65_0.parent and 1 or 0) > (arg_65_1.parent and 1 or 0)
	end)

	return var_63_0[1]
end

function var_0_0.DragFurnitureEnd(arg_66_0, arg_66_1, arg_66_2)
	if not arg_66_0.canEidt then
		return
	end

	local var_66_0 = arg_66_0.furnitures[arg_66_1]

	if not var_66_0:GetOpFlag() then
		return
	end

	var_66_0:ChangeState(CourtYardFurniture.STATE_IDLE)

	if isa(var_66_0, CourtYardWallFurniture) then
		arg_66_2 = var_66_0:NormalizePosition(arg_66_2, arg_66_0.minSizeX)
	end

	local var_66_1 = arg_66_0:VerifyDragPositionForFurniture(var_66_0, arg_66_2)

	if not var_66_1 then
		arg_66_0:RemoveFurniture(arg_66_1)
		arg_66_0:DispatchEvent(CourtYardEvent.REMOVE_ILLEGALITY_ITEM)

		return
	end

	if isa(var_66_0, CourtYardWallFurniture) then
		var_66_0:UpdatePosition(var_66_1)
	else
		var_66_0:SetPosition(var_66_1)
	end

	local var_66_2 = arg_66_0:GetParentForItem(var_66_0, var_66_1)
	local var_66_3

	if var_66_2 then
		arg_66_0:DispatchEvent(CourtYardEvent.CHILD_ITEM, var_66_0, var_66_2)
		var_66_2:AddChild(var_66_0)

		var_66_3 = var_66_2:AreaWithInfo(var_66_0, var_66_1, var_66_2:RawGetOffset(), true)
	else
		arg_66_0:AddItem(var_66_0)

		var_66_3 = arg_66_0:AreaWithInfo(var_66_0, var_66_1, var_66_0:GetOffset(), true)
	end

	arg_66_0:DispatchEvent(CourtYardEvent.DRAG_ITEM_END, var_66_0, var_66_3)
end

function var_0_0.IsLegalAreaForFurniture(arg_67_0, arg_67_1, arg_67_2)
	return _.all(arg_67_1:GetAreaByPosition(arg_67_2), function(arg_68_0)
		return arg_67_0:LegalPosition(arg_68_0, arg_67_1)
	end) or arg_67_0:GetParentForItem(arg_67_1, arg_67_2) ~= nil
end

function var_0_0.VerifyDragPositionForFurniture(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0

	if arg_69_0:IsLegalAreaForFurniture(arg_69_1, arg_69_2) then
		var_69_0 = arg_69_2
	else
		local var_69_1 = arg_69_1:GetPosition()

		if var_69_1 and isa(arg_69_1, CourtYardWallFurniture) then
			arg_69_1:UpdatePosition(var_69_1)
		end

		if var_69_1 and arg_69_0:IsLegalAreaForFurniture(arg_69_1, var_69_1) then
			var_69_0 = var_69_1
		else
			if var_69_1 and isa(arg_69_1, CourtYardWallFurniture) then
				arg_69_1:UpdatePosition(arg_69_2)
			end

			var_69_0 = arg_69_0:GetEmptyArea(arg_69_1)
		end
	end

	return var_69_0
end

function var_0_0.UnSelectFurniture(arg_70_0, arg_70_1)
	local var_70_0 = arg_70_0.furnitures[arg_70_1]

	if not var_70_0:GetOpFlag() then
		return
	end

	var_70_0:UpdateOpFlag(false)
	arg_70_0:DispatchEvent(CourtYardEvent.UNSELETED_ITEM, var_70_0)
end

function var_0_0.RotateFurniture(arg_71_0, arg_71_1)
	local var_71_0 = arg_71_0.furnitures[arg_71_1]

	if var_71_0:DisableRotation() then
		arg_71_0:DispatchEvent(CourtYardEvent.DISABLE_ROTATE_ITEM)
	elseif not arg_71_0:CanRotateItem(var_71_0) then
		arg_71_0:DispatchEvent(CourtYardEvent.ROTATE_ITEM_FAILED)
	else
		local var_71_1 = var_71_0:HasParent()

		if not var_71_1 then
			arg_71_0:RemoveItem(var_71_0)
		end

		var_71_0:Rotate()

		local var_71_2 = arg_71_0:AreaWithInfo(var_71_0, var_71_0:GetPosition(), var_71_0:GetOffset())

		if not var_71_1 then
			arg_71_0:AddItem(var_71_0)
		end

		arg_71_0:DispatchEvent(CourtYardEvent.ROTATE_ITEM, var_71_0, var_71_2)
	end
end

function var_0_0.RemoveFurniture(arg_72_0, arg_72_1)
	local var_72_0 = arg_72_0.furnitures[arg_72_1]
	local var_72_1 = var_72_0:HasParent()

	if var_72_1 then
		var_72_0:GetParent():RemoveChild(var_72_0)
	end

	local var_72_2 = var_72_0.childs or {}

	for iter_72_0 = #var_72_2, 1, -1 do
		arg_72_0:RemoveFurniture(var_72_2[iter_72_0].id)
	end

	if not var_72_1 then
		arg_72_0:RemoveItem(var_72_0)
	end

	local var_72_3 = var_72_0:GetMusicData()

	if var_72_3 then
		arg_72_0:DispatchEvent(CourtYardEvent.ON_ITEM_STOP_MUSIC, var_72_3.voice, var_72_3.voiceType)
		var_72_0:ChangeState(CourtYardFurniture.STATE_STOP_MUSIC)
	end

	arg_72_0:UnSelectFurniture(arg_72_1)
	arg_72_0.furnitures[arg_72_1]:Dispose()

	arg_72_0.furnitures[arg_72_1] = nil

	arg_72_0:DispatchEvent(CourtYardEvent.DETORY_ITEM, var_72_0)
	arg_72_0.composeChecker:Check()
end

function var_0_0.RemoveAllFurniture(arg_73_0)
	for iter_73_0, iter_73_1 in pairs(arg_73_0.furnitures) do
		if not iter_73_1:HasParent() then
			arg_73_0:RemoveFurniture(iter_73_1.id)
		end
	end

	arg_73_0:SetWallPaper(nil)
	arg_73_0:SetFloorPaper(nil)
end

function var_0_0.RemovePaper(arg_74_0, arg_74_1)
	local var_74_0 = arg_74_0:GetWallPaper()

	if var_74_0 and var_74_0.id == arg_74_1 then
		arg_74_0:SetWallPaper(nil)
	end

	local var_74_1 = arg_74_0:GetFloorPaper()

	if var_74_1 and var_74_1.id == arg_74_1 then
		arg_74_0:SetFloorPaper(nil)
	end
end

function var_0_0.CheckFurnitureState(arg_75_0)
	for iter_75_0, iter_75_1 in pairs(arg_75_0.furnitures) do
		if iter_75_1:IsType(Furniture.TYPE_MOVEABLE) and iter_75_1:IsReadyMove() then
			arg_75_0:ReadyMoveFurniture(iter_75_1.id)
		end
	end
end

function var_0_0.ReadyMoveFurniture(arg_76_0, arg_76_1)
	local var_76_0 = arg_76_0.furnitures[arg_76_1]
	local var_76_1 = arg_76_0:GetNextPositionForMove(var_76_0)

	if not var_76_1 then
		var_76_0:Rest()

		return
	end

	if var_76_0:IsDifferentDirection(var_76_1) and arg_76_0:CanRotateItem(var_76_0) then
		arg_76_0:RotateFurniture(arg_76_1)
	end

	var_76_0:Move(var_76_1)
	arg_76_0:RemoveItem(var_76_0)
	var_76_0:SetPosition(var_76_1)
	arg_76_0:AddItemAndRefresh(var_76_0)
end

function var_0_0.GetFurnituresByType(arg_77_0, arg_77_1)
	local var_77_0 = {}

	for iter_77_0, iter_77_1 in pairs(arg_77_0.furnitures) do
		if iter_77_1:IsType(arg_77_1) then
			table.insert(var_77_0, iter_77_1)
		end
	end

	return var_77_0
end

function var_0_0.EnterEditMode(arg_78_0)
	arg_78_0.canEidt = true

	for iter_78_0, iter_78_1 in pairs(arg_78_0.ships) do
		if iter_78_1:GetState() == CourtYardShip.STATE_DRAG then
			arg_78_0:DragShipEnd(iter_78_1.id, Vector2(-1, -1))
		end

		arg_78_0:GetPlaceableArea(iter_78_1):_ClearLockPosition(iter_78_1)

		if iter_78_1:HasParent() then
			local var_78_0 = iter_78_1:GetParent()

			var_78_0:RemoveChild(iter_78_1)
			arg_78_0:DispatchEvent(CourtYardEvent.UN_CHILD_ITEM, iter_78_1, var_78_0)
		else
			arg_78_0:RemoveItem(iter_78_1)
		end

		iter_78_1:ChangeState(CourtYardShip.STATE_STOP)
	end

	for iter_78_2, iter_78_3 in pairs(arg_78_0.furnitures) do
		if iter_78_3:IsType(Furniture.TYPE_TRANSPORT) and iter_78_3:IsUsing() then
			iter_78_3:Stop()
		end

		if iter_78_3:IsType(Furniture.TYPE_FOLLOWER) and iter_78_3:IsUsing() then
			iter_78_3:Stop()
		end

		if iter_78_3:IsType(Furniture.TYPE_MOVEABLE) and iter_78_3:IsMoving() then
			iter_78_3:Stop()
		end

		if iter_78_3:IsTouchState() then
			arg_78_0:ClickFurniture(iter_78_3.id)
		end
	end

	arg_78_0.recoder:BeginCheckChange()
	arg_78_0:DispatchEvent(CourtYardEvent.ENTER_EDIT_MODE)
end

function var_0_0.ExitEditMode(arg_79_0)
	for iter_79_0, iter_79_1 in pairs(arg_79_0.ships) do
		if iter_79_1:ShouldResetPosition() then
			local var_79_0 = iter_79_1:GetPosition()

			arg_79_0:ResetShip(iter_79_1, var_79_0)
		end
	end

	for iter_79_2, iter_79_3 in pairs(arg_79_0.furnitures) do
		if iter_79_3:IsType(Furniture.TYPE_MOVEABLE) and iter_79_3:IsStop() then
			iter_79_3:ReStart()

			if iter_79_3:CanTouch() then
				arg_79_0:ClickFurniture(iter_79_3.id)
			end
		end
	end

	local var_79_1 = _.detect(_.values(arg_79_0.furnitures), function(arg_80_0)
		return arg_80_0:GetOpFlag()
	end)

	if var_79_1 then
		arg_79_0:UnSelectFurniture(var_79_1.id)
	end

	arg_79_0.canEidt = false

	arg_79_0.recoder:EndCheckChange()
	arg_79_0:DispatchEvent(CourtYardEvent.EXIT_EDIT_MODE)
end

function var_0_0.InEidtMode(arg_81_0)
	return arg_81_0.canEidt
end

function var_0_0.StopAllDragState(arg_82_0)
	local function var_82_0()
		for iter_83_0, iter_83_1 in pairs(arg_82_0.ships) do
			if iter_83_1:GetState() == CourtYardShip.STATE_DRAG then
				arg_82_0:DragShipEnd(iter_83_1.id, Vector2(-1, -1))
			end
		end
	end

	local function var_82_1()
		for iter_84_0, iter_84_1 in pairs(arg_82_0.furnitures) do
			if iter_84_1:IsDragingState() then
				arg_82_0:DragFurnitureEnd(iter_84_1.id, Vector2(-1, -1))
				arg_82_0:UnSelectFurniture(iter_84_1.id)
			end
		end
	end

	if not arg_82_0:InEidtMode() then
		var_82_0()
	else
		var_82_1()
	end
end

function var_0_0.StartInteraction(arg_85_0, arg_85_1)
	local var_85_0 = arg_85_1:GetUser()
	local var_85_1 = arg_85_1:GetOwner()

	if isa(var_85_1, CourtYardFurniture) and var_85_1:GetInterActionBgm() then
		for iter_85_0, iter_85_1 in pairs(arg_85_0.furnitures) do
			if iter_85_1:IsPlayMusicState() then
				iter_85_1:ChangeState(CourtYardFurniture.STATE_STOP_MUSIC)
			end
		end
	end

	arg_85_0:DispatchEvent(CourtYardEvent.ITEM_INTERACTION, var_85_0, var_85_1, arg_85_1)
end

function var_0_0.WillClearInteraction(arg_86_0, arg_86_1, arg_86_2)
	local var_86_0 = arg_86_1:GetUser()
	local var_86_1 = arg_86_1:GetOwner()

	arg_86_0:DispatchEvent(CourtYardEvent.CLEAR_ITEM_INTERACTION, var_86_0, var_86_1, arg_86_1)
end

function var_0_0.ClearInteraction(arg_87_0, arg_87_1, arg_87_2)
	local var_87_0 = arg_87_1:GetUser()
	local var_87_1 = arg_87_1:GetOwner()

	if isa(var_87_0, CourtYardFollowerFurniture) then
		arg_87_0:ClearInteractionForFollower(var_87_0, var_87_1, arg_87_1, arg_87_2)
	elseif not arg_87_2 then
		if isa(var_87_1, CourtYardTransportFurniture) then
			arg_87_0:ClearInteractionForTransPort(var_87_0, var_87_1, arg_87_1)
		else
			arg_87_0:ResetShip(var_87_0, var_87_0:GetPosition())
		end
	end
end

function var_0_0.ClearInteractionForFollower(arg_88_0, arg_88_1, arg_88_2, arg_88_3, arg_88_4)
	local var_88_0 = arg_88_0:GetAroundEmptyArea(arg_88_1, arg_88_2:GetPosition())

	if not var_88_0 then
		arg_88_0:DispatchEvent(CourtYardEvent.REMOVE_ILLEGALITY_ITEM)
		arg_88_0:RemoveFurniture(arg_88_1.id)

		return
	end

	arg_88_1:SetPosition(var_88_0)
	arg_88_0:AddItemAndRefresh(arg_88_1)
end

function var_0_0.ClearInteractionForTransPort(arg_89_0, arg_89_1, arg_89_2, arg_89_3)
	if arg_89_3:IsFirstTime() then
		local var_89_0 = arg_89_0:GetFurnituresByType(Furniture.TYPE_TRANSPORT)
		local var_89_1 = _.select(var_89_0, function(arg_90_0)
			return arg_90_0.id ~= arg_89_2.id
		end)
		local var_89_2 = var_89_1[math.random(1, #var_89_1)]

		if var_89_2 and var_89_2:CanInterAction(arg_89_1) then
			var_89_2:GetInteractionSlot():Link(var_89_2, arg_89_1, arg_89_0)
		else
			arg_89_0:ResetShip(arg_89_1, arg_89_0:GetRandomPosition(arg_89_1))
		end
	else
		arg_89_0:ResetShip(arg_89_1, arg_89_0:GetAroundEmptyPosition(arg_89_2))
	end
end

function var_0_0.LegalPosition(arg_91_0, arg_91_1, arg_91_2)
	return var_0_0.super.LegalPosition(arg_91_0, arg_91_1, arg_91_2) and arg_91_2:InActivityRange(arg_91_1)
end

function var_0_0.GetLevel(arg_92_0)
	return arg_92_0.level
end

function var_0_0.Dispose(arg_93_0)
	var_0_0.super.Dispose(arg_93_0)
	arg_93_0.recoder:Dispose()

	arg_93_0.recoder = nil

	arg_93_0.composeChecker:Dispose()

	arg_93_0.composeChecker = nil

	for iter_93_0, iter_93_1 in pairs(arg_93_0.ships) do
		iter_93_1:Dispose()
	end

	for iter_93_2, iter_93_3 in pairs(arg_93_0.furnitures) do
		iter_93_3:Dispose()
	end

	arg_93_0.ships = nil
	arg_93_0.furnitures = nil
end

function var_0_0.GetDirty(arg_94_0)
	return arg_94_0.recoder:TakeSample()
end

function var_0_0.ToTable(arg_95_0)
	local var_95_0 = {}

	local function var_95_1(arg_96_0)
		arg_96_0.floor = arg_95_0.id
		var_95_0[arg_96_0.id] = arg_96_0
	end

	for iter_95_0, iter_95_1 in pairs(arg_95_0.furnitures) do
		var_95_1(iter_95_1:ToTable())
	end

	if arg_95_0.wallPaper then
		var_95_1(arg_95_0.wallPaper:ToTable())
	end

	if arg_95_0.floorPaper then
		var_95_1(arg_95_0.floorPaper:ToTable())
	end

	return var_95_0
end

return var_0_0
