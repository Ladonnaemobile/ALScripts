return {
	hideRecord = true,
	dialogbox = 2,
	mode = 2,
	id = "DORM3DDAILYCONVERSATION2053",
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
			dir = 1,
			say = "{dorm3d}，要一起去新开的刨冰店么？",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			side = 2,
			actorName = 30221,
			nameColor = "#FFFFFF",
			hidePaintObj = true,
			dir = 1,
			say = "毕竟海边和刨冰很配呢。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			},
			options = {
				{
					content = "{namecode:50:能代}有什么喜欢的刨冰口吻么？",
					flag = 1
				}
			}
		},
		{
			side = 2,
			actorName = 30221,
			nameColor = "#FFFFFF",
			hidePaintObj = true,
			dir = 1,
			say = "我想尝试一下草莓巧克力风味的，不过清橙风味的好像也不错……",
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
							name = "shuohua_deyi",
							time = 0,
							type = "action",
							skip = true
						},
						{
							skip = false,
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
		},
		{
			side = 2,
			actorName = 30221,
			nameColor = "#FFFFFF",
			hidePaintObj = true,
			dir = 1,
			say = "不如我们先一起到店里，然后再做决定吧？",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		}
	}
}
