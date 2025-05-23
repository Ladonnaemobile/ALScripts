local var_0_0 = class("SixthAnniversaryJPHotSpringScene", import("view.activity.BackHills.NewYearFestival.NewYearHotSpringScene"))

function var_0_0.getUIName(arg_1_0)
	return "SixthAnniversaryJPHotSpringUI"
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)
end

function var_0_0.didEnter(arg_3_0)
	var_0_0.super.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("Top/Help"), function()
		MsgboxMediator.ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hotspring_help.tip,
			contextSprites = {
				{
					name = "wenquanshoupai",
					path = "props/wenquanshoupai"
				}
			}
		})
	end, SFX_PANEL)
	setImageSprite(arg_3_0.top:Find("Ticket/Icon"), LoadSprite("props/wenquanshoupai", "wenquanshoupai"))
end

function var_0_0.willExit(arg_5_0)
	var_0_0.super.willExit(arg_5_0)
end

return var_0_0
