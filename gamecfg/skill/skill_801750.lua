return {
	uiEffect = "",
	name = "舰队空母",
	cd = 0,
	painting = 1,
	id = 801750,
	picture = "0",
	castCV = "skill",
	desc = "每次执行空袭后为先锋部队提高伤害",
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
			target_choise = "TargetPlayerVanguardFleet",
			targetAniEffect = "",
			arg_list = {
				buff_id = 3020
			}
		},
		{
			type = "BattleSkillAddBuff",
			casterAniEffect = "",
			target_choise = "TargetPlayerVanguardFleet",
			targetAniEffect = "",
			arg_list = {
				buff_id = 3050
			}
		}
	}
}
