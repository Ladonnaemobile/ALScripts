local var_0_0 = class("ChapterChampionSubmarine", import(".ChapterChampionNormal"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_1)
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.expedition_data_template
end

function var_0_0.getPrefab(arg_3_0)
	return arg_3_0:getConfig("icon")
end

function var_0_0.getFleetType(arg_4_0)
	return FleetType.Submarine
end

function var_0_0.getPoolType(arg_5_0)
	return "tpl_enemy"
end

function var_0_0.getScale(arg_6_0)
	return arg_6_0:getConfig("scale")
end

function var_0_0.inAlertRange(arg_7_0, arg_7_1, arg_7_2)
	return _.any(arg_7_0:getConfig("alert_range"), function(arg_8_0)
		return arg_8_0[1] + arg_7_0.row == arg_7_1 and arg_8_0[2] + arg_7_0.column == arg_7_2
	end)
end

return var_0_0
