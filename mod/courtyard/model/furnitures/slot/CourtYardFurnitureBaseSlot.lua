local var_0_0 = class("CourtYardFurnitureBaseSlot")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

var_0_0.TYPE_COMMOM = 1
var_0_0.TYPE_MAIN_SPINE = 2
var_0_0.TYPE_SPINE_EXTRA = 3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.mask = nil
	arg_1_0.scale = Vector3.one
	arg_1_0.offset = Vector3.zero
	arg_1_0.skewValue = Vector3.zero
	arg_1_0.follower = nil
	arg_1_0.animatorIndex = 0
	arg_1_0.animators = {}
	arg_1_0.bodyMask = nil
	arg_1_0.name = nil

	if not arg_1_2 or arg_1_2 == "" then
		arg_1_0.state = var_0_3
	else
		arg_1_0.state = var_0_1

		arg_1_0:OnInit(arg_1_2)
	end
end

function var_0_0.IsEmpty(arg_2_0)
	return arg_2_0.state == var_0_1
end

function var_0_0.IsUsing(arg_3_0)
	return arg_3_0.state == var_0_2
end

function var_0_0.Occupy(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0.state == var_0_1 then
		arg_4_0.user = arg_4_2
		arg_4_0.owner = arg_4_1
		arg_4_0.observer = arg_4_3
		arg_4_0.state = var_0_2

		arg_4_2:WillInteraction(arg_4_0)
		arg_4_1:WillInteraction(arg_4_0)
		arg_4_0:OnAwake()
		arg_4_3:StartInteraction(arg_4_0)
		arg_4_2:StartInteraction(arg_4_0)
		arg_4_1:StartInteraction(arg_4_0)
		onNextTick(function()
			arg_4_0:OnStart()
		end)
	end
end

function var_0_0.GetUser(arg_6_0)
	return arg_6_0.user
end

function var_0_0.GetOwner(arg_7_0)
	return arg_7_0.owner
end

function var_0_0.Use(arg_8_0)
	arg_8_0.state = var_0_2
end

function var_0_0.Empty(arg_9_0)
	arg_9_0.state = var_0_1
end

function var_0_0.Clear(arg_10_0, arg_10_1)
	if arg_10_0.state == var_0_2 then
		arg_10_0.state = var_0_1

		arg_10_0.observer:WillClearInteraction(arg_10_0, arg_10_1)
		arg_10_0.user:ClearInteraction(arg_10_0, arg_10_1)
		arg_10_0.owner:ClearInteraction(arg_10_0, arg_10_1)
		arg_10_0.observer:ClearInteraction(arg_10_0, arg_10_1)

		arg_10_0.user = nil
		arg_10_0.owner = nil
		arg_10_0.observer = nil
	end
end

function var_0_0.Continue(arg_11_0, arg_11_1)
	arg_11_0:OnContinue(arg_11_1)
end

function var_0_0.Stop(arg_12_0)
	arg_12_0:Clear(true)
	arg_12_0:OnStop()
end

function var_0_0.Reset(arg_13_0)
	return
end

function var_0_0.End(arg_14_0)
	arg_14_0:Clear(false)
	arg_14_0:OnEnd()
end

function var_0_0.GetMask(arg_15_0)
	return arg_15_0.mask
end

function var_0_0.GetScale(arg_16_0)
	return arg_16_0.scale
end

function var_0_0.GetOffset(arg_17_0)
	return arg_17_0.offset
end

function var_0_0.GetFollower(arg_18_0)
	return arg_18_0.follower
end

function var_0_0.GetBodyMask(arg_19_0)
	return arg_19_0.bodyMask
end

function var_0_0.GetAnimators(arg_20_0)
	return arg_20_0.animators
end

function var_0_0.GetUsingAnimator(arg_21_0)
	return arg_21_0.animators[arg_21_0.animatorIndex]
end

function var_0_0.GetName(arg_22_0)
	return arg_22_0.name
end

function var_0_0.GetSkew(arg_23_0)
	return arg_23_0.skewValue
end

function var_0_0.OnInit(arg_24_0, arg_24_1)
	return
end

function var_0_0.OnAwake(arg_25_0)
	return
end

function var_0_0.OnStart(arg_26_0)
	return
end

function var_0_0.OnStop(arg_27_0)
	return
end

function var_0_0.OnEnd(arg_28_0)
	return
end

function var_0_0.OnContinue(arg_29_0, arg_29_1)
	return
end

return var_0_0
