return {
	init_effect = "",
	name = "2025拉斐尔活动 新EX模式我方判定更改",
	time = 1,
	picture = "",
	desc = "",
	stack = 1,
	id = 201260,
	icon = 201260,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onAttach",
				"onStack"
			},
			arg_list = {
				buff_id = 201262,
				minTargetNumber = 1,
				check_target = {
					"TargetShipTag"
				},
				ship_tag_list = {
					"sinkFirst"
				}
			}
		}
	}
}
