return {
	effect_list = {
		{
			type = "BattleBuffCount",
			trigger = {
				"onFire"
			},
			arg_list = {
				countTarget = 8,
				countType = 20280,
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
				skill_id = 20282,
				countType = 20280
			}
		}
	},
	{
		desc = "主炮每进行8次攻击，触发全弹发射-巴尔的摩级II"
	},
	init_effect = "",
	name = "全弹发射",
	time = 0,
	color = "red",
	picture = "",
	desc = "主炮每进行8次攻击，触发全弹发射-巴尔的摩级II",
	stack = 1,
	id = 20282,
	icon = 20200,
	last_effect = ""
}
