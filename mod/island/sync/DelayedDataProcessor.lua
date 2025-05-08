local var_0_0 = class("DelayedDataProcesseor")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.delayedDataDic = {}
	arg_1_0.preTimeStampDic = {}
	arg_1_0.delayedTime = arg_1_1
	arg_1_0.intervalTime = arg_1_2
	arg_1_0.func = arg_1_3
end

function var_0_0.Add(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if arg_2_0.preTimeStampDic[arg_2_1] then
		var_2_0 = arg_2_0.preTimeStampDic[arg_2_1] + arg_2_0.intervalTime
	else
		arg_2_0.delayedDataDic[arg_2_1] = {}
		var_2_0 = pg.TimeMgr.GetInstance():GetServerTimeMs() + arg_2_0.delayedTime
	end

	table.insert(arg_2_0.delayedDataDic[arg_2_1], {
		data = arg_2_2,
		timeStamp = var_2_0
	})

	arg_2_0.preTimeStampDic[arg_2_1] = var_2_0
end

function var_0_0.Update(arg_3_0)
	local var_3_0 = pg.TimeMgr.GetInstance():GetServerTimeMs()

	for iter_3_0, iter_3_1 in pairs(arg_3_0.delayedDataDic) do
		if #iter_3_1 > 0 and var_3_0 >= iter_3_1[1].timeStamp then
			arg_3_0.func(iter_3_1[1].data)
			table.remove(iter_3_1, 1)
		end
	end
end

function var_0_0.Dispose(arg_4_0)
	return
end

return var_0_0
