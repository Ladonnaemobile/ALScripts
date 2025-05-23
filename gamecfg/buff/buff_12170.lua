return {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				skill_id = 1012161,
				minWeaponNumber = 1,
				check_weapon = true,
				weapon_group = {
					24000,
					24020,
					24040
				}
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				skill_id = 12153,
				maxWeaponNumber = 0,
				check_weapon = true,
				weapon_group = {
					24000,
					24020,
					24040
				}
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				minTargetNumber = 1,
				target = "TargetSelf",
				skill_id = 12150,
				check_target = {
					"TargetShipTag"
				},
				ship_tag_list = {
					"qiao5zhupao"
				}
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
	name = "最适化武装",
	init_effect = "",
	time = 0,
	color = "red",
	picture = "",
	desc = "",
	stack = 1,
	id = 12170,
	icon = 12150,
	last_effect = ""
}
