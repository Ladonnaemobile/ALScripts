local var_0_0 = class("MusicFestivalScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "MusicFestivalUI"
end

var_0_0.HUB_ID = 2

function var_0_0.init(arg_2_0)
	arg_2_0.top = arg_2_0:findTF("top")
	arg_2_0._closeBtn = arg_2_0:findTF("top/back")
	arg_2_0._helpBtn = arg_2_0:findTF("top/help")
	arg_2_0.btn_actskin = arg_2_0.top:Find("idol_jump")
	arg_2_0.btn_ins = arg_2_0.top:Find("ins_jump")
	arg_2_0._map = arg_2_0:findTF("scrollRect/map")
	arg_2_0.stage = arg_2_0._map:Find("stage")
	arg_2_0.screen = arg_2_0._map:Find("screen")
	arg_2_0.shop = arg_2_0._map:Find("shop")
	arg_2_0.painting = arg_2_0._map:Find("painting")
	arg_2_0.cube = arg_2_0._map:Find("cube")
	arg_2_0.foutain = arg_2_0._map:Find("foutain")
	arg_2_0.door = arg_2_0._map:Find("door")
	arg_2_0.bottom = arg_2_0._map:Find("bottom")
	arg_2_0.front = arg_2_0._map:Find("front")
	arg_2_0._shipTpl = arg_2_0._map:Find("ship")
	arg_2_0._xiefei = arg_2_0._map:Find("model/xiefei")
	arg_2_0._modeltip = arg_2_0._xiefei:Find("tip")
	arg_2_0._stageShip = arg_2_0._map:Find("stageship")

	setActive(arg_2_0._modeltip, false)

	arg_2_0.graphPath = GraphPath.New(import("GameCfg/BackHillGraphs/MusicFestivalGraph"))
	arg_2_0._loadingRequest = {}
	arg_2_0._ReturnRequest = {}

	local var_2_0 = "ouxiangxiaoditu"
	local var_2_1 = LoadPrefabRequestPackage.New("ui/" .. var_2_0, var_2_0, function(arg_3_0)
		setParent(arg_3_0, arg_2_0._map)

		local var_3_0 = GameObject.Find("UICamera/Canvas"):GetComponent(typeof(Canvas)).sortingOrder
		local var_3_1 = arg_3_0:GetComponentsInChildren(typeof(Renderer)):ToTable()

		for iter_3_0, iter_3_1 in ipairs(var_3_1) do
			iter_3_1.sortingOrder = var_3_0 + 1
		end
	end):Start()

	table.insert(arg_2_0._loadingRequest, var_2_1)
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0._closeBtn, function()
		arg_4_0:emit(var_0_0.ON_BACK)
	end)
	onButton(arg_4_0, arg_4_0._helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.music_main.tip
		})
	end)
	onButton(arg_4_0, arg_4_0.btn_actskin, function()
		arg_4_0:emit(MusicFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.MUSIC_CHUIXUE7DAY_ID
		})
	end)
	onButton(arg_4_0, arg_4_0.btn_ins, function()
		arg_4_0:emit(MusicFestivalMediator.GO_SUBLAYER, Context.New({
			viewComponent = InstagramLayer,
			mediator = InstagramMediator,
			data = {
				id = ActivityConst.IDOL_INS_ID
			}
		}))
	end)
	onButton(arg_4_0, arg_4_0._xiefei, function()
		arg_4_0:emit(MusicFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.MUSIC_FESTIVAL_ID
		})
	end)
	arg_4_0:InitFacility(arg_4_0.stage, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 6)
	end)
	arg_4_0:InitFacility(arg_4_0.screen, function()
		arg_4_0:emit(MusicFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.IDOL_PT_ID
		})
	end)
	arg_4_0:InitFacility(arg_4_0.shop, function()
		arg_4_0:emit(MusicFestivalMediator.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})
	end)
	arg_4_0:InitFacility(arg_4_0.painting, function()
		arg_4_0:emit(MusicFestivalMediator.GO_SCENE, SCENE.SKINSHOP)
	end)
	arg_4_0:InitFacility(arg_4_0.cube, function()
		arg_4_0:emit(MusicFestivalMediator.GO_SCENE, SCENE.GETBOAT, {
			projectName = "new",
			page = 1
		})
	end)
	arg_4_0:InitFacility(arg_4_0.foutain, function()
		local var_15_0 = Context.New({
			mediator = IdolMedalCollectionMediator,
			viewComponent = IdolMedalCollectionView,
			data = {},
			onRemoved = function()
				setActive(arg_4_0._tf, true)
			end
		})

		arg_4_0:emit(MusicFestivalMediator.GO_SUBLAYER, var_15_0, function()
			setActive(arg_4_0._tf, false)
		end)
	end)
	arg_4_0:InitFacility(arg_4_0.door, function()
		local var_18_0 = getProxy(ChapterProxy)
		local var_18_1, var_18_2 = var_18_0:getLastMapForActivity()

		if not var_18_1 or not var_18_0:getMapById(var_18_1):isUnlock() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
		else
			arg_4_0:emit(MusicFestivalMediator.GO_SCENE, SCENE.LEVEL, {
				chapterId = var_18_2,
				mapIdx = var_18_1
			})
		end
	end)

	arg_4_0.academyStudents = {}

	arg_4_0:InitAreaTransFunc()
	arg_4_0:updateStudents()
	arg_4_0:updateStageShip()
	arg_4_0:UpdateView()
