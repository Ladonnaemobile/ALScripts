return {
	init_effect = "",
	name = "2024鲁梅活动 BOSS入场无敌",
	time = 0.3,
	picture = "",
	desc = "",
	stack = 1,
	id = 201211,
	icon = 201211,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffSetBattleUnitType",
			trigger = {
				"onAttach",
				"onRemove"
			},
			arg_list = {
				value = -100
			}
		}
	}
}
