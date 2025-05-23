return {
	fadeOut = 1.5,
	mode = 2,
	defaultTb = 2003,
	id = "LINGYANGZHELAIFANGJISHI4",
	placeholder = {
		"tb"
	},
	scripts = {
		{
			expression = 1,
			side = 2,
			bgName = "star_level_bg_166",
			dir = 1,
			bgm = "qe-ova-1",
			actor = 406030,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "哎呀，被指挥官发现了呢♪",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			},
			flashout = {
				black = true,
				dur = 1,
				alpha = {
					0,
					1
				}
			},
			flashin = {
				delay = 1,
				dur = 1,
				black = true,
				alpha = {
					1,
					0
				}
			}
		},
		{
			expression = 6,
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			dir = 1,
			nameColor = "#A9F548FF",
			actor = 406030,
			say = "先声明一下，好孩子{namecode:491:亚德}是来帮忙的哦~可不是在偷懒呢。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 7,
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			dir = 1,
			nameColor = "#A9F548FF",
			actor = 406030,
			say = "只是有点好奇，所以才在这里感受一下下午茶而已哦~",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 3,
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			actor = -2,
			actorName = "娜比娅",
			nameColor = "#A9F548FF",
			say = "笨蛋{tb}怎么总是跑来找这种狡猾的家伙啊。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 6,
			side = 2,
			bgName = "star_level_bg_166",
			actorName = "娜比娅",
			fontsize = 24,
			actor = -2,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "不过这种说话方式倒是有点意思，值得学习一下呢~",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 7,
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			dir = 1,
			nameColor = "#A9F548FF",
			actor = 406030,
			say = "哼哼~来都来了，指挥官要不要也来点甜点？这可是限定款哦~",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 7,
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			dir = 1,
			nameColor = "#A9F548FF",
			actor = 406030,
			say = "不过呢，想要品尝的话，是要付出相应的代价的♪",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 6,
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			dir = 1,
			nameColor = "#A9F548FF",
			actor = 406030,
			say = "谁让指挥官是坏孩子嘛~",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 7,
			side = 2,
			bgName = "star_level_bg_166",
			actorName = "娜比娅",
			fontsize = 24,
			actor = -2,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "先给糖果再要好处吗~原来如此……",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			},
			options = {
				{
					content = "询问{namecode:491:亚德}想要什么代价",
					flag = 1
				},
				{
					content = "拒绝{namecode:491:亚德}的提议",
					flag = 2
				}
			}
		},
		{
			portrait = "zhihuiguan",
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			nameColor = "#A9F548FF",
			optionFlag = 1,
			actor = 0,
			say = "你想要什么代价？",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 6,
			side = 2,
			bgName = "star_level_bg_166",
			dir = 1,
			optionFlag = 1,
			actor = 406030,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "唔~这个嘛~让{namecode:491:亚德}好好想一想……",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 7,
			side = 2,
			bgName = "star_level_bg_166",
			dir = 1,
			optionFlag = 1,
			actor = 406030,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "不如陪{namecode:491:亚德}再坐一会儿？或者答应{namecode:491:亚德}一个小小的要求？",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			portrait = "zhihuiguan",
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			nameColor = "#A9F548FF",
			optionFlag = 1,
			actor = 0,
			say = "不会是什么过分的要求吧？",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 6,
			side = 2,
			bgName = "star_level_bg_166",
			dir = 1,
			optionFlag = 1,
			actor = 406030,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "放心啦，{namecode:491:亚德}是好孩子呢。不会提太过分的要求的…大概？呵呵♪",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 7,
			side = 2,
			bgName = "star_level_bg_166",
			actorName = "娜比娅",
			optionFlag = 1,
			actor = -2,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "原来这样就能让笨蛋{tb}上钩啊~",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 8,
			side = 2,
			bgName = "star_level_bg_166",
			actorName = "娜比娅",
			optionFlag = 1,
			actor = -2,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "啊，不过{tb}你可别真的上钩了哦~我可是在替你着想呢♪",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			nameColor = "#A9F548FF",
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			optionFlag = 2,
			say = "想了想，还是拒绝了{namecode:491:亚德}的提议。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			portrait = "zhihuiguan",
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			nameColor = "#A9F548FF",
			optionFlag = 2,
			actor = 0,
			say = "吃甜点就算了。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 6,
			side = 2,
			bgName = "star_level_bg_166",
			dir = 1,
			optionFlag = 2,
			actor = 406030,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "那真是太可惜了呢……明明{namecode:491:亚德}还想让指挥官品尝的……~",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 7,
			side = 2,
			bgName = "star_level_bg_166",
			dir = 1,
			optionFlag = 2,
			actor = 406030,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "不过既然这样，那下次{namecode:491:亚德}给指挥官带些别的好了？",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			actor = 406030,
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			dir = 1,
			optionFlag = 2,
			nameColor = "#A9F548FF",
			say = "作为交换，指挥官要答应{namecode:491:亚德}一个要求哦♪",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			portrait = "zhihuiguan",
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			nameColor = "#A9F548FF",
			optionFlag = 2,
			actor = 0,
			say = "嗯？为什么突然就要答应一个要求……？",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 1,
			side = 2,
			bgName = "star_level_bg_166",
			dir = 1,
			optionFlag = 2,
			actor = 406030,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "因为{namecode:491:亚德}是好孩子嘛，答应好孩子的要求也是天经地义的事情啦~",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 7,
			side = 2,
			bgName = "star_level_bg_166",
			actorName = "娜比娅",
			optionFlag = 2,
			actor = -2,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "啊~原来如此……还能这样啊~",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 7,
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			dir = 1,
			nameColor = "#A9F548FF",
			actor = 406030,
			say = "呵呵，说起来{namecode:491:亚德}今天的任务已经完成了呢♪",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 6,
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			dir = 1,
			nameColor = "#A9F548FF",
			actor = 406030,
			say = "看来娜比娅也学到了不少有趣的东西~",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 7,
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			actor = -2,
			actorName = "娜比娅",
			nameColor = "#A9F548FF",
			say = "哼哼~原来还可以这样捉弄笨蛋{tb}啊……",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			actor = 0,
			nameColor = "#A9F548FF",
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			side = 2,
			portrait = "zhihuiguan",
			say = "……",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 6,
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			dir = 1,
			nameColor = "#A9F548FF",
			actor = 406030,
			say = "那{namecode:491:亚德}就先告辞啦，下次见面的时候，指挥官要记得补偿{namecode:491:亚德}哦~",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 8,
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			actor = -2,
			actorName = "娜比娅",
			nameColor = "#A9F548FF",
			say = "居然还不忘记要好处……嘻嘻，这个也学到了呢~",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			nameColor = "#A9F548FF",
			side = 2,
			bgName = "star_level_bg_166",
			hidePaintObj = true,
			say = "和{namecode:491:亚德}告别之后，和娜比娅一起离开了。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		}
	}
}
