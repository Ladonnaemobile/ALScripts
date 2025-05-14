GraphicSettingConst = {}

local var_0_0 = GraphicSettingConst

var_0_0.SettingType = {
	toggle = 1,
	select = 2
}
var_0_0.SettingLevel = {
	High = 3,
	Mid = 2,
	Low = 1,
	Custom = 4
}
var_0_0.assetPath = {
	"Default_LowQualitySettings",
	"Default_MediumQualitySettings",
	"Default_HighQualitySettings",
	"Default_QualitySettings"
}
var_0_0.settings = {
	{
		tips = "grapihcs3d_setting_gpgpu_warning",
		settingType = 1,
		Cname = "EnableGPUDriver",
		playerPrefsname = "enableGPUDriver",
		settingName = "grapihcs3d_setting_enable_gup_driver",
		isShow = 1
	},
	{
		settingType = 2,
		Cname = "Resolution",
		playerPrefsname = "resolution",
		settingName = "grapihcs3d_setting_resolution",
		isShow = 1,
		optionNames = {
			"grapihcs3d_setting_resolution_optionname0",
			"grapihcs3d_setting_resolution_optionname1",
			"grapihcs3d_setting_resolution_optionname2"
		},
		options = {
			1280,
			1920,
			2560
		}
	},
	{
		settingType = 2,
		Cname = "RenderingQuality",
		playerPrefsname = "renderingQuality",
		settingName = "grapihcs3d_setting_rendering_quality",
		isShow = 1,
		optionNames = {
			"grapihcs3d_setting_rendering_quality_optionname0",
			"grapihcs3d_setting_rendering_quality_optionname1"
		},
		options = {
			0,
			1
		}
	},
	{
		settingType = 2,
		Cname = "ShaderQuality",
		playerPrefsname = "shaderQuality",
		settingName = "grapihcs3d_setting_shader_quality",
		isShow = 1,
		optionNames = {
			"grapihcs3d_setting_shader_quality_optionname0",
			"grapihcs3d_setting_shader_quality_optionname1"
		},
		options = {
			0,
			1
		}
	},
	{
		settingType = 1,
		Cname = "EnableAdditionalLights",
		playerPrefsname = "enableAdditionalLights",
		settingName = "grapihcs3d_setting_enable_additional_lights",
		isShow = 1
	},
	{
		settingType = 2,
		Cname = "ShadowQuality",
		playerPrefsname = "shadowQuality",
		settingName = "grapihcs3d_setting_shadow_quality",
		isShow = 1,
		optionNames = {
			"grapihcs3d_setting_shadow_quality_optionname0",
			"grapihcs3d_setting_shadow_quality_optionname1",
			"grapihcs3d_setting_shadow_quality_optionname2",
			"grapihcs3d_setting_shadow_quality_optionname3"
		},
		options = {
			0,
			1,
			2,
			3
		}
	},
	{
		settingType = 2,
		Cname = "ShadowUpdateMode",
		playerPrefsname = "shadowUpdateMode",
		settingName = "grapihcs3d_setting_shadow_update_mode",
		isShow = 1,
		optionNames = {
			"grapihcs3d_setting_shadow_update_mode_optionname0",
			"grapihcs3d_setting_shadow_update_mode_optionname1",
			"grapihcs3d_setting_shadow_update_mode_optionname2",
			"grapihcs3d_setting_shadow_update_mode_optionname3"
		},
		options = {
			0,
			1,
			2,
			3
		}
	},
	{
		settingType = 2,
		Cname = "TerrainLayerQuality",
		playerPrefsname = "terrainLayerQuality",
		settingName = "grapihcs3d_setting_terrain_layer_quality",
		isShow = 0,
		optionNames = {
			"grapihcs3d_setting_terrain_layer_quality_optionname0",
			"grapihcs3d_setting_terrain_layer_quality_optionname1",
			"grapihcs3d_setting_terrain_layer_quality_optionname2"
		},
		options = {
			0,
			1,
			2
		}
	},
	{
		settingType = 2,
		Cname = "CharacterQuality",
		playerPrefsname = "characterQuality",
		settingName = "grapihcs3d_setting_character_quality",
		isShow = 1,
		optionNames = {
			"grapihcs3d_setting_character_quality_optionname0",
			"grapihcs3d_setting_character_quality_optionname1",
			"grapihcs3d_setting_character_quality_optionname2"
		},
		options = {
			0,
			1,
			2
		}
	},
	{
		settingType = 1,
		Cname = "EnableReflection",
		playerPrefsname = "enableReflection",
		settingName = "grapihcs3d_setting_enable_reflection",
		isShow = 1
	},
	{
		settingType = 1,
		Cname = "EnablePostProcess",
		playerPrefsname = "enablePostProcess",
		settingName = "grapihcs3d_setting_enable_post_process",
		isShow = 1
	},
	{
		parentId = 11,
		settingType = 1,
		Cname = "EnablePostAntialiasing",
		playerPrefsname = "enablePostAntialiasing",
		settingName = "grapihcs3d_setting_enable_post_antialiasing",
		isShow = 1
	},
	{
		parentId = 11,
		settingType = 1,
		Cname = "EnableHDR",
		playerPrefsname = "enableHDR",
		settingName = "grapihcs3d_setting_enable_hdr",
		isShow = 1
	},
	{
		parentId = 11,
		settingType = 1,
		Cname = "EnableDof",
		playerPrefsname = "enableDOF",
		settingName = "grapihcs3d_setting_enable_dof",
		isShow = 1
	},
	{
		parentId = 11,
		settingType = 1,
		Cname = "EnableDistort",
		playerPrefsname = "enableDistort",
		settingName = "grapihcs3d_setting_enable_distort",
		isShow = 1
	}
}