end

function var_0_0.UpdateView(arg_19_0)
	local var_19_0 = getProxy(ActivityProxy)
	local var_19_1 = var_19_0:getActivityById(ActivityConst.MUSIC_FESTIVAL_ID)
	local var_19_2

	if var_19_1 and not var_19_1:isEnd() then
		var_19_2 = var_19_1:readyToAchieve()
	end

	setActive(arg_19_0._modeltip, var_19_2)

	local var_19_3 = arg_19_0.btn_actskin:Find("tip")
	local var_19_4 = var_19_0:getActivityById(ActivityConst.MUSIC_CHUIXUE7DAY_ID)
	local var_19_5 = var_19_4 and not var_19_4:isEnd() and var_19_4:readyToAchieve()

	setActive(var_19_3, var_19_5)

	local var_19_6 = arg_19_0.btn_ins:Find("tip")
	local var_19_7 = getProxy(InstagramProxy):ShouldShowTip()

	setActive(var_19_6, var_19_7)

	local var_19_8 = arg_19_0.screen:Find("tip")
	local var_19_9 = IdolPTPage.NeedTip()

	setActive(var_19_8, var_19_9)

	local var_19_10 = arg_19_0.foutain:Find("tip")
	local var_19_11 = var_0_0.MedalTip()

	setActive(var_19_10, var_19_11)

	local var_19_12 = arg_19_0.stage:Find("tip")
	local var_19_13 = getProxy(MiniGameProxy):GetHubByHubId(arg_19_0.HUB_ID).count > 0

	setActive(var_19_12, var_19_13)
end

function var_0_0.InitFacility(arg_20_0, arg_20_1, arg_20_2)
	onButton(arg_20_0, arg_20_1, arg_20_2)
	onButton(arg_20_0, arg_20_1:Find("button"), arg_20_2)
end

function var_0_0.getStudents(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_FESTIVAL_ID)

	if not var_21_1 then
		return var_21_0
	end

	local var_21_2 = var_21_1:getConfig("config_client")

	var_21_2 = var_21_2 and var_21_2.stage_off_ship

	if var_21_2 then
		local var_21_3 = Clone(var_21_2)
		local var_21_4 = 0
		local var_21_5 = #var_21_3

		while var_21_4 < 3 and var_21_5 > 0 do
			local var_21_6 = math.random(1, var_21_5)

			table.insert(var_21_0, var_21_3[var_21_6])

			var_21_3[var_21_6] = var_21_3[var_21_5]
			var_21_5 = var_21_5 - 1
			var_21_4 = var_21_4 + 1
		end
	end

	return var_21_0
end

function var_0_0.InitAreaTransFunc(arg_22_0)
	arg_22_0.edge2area = {
		["1_2"] = arg_22_0.bottom,
		["2_3"] = arg_22_0.bottom,
		["3_4"] = arg_22_0.bottom
	}
end

