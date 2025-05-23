return {
	hideRecord = true,
	dialogbox = 2,
	mode = 2,
	id = "DORM3DTOUCH1504",
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
			say = "这里，沾到了什么吗……？",
			voice = "event:/dorm/Tianlangxing_dorm3d_tone/touch06",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			},
			dispatcher = {
				name = STORY_EVENT.TEST,
				data = {
					op_list = {
						{
							param = "Play",
							name = "chuang_FF_2_jiao_1",
							time = 0,
							type = "action",
							skip = true
						},
						{
							param = "Play",
							name = "Face_yihuo",
							time = 0,
							type = "action",
							skip = true
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
