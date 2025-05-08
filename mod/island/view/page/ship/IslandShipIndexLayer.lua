local var_0_0 = class("IslandShipIndexLayer", import("view.common.CustomIndexLayer"))

function var_0_0.SortFunc(arg_1_0)
	return {
		function(arg_2_0)
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipByConfigId(arg_2_0)

			if var_2_0 then
				return var_2_0["Get" .. arg_1_0](var_2_0)
			else
				return 0
			end
		end,
		function(arg_3_0)
			return arg_3_0
		end
	}
end

var_0_0.sort = {
	{
		sortFuncs = var_0_0.SortFunc("Rarity"),
		name = ShipIndexConst.SortNames[1]
	},
	{
		sortFuncs = var_0_0.SortFunc("Level"),
		name = ShipIndexConst.SortNames[2]
	},
	{
		sortFuncs = var_0_0.SortFunc("Power"),
		name = ShipIndexConst.SortNames[3]
	},
	{
		sortFuncs = var_0_0.SortFunc("CreateTime"),
		name = ShipIndexConst.SortNames[4]
	},
	{
		sortFuncs = var_0_0.SortFunc("Energy"),
		name = ShipIndexConst.SortNames[6]
	}
}

function var_0_0.getSortFuncAndName(arg_4_0, arg_4_1)
	for iter_4_0 = 1, #var_0_0.sort do
		local var_4_0 = bit.lshift(1, iter_4_0 - 1)

		if bit.band(var_4_0, arg_4_0) > 0 then
			return underscore.map(var_0_0.sort[iter_4_0].sortFuncs, function(arg_5_0)
				return function(arg_6_0)
					return (arg_4_1 and -1 or 1) * arg_5_0(arg_6_0)
				end
			end), var_0_0.sort[iter_4_0].name
		end
	end
end

var_0_0.SortRarity = bit.lshift(1, 0)
var_0_0.SortLevel = bit.lshift(1, 1)
var_0_0.SortPower = bit.lshift(1, 2)
var_0_0.SortAchivedTime = bit.lshift(1, 3)
var_0_0.SortEnergy = bit.lshift(1, 4)
var_0_0.SortIndexs = {
	var_0_0.SortRarity,
	var_0_0.SortLevel,
	var_0_0.SortPower,
	var_0_0.SortAchivedTime,
	var_0_0.SortEnergy
}
var_0_0.SortNames = {
	"word_rarity",
	"word_lv",
	"word_synthesize_power",
	"word_achieved_item",
	"sort_energy"
}
var_0_0.ExtraPotency = bit.lshift(1, 0)
var_0_0.ExtraCanUpgSkill = bit.lshift(1, 1)
var_0_0.ExtraSpeStatus = bit.lshift(1, 2)
var_0_0.ExtraIndexs = {
	var_0_0.ExtraPotency,
	var_0_0.ExtraCanUpgSkill,
	var_0_0.ExtraSpeStatus
}
var_0_0.ExtraALL = IndexConst.BitAll(var_0_0.ExtraIndexs)

table.insert(var_0_0.ExtraIndexs, 1, var_0_0.ExtraALL)

var_0_0.ExtraNames = {
	"island_index_extra_all",
	"island_index_potency",
	"island_index_skill",
	"island_index_status"
}

local var_0_1 = {
	function()
		return true
	end,
	function(arg_8_0)
		if not arg_8_0 then
			return false
		end

		return arg_8_0:ExistPotency()
	end,
	function(arg_9_0)
		if not arg_9_0 then
			return false
		end

		return arg_9_0:AnySkillCanUpgrade()
	end,
	function(arg_10_0)
		if not arg_10_0 then
			return false
		end

		return arg_10_0:HasStatus()
	end
}

function var_0_0.filterByExtra(arg_11_0, arg_11_1)
	if not arg_11_1 or arg_11_1 == var_0_0.ExtraALL then
		return true
	end

	for iter_11_0 = 2, #var_0_1 do
		local var_11_0 = bit.lshift(1, iter_11_0 - 2)

		if bit.band(var_11_0, arg_11_1) > 0 and var_0_1[iter_11_0](arg_11_0) then
			return true
		end
	end

	return false
end

function var_0_0.getUIName(arg_12_0)
	return "IslandCustomIndexUI"
