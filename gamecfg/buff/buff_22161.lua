return {
	effect_list = {
		{
			type = "BattleBuffCount",
			trigger = {
				"onFire"
			},
			arg_list = {
				countTarget = 12,
				countType = 22160,
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
				skill_id = 22161,
				countType = 22160
			}
		}
	},
	{
		desc = "主炮每进行12次攻击，触发全弹发射-{namecode:37}I"
	},
	init_effect = "",
	name = "全弹发射",
	time = 0,
	color = "red",
	picture = "",
	desc = "主炮每进行12次攻击，触发全弹发射-{namecode:37}I",
	stack = 1,
	id = 22161,
	icon = 20100,
	last_effect = ""
}
