return {
	time = 7,
	name = "2025荷兰活动 堤坝防御带",
	init_effect = "",
	stack = 1,
	id = 201366,
	picture = "",
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onRemove"
			},
			arg_list = {
				buff_id = 201367
			}
		}
	}
}
