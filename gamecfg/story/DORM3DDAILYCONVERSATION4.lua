return {
	fadeOut = 1.5,
	dialogbox = 2,
	hideRecord = true,
	mode = 2,
	alpha = 0,
	id = "DORM3DDAILYCONVERSATION4",
	hideSkip = true,
	hideAuto = true,
	placeholder = {
		"dorm3d"
	},
	scripts = {
		{
			actor = 0,
			side = 2,
			nameColor = "#FFFFFF",
			hidePaintObj = true,
			say = "（这段时间天狼星都没提过什么要求……还是问问她吧。）",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			},
			options = {
				{
					content = "要不要添置一些家具？",
					flag = 1
				},
				{
					content = "有没有想要的东西？",
					flag = 2
				}
			}
		},
		{
			side = 2,
			actorName = 20220,
			nameColor = "#FFFFFF",
			hidePaintObj = true,
			dir = 1,
			say = "感谢您的关怀和慷慨，不过天狼星目前还不需要这些，我的{dorm3d}。",
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
							name = "biaoda",
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
		},
		{
			side = 2,
			actorName = 20220,
			nameColor = "#FFFFFF",
			hidePaintObj = true,
			dir = 1,
			say = "只要能够留在这里，并且还能够这样侍奉您，天狼星就满足了。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		}
	}
}
