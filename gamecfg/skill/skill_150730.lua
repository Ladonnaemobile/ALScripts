return {
	uiEffect = "",
	name = "冲击之盾",
	cd = 0,
	painting = 1,
	id = 150730,
	picture = "0",
	castCV = "skill",
	desc = "冲击之盾",
	aniEffect = {
		effect = "jineng",
		offset = {
			0,
			-2,
			0
		}
	},
	effect_list = {
		{
			type = "BattleSkillAddBuff",
			casterAniEffect = "",
			target_choise = "TargetSelf",
			targetAniEffect = "",
			arg_list = {
				buff_id = 150731
			}
		}
	}
}
