return {
	map_id = 10001,
	id = 1819603,
	stages = {
		{
			stageIndex = 1,
			failCondition = 1,
			timeCount = 300,
			passCondition = 1,
			backGroundStageID = 1,
			totalArea = {
				-80,
				20,
				90,
				70
			},
			playerArea = {
				-80,
				20,
				45,
				68
			},
			enemyArea = {},
			fleetCorrdinate = {
				-80,
				0,
				75
			},
			waves = {
				{
					triggerType = 1,
					waveIndex = 100,
					preWaves = {},
					triggerParams = {
						timeout = 0.5
					}
				},
				{
					triggerType = 3,
					waveIndex = 500,
					preWaves = {
						100
					},
					triggerParams = {
						id = "HUANYINLAIDAOTONGXINXUEYUAN5-1"
					}
				},
				{
					triggerType = 0,
					key = true,
					waveIndex = 101,
					conditionType = 1,
					preWaves = {
						100
					},
					triggerParam = {},
					spawn = {
						{
							deadFX = "youeryuan_bomb",
							monsterTemplateID = 16625001,
							delay = 0,
							corrdinate = {
								0,
								0,
								75
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							deadFX = "youeryuan_bomb",
							monsterTemplateID = 16625006,
							delay = 0,
							corrdinate = {
								30,
								0,
								62
							},
							buffList = {
								8001,
								8002
							}
						},
						{
							deadFX = "youeryuan_bomb",
							monsterTemplateID = 16625003,
							delay = 0,
							corrdinate = {
								-5,
								0,
								50
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							deadFX = "youeryuan_bomb",
							monsterTemplateID = 16625006,
							delay = 0,
							corrdinate = {
								30,
								0,
								38
							},
							buffList = {
								8001,
								8002
							}
						},
						{
							deadFX = "youeryuan_bomb",
							monsterTemplateID = 16625001,
							delay = 0,
							corrdinate = {
								0,
								0,
								25
							},
							buffList = {
								8001,
								8007
							}
						}
					}
				},
				{
					triggerType = 5,
					waveIndex = 400,
					preWaves = {
						101
					},
					triggerParams = {
						bgm = "votefes-up"
					}
				},
				{
					triggerType = 0,
					key = true,
					waveIndex = 105,
					conditionType = 0,
					preWaves = {
						101
					},
					triggerParam = {},
					spawn = {
						{
							monsterTemplateID = 16625303,
							delay = 0.1,
							corrdinate = {
								-10,
								0,
								50
							},
							bossData = {
								hpBarNum = 100,
								icon = ""
							},
							buffList = {}
						}
					}
				},
				{
					triggerType = 8,
					waveIndex = 900,
					preWaves = {
						105
					},
					triggerParams = {}
				},
				{
					triggerType = 3,
					key = true,
					waveIndex = 501,
					preWaves = {
						900
					},
					triggerParams = {
						id = "HUANYINLAIDAOTONGXINXUEYUAN5-2"
					}
				}
			}
		}
	},
	fleet_prefab = {
		vanguard_unitList = {
			{
				tmpID = 900440,
				configId = 900440,
				skinId = 102200,
				id = 1,
				level = 20,
				equipment = {
					false,
					false,
					false
				},
				properties = {
					cannon = 200,
					air = 0,
					antiaircraft = 200,
					torpedo = 100,
					durability = 70000,
					reload = 300,
					armor = 0,
					dodge = 50,
					speed = 32,
					luck = 99,
					hit = 50
				},
				skills = {
					{
						id = 12240,
						level = 10
					},
					{
						id = 12250,
						level = 10
					},
					{
						id = 20142,
						level = 10
					}
				}
			},
			{
				tmpID = 900428,
				configId = 900428,
				skinId = 401431,
				id = 2,
				level = 20,
				equipment = {
					false,
					false,
					false
				},
				properties = {
					cannon = 150,
					air = 0,
					antiaircraft = 100,
					torpedo = 150,
					durability = 50000,
					reload = 300,
					armor = 0,
					dodge = 50,
					speed = 43,
					luck = 99,
					hit = 50
				},
				skills = {
					{
						id = 150180,
						level = 10
					},
					{
						id = 150190,
						level = 10
					},
					{
						id = 23052,
						level = 10
					}
				}
			},
			{
				tmpID = 900429,
				configId = 900429,
				skinId = 401471,
				id = 3,
				level = 20,
				equipment = {
					false,
					false,
					false
				},
				properties = {
					cannon = 150,
					air = 0,
					antiaircraft = 100,
					torpedo = 150,
					durability = 50000,
					reload = 300,
					armor = 0,
					dodge = 50,
					speed = 43,
					luck = 99,
					hit = 50
				},
				skills = {
					{
						id = 150160,
						level = 10
					},
					{
						id = 150170,
						level = 10
					},
					{
						id = 30282,
						level = 10
					}
				}
			}
		},
		main_unitList = {
			{
				tmpID = 900442,
				configId = 900442,
				skinId = 407020,
				id = 1,
				level = 20,
				equipment = {
					false,
					false,
					false
				},
				properties = {
					cannon = 0,
					air = 200,
					antiaircraft = 100,
					torpedo = 0,
					durability = 80000,
					reload = 600,
					armor = 0,
					dodge = 50,
					speed = 20,
					luck = 99,
					hit = 50
				},
				skills = {
					{
						id = 12090,
						level = 10
					},
					{
						id = 12100,
						level = 10
					},
					{
						id = 200965,
						level = 10
					}
				}
			},
			{
				tmpID = 900441,
				configId = 900441,
				skinId = 204040,
				id = 2,
				level = 20,
				equipment = {
					false,
					false,
					false
				},
				properties = {
					cannon = 240,
					air = 0,
					antiaircraft = 100,
					torpedo = 0,
					durability = 80000,
					reload = 600,
					armor = 0,
					dodge = 50,
					speed = 20,
					luck = 99,
					hit = 50
				},
				skills = {
					{
						id = 13200,
						level = 10
					},
					{
						id = 13210,
						level = 10
					}
				}
			},
			{
				tmpID = 900439,
				configId = 900439,
				skinId = 403130,
				id = 3,
				level = 20,
				equipment = {
					false,
					false,
					false
				},
				properties = {
					cannon = 240,
					air = 0,
					antiaircraft = 100,
					torpedo = 0,
					durability = 80000,
					reload = 600,
					armor = 0,
					dodge = 50,
					speed = 20,
					luck = 99,
					hit = 50
				},
				skills = {
					{
						id = 200964,
						level = 10
					},
					{
						id = 16100,
						level = 10
					},
					{
						id = 23222,
						level = 10
					}
				}
			}
		}
	}
}
