return {
	effect_list = {
		{
			type = "BattleBuffCount",
			trigger = {
				"onFire"
			},
			arg_list = {
				countTarget = 8,
				countType = 20210,
				index = {
					1
				}
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onBattleBuffCount"
			},
			arg_list = {
				target = "TargetSelf",
				skill_id = 20212,
				countType = 20210
			}
		}
	},
	{
		desc = "主炮每进行8次攻击，触发全弹发射-彭萨科拉级II"
	},
	init_effect = "",
	name = "全弹发射",
	time = 0,
	color = "red",
	picture = "",
	desc = "主炮每进行8次攻击，触发全弹发射-彭萨科拉级II",
	stack = 1,
	id = 20212,
	icon = 20200,
	last_effect = ""
}
