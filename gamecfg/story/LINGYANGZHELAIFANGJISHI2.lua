return {
	defaultTb = 2003,
	mode = 2,
	fadeOut = 1.5,
	id = "LINGYANGZHELAIFANGJISHI2",
	scripts = {
		{
			nameColor = "#A9F548FF",
			side = 2,
			bgName = "star_level_bg_509",
			hidePaintObj = true,
			say = "当我带着娜比娅走近时，海天略显慌乱地收起了纸笔。",
			bgm = "qe-ova-1",
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
			expression = 7,
			side = 2,
			bgName = "star_level_bg_509",
			hidePaintObj = true,
			actor = -2,
			actorName = "娜比娅",
			nameColor = "#A9F548FF",
			say = "嗯~？在偷偷写什么东西呢？",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 5,
			side = 2,
			bgName = "star_level_bg_509",
			hidePaintObj = true,
			dir = 1,
			nameColor = "#A9F548FF",
			actor = 502070,
			say = "咳咳……小女子看这里景色颇好，就想到了新篇章的开头。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 2,
			side = 2,
			bgName = "star_level_bg_509",
			hidePaintObj = true,
			dir = 1,
			nameColor = "#A9F548FF",
			actor = 502070,
			say = "“落花人独立，微雨燕双飞”，这样的景致令人不禁提笔。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 3,
			side = 2,
			bgName = "star_level_bg_509",
			hidePaintObj = true,
			actor = -2,
			actorName = "娜比娅",
			nameColor = "#A9F548FF",
			say = "切……又在说些文绉绉的话啊~不如直接给人家看看写了什么吧！",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 5,
			side = 2,
			bgName = "star_level_bg_509",
			hidePaintObj = true,
			dir = 1,
			nameColor = "#A9F548FF",
			actor = 502070,
			say = "现在还只是些零散想法，还不成熟。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 5,
			side = 2,
			bgName = "star_level_bg_509",
			hidePaintObj = true,
			dir = 1,
			nameColor = "#A9F548FF",
			actor = 502070,
			say = "等到彻底成文的时候再看也不迟。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 2,
			side = 2,
			bgName = "star_level_bg_509",
			hidePaintObj = true,
			dir = 1,
			nameColor = "#A9F548FF",
			actor = 502070,
			say = "毕竟对小女子而言，写作一事马虎不得。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			},
			options = {
				{
					content = "确实，而且写作需要耐心",
					flag = 1
				},
				{
					content = "确实，而且写作需要感悟",
					flag = 2
				}
			}
		},
		{
			portrait = "zhihuiguan",
			side = 2,
			bgName = "star_level_bg_509",
			hidePaintObj = true,
			nameColor = "#A9F548FF",
			optionFlag = 1,
			actor = 0,
			say = "确实，而且写作需要耐心啊，字字珠玑都是反复推敲的结果。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 8,
			side = 2,
			bgName = "star_level_bg_509",
			dir = 1,
			optionFlag = 1,
			actor = 502070,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "指挥官说的不错，“欲穷千里目，更上一层楼”……",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 4,
			side = 2,
			bgName = "star_level_bg_509",
			dir = 1,
			optionFlag = 1,
			actor = 502070,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "正如登高望远，写作也需一步一个脚印地来。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 3,
			side = 2,
			bgName = "star_level_bg_509",
			actorName = "娜比娅",
			optionFlag = 1,
			actor = -2,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "哼！说得倒是挺厉害的！人家倒要看看有什么了不起！",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			portrait = "zhihuiguan",
			side = 2,
			bgName = "star_level_bg_509",
			hidePaintObj = true,
			nameColor = "#A9F548FF",
			optionFlag = 2,
			actor = 0,
			say = "确实，而且写作需要感悟，就像你常说的，读万卷书，行万里路。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 8,
			side = 2,
			bgName = "star_level_bg_509",
			dir = 1,
			optionFlag = 2,
			actor = 502070,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "正是如此，“纸上得来终觉浅，绝知此事要躬行”……",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 4,
			side = 2,
			bgName = "star_level_bg_509",
			dir = 1,
			optionFlag = 2,
			actor = 502070,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "眼前的风景、生活的点滴，都是最好的素材呢。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 2,
			side = 2,
			bgName = "star_level_bg_509",
			dir = 1,
			optionFlag = 2,
			actor = 502070,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "这也是小女子一直随身带着灵感素材本的原因。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 4,
			side = 2,
			bgName = "star_level_bg_509",
			actorName = "娜比娅",
			optionFlag = 2,
			actor = -2,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "切~整天写写画画有什么意思！",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 9,
			side = 2,
			bgName = "star_level_bg_509",
			dir = 1,
			optionFlag = 2,
			actor = 502070,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "并非如此。娜比娅小姐也有那种，让你想写下来的时刻吧？",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 2,
			side = 2,
			bgName = "star_level_bg_509",
			actorName = "娜比娅",
			optionFlag = 2,
			actor = -2,
			nameColor = "#A9F548FF",
			hidePaintObj = true,
			say = "才、才没有呢！虽、虽然偶尔确实会有那么一点点想法啦……",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 1,
			side = 2,
			bgName = "star_level_bg_509",
			hidePaintObj = true,
			dir = 1,
			nameColor = "#A9F548FF",
			actor = 502070,
			say = "啊，说起来小女子知道附近有家不错的咖啡厅。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			expression = 2,
			side = 2,
			bgName = "star_level_bg_509",
			hidePaintObj = true,
			dir = 1,
			nameColor = "#A9F548FF",
			actor = 502070,
			say = "细啜浮香午后茶……虽然不是品茶，但边喝咖啡，边聊天也无不可？",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			actor = 0,
			nameColor = "#A9F548FF",
			bgName = "star_level_bg_509",
			hidePaintObj = true,
			side = 2,
			portrait = "zhihuiguan",
			say = "听起来不错，那我们出发吧。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			nameColor = "#A9F548FF",
			side = 2,
			bgName = "star_level_bg_509",
			hidePaintObj = true,
			say = "之后和娜比娅在咖啡厅中与海天一起度过了许久。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		}
	}
}
