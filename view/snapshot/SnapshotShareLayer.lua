local var_0_0 = class("SnapshotShareLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "snapshotshareui"
end

function var_0_0.init(arg_2_0)
	arg_2_0.photoImgTrans = arg_2_0:findTF("PhotoImg")
	arg_2_0.rawImage = arg_2_0.photoImgTrans:GetComponent("RawImage")
	arg_2_0.shareBtnTrans = arg_2_0:findTF("BtnPanel/ShareBtn")
	arg_2_0.confirmBtnTrans = arg_2_0:findTF("BtnPanel/ConfirmBtn")
	arg_2_0.cancelBtnTrans = arg_2_0:findTF("BtnPanel/CancelBtn")
	arg_2_0.userAgreenTF = arg_2_0:findTF("UserAgreement")
	arg_2_0.userAgreenMainTF = arg_2_0:findTF("window", arg_2_0.userAgreenTF)
	arg_2_0.closeUserAgreenTF = arg_2_0:findTF("close_btn", arg_2_0.userAgreenMainTF)
	arg_2_0.userRefuseConfirmTF = arg_2_0:findTF("refuse_btn", arg_2_0.userAgreenMainTF)
	arg_2_0.userAgreenConfirmTF = arg_2_0:findTF("accept_btn", arg_2_0.userAgreenMainTF)

	setActive(arg_2_0.userAgreenTF, false)

	arg_2_0.rawImage.texture = arg_2_0.contextData.photoTex
	arg_2_0.bytes = arg_2_0.contextData.photoData
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.shareBtnTrans, function()
		local var_4_0 = PlayerPrefs.GetInt("snapshotAgress")

		if not var_4_0 or var_4_0 <= 0 then
			arg_3_0:showUserAgreement(function()
				PlayerPrefs.SetInt("snapshotAgress", 1)
				pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypePhoto)
			end)
		else
			pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypePhoto)
		end
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.confirmBtnTrans, function()
		YSNormalTool.MediaTool.SaveImageWithBytes(arg_3_0.bytes, function(arg_7_0, arg_7_1)
			if arg_7_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_save_ok"))
			end
		end)
		pg.TipsMgr.GetInstance():ShowTips(i18n("word_save_ok"))
		arg_3_0:closeView()
	end)
	onButton(arg_3_0, arg_3_0.cancelBtnTrans, function()
		arg_3_0:closeView()
	end)
end

function var_0_0.willExit(arg_9_0)
	return
end

function var_0_0.showUserAgreement(arg_10_0, arg_10_1)
	setButtonEnabled(arg_10_0.userAgreenConfirmTF, true)

	local var_10_0

	arg_10_0.userAgreenTitleTF = arg_10_0:findTF("UserAgreement/window/title")
	arg_10_0.userAgreenTitleTF:GetComponent("Text").text = i18n("word_snapshot_share_title")

	setActive(arg_10_0.userAgreenTF, true)
	setText(arg_10_0.userAgreenTF:Find("window/container/scrollrect/content/Text"), i18n("word_snapshot_share_agreement"))
	onButton(arg_10_0, arg_10_0.userRefuseConfirmTF, function()
		setActive(arg_10_0.userAgreenTF, false)
	end)
	onButton(arg_10_0, arg_10_0.userAgreenConfirmTF, function()
		setActive(arg_10_0.userAgreenTF, false)

		if arg_10_1 then
			arg_10_1()
		end
	end)
	onButton(arg_10_0, arg_10_0.closeUserAgreenTF, function()
		setActive(arg_10_0.userAgreenTF, false)
	end)
end

return var_0_0
