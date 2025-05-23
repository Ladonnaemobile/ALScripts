return {
	hideRecord = true,
	dialogbox = 2,
	mode = 2,
	id = "DORM3DHELLO14",
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
			say = "我最爱的{dorm3d}，您的到来是天狼星最大的幸福。如果可以的话……请允许天狼星拥抱您。",
			voice = "event:/dorm/Tianlangxing_dorm3d_tone1/drom3d_sirus_hello14",
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
