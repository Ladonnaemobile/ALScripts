return {
	effect_list = {
		{
			id = 1,
			type = "BattleBuffShieldWall",
			trigger = {
				"onUpdate"
			},
			arg_list = {
				do_when_hit = "intercept",
				effect = "gulitejineng_dunpai",
				count = 15,
				bulletType = 1,
				cld_list = {
					{
						box = {
							4,
							6,
							9
						},
						offset = {
							0,
							0,
							0
						}
					}
				},
				centerPosFun = function(arg_1_0)
					return Vector3(2, 1.5, 0.5)
				end,
				rotationFun = function(arg_2_0)
					return Vector3(0, 192, 0)
				end
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onShieldBroken"
			},
			arg_list = {
				skill_id = 108151,
				shieldBuffID = 108154
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
	init_effect = "",
	name = "",
	time = 10,
	color = "blue",
	picture = "",
	desc = "",
	stack = 1,
	id = 108154,
	icon = 108150,
	last_effect = ""
}
