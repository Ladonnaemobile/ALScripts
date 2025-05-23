local var_0_0 = class("MemoryCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_1.transform
	arg_1_0.lock = findTF(arg_1_0.tf, "lock")
	arg_1_0.txCondition = findTF(arg_1_0.lock, "condition")
	arg_1_0.normal = findTF(arg_1_0.tf, "normal")
	arg_1_0.txTitle = findTF(arg_1_0.normal, "title")
	arg_1_0.txSubtitle = findTF(arg_1_0.normal, "subtitle")
	arg_1_0.group = findTF(arg_1_0.tf, "group")
	arg_1_0.groupTitle = findTF(arg_1_0.group, "title")
	arg_1_0.groupCount = findTF(arg_1_0.group, "count")
	arg_1_0.itemIndexTF = findTF(arg_1_0.tf, "id")
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.isGroup = arg_2_1
	arg_2_0.info = arg_2_2

	arg_2_0:flush()
end

function var_0_0.flush(arg_3_0)
	setActive(arg_3_0.lock, false)
	setActive(arg_3_0.normal, false)
	setActive(arg_3_0.group, false)

	if arg_3_0.isGroup then
		setActive(arg_3_0.group, true)
		setText(arg_3_0.groupTitle, arg_3_0.info.title)
		GetImageSpriteFromAtlasAsync("memoryicon/" .. arg_3_0.info.icon, "", arg_3_0.group)

		local var_3_0 = 0
		local var_3_1 = #arg_3_0.info.memories

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.info.memories) do
			local var_3_2 = pg.memory_template[iter_3_1]

			if var_3_2.is_open == 1 or pg.NewStoryMgr.GetInstance():IsPlayed(var_3_2.story, true) then
				var_3_0 = var_3_0 + 1
			end
		end

		setText(arg_3_0.groupCount, var_3_0 .. "/" .. var_3_1)
	elseif arg_3_0.info.is_open == 1 or pg.NewStoryMgr.GetInstance():IsPlayed(arg_3_0.info.story, true) then
		setActive(arg_3_0.normal, true)
		setText(arg_3_0.txTitle, arg_3_0.info.title)
		setText(arg_3_0.txSubtitle, arg_3_0.info.subtitle)
		GetImageSpriteFromAtlasAsync("memoryicon/" .. arg_3_0.info.icon, "", arg_3_0.normal)
	else
		setActive(arg_3_0.lock, true)
		setText(arg_3_0.txCondition, arg_3_0.info.condition)
	end

	if arg_3_0.itemIndexTF then
		setActive(arg_3_0.itemIndexTF, not arg_3_0.isGroup)

		if not arg_3_0.isGroup and arg_3_0.info.index then
			setText(arg_3_0.itemIndexTF, string.format("%02u", arg_3_0.info.index))
		end
	end
end

function var_0_0.clear(arg_4_0)
	return
end

return var_0_0
