return {
	uiEffect = "",
	name = "全弹发射",
	cd = 0,
	painting = 1,
	id = 30371,
	picture = "0",
	desc = "全弹发射",
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
			type = "BattleSkillFire",
			casterAniEffect = "",
			target_choise = "TargetNil",
			targetAniEffect = "",
			arg_list = {
				weapon_id = 170621,
				emitter = "BattleBulletEmitter"
			}
		}
	}
}
