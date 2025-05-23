local var_0_0 = class("WSMapResource", import("...BaseEntity"))

var_0_0.Fields = {
	map = "table",
	rtDarkFog = "userdata",
	rtSairenFog = "userdata"
}

function var_0_0.Setup(arg_1_0, arg_1_1)
	arg_1_0.map = arg_1_1
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0:Clear()
end

function var_0_0.Load(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = arg_3_0.map

	table.insert(var_3_0, function(arg_4_0)
		PoolMgr.GetInstance():GetUI("darkfog", true, function(arg_5_0)
			setParent(arg_5_0, GameObject.Find("__Pool__").transform)

			arg_3_0.rtDarkFog = arg_5_0.transform

			setActive(arg_3_0.rtDarkFog, false)
			arg_4_0()
		end)
	end)
	table.insert(var_3_0, function(arg_6_0)
		PoolMgr.GetInstance():GetUI("sairenfog", true, function(arg_7_0)
			setParent(arg_7_0, GameObject.Find("__Pool__").transform)

			arg_3_0.rtSairenFog = arg_7_0.transform

			setActive(arg_3_0.rtSairenFog, false)
			arg_6_0()
		end)
	end)
	seriesAsync(var_3_0, arg_3_1)
end

function var_0_0.Unload(arg_8_0)
	if arg_8_0.rtDarkFog then
		PoolMgr.GetInstance():ReturnUI("darkfog", arg_8_0.rtDarkFog.gameObject)

		arg_8_0.rtDarkFog = nil
	end

	if arg_8_0.rtSairenFog then
		PoolMgr.GetInstance():ReturnUI("darkfog", arg_8_0.rtSairenFog.gameObject)

		arg_8_0.rtSairenFog = nil
	end
end

return var_0_0
