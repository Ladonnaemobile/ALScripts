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
				effect = "shield05",
				count = 5,
				bulletType = 3,
				cld_list = {
					{
						box = {
							3,
							3,
							7
						},
						offset = {
							0,
							0,
							-1.3
						}
					}
				},
				centerPosFun = function(arg_1_0)
					return Vector3(3, -1.8, 0.5)
				end,
				rotationFun = function(arg_2_0)
					return Vector3(0, 192, 0)
				end
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
	desc_get = "鱼雷防御盾",
	name = "鱼雷防御盾",
	init_effect = "",
	time = 20,
	color = "red",
	picture = "",
	desc = "鱼雷防御盾",
	stack = 1,
	id = 13281,
	icon = 13280,
	last_effect = ""
}
