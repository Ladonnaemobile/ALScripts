local var_0_0 = class("CourtYardBaseSubPage")

var_0_0.STATES = {
	DESTROY = 5,
	NONE = 1,
	LOADING = 2,
	INITED = 4,
	LOADED = 3
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.contextData = arg_1_2
	arg_1_0.parent = arg_1_1
	arg_1_0._parentTf = arg_1_1._tf
	arg_1_0._go = nil
	arg_1_0._tf = nil
	arg_1_0._state = var_0_0.STATES.NONE
	arg_1_0._funcQueue = {}
end

function var_0_0.Load(arg_2_0)
	if arg_2_0._state ~= var_0_0.STATES.NONE then
		return
	end

	arg_2_0._state = var_0_0.STATES.LOADING

	pg.UIMgr.GetInstance():LoadingOn()

	local var_2_0 = PoolMgr.GetInstance()

	var_2_0:GetUI(arg_2_0:getUIName(), true, function(arg_3_0)
		if arg_2_0._state == var_0_0.STATES.DESTROY then
			pg.UIMgr.GetInstance():LoadingOff()
			var_2_0:ReturnUI(arg_2_0:getUIName(), arg_3_0)
		else
			arg_2_0:Loaded(arg_3_0)
			arg_2_0:Init()
		end
	end)
end

function var_0_0.Loaded(arg_4_0, arg_4_1)
	pg.UIMgr.GetInstance():LoadingOff()

	if arg_4_0._state ~= var_0_0.STATES.LOADING then
		return
	end

	arg_4_0._state = var_0_0.STATES.LOADED
	arg_4_0._go = arg_4_1
	arg_4_0._tf = tf(arg_4_1)

	pg.DelegateInfo.New(arg_4_0)
	SetParent(arg_4_0._tf, arg_4_0._parentTf, false)
	arg_4_0:OnLoaded()
end

function var_0_0.Init(arg_5_0)
	if arg_5_0._state ~= var_0_0.STATES.LOADED then
		return
	end

	arg_5_0._state = var_0_0.STATES.INITED

	arg_5_0:OnInit()
	arg_5_0:HandleFuncQueue()
end

function var_0_0.Destroy(arg_6_0)
	if arg_6_0._state == var_0_0.STATES.DESTROY then
		return
	end

	if not arg_6_0:GetLoaded() then
		arg_6_0._state = var_0_0.STATES.DESTROY

		return
	end

	arg_6_0._state = var_0_0.STATES.DESTROY

	pg.DelegateInfo.Dispose(arg_6_0)
	arg_6_0:OnDestroy()

	arg_6_0._tf = nil

	local var_6_0 = PoolMgr.GetInstance()
	local var_6_1 = arg_6_0:getUIName()

	if arg_6_0._go ~= nil and var_6_1 then
		var_6_0:ReturnUI(var_6_1, arg_6_0._go)

		arg_6_0._go = nil
	end
end

function var_0_0.HandleFuncQueue(arg_7_0)
	if arg_7_0._state == var_0_0.STATES.INITED then
		while #arg_7_0._funcQueue > 0 do
			local var_7_0 = table.remove(arg_7_0._funcQueue, 1)

			var_7_0.func(unpack(var_7_0.params, 1, var_7_0.params.len))
		end
	end
end

function var_0_0.Reset(arg_8_0)
	arg_8_0._state = var_0_0.STATES.NONE
end

function var_0_0.ActionInvoke(arg_9_0, arg_9_1, ...)
	assert(arg_9_0[arg_9_1], "func not exist >>>" .. arg_9_1)

	arg_9_0._funcQueue[#arg_9_0._funcQueue + 1] = {
		funcName = arg_9_1,
		func = arg_9_0[arg_9_1],
		params = {
			len = 1 + select("#", ...),
			arg_9_0,
			...
		}
	}

	arg_9_0:HandleFuncQueue()
end

function var_0_0.CallbackInvoke(arg_10_0, arg_10_1, ...)
	arg_10_0._funcQueue[#arg_10_0._funcQueue + 1] = {
		func = arg_10_1,
		params = packEx(...)
	}

	arg_10_0:HandleFuncQueue()
end

function var_0_0.ExecuteAction(arg_11_0, arg_11_1, ...)
	arg_11_0:Load()
	arg_11_0:ActionInvoke(arg_11_1, ...)
end

function var_0_0.GetLoaded(arg_12_0)
	return arg_12_0._state >= var_0_0.STATES.LOADED
end

function var_0_0.CheckState(arg_13_0, arg_13_1)
	return arg_13_0._state == arg_13_1
end

function var_0_0.Show(arg_14_0)
	setActive(arg_14_0._tf, true)
end

function var_0_0.Hide(arg_15_0)
	setActive(arg_15_0._tf, false)
end

function var_0_0.isShowing(arg_16_0)
	return arg_16_0._tf and isActive(arg_16_0._tf)
end

function var_0_0.Emit(arg_17_0, arg_17_1, ...)
	arg_17_0.parent:Emit(arg_17_1, ...)
end

function var_0_0.findTF(arg_18_0, arg_18_1, arg_18_2)
	assert(arg_18_0._tf, "transform should exist")

	return findTF(arg_18_2 or arg_18_0._tf, arg_18_1)
end

function var_0_0.getTpl(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:findTF(arg_19_1, arg_19_2)

	var_19_0:SetParent(arg_19_0._tf, false)
	SetActive(var_19_0, false)

	return var_19_0
end

function var_0_0.getUIName(arg_20_0)
	return nil
end

function var_0_0.OnLoaded(arg_21_0)
	return
end

function var_0_0.OnInit(arg_22_0)
	return
end

function var_0_0.OnDestroy(arg_23_0)
	return
end

return var_0_0
