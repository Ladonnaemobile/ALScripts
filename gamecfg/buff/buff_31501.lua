return {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onUpdate"
			},
			arg_list = {
				time = 30,
				target = "TargetSelf",
				skill_id = 31501
			}
		}
	},
	{
		desc = "每隔30秒，释放1次技能鱼雷",
		effect_list = {
			{
				type = "BattleBuffCastSkill",
				trigger = {
					"onUpdate"
				},
				arg_list = {
					time = 30,
					target = "TargetSelf",
					skill_id = 31501
				}
			}
		}
	},
	init_effect = "",
	name = "敌人技能鱼雷三联",
	time = 0,
	picture = "",
	desc = "每隔30秒，释放1次技能鱼雷",
	stack = 1,
	id = 31501,
	icon = 31501,
	last_effect = ""
}
