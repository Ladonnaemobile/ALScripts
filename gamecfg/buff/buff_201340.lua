return {
	time = 0,
	name = "2025医院活动 探索计数 2层效果 抗体",
	init_effect = "",
	stack = 7,
	id = 201340,
	picture = "",
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddAttr",
			trigger = {
				"onAttach",
				"onStack",
				"onRemove"
			},
			arg_list = {
				attr = "injureRatioByAir",
				number = -0.1
			}
		}
	}
}
