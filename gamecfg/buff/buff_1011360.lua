return {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				skill_id = 1011360
			}
		},
		{
			type = "BattleBuffCount",
			trigger = {
				"onFire"
			},
			arg_list = {
				countTarget = 5,
				countType = 1011360,
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
				skill_id = 1011361,
				countType = 1011360
			}
		}
	},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	desc_get = "出击时，队伍中驱逐舰对巡洋舰伤害提升",
	name = "塔萨法隆格逆袭 +",
	init_effect = "",
	time = 0,
	color = "yellow",
	picture = "",
	desc = "出击时，队伍中驱逐舰对巡洋舰伤害提升",
	stack = 1,
	id = 1011360,
	icon = 11360,
	last_effect = ""
}
