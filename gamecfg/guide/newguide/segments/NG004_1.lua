local var_0_0 = {
	"接下来让我们去看看<color=#ff7d36>指挥官手册</color>",
	"领取<color=#ff7d36>任务奖励</color>",
	"关闭奖励界面",
	"<color=#ff7d36>指挥官手册</color>是面向新人指挥官，进行引导和系统说明的手册",
	"<color=#ff7d36>新手任务</color>里记录了大量可以帮助新人指挥官快速成长的训练任务",
	"而<color=#ff7d36>功能指引</color>页签则里记录了各个系统的注意事项",
	"如果指挥官有疑问，不妨来手册里看看吧~"
}

return {
	id = "NG004_1",
	events = {
		{
			alpha = 0.4,
			style = {
				dir = -1,
				mode = 2,
				posY = 172,
				posX = -337,
				text = var_0_0[1]
			}
		},
		{
			ui = {
				dynamicPath = function()
					if getProxy(SettingsProxy):IsMellowStyle() then
						return "/OverlayCamera/Overlay/UIMain/NewMainMellowTheme(Clone)/frame/left/list/MainUIRecruitBtn4Mellow(Clone)"
					else
						return "/OverlayCamera/Overlay/UIMain/NewMainClassicTheme(Clone)/frame/link_top/layout/MainUIRecruitBtn(Clone)"
					end
				end
			}
		},
		{
			alpha = 0.4,
			style = {
				dir = -1,
				mode = 2,
				posY = -102.33,
				posX = -29.1,
				text = var_0_0[2]
			},
			ui = {
				path = "/OverlayCamera/Overlay/UIMain/blur_panel/panel/pages/taskPage/page/scroll/Viewport/Content/tpl/normal/get_btn",
				triggerType = {
					1
				}
			}
		},
		{
			alpha = 0,
			waitScene = "AwardInfoLayer",
			style = {
				dir = -1,
				mode = 2,
				posY = -341,
				posX = 431,
				text = var_0_0[3]
			},
			spriteui = {
				defaultName = "white_dot",
				path = "/OverlayCamera/Overlay/UIMain/AwardInfoUI(Clone)/items/items_scroll/content",
				childPath = "bg/icon_bg/icon",
				pathIndex = "#"
			},
			ui = {
				path = "OverlayCamera/Overlay/UIMain/AwardInfoUI(Clone)",
				pathIndex = -1,
				triggerType = {
					1
				},
				fingerPos = {
					posY = -172,
					posX = 520
				}
			}
		},
		{
			alpha = 0.4,
			style = {
				dir = -1,
				mode = 2,
				posY = -102.33,
				posX = -29.1,
				text = var_0_0[4]
			}
		},
		{
			alpha = 0.4,
			style = {
				dir = -1,
				mode = 2,
				posX = -29.1,
				posY = -102.33,
				lineMode = true,
				text = var_0_0[5],
				uiset = {
					{
						linemode = 1,
						path = "/OverlayCamera/Overlay/UIMain/blur_panel/panel/pageBtns/taskBtn"
					}
				}
			}
		},
		{
			alpha = 0.4,
			style = {
				dir = -1,
				mode = 2,
				posX = -29.1,
				posY = -102.33,
				lineMode = true,
				text = var_0_0[6],
				uiset = {
					{
						linemode = 1,
						path = "/OverlayCamera/Overlay/UIMain/blur_panel/panel/pageBtns/guideBtn"
					}
				}
			}
		},
		{
			alpha = 0.4,
			style = {
				dir = -1,
				mode = 2,
				posY = -102.33,
				posX = -29.1,
				text = var_0_0[7]
			}
		}
	}
}
