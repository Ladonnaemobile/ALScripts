return {
	hideRecord = true,
	dialogbox = 2,
	mode = 2,
	id = "DORM3DGIFTFEEDBACK201",
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	placeholder = {
		"dorm3d"
	},
	scripts = {
		{
			actorName = 30221,
			nameColor = "#FFFFFF",
			say = "我会好好珍藏{dorm3d}送我的礼物的。",
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
							name = "shuohua_qidai",
							type = "action"
						},
						{
							skip = true,
							name = "Face_weixiao",
							type = "action"
						},
						{
							skip = false,
							time = 2,
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
