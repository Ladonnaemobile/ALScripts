return {
	init_effect = "",
	name = "黑长门 樱花结界小 月亏效果",
	time = 15,
	picture = "",
	desc = "",
	stack = 1,
	id = 201053,
	icon = 201053,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAura",
			trigger = {
				"onAttach"
			},
			arg_list = {
				buff_id = 201055,
				cld_data = {
					box = {
						range = 13
					}
				}
			}
		}
	}
}
