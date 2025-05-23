return {
	last_effect_stack_list = {
		[2] = "lafeier_tiaosepan_05",
		[3] = "lafeier_tiaosepan_06"
	},
	effect_list = {
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onSink"
			},
			arg_list = {
				buff_id = 150957,
				repeat_count = -1,
				target = {
					"TargetAllFoe",
					"TargetFatalDamageSrc"
				}
			}
		},
		{
			type = "BattleBuffFixVelocity",
			trigger = {
				"onAttach",
				"onStack",
				"onRemove"
			},
			arg_list = {
				add = 0,
				mul = -500
			}
		},
		{
			type = "BattleBuffCount",
			trigger = {
				"onAttach",
				"onStack"
			},
			arg_list = {
				countTarget = 3,
				countType = 150948
			}
		},
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onBattleBuffCount"
			},
			arg_list = {
				buff_id = 150949,
				target = "TargetSelf",
				countType = 150948
			}
		},
		{
			type = "BattleBuffAddTag",
			trigger = {
				"onAttach",
				"onRemove"
			},
			arg_list = {
				tag = "HEIYANLIAO"
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
	desc_get = "",
	name = "",
	init_effect = "",
	time = 10,
	color = "yellow",
	picture = "",
	desc = "黑颜料",
	stack = 3,
	id = 150948,
	icon = 150940,
	last_effect = "lafeier_tiaosepan_04"
}