function var_0_0.InitDefautQuality()
	if PlayerPrefs.GetInt("dorm3d_graphics_settings_new", 0) == 0 then
		local var_1_0 = DevicePerformanceUtil.GetDevicePerformanceLevel()

		if PLATFORM == PLATFORM_IPHONEPLAYER then
			local var_1_1 = SystemInfo.deviceModel or ""

			local function var_1_2(arg_2_0)
				local var_2_0 = string.match(arg_2_0, "iPad(%d+)")
				local var_2_1 = tonumber(var_2_0)

				if var_2_1 and var_2_1 >= 8 then
					return true
				end

				return false
			end

			local function var_1_3(arg_3_0)
				local var_3_0 = string.match(arg_3_0, "iPhone(%d+)")
				local var_3_1 = tonumber(var_3_0)

				if var_3_1 and var_3_1 >= 13 then
					return true
				end

				return false
			end

			if var_1_2(var_1_1) or var_1_3(var_1_1) then
				var_1_0 = DevicePerformanceLevel.High
			end
		end

		local var_1_4 = var_1_0 == DevicePerformanceLevel.High and 3 or var_1_0 == DevicePerformanceLevel.Mid and 2 or 1

		PlayerPrefs.SetInt("dorm3d_graphics_settings_new", var_1_4)

		Dorm3dRoomTemplateScene.FirstDefaultSetting = var_1_4
	end
end

function var_0_0.SettingQuality()
	local var_4_0 = PlayerPrefs.GetInt("dorm3d_graphics_settings_new", 4)
	local var_4_1 = var_0_0.assetPath[var_4_0]
	local var_4_2 = LoadAny("three3dquaitysettings/defaultsettings", var_4_1)

	if var_4_0 ~= 4 then
		BLHX.Rendering.GlobalQualitySettings.SetOverrideQualitySettings(var_4_2)

		return
	end

	for iter_4_0, iter_4_1 in ipairs(var_0_0.settings) do
		local var_4_3 = PlayerPrefs.GetInt(iter_4_1.playerPrefsname, -1)

		if var_4_3 ~= -1 then
			if iter_4_1.settingType == var_0_0.SettingType.toggle then
				var_4_3 = var_4_3 == 1 and true or false
			end

			var_4_2[iter_4_1.Cname] = var_4_3
		end
	end

	BLHX.Rendering.GlobalQualitySettings.SetOverrideQualitySettings(var_4_2)
end

function var_0_0.ClearPlayerPrefs()
	if PlayerPrefs.GetInt("dorm3d_graphics_settings_changeed", 0) == 1 then
		return
	end

	PlayerPrefs.SetInt("dorm3d_graphics_settings_changeed", 1)

	for iter_5_0, iter_5_1 in ipairs(var_0_0.settings) do
		PlayerPrefs.DeleteKey(iter_5_1.playerPrefsname)
	end
end

return var_0_0
