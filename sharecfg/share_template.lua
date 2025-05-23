pg = pg or {}
pg.share_template = {
	{
		description = "#碧蓝航线#",
		name = "个人信息界面",
		show_comps = "",
		deck = 1,
		id = 1,
		move_comps = "",
		camera = "UICamera",
		qrcode_location = {
			373,
			178
		},
		hidden_comps = {
			"/UICamera/Canvas/UIMain/PlayerVitaeUI(Clone)/detail/toggleBtns",
			"/UICamera/Canvas/UIMain/PlayerVitaeUI(Clone)/adapt/btns",
			"/UICamera/Canvas/UIMain/PlayerVitaeUI(Clone)/detail/PlayerVitaeDetailPage(Clone)/btn_share",
			"/UICamera/Canvas/UIMain/PlayerVitaeUI(Clone)/detail/PlayerVitaeDetailPage(Clone)/btn_attire"
		}
	},
	{
		description = "#碧蓝航线#",
		name = "档案界面",
		show_comps = "",
		deck = 1,
		id = 2,
		move_comps = "",
		camera = "UICamera",
		qrcode_location = {
			373,
			120
		},
		hidden_comps = {
			"/OverlayCamera/Overlay/UIMain/blur_panel",
			"/UICamera/Canvas/UIMain/ShipProfileUI(Clone)/profile_panel/eva_btn",
			"/UICamera/Canvas/UIMain/ShipProfileUI(Clone)/profile_panel/share_btn",
			"/UICamera/Canvas/UIMain/ShipProfileUI(Clone)/profile_panel/view_btn"
		}
	},
	{
		description = "#碧蓝航线#",
		name = "获得新舰船界面",
		deck = 2,
		id = 3,
		camera = "OverlayCamera",
		qrcode_location = {
			-340,
			160
		},
		hidden_comps = {
			"/OverlayCamera/Overlay/UIMain/NewShipUI(Clone)/shake_panel/ForNotch",
			"/OverlayCamera/Overlay/UIMain/NewShipUI(Clone)/shake_panel/property_btn",
			"/OverlayCamera/Overlay/UIMain/NewShipUI(Clone)/shake_panel/dialogue",
			"/OverlayCamera/Overlay/UIOverlay/TipPanel(Clone)",
			"/OverlayCamera/Overlay/UIEffect/ClickEffect(Clone)"
		},
		show_comps = {
			"/OverlayCamera/Overlay/UIMain/NewShipUI(Clone)/shake_panel/ship_type"
		},
		move_comps = {
			{
				path = "/OverlayCamera/Overlay/UIMain/NewShipUI(Clone)/shake_panel/ship_type",
				x = 18,
				y = -920
			}
		}
	},
	{
		description = "#碧蓝航线#",
		name = "后宅",
		show_comps = "",
		deck = 1,
		id = 4,
		move_comps = "",
		camera = "UICamera",
		qrcode_location = {
			373,
			120
		},
		hidden_comps = {
			"/UICamera/Canvas/UIMain/CourtYardUI(Clone)/main"
		}
	},
	{
		description = "#碧蓝航线#",
		name = "获得新皮肤界面",
		show_comps = "",
		deck = 2,
		id = 5,
		move_comps = "",
		camera = "OverlayCamera",
		qrcode_location = {
			-340,
			160
		},
		hidden_comps = {
			"/OverlayCamera/Overlay/UIMain/NewSkinUI(Clone)/shake_panel/dialogue",
			"/OverlayCamera/Overlay/UIMain/NewSkinUI(Clone)/shake_panel/left_panel",
			"/OverlayCamera/Overlay/UIMain/NewSkinUI(Clone)/shake_panel/set_skin_btn",
			"/OverlayCamera/Overlay/UIEffect/ClickEffect(Clone)",
			"/OverlayCamera/Overlay/UIOverlay/TipPanel(Clone)"
		}
	},
	{
		description = "#碧蓝航线#",
		name = "玩家历程界面",
		show_comps = "",
		deck = 3,
		id = 6,
		move_comps = "",
		camera = "UICamera",
		qrcode_location = {
			-592,
			-381
		},
		hidden_comps = {
			"UICamera/Canvas/UIMain/PlayerSummaryUI(Clone)/bg/main/pages/page5/share"
		}
	},
	{
		description = "#碧蓝航线#",
		name = "拍照分享",
		show_comps = "",
		deck = 1,
		id = 7,
		move_comps = "",
		camera = "UICamera",
		qrcode_location = {
			373,
			120
		},
		hidden_comps = {
			"UICamera/Canvas/UIMain/SnapshotShareUI(Clone)/BtnPanel"
		}
	},
	{
		description = "#碧蓝航线#",
		name = "回流纪念信",
		show_comps = "",
		deck = 1,
		hidden_comps = "",
		id = 8,
		move_comps = "",
		camera = "UICamera",
		qrcode_location = {
			373,
			120
		}
	},
	{
		description = "#碧蓝航线#",
		name = "获得新指挥喵界面",
		show_comps = "",
		deck = 1,
		id = 9,
		move_comps = "",
		camera = "OverlayCamera",
		qrcode_location = {
			373,
			120
		},
		hidden_comps = {
			"/OverlayCamera/Overlay/UIMain/GetCommanderUI(Clone)/left_panel/btns/lock",
			"/OverlayCamera/Overlay/UIMain/GetCommanderUI(Clone)/left_panel/btns/share"
		}
	},
	{
		description = "#碧蓝航线#",
		name = "画图功能分享",
		show_comps = "",
		deck = 1,
		hidden_comps = "",
		id = 10,
		move_comps = "",
		camera = "UICamera",
		qrcode_location = {
			-592,
			-381
		}
	},
	{
		description = "#碧蓝航线#",
		name = "挑战分享",
		show_comps = "",
		deck = 1,
		id = 11,
		move_comps = "",
		camera = "UICamera",
		qrcode_location = {
			373,
			120
		},
		hidden_comps = {
			"UICamera/Canvas/UIMain/LimitChallengeUI(Clone)/blur_panel",
			"UICamera/Canvas/UIMain/LimitChallengeUI(Clone)/Adapt/StartBtn"
		}
	},
	{
		description = "#碧蓝航线#",
		name = "ins分享",
		show_comps = "",
		deck = 1,
		hidden_comps = "",
		id = 12,
		move_comps = "",
		camera = "OverlayCamera",
		qrcode_location = {
			373,
			120
		}
	},
	{
		description = "#碧蓝航线#",
		name = "必胜客分享",
		id = 13,
		deck = 2,
		hidden_comps = "",
		move_comps = "",
		camera = "UICamera",
		qrcode_location = {
			314.5,
			-539
		},
		show_comps = {
			"UICamera/Canvas/UIMain/PizzahutSharePage(Clone)"
		}
	},
	{
		description = "#碧蓝航线#",
		name = "玩家历程MarkII界面分享",
		show_comps = "",
		deck = 0,
		hidden_comps = "",
		id = 14,
		move_comps = "",
		camera = "UICamera",
		qrcode_location = {
			-38,
			-279
		}
	},
	{
		description = "#碧蓝航线#",
		name = "POLARIS活动大佬章界面分享",
		show_comps = "",
		deck = 0,
		id = 15,
		move_comps = "",
		camera = "OverlayCamera",
		qrcode_location = {
			-592,
			-436
		},
		hidden_comps = {
			"/OverlayCamera/Overlay/UIEffect/ClickEffect(Clone)"
		}
	},
	{
		description = "#碧蓝航线#",
		name = "熊小白分享",
		id = 16,
		deck = 2,
		hidden_comps = "",
		move_comps = "",
		camera = "UICamera",
		qrcode_location = {
			314.5,
			-539
		},
		show_comps = {
			"UICamera/Canvas/UIMain/IcecreamSharePage(Clone)"
		}
	},
	{
		description = "#碧蓝航线#",
		name = "情人节qet",
		deck = 5,
		id = 17,
		move_comps = "",
		camera = "OverlayCamera",
		qrcode_location = {
			470,
			-440
		},
		hidden_comps = {
			"/UICamera/Canvas/UIMain/ValentineQteGamePage(Clone)/pause",
			"/UICamera/Canvas/UIMain/ValentineQteGamePage(Clone)/time",
			"/UICamera/Canvas/UIMain/ValentineQteGamePage(Clone)/title",
			"/UICamera/Canvas/UIMain/ValentineQteGamePage(Clone)/score",
			"/OverlayCamera/Overlay/UIMain/result_panel/share",
			"/OverlayCamera/Overlay/UIEffect"
		},
		show_comps = {
			"/OverlayCamera/Overlay/UIMain/result_panel/frame/Text"
		}
	},
	{
		description = "#碧蓝航线#",
		name = "连战活动 - EX分享界面",
		id = 18,
		deck = 1,
		hidden_comps = "",
		move_comps = "",
		camera = "OverlayCamera",
		qrcode_location = {
			383,
			120
		},
		show_comps = {
			"UICamera/Canvas/UIMain/PizzahutSharePage(Clone)"
		}
	},
	{
		description = "#碧蓝航线#",
		name = "3d宿舍拍照分享界面",
		show_comps = "",
		deck = 2,
		id = 19,
		move_comps = "",
		camera = "OverlayCamera",
		qrcode_location = {
			-308,
			88
		},
		hidden_comps = {
			"/OverlayCamera/Overlay/UIEffect/vfx_ui_dianji01(Clone)",
			"/OverlayCamera/Overlay/UIMain/Dorm3dPhotoShareUI(Clone)/BG",
			"/OverlayCamera/Overlay/UIMain/Dorm3dPhotoShareUI(Clone)/PhotoImg",
			"/OverlayCamera/Overlay/UIMain/Dorm3dPhotoShareUI(Clone)/PhotoImg",
			"/OverlayCamera/Overlay/UIMain/Dorm3dPhotoShareUI(Clone)/ConfirmBtn",
			"/OverlayCamera/Overlay/UIMain/Dorm3dPhotoShareUI(Clone)/ShareBtn",
			"/OverlayCamera/Overlay/UIOverlay/TipPanel(Clone)"
		}
	},
	all = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10,
		11,
		12,
		13,
		14,
		15,
		16,
		17,
		18,
		19
	}
}
