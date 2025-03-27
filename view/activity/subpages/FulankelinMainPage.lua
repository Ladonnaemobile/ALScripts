local var_0_0 = class("FulankelinMainPage", import("view.base.BaseActivityPage"))
local var_0_1 = 71122
local var_0_2 = ActivityConst.Valleyhospital_ACT_ID
local var_0_3 = ActivityConst.Valleyhospital_ACT_ID

function var_0_0.OnInit(arg_1_0)
	arg_1_0.ad = arg_1_0:findTF("AD")
	arg_1_0.btnCollect = findTF(arg_1_0.ad, "btnCollect")
	arg_1_0.btnSkin = findTF(arg_1_0.ad, "btnSkin")
	arg_1_0.btnSkinText = findTF(arg_1_0.btnSkin, "bgTime/text")
	arg_1_0.btnAct = findTF(arg_1_0.ad, "btnAct")
	arg_1_0.btnActText = findTF(arg_1_0.btnAct, "bgTime/text")
	arg_1_0.btnBuild = findTF(arg_1_0.ad, "btnBuild")
	arg_1_0.btnBuildText = findTF(arg_1_0.btnBuild, "bgTime/text")

	GetComponent(arg_1_0.btnCollect, typeof(Image)):SetNativeSize()
	GetComponent(arg_1_0.btnSkin, typeof(Image)):SetNativeSize()
	GetComponent(arg_1_0.btnAct, typeof(Image)):SetNativeSize()
	GetComponent(arg_1_0.btnBuild, typeof(Image)):SetNativeSize()
	onButton(arg_1_0, arg_1_0.btnCollect, function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_ALBUM
		})
	end)
	onButton(arg_1_0, arg_1_0.btnSkin, function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)
	end, SFX_CONFIRM)
	onButton(arg_1_0, arg_1_0.btnAct, function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CLUE_MAP)
	end, SFX_CONFIRM)
	onButton(arg_1_0, arg_1_0.btnBuild, function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD
		})
	end, SFX_CONFIRM)
end

function var_0_0.OnDataSetting(arg_6_0)
	return
end

function var_0_0.OnFirstFlush(arg_7_0)
	arg_7_0:updateUI()
end

function var_0_0.OnUpdateFlush(arg_8_0)
	arg_8_0:updateUI()
end

function var_0_0.updateUI(arg_9_0)
	local var_9_0, var_9_1 = pg.TimeMgr.GetInstance():inTime(pg.shop_template[var_0_1].time)
	local var_9_2

	if var_9_1 then
		local var_9_3 = pg.TimeMgr.GetInstance():Table2ServerTime(var_9_1)

		var_9_2 = skinCommdityTimeStamp(var_9_3)
	end

	local var_9_4, var_9_5 = pg.TimeMgr.GetInstance():inTime(pg.activity_template[var_0_3].time)
	local var_9_6

	if var_9_5 then
		local var_9_7 = pg.TimeMgr.GetInstance():Table2ServerTime(var_9_5)

		var_9_6 = skinCommdityTimeStamp(var_9_7)
	end

	if var_9_2 then
		setText(arg_9_0.btnSkinText, var_9_2)
	else
		setActive(findTF(arg_9_0.btnSkin, "bgTime"), false)
	end

	setText(arg_9_0.btnActText, "")

	if var_9_6 then
		setText(arg_9_0.btnBuildText, var_9_6)
	else
		setActive(findTF(arg_9_0.btnBuild, "bgTime"), false)
	end
end

return var_0_0
