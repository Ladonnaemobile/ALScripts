return {
	hideRecord = true,
	dialogbox = 2,
	mode = 2,
	id = "DORM3DHELLO2015",
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	placeholder = {
		"dorm3d"
	},
	scripts = {
		{
			side = 2,
			actorName = 30221,
			nameColor = "#FFFFFF",
			hidePaintObj = true,
			say = "虽、虽然我不常说这种话，但看着你的时候，我突然意识到我有多么依赖你……唔，今后你可不可以也多依赖我一些呢？毕、毕竟我想永远陪伴在你的身边……",
			voice = "event:/dorm/drom3d_noshiro_other/drom3d_Noshiro_hello15",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			},
			dispatcher = {
				name = STORY_EVENT.TEST,
				data = {
					op_list = {
						{
							skip = true,
							name = "shuohua_gandong",
							type = "action"
						},
						{
							skip = true,
							name = "Face_weixiao",
							type = "action"
						},
						{
							time = 2.5,
							type = "wait"
						}
					}
				},
				callbackData = {
					hideUI = false,
					name = STORY_EVENT.TEST_DONE
				}
			}
		}
	}
}