end

function var_0_0.init(arg_13_0)
	var_0_0.super.init(arg_13_0)

	arg_13_0.titleTxt = arg_13_0._tf:Find("index_panel/layout/tip"):GetComponent(typeof(Text))
	arg_13_0.closeBtn = arg_13_0._tf:Find("index_panel/layout/clsoe")
	arg_13_0.tplContainer = arg_13_0._tf:Find("index_panel/layout/container")

	local var_13_0 = arg_13_0.contextData

	arg_13_0.OnFilter = var_13_0.OnFilter
	arg_13_0.indexDatas = var_13_0.defaultIndex or {}
end

function var_0_0.BlurPanel(arg_14_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_14_0._tf, false, {
		weight = LayerWeightConst.SECOND_LAYER + 1
	})
end

function var_0_0.didEnter(arg_15_0)
	arg_15_0.contextData = arg_15_0:InitData()

	var_0_0.super.didEnter(arg_15_0)

	arg_15_0.titleTxt.text = i18n("child_filter_title")

	onButton(arg_15_0, arg_15_0.closeBtn, function()
		arg_15_0:emit(var_0_0.ON_CLOSE)
	end, SFX_PANEL)
end

function var_0_0.InitGroup(arg_17_0)
	var_0_0.super.InitGroup(arg_17_0)

	local function var_17_0(arg_18_0)
		setActive(arg_18_0:Find("line"), false)
	end

	for iter_17_0 = 1, arg_17_0.tplContainer.childCount do
		local var_17_1 = arg_17_0.tplContainer:GetChild(iter_17_0 - 1):Find("bg")

		if var_17_1.childCount > 7 then
			var_17_0(var_17_1:GetChild(6))
		end

		if var_17_1.childCount > 0 then
			var_17_0(var_17_1:GetChild(var_17_1.childCount - 1))
		end
	end
end

function var_0_0.InitData(arg_19_0)
	return {
		indexDatas = Clone(arg_19_0.indexDatas),
		customPanels = {
			sortIndex = {
				isSort = true,
				mode = CustomIndexLayer.Mode.OR,
				options = var_0_0.SortIndexs,
				names = var_0_0.SortNames
			},
			campIndex = {
				blueSeleted = true,
				mode = CustomIndexLayer.Mode.AND,
				options = ShipIndexConst.CampIndexs,
				names = ShipIndexConst.CampNames
			},
			rarityIndex = {
				blueSeleted = true,
				mode = CustomIndexLayer.Mode.AND,
				options = ShipIndexConst.RarityIndexs,
				names = ShipIndexConst.RarityNames
			},
			extraIndex = {
				blueSeleted = true,
				mode = CustomIndexLayer.Mode.AND,
				options = var_0_0.ExtraIndexs,
				names = var_0_0.ExtraNames
			}
		},
		groupList = {
			{
				dropdown = false,
				titleTxt = "indexsort_sort",
				titleENTxt = "indexsort_sorteng",
				tags = {
					"sortIndex"
				}
			},
			{
				dropdown = false,
				titleTxt = "indexsort_camp",
				titleENTxt = "indexsort_campeng",
				tags = {
					"campIndex"
				}
			},
			{
				dropdown = false,
				titleTxt = "indexsort_rarity",
				titleENTxt = "indexsort_rarityeng",
				tags = {
					"rarityIndex"
				}
			},
			{
				dropdown = false,
				titleTxt = "indexsort_extraindex",
				titleENTxt = "indexsort_indexeng",
				tags = {
					"extraIndex"
				}
			}
		},
		callback = function(arg_20_0)
			arg_19_0.OnFilter(arg_20_0)
		end
	}
end

function var_0_0.UpdateBtnStyle(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_2 ~= arg_21_0.greySprite

	arg_21_1:GetComponent(typeof(Image)).color = var_21_0 and Color.New(0, 0, 0, 1) or Color.New(1, 1, 1, 1)
	arg_21_1:Find("Image"):GetComponent(typeof(Text)).color = var_21_0 and Color.New(1, 1, 1, 1) or Color.New(0.2235294, 0.227451, 0.2352941, 1)

	setActive(arg_21_1:Find("selected"), var_21_0)
end

return var_0_0
