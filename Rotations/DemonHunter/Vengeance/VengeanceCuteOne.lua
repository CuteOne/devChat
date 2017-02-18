-- Rotation
function DemonHunterVengeance()
	-- Before we attempt to attack make sure we have a unit and it's valid.
	-- If not in combat do nothing unless player selects unit
	-- If in combat make sure we have valid unit: (enemy, on threat table if in party otherwise selected)
	if Unit.valid then


	-- Fiery Brand
		-- actions+=/fiery_brand,if=buff.demon_spikes.down&buff.metamorphosis.down
		if not player.buff.exists(fieryBrand) and not player.buff.exists(metamorphosis) then
			cast(fieryBrand
		end
		-- if not UnitAuras("player","Fiery Brand") and not UnitAuras("player","Metamorphosis") then
		-- 	cast("Fiery Brand","target")
		-- end
	-- Demon Spikes
		-- actions+=/demon_spikes,if=charges=2|buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down
		if charges.demonSpikes == 2 or not buff.demonSpikes and not debuff.fieryBrand(bestUnit) and buff.metamorphosis then
			cast.demonSpikes()
		end
		-- if select(1,GetSpellCharges("Demon Spikes")) == 2 then
		-- 	cast("Demon Spikes","player")
		-- end
	-- Infernal Strike
		-- actions+=/infernal_strike,if=!sigil_placed&!in_flight&remains-travel_time-delay<0.3*duration&(!artifact.fiery_demise.enabled|(max_charges-charges_fractional)*recharge_time<cooldown.fiery_brand.remains+5)&(cooldown.sigil_of_flame.remains>7|charges=2)
		if not placed.sigilOfFlame and not inFlight.infernalStrike and  
		if canCast("Shear") then
			if select(1,GetSpellCharges("Infernal Strike")) == 2 then
				cast("Infernal Strike","player","player")
			end
		end
	-- Spirit Bomb
		-- actions+=/spirit_bomb,if=debuff.frailty.down
		if not UnitAuras("target","Frailty","player") then
			cast("Spirit Bomb","target")
		end
	-- Soul Carver
		-- actions+=/soul_carver,if=dot.fiery_brand.ticking
		if UnitAuras("target","Fiery Brand","player") ~= nil then
			cast("Soul Carver","target")
		end
	-- Immolation
		-- actions+=/immolation_aura,if=pain<=80
		if pain <= 80 then
			cast("Immolation Aura","player")
		end
	-- Felblade
		-- actions+=/felblade,if=pain<=70
		if pain <= 70 then
			cast("Felblade","target")
		end
	-- Soul Barrier
		-- actions+=/soul_barrier
		cast("Soul Barrier","player")
	-- Soul Cleave
		-- actions+=/soul_cleave,if=soul_fragments=5
		if getAuraStacks("player","Soul Fragments") == 5 then
			cast("Soul Cleave","target")
		end
	-- Metamorphosis
		-- actions+=/metamorphosis,if=buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down&incoming_damage_5s>health.max*0.70
		if not UnitAuras("player","Demon Spikes") and not UnitAuras("target","Fiery Brand","player") and not UnitAuras("player","Metamorphosis") and php < 30 then
			cast("Metamorphosis","player")
		end
	-- Fel Devastation
		-- actions+=/fel_devastation,if=incoming_damage_5s>health.max*0.70
		if php < 30 then
			cast("Fel Devastation","player")
		end
	-- Soul Cleave
		-- actions+=/soul_cleave,if=incoming_damage_5s>=health.max*0.70
		if php < 30 then
			cast("Soul Cleave","target")
		end
	-- Fel Eruption
		-- actions+=/fel_eruption
		cast("Fel Eruption","player")
	-- Sigil of Flame
		-- actions+=/sigil_of_flame,if=remains-delay<=0.3*duration
		if getAuraRefresh("target","Sigil of Flame","player") then
			cast("Sigil of Flame","target","target")
		end
	-- Fracture
		-- actions+=/fracture,if=pain>=80&soul_fragments<4&incoming_damage_4s<=health.max*0.20
		if pain >= 80 and getAuraStacks("player","Soul Fragments") < 4 and php > 80 then
			cast("Fracture","target")
		end
	-- Soul Cleave
		-- actions+=/soul_cleave,if=pain>=80
		if pain >= 80 then
			cast("Soul Cleave","target")
		end
	-- Shear
		-- actions+=/shear
		cast("Shear","target");
	end
end