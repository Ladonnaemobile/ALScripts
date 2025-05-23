local var_0_0 = class("SettingsResUpdatePanel", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsResUpdate"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("Settings_title_resUpdate")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / DOWNLOAD"
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.tpl = arg_4_0._tf:Find("Tpl")
	arg_4_0.containerTF = arg_4_0._tf:Find("options/list")
	arg_4_0.iconTF = arg_4_0._tf:Find("Icon")

	local var_4_0 = arg_4_0._tf:Find("options/MainGroup")
	local var_4_1 = not GroupMainHelper.IsVerSameWithServer()

	setActive(var_4_0, var_4_1)

	if var_4_1 then
		arg_4_0.mainGroupBtn = SettingsMainGroupBtn.New(var_4_0)
	end

	arg_4_0.soundBtn = SettingsSoundBtn.New({
		tpl = arg_4_0.tpl,
		container = arg_4_0.containerTF,
		iconSP = getImageSprite(arg_4_0.iconTF:Find("CV"))
	})
	arg_4_0.live2dBtn = SettingsLive2DBtn.New({
		tpl = arg_4_0.tpl,
		container = arg_4_0.containerTF,
		iconSP = getImageSprite(arg_4_0.iconTF:Find("L2D"))
	})
	arg_4_0.galleryBtn = SettingsGalleryBtn.New({
		tpl = arg_4_0.tpl,
		container = arg_4_0.containerTF,
		iconSP = getImageSprite(arg_4_0.iconTF:Find("GALLERY_PIC"))
	})
	arg_4_0.musicBtn = SettingsMusicBtn.New({
		tpl = arg_4_0.tpl,
		container = arg_4_0.containerTF,
		iconSP = getImageSprite(arg_4_0.iconTF:Find("GALLERY_BGM"))
	})
	arg_4_0.mangaBtn = SettingsMangaBtn.New({
		tpl = arg_4_0.tpl,
		container = arg_4_0.containerTF,
		iconSP = getImageSprite(arg_4_0.iconTF:Find("MANGA"))
	})

	if not LOCK_3DDORM_RES_DOWNLOAD_BTN then
		arg_4_0.dormBtn = SettingsDormBtn.New({
			tpl = arg_4_0.tpl,
			container = arg_4_0.containerTF,
			iconSP = getImageSprite(arg_4_0.iconTF:Find("DORM"))
		})
	end

	arg_4_0.repairBtn = SettingsResRepairBtn.New({
		tpl = arg_4_0.tpl,
		container = arg_4_0.containerTF,
		iconSP = getImageSprite(arg_4_0.iconTF:Find("REPAIR"))
	})
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)

	if arg_5_0:IsLoaded() then
		arg_5_0.repairBtn:Dispose()

		arg_5_0.repairBtn = nil

		arg_5_0.live2dBtn:Dispose()

		arg_5_0.live2dBtn = nil

		arg_5_0.galleryBtn:Dispose()

		arg_5_0.galleryBtn = nil

		arg_5_0.soundBtn:Dispose()

		arg_5_0.soundBtn = nil

		arg_5_0.musicBtn:Dispose()

		arg_5_0.musicBtn = nil

		arg_5_0.mangaBtn:Dispose()

		arg_5_0.mangaBtn = nil

		if arg_5_0.dormBtn then
			arg_5_0.dormBtn:Dispose()

			arg_5_0.dormBtn = nil
		end

		if arg_5_0.mainGroupBtn then
			arg_5_0.mainGroupBtn:Dispose()

			arg_5_0.mainGroupBtn = nil
		end
	end
end

return var_0_0
