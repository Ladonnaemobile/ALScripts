pg = pg or {}
pg.mini_game = {
	{
		is_ranking = 0,
		view_name = "TestView",
		type = 1,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "测试小游戏",
		config_data = "",
		config_csv = "",
		id = 1,
		hub_id = 1,
		request_data = 0,
		simple_config_data = {
			test = {
				1,
				2,
				3
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "SnackView",
		type = 1,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "小吃小游戏",
		config_data = "",
		config_csv = "",
		id = 2,
		hub_id = 1,
		request_data = 0,
		simple_config_data = {
			memory_time = 5,
			select_time = 10,
			correct_value = {
				[0] = 0,
				1,
				2,
				5
			},
			score_level = {
				0,
				5,
				12,
				20
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "ShrineView",
		type = 3,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "神社小游戏",
		config_csv = "",
		id = 3,
		hub_id = 4,
		request_data = 1,
		simple_config_data = {
			target = 100000
		},
		config_data = {
			5,
			{
				10,
				11,
				12
			},
			2
		}
	},
	{
		is_ranking = 0,
		view_name = "FireworkFactoryView",
		type = 2,
		game_room = 0,
		mediator_name = "FireworkFactoryMediator",
		config_csv_key = "",
		name = "制作烟花",
		config_data = "",
		config_csv = "",
		id = 4,
		hub_id = 1,
		request_data = 1,
		simple_config_data = {
			roundTime = 50,
			score_reference = {
				{
					140,
					160
				},
				{
					120,
					180
				},
				{
					90,
					210
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "ShootingGameView",
		type = 2,
		game_room = 0,
		mediator_name = "ShootingGameMediator",
		config_csv_key = "",
		name = "打靶游戏",
		config_data = "",
		config_csv = "",
		id = 5,
		hub_id = 1,
		request_data = 0,
		simple_config_data = {
			fireCD = 1,
			moveSpeed = 4,
			baseTime = 12,
			bonusTime = 0,
			targetScore = {
				10,
				5,
				2
			},
			score_level = {
				0,
				10,
				25,
				35
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "MusicGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "音乐小游戏",
		config_data = "",
		config_csv = "",
		id = 6,
		hub_id = 2,
		request_data = 0,
		simple_config_data = {
			combo = 100,
			perfecttime = 0.1,
			misstime = 0.35,
			good = 300,
			special_combo = 0,
			perfect = 600,
			miss = 0,
			laterperfecttime = 0.1,
			speed_max = 100,
			goodtime = 0.25,
			special_score = 5000,
			speed_min = 60,
			latergoodtime = 0.2,
			story = {
				{
					"OUXIANGRICHANG1"
				},
				{},
				{},
				{
					"OUXIANGRICHANG2"
				},
				{},
				{},
				{
					"OUXIANGRICHANG3"
				}
			},
			combo_interval = {
				10,
				20,
				40,
				60,
				80,
				100
			},
			Blist = {
				{
					27640,
					55960
				},
				{
					16480,
					23080
				},
				{
					16700,
					52360
				},
				{
					24760,
					55480
				},
				{
					24280,
					43960
				}
			},
			Alist = {
				{
					55280,
					111920
				},
				{
					32960,
					46160
				},
				{
					33400,
					104720
				},
				{
					49520,
					110960
				},
				{
					48560,
					87920
				}
			},
			Slist = {
				{
					82920,
					167880
				},
				{
					49440,
					69240
				},
				{
					50100,
					157080
				},
				{
					74280,
					166440
				},
				{
					72840,
					131880
				}
			},
			SSlist = {
				{
					110560,
					223840
				},
				{
					65920,
					92320
				},
				{
					66800,
					209440
				},
				{
					99040,
					221920
				},
				{
					97120,
					175840
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "HoloLiveLinkGameView",
		type = 2,
		game_room = 0,
		mediator_name = "HoloLiveLinkGameMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "holo连连看",
		config_csv = "activity_event_linkgame",
		id = 7,
		hub_id = 3,
		request_data = 1
	},
	{
		is_ranking = 0,
		view_name = "QTEGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "鬼怒修行QTE游戏",
		config_data = "",
		config_csv = "",
		id = 8,
		hub_id = 4,
		request_data = 1,
		simple_config_data = {
			gameTime = 60,
			shrineGameId = 3,
			roundTime = 4,
			scorePerHit = 10,
			comboRange = {
				5,
				10
			},
			comboAddScore = {
				5,
				10
			},
			targetCombo = {
				25,
				50
			},
			targetComboScore = {
				250,
				500
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "StackGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "春节叠叠乐",
		config_csv = "",
		id = 9,
		hub_id = 5,
		request_data = 1
	},
	{
		is_ranking = 0,
		view_name = "LanternFestivalView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "元宵答题",
		config_csv = "activity_event_question",
		id = 10,
		hub_id = 6,
		request_data = 1
	},
	{
		is_ranking = 0,
		view_name = "DecodeMiniGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "解密游戏",
		config_csv = "",
		id = 11,
		hub_id = 7,
		request_data = 1
	},
	{
		is_ranking = 0,
		view_name = "Match3GameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "消消乐",
		config_csv = "",
		id = 12,
		hub_id = 8,
		request_data = 1
	},
	{
		is_ranking = 0,
		view_name = "TowerClimbingGameView",
		type = 4,
		game_room = 0,
		mediator_name = "TowerClimbingMediator",
		config_csv_key = "",
		name = "啾啾大冒险",
		config_data = "",
		config_csv = "",
		id = 13,
		hub_id = 9,
		request_data = 1,
		simple_config_data = {
			{
				{
					10,
					20,
					30,
					40,
					50
				},
				{
					{
						14,
						104,
						1
					}
				}
			},
			{
				{
					10,
					20,
					30,
					40,
					50
				},
				{
					{
						2,
						59789,
						1
					}
				}
			},
			{
				{
					10,
					20,
					30,
					40,
					50
				},
				{
					{
						2,
						59790,
						1
					},
					{
						15,
						103,
						1
					}
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "RollingBallGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "啾啾转转乐",
		config_csv = "",
		id = 14,
		hub_id = 10,
		request_data = 1
	},
	{
		is_ranking = 0,
		view_name = "HalloweenGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "万圣节小游戏",
		config_csv = "",
		id = 15,
		hub_id = 25,
		request_data = 1
	},
	{
		is_ranking = 0,
		view_name = "MusicGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "音乐小游戏",
		config_data = "",
		config_csv = "",
		id = 16,
		hub_id = 12,
		request_data = 0,
		simple_config_data = {
			special_combo = 0,
			good = 300,
			misstime = 0.35,
			perfect = 600,
			goodtime = 0.25,
			combo = 100,
			miss = 0,
			laterperfecttime = 0.1,
			speed_max = 100,
			perfecttime = 0.1,
			special_score = 5000,
			speed_min = 60,
			latergoodtime = 0.2,
			story = {
				{},
				{},
				{},
				{},
				{},
				{},
				{}
			},
			combo_interval = {
				10,
				20,
				40,
				60,
				80,
				100
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "VolleyballGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "沙排小游戏",
		config_data = "",
		config_csv = "",
		id = 17,
		hub_id = 13,
		request_data = 0,
		simple_config_data = {
			story = {
				{
					"JIARIHANGXIANRICHANG1"
				},
				{},
				{
					"JIARIHANGXIANRICHANG2"
				},
				{},
				{
					"JIARIHANGXIANRICHANG3"
				},
				{},
				{
					"JIARIHANGXIANRICHANG4"
				}
			},
			mainChar = {
				1,
				6,
				3,
				4,
				5,
				2,
				7
			},
			minorChar = {
				2,
				1,
				2,
				5,
				6,
				7,
				4
			},
			endScore = {
				5,
				5,
				5,
				5,
				5,
				5,
				5
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "SnowballGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "2002啾啾雪合战小游戏",
		config_csv = "",
		id = 18,
		hub_id = 14,
		request_data = 1
	},
	{
		is_ranking = 0,
		view_name = "NewYearSnackView",
		type = 1,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "2020小吃街小游戏",
		config_data = "",
		config_csv = "",
		id = 19,
		hub_id = 15,
		request_data = 0,
		simple_config_data = {
			memory_time = 5,
			select_time = 10,
			correct_value = {
				[0] = 0,
				1,
				2,
				5
			},
			score_level = {
				0,
				5,
				12,
				20
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "NewYearShrineView",
		type = 3,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		name = "2020敲钟小游戏",
		config_csv = "",
		id = 20,
		hub_id = 14,
		request_data = 1,
		config_data = {
			5,
			{
				10,
				11,
				12
			},
			2
		}
	},
	{
		is_ranking = 0,
		view_name = "FushunAdventureView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "2021抚顺大冒险II",
		config_csv = "",
		id = 21,
		hub_id = 16,
		request_data = 1
	},
	{
		is_ranking = 0,
		view_name = "LanternFestivalView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "元宵答题2",
		config_csv = "activity_event_question",
		id = 22,
		hub_id = 17,
		request_data = 1
	},
	{
		is_ranking = 0,
		view_name = "PokeMoleView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "打地鼠",
		config_csv = "",
		id = 23,
		hub_id = 18,
		request_data = 1
	},
	{
		is_ranking = 0,
		view_name = "IdolMasterView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "啾啾握手会",
		config_csv = "",
		id = 24,
		hub_id = 19,
		request_data = 0
	},
	{
		is_ranking = 0,
		view_name = "SnackView",
		type = 1,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "小吃小游戏",
		config_data = "",
		config_csv = "",
		id = 25,
		hub_id = 20,
		request_data = 0,
		simple_config_data = {
			memory_time = 5,
			select_time = 10,
			correct_value = {
				[0] = 0,
				1,
				2,
				5
			},
			score_level = {
				0,
				5,
				12,
				20
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "FireworkFactoryView",
		type = 2,
		game_room = 0,
		mediator_name = "FireworkFactoryMediator",
		config_csv_key = "",
		name = "制作烟花",
		config_data = "",
		config_csv = "",
		id = 26,
		hub_id = 20,
		request_data = 1,
		simple_config_data = {
			roundTime = 50,
			score_reference = {
				{
					140,
					160
				},
				{
					120,
					180
				},
				{
					90,
					210
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "ShootingGameView",
		type = 2,
		game_room = 0,
		mediator_name = "ShootingGameMediator",
		config_csv_key = "",
		name = "打靶游戏",
		config_data = "",
		config_csv = "",
		id = 27,
		hub_id = 20,
		request_data = 0,
		simple_config_data = {
			fireCD = 1,
			moveSpeed = 4,
			baseTime = 12,
			bonusTime = 0,
			targetScore = {
				10,
				5,
				2
			},
			score_level = {
				0,
				10,
				25,
				35
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "RopingCowGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "啾啾牛仔",
		config_data = "",
		config_csv = "",
		id = 28,
		hub_id = 56,
		request_data = 1,
		simple_config_data = {
			stroy_act = 5523,
			drop = {
				{
					2,
					54006,
					1
				},
				{
					2,
					50004,
					5
				},
				{
					1,
					2,
					300
				},
				{
					2,
					54034,
					2
				},
				{
					2,
					20013,
					1
				},
				{
					2,
					54051,
					1
				},
				{
					2,
					30359,
					2
				}
			},
			story = {
				{
					"HUANGYEJIARIKAITUOJI13"
				},
				{
					"HUANGYEJIARIKAITUOJI14"
				},
				{
					"HUANGYEJIARIKAITUOJI15"
				},
				{
					"HUANGYEJIARIKAITUOJI16"
				},
				{
					"HUANGYEJIARIKAITUOJI17"
				},
				{
					"HUANGYEJIARIKAITUOJI18"
				},
				{}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "GuessForkGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "猜叉子小游戏",
		config_csv = "",
		id = 29,
		hub_id = 22,
		request_data = 0
	},
	{
		is_ranking = 0,
		view_name = "CatchTreasureGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "打捞团小游戏",
		config_data = "",
		config_csv = "",
		id = 30,
		hub_id = 23,
		request_data = 0,
		simple_config_data = {
			drop_ids = {
				{
					2,
					54050,
					2
				},
				{
					1,
					1,
					300
				},
				{
					2,
					54051,
					1
				},
				{
					1,
					1,
					300
				},
				{
					2,
					50004,
					5
				},
				{
					2,
					20012,
					2
				},
				{
					2,
					30347,
					2
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "EatFoodGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "夕立改造小游戏",
		config_csv = "",
		id = 31,
		hub_id = 35,
		request_data = 0
	},
	{
		is_ranking = 0,
		view_name = "GridGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "古立特小游戏",
		config_csv = "",
		id = 32,
		hub_id = 26,
		request_data = 0
	},
	{
		is_ranking = 1,
		view_name = "CurlingGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "冰壶小游戏",
		config_data = "",
		config_csv = "",
		id = 33,
		hub_id = 38,
		request_data = 0,
		simple_config_data = {
			skin_shop_id = 2020772,
			drop = {
				{
					2,
					54006,
					1
				},
				{
					2,
					50004,
					5
				},
				{
					1,
					2,
					300
				},
				{
					2,
					54034,
					1
				},
				{
					2,
					20013,
					1
				},
				{
					2,
					54051,
					1
				},
				{
					7,
					202072,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "Shrine2022View",
		type = 3,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "神社指挥官许愿",
		config_csv = "",
		id = 34,
		hub_id = 27,
		request_data = 1,
		simple_config_data = {
			target = 100000
		},
		config_data = {
			5,
			{
				10,
				11,
				12
			},
			2
		}
	},
	{
		is_ranking = 0,
		view_name = "Shrine2022View",
		type = 5,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "神社舰娘许愿",
		config_csv = "",
		id = 35,
		hub_id = 27,
		request_data = 1,
		simple_config_data = {
			8,
			59261,
			1
		},
		config_data = {
			0,
			{
				59,
				60,
				61,
				62,
				63,
				64,
				65
			},
			1
		}
	},
	{
		is_ranking = 0,
		view_name = "FireworkFactory2022View",
		type = 2,
		game_room = 0,
		mediator_name = "FireworkFactoryMediator",
		config_csv_key = "",
		name = "新年烟花工坊",
		config_data = "",
		config_csv = "",
		id = 36,
		hub_id = 28,
		request_data = 1,
		simple_config_data = {
			roundTime = 50,
			score_reference = {
				{
					140,
					160
				},
				{
					120,
					180
				},
				{
					90,
					210
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "Fushun3GameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "2021抚顺大冒险III",
		config_csv = "",
		id = 37,
		hub_id = 53,
		request_data = 1
	},
	{
		is_ranking = 0,
		view_name = "LanternFestivalView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "元宵答题3",
		config_csv = "activity_event_question",
		id = 38,
		hub_id = 30,
		request_data = 1
	},
	{
		is_ranking = 0,
		view_name = "DecodeMiniGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "解密游戏",
		config_data = "",
		config_csv = "",
		id = 39,
		hub_id = 31,
		request_data = 1,
		simple_config_data = {}
	},
	{
		is_ranking = 0,
		view_name = "HideSeekGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "啾啾躲猫猫",
		config_data = "",
		config_csv = "",
		id = 40,
		hub_id = 32,
		request_data = 1,
		simple_config_data = {}
	},
	{
		is_ranking = 0,
		view_name = "IceCreamGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "冰淇淋小游戏",
		config_data = "",
		config_csv = "",
		id = 41,
		hub_id = 33,
		request_data = 0,
		simple_config_data = {
			drop_ids = {
				{
					2,
					54050,
					2
				},
				{
					1,
					1,
					300
				},
				{
					2,
					54051,
					1
				},
				{
					1,
					1,
					300
				},
				{
					2,
					50004,
					5
				},
				{
					2,
					20012,
					2
				},
				{
					14,
					601,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "CookGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "女仆蛋糕小游戏",
		config_data = "",
		config_csv = "",
		id = 42,
		hub_id = 34,
		request_data = 0,
		simple_config_data = {
			drop_ids = {
				{
					2,
					54006,
					1
				},
				{
					2,
					50004,
					5
				},
				{
					5,
					94304,
					1
				},
				{
					2,
					54034,
					2
				},
				{
					2,
					20013,
					1
				},
				{
					2,
					54051,
					1
				},
				{
					5,
					94113,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "RyzaMiniGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "莱莎炸弹小游戏",
		config_data = "",
		config_csv = "",
		id = 43,
		hub_id = 36,
		request_data = 0,
		simple_config_data = {
			story = {
				{
					"LAISHARICHANG1"
				},
				{
					"LAISHARICHANG2"
				},
				{
					"LAISHARICHANG3"
				},
				{
					"LAISHARICHANG4"
				},
				{
					"LAISHARICHANG5"
				},
				{
					"LAISHARICHANG6"
				},
				{
					"LAISHARICHANG7"
				}
			},
			drop_ids = {
				{
					2,
					30341,
					1
				},
				{
					5,
					95144,
					1
				},
				{
					2,
					30341,
					1
				},
				{
					9,
					1218,
					1
				},
				{
					2,
					30341,
					1
				},
				{
					2,
					30341,
					1
				},
				{
					5,
					95128,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "BeachGuardGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "PVZ小游戏",
		config_data = "",
		config_csv = "",
		id = 44,
		hub_id = 37,
		request_data = 0,
		simple_config_data = {
			drop = {
				{
					2,
					54006,
					1
				},
				{
					2,
					50004,
					5
				},
				{
					1,
					2,
					300
				},
				{
					2,
					54034,
					1
				},
				{
					2,
					20013,
					1
				},
				{
					2,
					54051,
					1
				},
				{
					7,
					102233,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "Shrine2022View",
		type = 3,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "2023神社指挥官许愿",
		config_csv = "",
		id = 45,
		hub_id = 37,
		request_data = 1,
		simple_config_data = {
			target = 100000,
			shipGameID = 46
		},
		config_data = {
			5,
			{
				10,
				11,
				12
			},
			2
		}
	},
	{
		is_ranking = 0,
		view_name = "Shrine2022View",
		type = 5,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "2023神社舰娘许愿",
		config_csv = "",
		id = 46,
		hub_id = 37,
		request_data = 1,
		simple_config_data = {
			8,
			59372,
			1
		},
		config_data = {
			0,
			{
				66,
				67,
				68,
				69,
				70,
				71,
				72
			},
			1
		}
	},
	{
		is_ranking = 0,
		view_name = "StackGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "春节叠叠乐复刻",
		config_data = "",
		config_csv = "",
		id = 47,
		hub_id = 39,
		request_data = 1,
		simple_config_data = {
			drop = {
				{
					2,
					54006,
					1
				},
				{
					2,
					50004,
					5
				},
				{
					1,
					2,
					300
				},
				{
					2,
					54034,
					1
				},
				{
					2,
					20013,
					1
				},
				{
					2,
					54051,
					1
				},
				{
					4,
					301721,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "NenjuuMiniGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "年兽小游戏",
		config_data = "",
		config_csv = "",
		id = 48,
		hub_id = 40,
		request_data = 0,
		simple_config_data = {
			drop = {
				{
					2,
					60024,
					1
				},
				{
					2,
					60024,
					1
				},
				{
					2,
					60024,
					1
				},
				{
					2,
					60024,
					1
				},
				{
					2,
					60024,
					1
				},
				{
					2,
					60024,
					1
				},
				{
					4,
					501021,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "LanternFestivalView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "元宵答题4",
		config_csv = "activity_event_question",
		id = 49,
		hub_id = 41,
		request_data = 1
	},
	{
		is_ranking = 0,
		view_name = "ValentineQteGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "2023情人节小游戏",
		config_data = "",
		config_csv = "",
		id = 50,
		hub_id = 63,
		request_data = 1,
		simple_config_data = {
			drop_ids = {
				{
					2,
					54006,
					1
				},
				{
					2,
					50004,
					5
				},
				{
					1,
					2,
					300
				},
				{
					2,
					54034,
					2
				},
				{
					2,
					20013,
					1
				},
				{
					2,
					54051,
					1
				},
				{
					7,
					201372,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "DOAPPMiniGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "砰砰咚挑战赛",
		config_data = "",
		config_csv = "",
		id = 51,
		hub_id = 43,
		request_data = 0,
		simple_config_data = {
			drop = {
				{
					2,
					30323,
					1
				},
				{
					2,
					30323,
					1
				},
				{
					21,
					10980,
					1
				},
				{
					2,
					30323,
					1
				},
				{
					2,
					30323,
					1
				},
				{
					2,
					30323,
					1
				},
				{
					21,
					10960,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "OreMiniGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "六周年搬矿石小游戏",
		config_csv = "",
		id = 52,
		hub_id = 44,
		request_data = 0
	},
	{
		is_ranking = 0,
		view_name = "IslandCatchTreasureGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "(海岛)打捞团小游戏",
		config_csv = "",
		id = 53,
		hub_id = 44,
		request_data = 0
	},
	{
		is_ranking = 0,
		view_name = "IslandTowerClimbingGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "(海岛)啾啾大冒险",
		config_data = "",
		config_csv = "",
		id = 54,
		hub_id = 44,
		request_data = 0,
		simple_config_data = {
			{
				{
					10,
					20,
					30,
					40,
					50
				},
				{
					{
						14,
						104,
						1
					}
				}
			},
			{
				{
					10,
					20,
					30,
					40,
					50
				},
				{
					{
						2,
						59789,
						1
					}
				}
			},
			{
				{
					10,
					20,
					30,
					40,
					50
				},
				{
					{
						2,
						59790,
						1
					},
					{
						15,
						103,
						1
					}
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "GridGameReView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "古立特小游戏2",
		config_csv = "",
		id = 55,
		hub_id = 46,
		request_data = 0
	},
	{
		is_ranking = 0,
		view_name = "CastleGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "城堡挑战赛Q版小游戏",
		config_data = "",
		config_csv = "",
		id = 56,
		hub_id = 47,
		request_data = 0,
		simple_config_data = {
			drop_ids = {
				{
					2,
					54050,
					2
				},
				{
					1,
					1,
					300
				},
				{
					2,
					54051,
					1
				},
				{
					1,
					1,
					300
				},
				{
					2,
					50004,
					5
				},
				{
					2,
					20012,
					2
				},
				{
					2,
					30347,
					2
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "LaunchBallGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "祖玛弹珠小游戏",
		config_data = "",
		config_csv = "",
		id = 57,
		hub_id = 48,
		request_data = 0,
		simple_config_data = {
			drop_ids = {
				{
					2,
					54050,
					2
				},
				{
					1,
					1,
					300
				},
				{
					2,
					54051,
					1
				},
				{
					1,
					1,
					300
				},
				{
					2,
					50004,
					5
				},
				{
					2,
					20012,
					2
				},
				{
					2,
					30347,
					2
				}
			}
		}
	},
	{
		is_ranking = 1,
		view_name = "RacingMiniGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "赛车活跃小游戏",
		config_data = "",
		config_csv = "",
		id = 58,
		hub_id = 49,
		request_data = 0,
		simple_config_data = {
			drop = {
				{
					2,
					54006,
					1
				},
				{
					2,
					50004,
					5
				},
				{
					14,
					605,
					1
				},
				{
					2,
					54034,
					2
				},
				{
					2,
					20013,
					1
				},
				{
					2,
					54051,
					1
				},
				{
					5,
					263,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "SailBoatGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "帆船小游戏",
		config_data = "",
		config_csv = "",
		id = 59,
		hub_id = 50,
		request_data = 0,
		simple_config_data = {
			drop_ids = {
				{
					2,
					54003,
					1
				},
				{
					2,
					50004,
					5
				},
				{
					3,
					150160,
					1
				},
				{
					2,
					54024,
					2
				},
				{
					3,
					150180,
					1
				},
				{
					2,
					20013,
					2
				},
				{
					5,
					304106,
					1
				}
			},
			show_time = {
				"timer",
				{
					{
						2024,
						10,
						24
					},
					{
						0,
						0,
						0
					}
				},
				{
					{
						2024,
						11,
						7
					},
					{
						23,
						59,
						59
					}
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "CookGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "女仆蛋糕小游戏II",
		config_data = "",
		config_csv = "",
		id = 60,
		hub_id = 51,
		request_data = 0,
		simple_config_data = {
			drop_ids = {
				{
					2,
					59516,
					15
				},
				{
					2,
					59516,
					15
				},
				{
					5,
					306109,
					1
				},
				{
					2,
					59516,
					25
				},
				{
					2,
					59516,
					25
				},
				{
					2,
					59516,
					25
				},
				{
					5,
					306113,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "Shrine2022View",
		type = 5,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "2024神社舰娘许愿",
		config_csv = "",
		id = 61,
		hub_id = 51,
		request_data = 1,
		simple_config_data = {
			8,
			59850,
			1
		},
		config_data = {
			0,
			{
				74,
				75,
				76,
				77,
				78,
				79,
				80
			},
			1
		}
	},
	{
		is_ranking = 0,
		view_name = "Shrine2022View",
		type = 3,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "2024神社指挥官许愿",
		config_csv = "",
		id = 62,
		hub_id = 51,
		request_data = 1,
		simple_config_data = {
			target = 100000,
			shipGameID = 61
		},
		config_data = {
			5,
			{
				10,
				11,
				12
			},
			2
		}
	},
	{
		is_ranking = 0,
		view_name = "BeachGuardGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "PVZ小游戏复刻",
		config_data = "",
		config_csv = "",
		id = 63,
		hub_id = 52,
		request_data = 0,
		simple_config_data = {
			drop = {
				{
					2,
					54006,
					1
				},
				{
					2,
					50004,
					5
				},
				{
					1,
					2,
					300
				},
				{
					2,
					54034,
					1
				},
				{
					2,
					20013,
					1
				},
				{
					2,
					54051,
					1
				},
				{
					7,
					102233,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "LanternFestivalView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "元宵答题2024",
		config_csv = "activity_event_question",
		id = 64,
		hub_id = 54,
		request_data = 1
	},
	{
		is_ranking = 1,
		view_name = "PipeGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "水管工小游戏",
		config_data = "",
		config_csv = "",
		id = 65,
		hub_id = 55,
		request_data = 0,
		simple_config_data = {
			drop_ids = {
				{
					2,
					54050,
					2
				},
				{
					1,
					1,
					300
				},
				{
					2,
					54051,
					1
				},
				{
					1,
					1,
					300
				},
				{
					2,
					50004,
					5
				},
				{
					2,
					20012,
					2
				},
				{
					2,
					30347,
					2
				}
			}
		}
	},
	{
		is_ranking = 1,
		view_name = "TouchCakeGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "啾啾蛋糕塔",
		config_data = "",
		config_csv = "",
		id = 66,
		hub_id = 57,
		request_data = 1,
		simple_config_data = {
			drop_ids = {
				{
					2,
					54050,
					2
				},
				{
					1,
					1,
					300
				},
				{
					2,
					54051,
					1
				},
				{
					1,
					1,
					300
				},
				{
					2,
					50004,
					5
				},
				{
					2,
					20012,
					2
				},
				{
					2,
					30347,
					2
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "EatFoodGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "宿舍拍手小游戏(用于存分数",
		config_data = "",
		config_csv = "",
		id = 67,
		hub_id = 45,
		request_data = 0,
		simple_config_data = {
			drop_ids = {
				{
					2,
					54050,
					2
				},
				{
					1,
					1,
					300
				},
				{
					2,
					54051,
					1
				},
				{
					1,
					1,
					300
				},
				{
					2,
					50004,
					5
				},
				{
					2,
					20012,
					2
				},
				{
					2,
					30347,
					2
				}
			}
		}
	},
	{
		is_ranking = 1,
		view_name = "BoatAdGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "海盗广告小游戏",
		config_data = "",
		config_csv = "",
		id = 68,
		hub_id = 58,
		request_data = 1,
		simple_config_data = {
			drop_ids = {
				{
					2,
					54050,
					2
				},
				{
					1,
					1,
					300
				},
				{
					2,
					54051,
					1
				},
				{
					1,
					1,
					300
				},
				{
					2,
					50004,
					5
				},
				{
					2,
					20012,
					2
				},
				{
					2,
					30347,
					2
				}
			}
		}
	},
	{
		is_ranking = 1,
		view_name = "ToLoveGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "tolove联动小游戏",
		config_data = "",
		config_csv = "",
		id = 69,
		hub_id = 59,
		request_data = 0,
		simple_config_data = {
			story = {
				{
					"WEIXIANFAMINGPOJINZHONGRICHANG1"
				},
				{
					"WEIXIANFAMINGPOJINZHONGRICHANG2"
				},
				{
					"WEIXIANFAMINGPOJINZHONGRICHANG3"
				},
				{
					"WEIXIANFAMINGPOJINZHONGRICHANG4"
				},
				{
					"WEIXIANFAMINGPOJINZHONGRICHANG5"
				},
				{
					"WEIXIANFAMINGPOJINZHONGRICHANG6"
				},
				{}
			},
			drop_ids = {
				{
					5,
					316303,
					1
				},
				{
					2,
					54049,
					2
				},
				{
					5,
					316306,
					1
				},
				{
					1,
					1,
					500
				},
				{
					2,
					30362,
					1
				},
				{
					2,
					54016,
					10
				},
				{
					5,
					316307,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "Shrine2022View",
		type = 5,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "2024神社舰娘许愿",
		config_csv = "",
		id = 70,
		hub_id = 60,
		request_data = 1,
		simple_config_data = {
			8,
			65066,
			1
		},
		config_data = {
			0,
			{
				82,
				83,
				84,
				85,
				86,
				87,
				88
			},
			1
		}
	},
	{
		is_ranking = 0,
		view_name = "Shrine2022View",
		type = 3,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "2024神社指挥官许愿",
		config_csv = "",
		id = 71,
		hub_id = 60,
		request_data = 1,
		simple_config_data = {
			target = 100000,
			shipGameID = 70
		},
		config_data = {
			5,
			{
				10,
				11,
				12
			},
			2
		}
	},
	{
		is_ranking = 0,
		view_name = "CurlingGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "冰壶小游戏",
		config_data = "",
		config_csv = "",
		id = 72,
		hub_id = 60,
		request_data = 0,
		simple_config_data = {
			drop = {
				{
					1,
					449,
					15
				},
				{
					1,
					449,
					15
				},
				{
					5,
					317304,
					1
				},
				{
					1,
					449,
					25
				},
				{
					1,
					449,
					25
				},
				{
					1,
					449,
					25
				},
				{
					5,
					317107,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "NenjuuMiniGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "年兽小游戏(抚顺大冒险4 IV 复刻)",
		config_data = "",
		config_csv = "",
		id = 73,
		hub_id = 61,
		request_data = 0,
		simple_config_data = {
			drop = {
				{
					2,
					60026,
					1
				},
				{
					2,
					60026,
					1
				},
				{
					2,
					60026,
					2
				},
				{
					4,
					501021,
					1
				},
				{
					2,
					60026,
					1
				},
				{
					2,
					60026,
					2
				},
				{
					2,
					59854,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "LanternFestivalView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "元宵答题2025",
		config_csv = "activity_event_question",
		id = 74,
		hub_id = 62,
		request_data = 1
	},
	{
		is_ranking = 0,
		view_name = "EatFoodGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "猜拳小游戏",
		config_csv = "",
		id = 75,
		hub_id = 45,
		request_data = 0
	},
	{
		is_ranking = 1,
		view_name = "WatermelonGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "『别墅度假岛』合成小游戏",
		config_data = "",
		config_csv = "",
		id = 76,
		hub_id = 64,
		request_data = 0,
		simple_config_data = {
			drop_ids = {
				{
					2,
					54006,
					1
				},
				{
					17,
					247,
					1
				},
				{
					1,
					2,
					300
				},
				{
					2,
					54034,
					1
				},
				{
					2,
					20013,
					1
				},
				{
					2,
					54051,
					1
				},
				{
					17,
					248,
					1
				}
			}
		}
	},
	{
		is_ranking = 0,
		view_name = "CatchTreasureGameView",
		type = 2,
		game_room = 0,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "『别墅度假岛』打捞团小游戏",
		config_data = "",
		config_csv = "",
		id = 77,
		hub_id = 65,
		request_data = 0,
		simple_config_data = {
			drop_ids = {
				{
					2,
					54006,
					1
				},
				{
					2,
					50004,
					5
				},
				{
					9,
					3046,
					1
				},
				{
					2,
					54034,
					2
				},
				{
					9,
					3047,
					1
				},
				{
					2,
					20013,
					1
				},
				{
					9,
					3048,
					1
				}
			}
		}
	},
	[1001] = {
		is_ranking = 0,
		view_name = "GameRoomFushun3View",
		type = 1,
		game_room = 1,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "小游戏厅抚顺大冒险",
		config_csv = "",
		id = 1001,
		hub_id = 45,
		request_data = 1
	},
	[1002] = {
		is_ranking = 0,
		view_name = "GameRoomPileGameView",
		type = 1,
		game_room = 1,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "小游戏厅叠叠乐",
		config_csv = "",
		id = 1002,
		hub_id = 45,
		request_data = 1
	},
	[1003] = {
		is_ranking = 0,
		view_name = "GameRoomMatch3View",
		type = 1,
		game_room = 2,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "小游戏厅三消",
		config_csv = "",
		id = 1003,
		hub_id = 45,
		request_data = 1
	},
	[1004] = {
		is_ranking = 0,
		view_name = "GameRoomShootingView",
		type = 1,
		game_room = 3,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "小游戏厅打靶",
		config_data = "",
		config_csv = "",
		id = 1004,
		hub_id = 45,
		request_data = 1,
		simple_config_data = {
			fireCD = 1,
			moveSpeed = 4,
			baseTime = 12,
			bonusTime = 0,
			targetScore = {
				10,
				5,
				2
			},
			score_level = {
				0,
				10,
				25,
				35
			}
		}
	},
	[1005] = {
		is_ranking = 0,
		view_name = "GameRoomSnackView",
		type = 1,
		game_room = 4,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "小游戏厅小吃街",
		config_data = "",
		config_csv = "",
		id = 1005,
		hub_id = 45,
		request_data = 1,
		simple_config_data = {
			memory_time = 5,
			select_time = 10,
			correct_value = {
				[0] = 0,
				1,
				2,
				5
			},
			score_level = {
				0,
				5,
				12,
				20
			}
		}
	},
	[1006] = {
		is_ranking = 0,
		view_name = "GameRoomQTEView",
		type = 1,
		game_room = 5,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "小游戏厅修行",
		config_data = "",
		config_csv = "",
		id = 1006,
		hub_id = 45,
		request_data = 1,
		simple_config_data = {
			gameTime = 60,
			shrineGameId = 3,
			roundTime = 4,
			scorePerHit = 10,
			comboRange = {
				5,
				10
			},
			comboAddScore = {
				5,
				10
			},
			targetCombo = {
				25,
				50
			},
			targetComboScore = {
				250,
				500
			}
		}
	},
	[1007] = {
		is_ranking = 0,
		view_name = "GameRoomPokeView",
		type = 1,
		game_room = 6,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "小游戏厅蛋糕保卫战",
		config_csv = "",
		id = 1007,
		hub_id = 45,
		request_data = 1
	},
	[1008] = {
		is_ranking = 0,
		view_name = "GameRoomTowerView",
		type = 1,
		game_room = 7,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "小游戏厅啾啾大冒险",
		config_data = "",
		config_csv = "",
		id = 1008,
		hub_id = 45,
		request_data = 1,
		simple_config_data = {
			{
				{
					10,
					20,
					30,
					40,
					50
				},
				{
					{
						14,
						104,
						1
					}
				}
			},
			{
				{
					10,
					20,
					30,
					40,
					50
				},
				{
					{
						2,
						59789,
						1
					}
				}
			},
			{
				{
					10,
					20,
					30,
					40,
					50
				},
				{
					{
						2,
						59790,
						1
					},
					{
						15,
						103,
						1
					}
				}
			}
		}
	},
	[1009] = {
		is_ranking = 0,
		view_name = "GameRoomFushun2View",
		type = 1,
		game_room = 8,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "小游戏厅大冒险2",
		config_csv = "",
		id = 1009,
		hub_id = 45,
		request_data = 1
	},
	[1010] = {
		is_ranking = 0,
		view_name = "GameRoomRollingView",
		type = 1,
		game_room = 9,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "小游戏厅转转乐",
		config_csv = "",
		id = 1010,
		hub_id = 45,
		request_data = 1
	},
	[1011] = {
		is_ranking = 0,
		view_name = "GameRoomHalloweenView",
		type = 1,
		game_room = 10,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "小游戏厅万圣节",
		config_csv = "",
		id = 1011,
		hub_id = 45,
		request_data = 1
	},
	[1012] = {
		is_ranking = 0,
		view_name = "GameRoomSnowballView",
		type = 1,
		game_room = 11,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "小游戏厅雪合战",
		config_csv = "",
		id = 1012,
		hub_id = 45,
		request_data = 1
	},
	[1013] = {
		is_ranking = 0,
		view_name = "GameRoomPipeView",
		type = 1,
		game_room = 12,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "小游戏厅水管工",
		config_data = "",
		config_csv = "",
		id = 1013,
		hub_id = 45,
		request_data = 1,
		simple_config_data = {
			drop_ids = {
				{
					2,
					54050,
					2
				},
				{
					1,
					1,
					300
				},
				{
					2,
					54051,
					1
				},
				{
					1,
					1,
					300
				},
				{
					2,
					50004,
					5
				},
				{
					2,
					20012,
					2
				},
				{
					2,
					30347,
					2
				}
			}
		}
	},
	[1014] = {
		is_ranking = 0,
		view_name = "GameRoomCookView",
		type = 1,
		game_room = 13,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "小游戏厅蛋糕",
		config_data = "",
		config_csv = "",
		id = 1014,
		hub_id = 45,
		request_data = 1,
		simple_config_data = {
			drop_ids = {
				{
					2,
					59516,
					15
				},
				{
					2,
					59516,
					15
				},
				{
					5,
					306109,
					1
				},
				{
					2,
					59516,
					25
				},
				{
					2,
					59516,
					25
				},
				{
					2,
					59516,
					25
				},
				{
					5,
					306113,
					1
				}
			}
		}
	},
	[1015] = {
		is_ranking = 0,
		view_name = "GameRoomLaunchView",
		type = 1,
		game_room = 14,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "小游戏厅祖玛",
		config_data = "",
		config_csv = "",
		id = 1015,
		hub_id = 45,
		request_data = 1,
		simple_config_data = {
			drop_ids = {
				{
					2,
					54050,
					2
				},
				{
					1,
					1,
					300
				},
				{
					2,
					54051,
					1
				},
				{
					1,
					1,
					300
				},
				{
					2,
					50004,
					5
				},
				{
					2,
					20012,
					2
				},
				{
					2,
					30347,
					2
				}
			}
		}
	},
	[1016] = {
		is_ranking = 0,
		view_name = "GameRoomTreasureView",
		type = 1,
		game_room = 15,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "小游戏厅打捞",
		config_csv = "",
		id = 1016,
		hub_id = 45,
		request_data = 1
	},
	[1017] = {
		is_ranking = 0,
		view_name = "GameRoomGuardView",
		type = 1,
		game_room = 16,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		name = "小游戏厅沙滩保卫",
		config_data = "",
		config_csv = "",
		id = 1017,
		hub_id = 45,
		request_data = 1,
		simple_config_data = {
			drop = {
				{
					2,
					54006,
					1
				},
				{
					2,
					50004,
					5
				},
				{
					1,
					2,
					300
				},
				{
					2,
					54034,
					1
				},
				{
					2,
					20013,
					1
				},
				{
					2,
					54051,
					1
				},
				{
					7,
					102233,
					1
				}
			}
		}
	},
	[1018] = {
		is_ranking = 0,
		view_name = "GameRoomOreView",
		type = 1,
		game_room = 17,
		mediator_name = "MiniHubMediator",
		config_csv_key = "",
		simple_config_data = "",
		config_data = "",
		name = "小游戏厅搬矿石",
		config_csv = "",
		id = 1018,
		hub_id = 45,
		request_data = 1
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
		19,
		20,
		21,
		22,
		23,
		24,
		25,
		26,
		27,
		28,
		29,
		30,
		31,
		32,
		33,
		34,
		35,
		36,
		37,
		38,
		39,
		40,
		41,
		42,
		43,
		44,
		45,
		46,
		47,
		48,
		49,
		50,
		51,
		52,
		53,
		54,
		55,
		56,
		57,
		58,
		59,
		60,
		61,
		62,
		63,
		64,
		65,
		66,
		67,
		68,
		69,
		70,
		71,
		72,
		73,
		74,
		75,
		76,
		77,
		1001,
		1002,
		1003,
		1004,
		1005,
		1006,
		1007,
		1008,
		1009,
		1010,
		1011,
		1012,
		1013,
		1014,
		1015,
		1016,
		1017,
		1018
	}
}
