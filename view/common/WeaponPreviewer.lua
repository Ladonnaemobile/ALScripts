local var_0_0 = class("WeaponPreviewer")
local var_0_1 = Vector3(0, 1, 40)
local var_0_2 = Vector3(40, 1, 40)
local var_0_3 = Vector3(30, 0, 0)
local var_0_4 = Vector3(0.1, 0.1, 0.1)
local var_0_5 = Vector3(330, 0, 0)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.rawImage = arg_1_1

	setActive(arg_1_0.rawImage, false)

	arg_1_0.seaCameraGO = GameObject.Find("BarrageCamera")
	arg_1_0.seaCamera = arg_1_0.seaCameraGO:GetComponent(typeof(Camera))
	arg_1_0.seaCamera.targetTexture = arg_1_0.rawImage.texture
	arg_1_0.seaCamera.enabled = true
	arg_1_0.displayFireFX = true
	arg_1_0.displayHitFX = false
end

function var_0_0.configUI(arg_2_0, arg_2_1)
	arg_2_0.healTF = arg_2_1

	setActive(arg_2_0.healTF, false)
	arg_2_0.healTF:GetComponent("DftAniEvent"):SetEndEvent(function()
		setActive(arg_2_0.healTF, false)
		setText(arg_2_0.healTF:Find("text"), "")
	end)
end

