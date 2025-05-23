local var_0_0 = {
	"前往<color=#ff7d36>编队</color>，将角色编入队伍",
	"但需要注意，<color=#ffde38>前排先锋和后排主力都只能编入指定类型的舰种 </color>",
	"",
	"点击<color=#ff7d36>添加</color>来编入新角色",
	"选择需要上场的角色",
	"点击<color=#ff7d36>确定</color>按钮",
	"看！新角色成功入队！舰队实力大幅度提升！",
	"让我们返回到主界面吧！"
}

return {
	id = "NS004",
	events = {
		{
			alpha = 0.328,
			style = {
				dir = -1,
				mode = 2,
				posY = -275,
				posX = 168,
				text = var_0_0[1]
			},
			ui = {
				pathIndex = -1,
				dynamicPath = function()
					if getProxy(SettingsProxy):IsMellowStyle() then
						return "/OverlayCamera/Overlay/UIMain/NewMainMellowTheme(Clone)/frame/right/1/formation"
					else
						return "/OverlayCamera/Overlay/UIMain/NewMainClassicTheme(Clone)/frame/right/formationButton"
					end
				end,
				triggerType = {
					1
				},
				fingerPos = {
					posY = -34.7,
					posX = 68.5
				}
			}
		},
		{
			alpha = 0.574,
			waitScene = "FormationUI",
			style = {
				dir = 1,
				mode = 1,
				posY = -100,
				posX = 300,
				text = var_0_0[2]
			}
		},
		{
			alpha = 0.371,
			style = {
				dir = -1,
				mode = 2,
				posY = 122.82,
				posX = 243.5,
				text = var_0_0[4]
			},
			ui = {
				path = "/UICamera/Canvas/UIMain/FormationUI(Clone)/GridFrame/vanguard_2/tip",
				pathIndex = -1,
				triggerType = {
					1
				},
				fingerPos = {
					posY = -34.7,
					posX = 68.5
				}
			}
		},
		{
			alpha = 0.482,
			waitScene = "DockyardScene",
			style = {
				dir = -1,
				mode = 2,
				posY = 0,
				posX = 0,
				text = var_0_0[5]
			},
			ui = {
				path = "UICamera/Canvas/UIMain/DockyardUI(Clone)/main/ship_container/ships",
				pathIndex = 1,
				image = {
					isChild = true,
					source = "content/ship_icon",
					target = "content/ship_icon",
					isRelative = true
				},
				triggerType = {
					1
				},
				fingerPos = {
					posY = -107.3,
					posX = 67.77
				}
			}
		},
		{
			alpha = 0.363,
			style = {
				dir = 1,
				mode = 2,
				posY = 0,
				posX = 0,
				text = var_0_0[6]
			},
			ui = {
				path = "OverlayCamera/Overlay/UIMain/blur_panel/select_panel/confirm_button",
				pathIndex = -1,
				triggerType = {
					1
				},
				fingerPos = {
					posY = -24.4,
					posX = 65.8
				}
			}
		},
		{
			alpha = 0.196,
			code = -1,
			waitScene = "FormationUI",
			style = {
				dir = -1,
				mode = 1,
				posY = 0,
				posX = 0,
				text = var_0_0[7]
			}
		},
		{
			alpha = 0.45,
			style = {
				dir = -1,
				mode = 2,
				posY = 215.7,
				posX = -95.62,
				text = var_0_0[8]
			},
			ui = {
				path = "/UICamera/Canvas/UIMain/FormationUI(Clone)/blur_panel/top/back_btn",
				pathIndex = -1,
				triggerType = {
					1
				},
				fingerPos = {
					posY = -40,
					posX = 20
				}
			}
		}
	}
}
