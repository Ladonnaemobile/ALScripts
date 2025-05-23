local var_0_0 = {
	"指挥官，军部为港区派遣了能够在水下作战的舰娘协助我们，快去迎接一下新的伙伴吧",
	"欢迎港区的第一个潜艇！给我们的新伙伴编队吧，指挥官！",
	"这样我们的第一支潜艇舰队就诞生了！",
	"不过，为了应对敌方也有可能出现潜艇的情况，请指挥官为舰娘配备反潜设备",
	"反潜设备的相关内容可以点击帮助按钮查看详细内容哦"
}

return {
	id = "NG002",
	events = {
		{
			code = 2,
			ui = {
				path = "/UICamera/Canvas/UIMain/LevelMainScene(Clone)/top/top_chapter/back_button"
			}
		},
		{
			alpha = 0.4,
			style = {
				dir = 1,
				mode = 1,
				posY = -110,
				posX = 200,
				text = var_0_0[1]
			}
		},
		{
			code = 2,
			ui = {
				path = "/UICamera/Canvas/UIMain/LevelMainScene(Clone)/top/top_chapter/back_button"
			}
		},
		{
			ui = {
				dynamicPath = function()
					if getProxy(SettingsProxy):IsMellowStyle() then
						return "/OverlayCamera/Overlay/UIMain/NewMainMellowTheme(Clone)/frame/bottom/frame/task"
					else
						return "/OverlayCamera/Overlay/UIMain/NewMainClassicTheme(Clone)/frame/bottom/taskButton"
					end
				end
			}
		},
		{
			ui = {
				path = "/UICamera/Canvas/UIMain/TaskScene(Clone)/blur_panel/adapt/left_length/frame/tagRoot/branch",
				triggerType = {
					2,
					true
				}
			}
		},
		{
			ui = {
				delay = 1,
				path = "/UICamera/Canvas/UIMain/TaskScene(Clone)/pages/TaskListPage(Clone)/right_panel/mask/content/10302/frame/get_btn"
			}
		},
		{
			delay = 1,
			ui = {
				path = "/OverlayCamera/Overlay/UIMain/AwardInfoUI(Clone)",
				fingerPos = {
					posY = -225.3,
					posX = 256.86
				}
			}
		},
		{
			ui = {
				path = "/OverlayCamera/Overlay/UIMain/NewShipUI(Clone)/shake_panel/click",
				fingerPos = {
					posY = -242.9,
					posX = 330.5
				}
			}
		},
		{
			code = 1,
			ui = {
				path = "/OverlayCamera/Overlay/UIMain/Msgbox(Clone)/window/button_container/custom_button_1(Clone)"
			}
		},
		{
			alpha = 0.4,
			style = {
				dir = 1,
				mode = 1,
				posY = -110,
				posX = 200,
				text = var_0_0[2]
			}
		},
		{
			ui = {
				path = "/UICamera/Canvas/UIMain/TaskScene(Clone)/blur_panel/adapt/top/back_btn"
			}
		},
		{
			ui = {
				dynamicPath = function()
					if getProxy(SettingsProxy):IsMellowStyle() then
						return "/OverlayCamera/Overlay/UIMain/NewMainMellowTheme(Clone)/frame/right/1/formation"
					else
						return "/OverlayCamera/Overlay/UIMain/NewMainClassicTheme(Clone)/frame/right/formationButton"
					end
				end
			}
		},
		{
			ui = {
				path = "/UICamera/Canvas/UIMain/FormationUI(Clone)/blur_panel/bottom/fleet_select/sub"
			}
		},
		{
			ui = {
				path = "/UICamera/Canvas/UIMain/FormationUI(Clone)/GridFrame/submarine_1/tip"
			}
		},
		{
			ui = {
				path = "/UICamera/Canvas/UIMain/DockyardUI(Clone)/main/ship_container/ships/308031",
				image = {
					isChild = true,
					source = "content/ship_icon",
					target = "content/ship_icon",
					isRelative = true
				}
			}
		},
		{
			ui = {
				path = "/OverlayCamera/Overlay/UIMain/blur_panel/select_panel/confirm_button"
			}
		},
		{
			alpha = 0.4,
			style = {
				dir = 1,
				mode = 1,
				posY = -110,
				posX = 200,
				text = var_0_0[3]
			}
		},
		{
			alpha = 0.4,
			style = {
				dir = 1,
				mode = 1,
				posY = -110,
				posX = 200,
				text = var_0_0[4]
			}
		},
		{
			ui = {
				path = "/UICamera/Canvas/UIMain/FormationUI(Clone)/blur_panel/top/back_btn"
			}
		},
		{
			ui = {
				dynamicPath = function()
					if getProxy(SettingsProxy):IsMellowStyle() then
						return "/OverlayCamera/Overlay/UIMain/NewMainMellowTheme(Clone)/frame/bottom/frame/dock"
					else
						return "/OverlayCamera/Overlay/UIMain/NewMainClassicTheme(Clone)/frame/bottom/dockBtn"
					end
				end
			}
		},
		{
			ui = {
				path = "/UICamera/Canvas/UIMain/DockyardUI(Clone)/main/ship_container/ships",
				pathIndex = 0,
				image = {
					isChild = true,
					source = "content/ship_icon",
					target = "content/ship_icon",
					isRelative = true
				}
			}
		},
		{
			alpha = 0.4,
			style = {
				dir = 1,
				mode = 1,
				posY = -110,
				posX = 200,
				text = var_0_0[5]
			}
		},
		{
			ui = {
				path = "/OverlayCamera/Overlay/UIMain/blur_panel/adapt/help_btn"
			}
		}
	}
}
