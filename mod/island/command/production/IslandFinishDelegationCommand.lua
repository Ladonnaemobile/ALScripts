local var_0_0 = class("IslandFinishDelegationCommand", pm.SimpleCommand)

var_0_0.END_DELEGATION = "IslandFinishDelegationCommand:END_DELEGATION"

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.build_id
	local var_1_2 = var_1_0.area_id
	local var_1_3 = getProxy(IslandProxy):GetIsland()
	local var_1_4 = var_1_3:GetBuildingAgency()
	local var_1_5 = var_1_3:GetCharacterAgency()

	pg.ConnectionMgr.GetInstance():Send(21503, {
		build_id = var_1_1,
		area_id = var_1_2
	}, 21504, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_4:GetBuilding(var_1_1)

			if var_1_1 == IslandTechnologyAgency.PLACE_ID then
				local var_2_1 = var_2_0:GetDelegationSlotData(var_1_2):GetFormulaId()

				var_1_3:GetTechnologyAgency():AddFinishCntByFormulatId(var_2_1)
			end

			var_2_0:UpdateDeleationRoleDataBySlotId(var_1_2, nil)

			if #arg_2_0.award > 0 then
				local var_2_2 = arg_2_0.award[1]

				var_2_0:UpdateDeleationRewardDataBySlotId(var_1_2, var_2_2)
			end

			local var_2_3 = var_1_5:GetShipById(arg_2_0.ship_id)

			var_2_3:UpdateEnergy(arg_2_0.cur_energy)
			var_2_3:UpdateEnergyBeginRecoverTime(arg_2_0.recover_time)
			var_2_3:AddExp(arg_2_0.add_exp)
			var_1_3:DispatchEvent(var_0_0.END_DELEGATION, {
				build_id = var_1_1,
				ship_id = arg_2_0.ship_id,
				area_id = var_1_2
			})
			arg_1_0:sendNotification(GAME.ISLAND_FINISH_DELEGATION_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end
	end)
end

return var_0_0