function var_0_0.updateStudents(arg_23_0)
	local var_23_0 = arg_23_0:getStudents()

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		if not arg_23_0.academyStudents[iter_23_0] then
			local var_23_1 = cloneTplTo(arg_23_0._shipTpl, arg_23_0._map)

			var_23_1.gameObject.name = iter_23_0

			local var_23_2 = SummerFeastNavigationAgent.New(var_23_1.gameObject)

			var_23_2:attach()
			var_23_2:setPathFinder(arg_23_0.graphPath)
			var_23_2:SetOnTransEdge(function(arg_24_0, arg_24_1, arg_24_2)
				arg_24_1, arg_24_2 = math.min(arg_24_1, arg_24_2), math.max(arg_24_1, arg_24_2)

				local var_24_0 = arg_23_0.edge2area[arg_24_1 .. "_" .. arg_24_2] or arg_23_0.front

				arg_24_0._tf:SetParent(var_24_0)
			end)
			var_23_2:updateStudent(iter_23_1)

			arg_23_0.academyStudents[iter_23_0] = var_23_2
		end
	end

	if #var_23_0 > 0 then
		arg_23_0.sortTimer = Timer.New(function()
			arg_23_0:sortStudents()
		end, 0.2, -1)

		arg_23_0.sortTimer:Start()
		arg_23_0.sortTimer.func()
	end
end

function var_0_0.getStageShip(arg_26_0)
	local var_26_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MUSIC_FESTIVAL_ID)

	if not var_26_0 then
		return
	end

	local var_26_1 = var_26_0:getConfig("config_client")
	local var_26_2 = var_26_1 and var_26_1.stage_on_ship

	if var_26_2 then
		local var_26_3 = #var_26_2

		return var_26_2[math.random(1, var_26_3)], var_26_2.action[1]
	end
end

function var_0_0.updateStageShip(arg_27_0)
	local var_27_0, var_27_1 = arg_27_0:getStageShip()

	if var_27_0 then
		local var_27_2 = GetSpineRequestPackage.New(var_27_0, function(arg_28_0)
			arg_28_0.transform.localScale = Vector3(0.5, 0.5, 1)
			arg_28_0.transform.localPosition = Vector3.zero

			arg_28_0.transform:SetParent(arg_27_0._stageShip, false)
			arg_28_0.transform:SetSiblingIndex(1)
			setActive(arg_27_0._stageShip, true)
			arg_28_0:GetComponent(typeof(SpineAnimUI)):SetAction(var_27_1, 0)

			arg_27_0._loadingRequest[var_27_0] = nil
			arg_27_0._ReturnRequest[var_27_0] = ReturnSpineRequestPackage.New(var_27_0, arg_28_0)
		end):Start()

		arg_27_0._loadingRequest[var_27_0] = var_27_2
	end
end

function var_0_0.sortStudents(arg_29_0)
	local var_29_0 = {
		arg_29_0.front,
		arg_29_0.middle,
		arg_29_0.bottom
	}

	for iter_29_0, iter_29_1 in pairs(var_29_0) do
		if iter_29_1.childCount > 1 then
			local var_29_1 = {}

			for iter_29_2 = 1, iter_29_1.childCount do
				local var_29_2 = iter_29_1:GetChild(iter_29_2 - 1)

				table.insert(var_29_1, {
					tf = var_29_2,
					index = iter_29_2
				})
			end

			table.sort(var_29_1, function(arg_30_0, arg_30_1)
				local var_30_0 = arg_30_0.tf.anchoredPosition.y - arg_30_1.tf.anchoredPosition.y

				if math.abs(var_30_0) < 1 then
					return arg_30_0.index < arg_30_1.index
				else
					return var_30_0 > 0
				end
			end)

			for iter_29_3, iter_29_4 in ipairs(var_29_1) do
				iter_29_4.tf:SetSiblingIndex(iter_29_3 - 1)
			end
		end
	end
end

function var_0_0.clearStudents(arg_31_0)
	if arg_31_0.sortTimer then
		arg_31_0.sortTimer:Stop()

		arg_31_0.sortTimer = nil
	end

	for iter_31_0, iter_31_1 in pairs(arg_31_0.academyStudents) do
		iter_31_1:detach()
		Destroy(iter_31_1._go)
	end

	arg_31_0.academyStudents = {}
end

function var_0_0.TryPlayStory(arg_32_0)
	local var_32_0 = "TIANHOUYUYI2"

	if var_32_0 then
		pg.NewStoryMgr.GetInstance():Play(var_32_0)
	end
end

function var_0_0.MedalTip()
	local var_33_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)

	return Activity.IsActivityReady(var_33_0)
end

function var_0_0.willExit(arg_34_0)
	arg_34_0:clearStudents()

	for iter_34_0, iter_34_1 in pairs(arg_34_0._loadingRequest) do
		iter_34_1:Stop()
	end

	table.clear(arg_34_0._loadingRequest)

	for iter_34_2, iter_34_3 in pairs(arg_34_0._ReturnRequest) do
		iter_34_3()
	end

	table.clear(arg_34_0._ReturnRequest)
end

return var_0_0
