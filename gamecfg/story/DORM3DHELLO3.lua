return {
	hideRecord = true,
	dialogbox = 2,
	mode = 2,
	id = "DORM3DHELLO3",
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	placeholder = {
		"dorm3d"
	},
	scripts = {
		{
			nameColor = "#FFFFFF",
			actorName = 20220,
			say = "您的到来就是对天狼星女仆工作的最大认可，我骄傲的{dorm3d}。今天的天狼星也不会让您失望哦。",
			voice = "event:/dorm/Tianlangxing_dorm3d_tone1/drom3d_sirus_hello3",
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
							name = "Bow",
							type = "action"
						},
						{
							param = "Play",
							name = "Face_weixiao",
							time = 0,
							type = "action",
							skip = true
						},
						{
							skip = false,
							time = 1,
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
