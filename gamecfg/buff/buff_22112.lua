return {
	effect_list = {
		{
			type = "BattleBuffCount",
			trigger = {
				"onFire"
			},
			arg_list = {
				countTarget = 8,
				countType = 22110,
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
				skill_id = 22112,
				countType = 22110
			}
		}
	},
	{
		desc = "主炮每进行8次攻击，触发全弹发射-{namecode:41}级II"
	},
	init_effect = "",
	name = "全弹发射",
	time = 0,
	color = "red",
	picture = "",
	desc = "主炮每进行8次攻击，触发全弹发射-{namecode:41}级II",
	stack = 1,
	id = 22112,
	icon = 20100,
	last_effect = ""
}
