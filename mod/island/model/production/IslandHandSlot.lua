local var_0_0 = class("IslandHandSlot", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0:UpdateData(arg_1_1)
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_production_slot
end

function var_0_0.UpdateData(arg_3_0, arg_3_1)
	arg_3_0.id = arg_3_1.id
	arg_3_0.state = arg_3_1.state
	arg_3_0.formula_id = arg_3_1.formula_id
	arg_3_0.end_time = arg_3_1.end_time
end

return var_0_0