function var_0_0.setDisplayWeapon(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.weaponIds = arg_4_1
	arg_4_0.equipSkinId = arg_4_2 or 0

	arg_4_0:onWeaponUpdate()
end

function var_0_0.SetFXMode(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.displayFireFX = arg_5_1
	arg_5_0.displayHitFX = arg_5_2
end

function var_0_0.load(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	assert(not arg_6_0.loading and not arg_6_0.loaded, "load function can be called only once.")

	arg_6_0.loading = true
	arg_6_0.shipVO = arg_6_2

	ys.Battle.BattleVariable.Init(true)
	ys.Battle.BattleFXPool.GetInstance():Init()

	local var_6_0 = ys.Battle.BattleResourceManager.GetInstance()

	var_6_0:Init()
	var_6_0:AddPreloadResource(var_6_0.GetMapResource(arg_6_1))
	var_6_0:AddPreloadResource(var_6_0.GetDisplayCommonResource())

	if arg_6_0.equipSkinId > 0 then
		var_6_0:AddPreloadResource(var_6_0.GetEquipSkinPreviewRes(arg_6_0.equipSkinId))
	end

	var_6_0:AddPreloadResource(var_6_0.GetShipResource(arg_6_2.configId, arg_6_2.skinId), false)

	if arg_6_2:getShipType() ~= ShipType.WeiXiu then
		for iter_6_0, iter_6_1 in ipairs(arg_6_3) do
			if iter_6_1 ~= 0 then
				local var_6_1 = ys.Battle.BattleDataFunction.GetWeaponDataFromID(iter_6_1).weapon_id

				for iter_6_2, iter_6_3 in ipairs(var_6_1) do
					var_6_0:AddPreloadResource(var_6_0.GetWeaponResource(iter_6_3))
				end
			end
		end
	end

	local function var_6_2()
		arg_6_0.seaView = ys.Battle.BattleMap.New(arg_6_1)

		local function var_7_0(arg_8_0)
			arg_6_0.loading = false
			arg_6_0.loaded = true

			pg.UIMgr.GetInstance():LoadingOff()

			arg_6_0.seaCharacter = arg_8_0

			local var_8_0 = arg_6_2:getConfig("scale") / 50
			local var_8_1 = arg_8_0.transform

			var_8_1.localScale = Vector3(var_8_0, var_8_0, var_8_0)
			var_8_1.localPosition = var_0_1
			var_8_1.localEulerAngles = var_0_3
			arg_6_0.seaAnimator = var_8_1:GetComponent("SpineAnim")
			arg_6_0.characterAction = ys.Battle.BattleConst.ActionName.MOVE

			arg_6_0.seaAnimator:SetAction(arg_6_0.characterAction, 0, true)

			arg_6_0.seaFXList = {}
			arg_6_0._FXAttachPoint = GameObject()

			local var_8_2 = arg_6_0._FXAttachPoint.transform

			var_8_2:SetParent(var_8_1, false)

			var_8_2.localPosition = Vector3.zero
			var_8_2.localEulerAngles = var_0_5

			local var_8_3 = pg.ship_skin_template[arg_6_2.skinId].fx_container
			local var_8_4 = {}

			for iter_8_0, iter_8_1 in ipairs(ys.Battle.BattleConst.FXContainerIndex) do
				local var_8_5 = var_8_3[iter_8_0]

				var_8_4[iter_8_0] = Vector3(var_8_5[1], var_8_5[2], var_8_5[3])
			end

			arg_6_0._FXOffset = var_8_4

			if arg_6_0.equipSkinId > 0 then
				arg_6_0:attachOrbit()
			end

			local var_8_6 = ys.Battle.BattleFXPool.GetInstance()
			local var_8_7 = var_8_6:GetCharacterFX("movewave", arg_6_0)

			pg.EffectMgr.GetInstance():PlayBattleEffect(var_8_7, Vector3.zero, true)

			arg_6_0.seaFXPool = var_8_6

			if arg_6_2:getShipType() ~= ShipType.WeiXiu then
				arg_6_0.boneList = {}

				local var_8_8 = var_8_1.localToWorldMatrix
				local var_8_9 = pg.ship_skin_template[arg_6_2.skinId]

				for iter_8_2, iter_8_3 in pairs(var_8_9.bound_bone) do
					local var_8_10 = {}

					for iter_8_4, iter_8_5 in ipairs(iter_8_3) do
						if type(iter_8_5) == "table" then
							var_8_10[#var_8_10 + 1] = Vector3(iter_8_5[1], iter_8_5[2], iter_8_5[3])
						else
							var_8_10[#var_8_10 + 1] = Vector3.zero
						end
					end

					arg_6_0.boneList[iter_8_2] = var_8_8:MultiplyPoint3x4(var_8_10[1])
				end

				arg_6_0:SeaUpdate()
			end

			setActive(arg_6_0.rawImage, true)
			pg.TimeMgr.GetInstance():ResumeBattleTimer()
			arg_6_0:onWeaponUpdate()
			arg_6_4()
		end

		var_6_0:InstCharacter(arg_6_2:getPrefab(), function(arg_9_0)
			var_7_0(arg_9_0)
		end)
	end

	var_6_0:StartPreload(var_6_2, nil)
	pg.UIMgr.GetInstance():LoadingOn()
end

function var_0_0.attachOrbit(arg_10_0)
	local var_10_0 = pg.equip_skin_template[arg_10_0.equipSkinId]

	if var_10_0.orbit_combat ~= "" then
		arg_10_0.orbitList = {}

		local var_10_1 = ys.Battle.BattleResourceManager.GetOrbitPath(var_10_0.orbit_combat)

		ResourceMgr.Inst:getAssetAsync(var_10_1, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_11_0)
			if arg_10_0.seaCharacter then
				local var_11_0 = Object.Instantiate(arg_11_0)

				table.insert(arg_10_0.orbitList, var_11_0)

				local var_11_1 = var_10_0.orbit_combat_bound[1]
				local var_11_2 = var_10_0.orbit_combat_bound[2]

				var_11_0.transform.localPosition = Vector3(var_11_2[1], var_11_2[2], var_11_2[3])

				local var_11_3 = SpineAnim.AddFollower(var_11_1, arg_10_0.seaCharacter.transform, var_11_0.transform):GetComponent("Spine.Unity.BoneFollower")

				if var_10_0.orbit_rotate then
					var_11_3.followBoneRotation = true

					local var_11_4 = var_11_0.transform.localEulerAngles

					var_11_0.transform.localEulerAngles = Vector3(var_11_4.x, var_11_4.y, var_11_4.z - 90)
				else
					var_11_3.followBoneRotation = false
				end
			end
		end), true, true)
	end
end

function var_0_0.playShipAnims(arg_12_0)
	if arg_12_0.loaded and arg_12_0.seaAnimator then
		local var_12_0 = {
			"attack",
			"victory",
			"dead"
		}

		local function var_12_1(arg_13_0)
			if arg_12_0.seaAnimator then
				arg_12_0.seaAnimator:SetActionCallBack(nil)
			end

			arg_12_0.seaAnimator:SetAction(var_12_0[arg_13_0], 0, false)
			arg_12_0.seaAnimator:SetActionCallBack(function(arg_14_0)
				if arg_14_0 == "finish" then
					arg_12_0.seaAnimator:SetActionCallBack(nil)
					arg_12_0.seaAnimator:SetAction("stand", 0, false)
				end
			end)
		end

		if arg_12_0.palyAnimTimer then
			arg_12_0.palyAnimTimer:Stop()

			arg_12_0.palyAnimTimer = nil
		end

		arg_12_0.palyAnimTimer = Timer.New(function()
			var_12_1(math.random(1, #var_12_0))
		end, 5, -1)

		arg_12_0.palyAnimTimer:Start()
		arg_12_0.palyAnimTimer.func()
	end
end

function var_0_0.onWeaponUpdate(arg_16_0)
	if arg_16_0.loaded and arg_16_0.weaponIds then
		if arg_16_0.seaAnimator then
			arg_16_0.seaAnimator:SetActionCallBack(nil)
		end

		local function var_16_0()
			for iter_17_0, iter_17_1 in pairs(arg_16_0.weaponList or {}) do
				for iter_17_2, iter_17_3 in pairs(iter_17_1.emitterList or {}) do
					iter_17_3:Destroy()
				end
			end

			for iter_17_4, iter_17_5 in ipairs(arg_16_0.bulletList or {}) do
				Object.Destroy(iter_17_5._go)
			end

			for iter_17_6, iter_17_7 in pairs(arg_16_0.aircraftList or {}) do
				Object.Destroy(iter_17_7.obj)
			end

			arg_16_0.bulletList = {}
			arg_16_0.aircraftList = {}
			arg_16_0.UpdateHandlers = {}
		end

		if #arg_16_0.weaponIds == 0 and arg_16_0.playRandomAnims then
			if arg_16_0._fireTimer then
				arg_16_0._fireTimer:Stop()
			end

			if arg_16_0._delayTimer then
				arg_16_0._delayTimer:Stop()
			end

			if arg_16_0.shipVO:getShipType() ~= ShipType.WeiXiu then
				var_16_0()
			elseif arg_16_0.buffTimer then
				pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_16_0.buffTimer)

				arg_16_0.buffTimer = nil
			end

			arg_16_0:playShipAnims()
		elseif arg_16_0.shipVO:getShipType() ~= ShipType.WeiXiu then
			var_16_0()
			arg_16_0:MakeWeapon(arg_16_0.weaponIds)
			arg_16_0:SeaFire()
		else
			local var_16_1 = arg_16_0.weaponIds[1]

			if var_16_1 then
				local var_16_2 = Equipment.getConfigData(var_16_1).skill_id[1]
				local var_16_3 = var_16_2 and var_16_2[1]

				arg_16_0:MakeBuff(var_16_3)
			end
		end
	end
end

function var_0_0.SeaFire(arg_18_0)
	local var_18_0 = 1

	if arg_18_0._fireTimer then
		arg_18_0._delayTimer:Stop()
		arg_18_0._fireTimer:Stop()
		arg_18_0._fireTimer:Start()
	else
		local function var_18_1()
			local var_19_0 = arg_18_0.weaponList[var_18_0]

			if var_19_0 then
				local function var_19_1()
					local var_20_0 = 1
					local var_20_1 = 0

					for iter_20_0, iter_20_1 in ipairs(var_19_0.emitterList) do
						iter_20_1:Ready()
					end

					for iter_20_2, iter_20_3 in ipairs(var_19_0.emitterList) do
						iter_20_3:Fire(nil, var_20_0, var_20_1)
					end

					local var_20_2 = var_19_0.tmpData.fire_fx

					if arg_18_0.equipSkinId > 0 then
						local var_20_3, var_20_4, var_20_5, var_20_6, var_20_7, var_20_8 = ys.Battle.BattleDataFunction.GetEquipSkin(arg_18_0.equipSkinId)

						if var_20_7 ~= "" then
							var_20_2 = var_20_7
						end
					end

					if var_20_2 and var_20_2 ~= "" and arg_18_0.displayFireFX then
						arg_18_0.seaFXPool:GetCharacterFX(var_20_2, arg_18_0, true, function()
							return
						end)
					end

					var_18_0 = var_18_0 + 1
				end

				if var_19_0.tmpData.action_index ~= "" then
					arg_18_0.characterAction = var_19_0.tmpData.action_index

					arg_18_0.seaAnimator:SetAction(arg_18_0.characterAction, 0, false)
					arg_18_0.seaAnimator:SetActionCallBack(function(arg_22_0)
						if arg_22_0 == "action" then
							var_19_1()
						end
					end)
				else
					var_19_1()
				end
			elseif arg_18_0.characterAction ~= ys.Battle.BattleConst.ActionName.MOVE then
				arg_18_0.characterAction = ys.Battle.BattleConst.ActionName.MOVE

				arg_18_0.seaAnimator:SetAction(arg_18_0.characterAction, 0, true)

				var_18_0 = 1

				arg_18_0._fireTimer:Pause()
				arg_18_0._delayTimer:Start()
			end
		end

		arg_18_0._fireTimer = pg.TimeMgr.GetInstance():AddBattleTimer("barrageFireTimer", -1, 1.5, var_18_1)

		local function var_18_2()
			arg_18_0._delayTimer:Stop()
			arg_18_0._fireTimer:Resume()
		end

		arg_18_0._delayTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", -1, 3, var_18_2, nil, true)
	end
end

function var_0_0.MakeBuff(arg_24_0, arg_24_1)
	local var_24_0 = getSkillConfig(arg_24_1)
	local var_24_1 = var_24_0.effect_list[1].arg_list.skill_id
	local var_24_2 = var_24_0.effect_list[1].arg_list.time
	local var_24_3 = pg.skillCfg["skill_" .. var_24_1]

	if arg_24_0.buffTimer then
		pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_24_0.buffTimer)

		arg_24_0.buffTimer = nil
	end

	arg_24_0.buffTimer = pg.TimeMgr.GetInstance():AddBattleTimer("buffTimer", -1, var_24_2, function()
		setActive(arg_24_0.healTF, true)
		setText(arg_24_0.healTF:Find("text"), var_24_3.effect_list[1].arg_list.number)
	end)
end

function var_0_0.MakeWeapon(arg_26_0, arg_26_1)
	arg_26_0.weaponList = {}
	arg_26_0.bulletList = {}
	arg_26_0.aircraftList = {}

	local var_26_0 = 0
	local var_26_1 = ys.Battle.BattleConst

	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		local var_26_2 = Equipment.getConfigData(iter_26_1).weapon_id

		for iter_26_2, iter_26_3 in ipairs(var_26_2) do
			if iter_26_3 <= 0 then
				break
			end

			var_26_0 = var_26_0 + 1

			local var_26_3 = ys.Battle.BattleDataFunction.GetWeaponPropertyDataFromID(iter_26_3)

			if var_26_3.type == var_26_1.EquipmentType.MAIN_CANNON or var_26_3.type == var_26_1.EquipmentType.SUB_CANNON or var_26_3.type == var_26_1.EquipmentType.TORPEDO or var_26_3.type == var_26_1.EquipmentType.MANUAL_TORPEDO or var_26_3.type == var_26_1.EquipmentType.POINT_HIT_AND_LOCK then
				if type(var_26_3.barrage_ID) == "table" then
					arg_26_0.weaponList[var_26_0] = {
						tmpData = var_26_3,
						emitterList = {}
					}

					for iter_26_4, iter_26_5 in ipairs(var_26_3.barrage_ID) do
						local var_26_4 = arg_26_0:createEmitterCannon(iter_26_5, var_26_3.bullet_ID[iter_26_4], var_26_3.spawn_bound)

						arg_26_0.weaponList[var_26_0].emitterList[iter_26_4] = var_26_4
					end
				end
			elseif var_26_3.type == var_26_1.EquipmentType.PREVIEW_ARICRAFT and type(var_26_3.barrage_ID) == "table" then
				arg_26_0.weaponList[var_26_0] = {
					tmpData = var_26_3,
					emitterList = {}
				}

				for iter_26_6, iter_26_7 in ipairs(var_26_3.barrage_ID) do
					local var_26_5 = arg_26_0:createEmitterAir(iter_26_7, var_26_3.bullet_ID[iter_26_6], var_26_3.spawn_bound)

					arg_26_0.weaponList[var_26_0].emitterList[iter_26_6] = var_26_5
				end
			end
		end
	end
end

function var_0_0.getEmitterHost(arg_27_0)
	if not arg_27_0._emitterHost then
		arg_27_0._emitterHost = ys.Battle.BattlePlayerUnit.New(1, ys.Battle.BattleConfig.FRIENDLY_CODE)

		local var_27_0 = {
			speed = 0
		}

		arg_27_0._emitterHost:SetSkinId(arg_27_0.shipVO.skinId)
		arg_27_0._emitterHost:SetTemplate(arg_27_0.shipVO.configId, var_27_0)
	end

	return arg_27_0._emitterHost
end

function var_0_0.createEmitterCannon(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_0:getEmitterHost()

	local function var_28_1(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
		local var_29_0
		local var_29_1 = ys.Battle.BattleDataFunction.CreateBattleBulletData(arg_28_2, arg_28_2, var_28_0, var_29_0, var_0_2)

		var_29_1:SetOffsetPriority(arg_29_3)
		var_29_1:SetShiftInfo(arg_29_0, arg_29_1)
		var_29_1:SetRotateInfo(nil, 0, arg_29_2)

		if arg_28_0.equipSkinId > 0 then
			local var_29_2 = pg.equip_skin_template[arg_28_0.equipSkinId]
			local var_29_3, var_29_4, var_29_5, var_29_6, var_29_7, var_29_8 = ys.Battle.BattleDataFunction.GetEquipSkin(arg_28_0.equipSkinId)
			local var_29_9 = var_29_1:GetType()
			local var_29_10 = ys.Battle.BattleConst.BulletType
			local var_29_11

			if var_29_9 == var_29_10.CANNON or var_29_9 == var_29_10.BOMB then
				if _.any(EquipType.CannonEquipTypes, function(arg_30_0)
					return table.contains(var_29_2.equip_type, arg_30_0)
				end) then
					var_29_1:SetModleID(var_29_3)
				elseif var_29_4 and #var_29_4 > 0 then
					var_29_1:SetModleID(var_29_4, nil, var_29_8)
				elseif var_29_6 and #var_29_6 > 0 then
					var_29_1:SetModleID(var_29_6, nil, var_29_8)
				end
			elseif var_29_9 == var_29_10.TORPEDO then
				if table.contains(var_29_2.equip_type, EquipType.Torpedo) then
					var_29_1:SetModleID(var_29_3)
				elseif var_29_5 and #var_29_5 > 0 then
					var_29_1:SetModleID(var_29_5, nil, var_29_8)
				end
			end
		end

		local var_29_12 = var_29_1:GetType()
		local var_29_13 = ys.Battle.BattleConst.BulletType
		local var_29_14

		if var_29_12 == var_29_13.CANNON then
			var_29_14 = ys.Battle.BattleCannonBullet.New()
		elseif var_29_12 == var_29_13.BOMB then
			var_29_14 = ys.Battle.BattleBombBullet.New()
		elseif var_29_12 == var_29_13.TORPEDO then
			var_29_14 = ys.Battle.BattleTorpedoBullet.New()
		else
			var_29_14 = ys.Battle.BattleBullet.New()
		end

		var_29_14:SetBulletData(var_29_1)

		local function var_29_15(arg_31_0)
			var_29_14:AddModel(arg_31_0)
			var_29_14:AddRotateScript()

			local var_31_0 = tf(arg_31_0)

			if var_31_0.parent then
				var_31_0.parent = nil
			end

			local var_31_1 = var_31_0:Find("bullet_random")

			if var_31_1 and var_31_1:GetComponent(typeof(SpineAnim)) then
				local var_31_2 = var_31_1:GetComponent(typeof(SpineAnim))
				local var_31_3 = tostring(math.random(3))

				var_31_2:SetAction(var_31_3, 0, false)
			end

			var_29_14:SetSpawn(arg_28_0.boneList[arg_28_3])

			if arg_28_0.bulletList then
				table.insert(arg_28_0.bulletList, var_29_14)

				if arg_28_0.equipSkinId > 0 then
					local var_31_4 = pg.equip_skin_template[arg_28_0.equipSkinId]
					local var_31_5 = var_29_1:GetType()
					local var_31_6 = ys.Battle.BattleConst.BulletType

					if var_31_5 == var_31_6.CANNON then
						if _.any(EquipType.CannonEquipTypes, function(arg_32_0)
							return table.contains(var_31_4.equip_type, arg_32_0)
						end) and var_31_4.preview_hit_distance > 0 then
							arg_28_0:AddSelfDestroyBullet(var_29_14, var_31_4.preview_hit_distance)
						end
					elseif var_31_5 == var_31_6.TORPEDO and table.contains(var_31_4.equip_type, EquipType.Torpedo) and var_31_4.preview_hit_distance > 0 then
						arg_28_0:AddSelfDestroyBullet(var_29_14, var_31_4.preview_hit_distance)
					end
				end
			end
		end

		ys.Battle.BattleResourceManager.GetInstance():InstBullet(var_29_14:GetModleID(), function(arg_33_0)
			var_29_15(arg_33_0)
		end)
	end

	local function var_28_2()
		return
	end

	local var_28_3 = "BattleBulletEmitter"

	return (ys.Battle[var_28_3].New(var_28_1, var_28_2, arg_28_1))
end

function var_0_0.createEmitterAir(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local function var_35_0(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
		local var_36_0 = {
			id = arg_35_2
		}
		local var_36_1 = pg.aircraft_template[arg_35_2]

		var_36_0.tmpData = var_36_1

		local var_36_2 = math.deg2Rad * arg_36_2
		local var_36_3 = Vector3(math.cos(var_36_2), 0, math.sin(var_36_2))

		local function var_36_4(arg_37_0)
			local var_37_0 = var_0_1 + Vector3(var_36_1.position_offset[1] + arg_36_0, var_36_1.position_offset[2], var_36_1.position_offset[3] + arg_36_1)

			arg_37_0.transform.localPosition = var_37_0
			arg_37_0.transform.localScale = var_0_4
			var_36_0.obj = arg_37_0
			var_36_0.tf = arg_37_0.transform
			var_36_0.pos = var_37_0
			var_36_0.baseVelocity = ys.Battle.BattleFormulas.ConvertAircraftSpeed(var_36_0.tmpData.speed)
			var_36_0.speed = var_36_3 * var_36_0.baseVelocity
			var_36_0.speedZ = (math.random() - 0.5) * 0.5
			var_36_0.targetZ = var_0_1.z

			if arg_35_0.aircraftList then
				table.insert(arg_35_0.aircraftList, var_36_0)
			end
		end

		local var_36_5 = var_36_1.model_ID

		if arg_35_0.equipSkinId > 0 then
			local var_36_6 = pg.equip_skin_template[arg_35_0.equipSkinId]

			if table.contains(var_36_6.equip_type, EquipType.AirProtoEquipTypes[var_36_1.type]) then
				var_36_5 = ys.Battle.BattleDataFunction.GetEquipSkin(arg_35_0.equipSkinId)
			end
		end

		ys.Battle.BattleResourceManager.GetInstance():InstAirCharacter(var_36_5, function(arg_38_0)
			var_36_4(arg_38_0)
		end)
	end

	local function var_35_1()
		return
	end

	local var_35_2 = "BattleBulletEmitter"

	return (ys.Battle[var_35_2].New(var_35_0, var_35_1, arg_35_1))
end

function var_0_0.AddSelfDestroyBullet(arg_40_0, arg_40_1, arg_40_2)
	if not arg_40_0.displayHitFX then
		return
	end

	table.insert(arg_40_0.UpdateHandlers, function(arg_41_0)
		local var_41_0 = table.indexof(arg_40_0.bulletList, arg_40_1)

		if not var_41_0 then
			arg_41_0()

			return
		end

		if arg_40_1:GetBulletData():GetCurrentDistance() < arg_40_2 then
			return
		end

		arg_40_0:RemoveBullet(var_41_0, true)
		arg_41_0()
	end)
end

function var_0_0.RemoveBullet(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_0.bulletList[arg_42_1]

	Object.Destroy(var_42_0._go)
	table.remove(arg_42_0.bulletList, arg_42_1)

	if arg_42_2 then
		local var_42_1 = var_42_0:GetMissFXID()

		if arg_42_0.equipSkinId > 0 then
			local var_42_2 = pg.equip_skin_template[arg_42_0.equipSkinId]

			if var_42_2.hit_fx_name ~= "" then
				var_42_1 = var_42_2.hit_fx_name
			end
		end

		if var_42_1 and var_42_1 ~= "" then
			local var_42_3, var_42_4 = arg_42_0.seaFXPool:GetFX(var_42_1)

			pg.EffectMgr.GetInstance():PlayBattleEffect(var_42_3, var_42_0:GetPosition() + var_42_4, true)
		end
	end
end

function var_0_0.SeaUpdate(arg_43_0)
	local var_43_0 = 0
	local var_43_1 = -20
	local var_43_2 = 60
	local var_43_3 = 0
	local var_43_4 = 60
	local var_43_5 = ys.Battle.BattleConfig
	local var_43_6 = ys.Battle.BattleConst

	local function var_43_7()
		for iter_44_0 = #arg_43_0.bulletList, 1, -1 do
			local var_44_0 = arg_43_0.bulletList[iter_44_0]
			local var_44_1 = var_44_0._bulletData:GetSpeed()()
			local var_44_2 = var_44_0:GetPosition()

			if var_44_2.x > var_43_2 and var_44_1.x > 0 or var_44_2.z < var_43_3 and var_44_1.z < 0 then
				arg_43_0:RemoveBullet(iter_44_0, false)
			elseif var_44_2.x < var_43_1 and var_44_1.x < 0 and var_44_0:GetType() ~= var_43_6.BulletType.BOMB then
				arg_43_0:RemoveBullet(iter_44_0, false)
			else
				local var_44_3 = pg.TimeMgr.GetInstance():GetCombatTime()

				var_44_0._bulletData:Update(var_44_3)
				var_44_0:Update(var_43_0)

				if var_44_2.z > var_43_4 and var_44_1.z > 0 or var_44_0._bulletData:IsOutRange(var_43_0) then
					arg_43_0:RemoveBullet(iter_44_0, true)
				end
			end
		end

		for iter_44_1, iter_44_2 in ipairs(arg_43_0.aircraftList) do
			local var_44_4 = iter_44_2.pos + iter_44_2.speed

			if var_44_4.y < var_43_5.AircraftHeight + 5 then
				iter_44_2.speed.y = math.max(0.4, 1 - var_44_4.y / var_43_5.AircraftHeight)

				local var_44_5 = math.min(1, var_44_4.y / var_43_5.AircraftHeight)

				iter_44_2.tf.localScale = Vector3(var_44_5, var_44_5, var_44_5)
			end

			iter_44_2.speed.z = iter_44_2.baseVelocity * iter_44_2.speedZ

			local var_44_6 = iter_44_2.targetZ - var_44_4.z

			if var_44_6 > iter_44_2.baseVelocity then
				iter_44_2.speed.z = iter_44_2.baseVelocity * 0.5
			elseif var_44_6 < -iter_44_2.baseVelocity then
				iter_44_2.speed.z = -iter_44_2.baseVelocity * 0.5
			else
				iter_44_2.targetZ = var_0_1.z + var_0_1.z * (math.random() - 0.5) * 0.6
			end

			if var_44_4.x > var_43_2 or var_44_4.x < var_43_1 then
				Object.Destroy(iter_44_2.obj)
				table.remove(arg_43_0.aircraftList, iter_44_1)
			else
				iter_44_2.tf.localPosition = var_44_4
				iter_44_2.pos = var_44_4
			end
		end

		for iter_44_3 = #arg_43_0.UpdateHandlers, 1, -1 do
			local var_44_7 = arg_43_0.UpdateHandlers[iter_44_3]

			local function var_44_8()
				table.remove(arg_43_0.UpdateHandlers, iter_44_3)
			end

			var_44_7(var_44_8)
		end

		var_43_0 = var_43_0 + 1
	end

	pg.TimeMgr.GetInstance():AddBattleTimer("barrageUpdateTimer", -1, 0.033, var_43_7)
end

function var_0_0.GetFXOffsets(arg_46_0, arg_46_1)
	arg_46_1 = arg_46_1 or 1

	return arg_46_0._FXOffset[arg_46_1]
end

function var_0_0.GetAttachPoint(arg_47_0)
	return arg_47_0._FXAttachPoint
end

function var_0_0.GetGO(arg_48_0)
	return arg_48_0.seaCharacter
end

function var_0_0.GetSpecificFXScale(arg_49_0)
	return {}
end

function var_0_0.clear(arg_50_0)
	pg.TimeMgr.GetInstance():RemoveAllBattleTimer()

	arg_50_0._emitterHost = nil

	if arg_50_0.seaCharacter then
		Destroy(arg_50_0.seaCharacter)

		arg_50_0.seaCharacter = nil
	end

	if arg_50_0.aircraftList then
		for iter_50_0, iter_50_1 in ipairs(arg_50_0.aircraftList) do
			Destroy(iter_50_1.obj)
		end

		arg_50_0.aircraftList = nil
	end

	if arg_50_0.seaView then
		arg_50_0.seaView:Dispose()

		arg_50_0.seaView = nil
	end

	if arg_50_0.weaponList then
		for iter_50_2, iter_50_3 in ipairs(arg_50_0.weaponList) do
			for iter_50_4, iter_50_5 in ipairs(iter_50_3.emitterList) do
				iter_50_5:Destroy()
			end
		end

		arg_50_0.weaponList = nil
	end

	if arg_50_0.bulletList then
		for iter_50_6, iter_50_7 in ipairs(arg_50_0.bulletList) do
			Destroy(iter_50_7._go)
		end

		arg_50_0.bulletList = nil
	end

	if arg_50_0.orbitList then
		for iter_50_8, iter_50_9 in ipairs(arg_50_0.orbitList) do
			Destroy(iter_50_9)
		end

		arg_50_0.orbitList = nil
	end

	if arg_50_0.seaFXPool then
		arg_50_0.seaFXPool:Clear()

		arg_50_0.seaFXPool = nil
	end

	if arg_50_0.seaFXContainersPool then
		arg_50_0.seaFXContainersPool:Clear()

		arg_50_0.seaFXContainersPool = nil
	end

	ys.Battle.BattleResourceManager.GetInstance():Clear()

	arg_50_0.seaCamera.enabled = false
	arg_50_0.seaCameraGO = nil
	arg_50_0.seaCamera = nil
	arg_50_0.loading = false
	arg_50_0.loaded = false

	if arg_50_0.palyAnimTimer then
		arg_50_0.palyAnimTimer:Stop()

		arg_50_0.palyAnimTimer = nil
	end
end

return var_0_0
