return {
	hideRecord = true,
	dialogbox = 2,
	mode = 2,
	id = "DORM3DGIFTFEEDBACK304",
	alpha = 0,
	hideSkip = true,
	hideAuto = true,
	placeholder = {
		"dorm3d"
	},
	scripts = {
		{
			actorName = 19903,
			nameColor = "#FFFFFF",
			say = "颜料……！安克雷奇……要好好用……！",
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
							name = "ab_shuohua_jidong_01",
							type = "action"
						},
						{
							skip = true,
							name = "Face_kaixing",
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
		},
		{
			actorName = 19903,
			nameColor = "#FFFFFF",
			say = "嗯！安克雷奇……画最喜欢的{dorm3d}！嘿嘿……",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		}
	}
}
