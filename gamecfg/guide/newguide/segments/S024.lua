local var_0_0 = {
	"指挥官请点击<color=#ff7d36>出击</color>",
	"这次我们的舰队已经比较完善啦~一定可以击破大黄蜂的！",
	"可恶，又遭到了敌方舰队的拦截！但是我们的<color=#ff7d36>总机动值已经提高</color>，轻而易举的就能避开这种无谓的战斗",
	"点击<color=#ff7d36>规避</color>轻松甩掉他们的拦截吧！"
}

return {
	id = "S024",
	events = {
		{
			alpha = 0.422,
			code = 2,
			style = {
				dir = 1,
				mode = 2,
				posY = -42,
				posX = 243,
				text = var_0_0[1]
			},
			ui = {
				pathIndex = -1,
				dynamicPath = function()
					if getProxy(SettingsProxy):IsMellowStyle() then
						return "/OverlayCamera/Overlay/UIMain/NewMainMellowTheme(Clone)/frame/right/1/battle"
					else
						return "/OverlayCamera/Overlay/UIMain/NewMainClassicTheme(Clone)/frame/right/combatBtn"
					end
				end,
				triggerType = {
					1
				},
				fingerPos = {
					posY = -18.1,
					posX = 68.35
				}
			}
		},
		{
			alpha = 0.277,
			code = 2,
			waitScene = "LevelScene",
			style = {
				dir = 1,
				mode = 2,
				posY = -200,
				posX = -190,
				text = var_0_0[2]
			},
			ui = {
				path = "/OverlayCamera/Overlay/UIMain/top/LevelStageView(Clone)/bottom_stage/Normal/func_button",
				pathIndex = -1,
				triggerType = {
					1
				},
				fingerPos = {
					posY = -29.71,
					posX = 25.08
				}
			}
		},
		{
			alpha = 0.297,
			code = 1,
			baseui = {
				path = "OverlayCamera/Overlay/UIMain/top/LevelAmbushView(Clone)/window/dodge_button"
			},
			style = {
				dir = 1,
				mode = 2,
				posY = -304,
				posX = -190,
				text = var_0_0[3]
			}
		},
		{
			alpha = 0.297,
			code = 1,
			style = {
				dir = 1,
				mode = 2,
				posY = 167.08,
				posX = 23.41,
				text = var_0_0[4]
			}
		},
		{
			alpha = 0.303,
			ui = {
				path = "OverlayCamera/Overlay/UIMain/top/LevelAmbushView(Clone)/window/dodge_button",
				pathIndex = -1,
				triggerType = {
					1
				},
				fingerPos = {
					posY = -23.85,
					posX = 23.79
				}
			}
		}
	}
}
