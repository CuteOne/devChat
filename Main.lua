local devChat_EventFrame = CreateFrame("Frame")
devChat_EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
devChat_EventFrame:SetScript("OnEvent",
function(self, event, ...)
	-- Globals Section
	devChat_UpdateInterval = 1--math.random(0.22,0.32)

	-- Engine
	local devChat = CreateFrame("Frame")
	devChat:SetScript("OnUpdate", function(self, elapsed)
		if self.TimeSinceLastUpdate == nil then self.TimeSinceLastUpdate = 0 end
		self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed; 	

	  	while (self.TimeSinceLastUpdate > devChat_UpdateInterval) do
	  	-- Functions
	  		function UnitAuras(unit,spellName)
				if UnitAura(unit,spellName) ~= nil then 
					return UnitAura(unit,spellName)
				elseif UnitAura(unit,spellName,nil,"PLAYER HARMFUL") ~= nil then
					return UnitAura(unit,spellName,nil,"PLAYER HARMFUL")
				else 
					return nil
				end 
			end
	  		function getAuraDuration(Unit,Aura,Source)
				if UnitAuras(Unit,Aura,Source) ~= nil then
					return select(6,UnitAuras(Unit,Aura,Source))*1
				end
				return 0
			end
			function getAuraRemain(Unit,Aura,Source)
				if UnitAuras(Unit,Aura,Source) ~= nil then
					return (select(7,UnitAuras(Unit,Aura,Source)) - GetTime())
				end
				return 0
			end
			function getAuraStacks(Unit,Aura,Source)
				if UnitAuras(Unit,Aura,Source) ~= nil then
					return select(4,UnitAuras(Unit,Aura,Source))
				end
				return 0
			end
	  		function getSpellCD(Spell)
				if GetSpellCooldown(Spell) == 0 then
					return 0
				else
					local Start ,CD = GetSpellCooldown(Spell)
					local MyCD = Start + CD - GetTime()
					return MyCD
				end
			end
			function isKnown(Spell)
				local spellName = GetSpellInfo(spellID)
				if GetSpellBookItemInfo(Spell) ~= nil then
					return true
				end
				if IsPlayerSpell(select(7,GetSpellInfo(Spell))) == true then
					return true
				end
				return false
			end
			function canCast(Spell)
				if IsUsableSpell(Spell) and getSpellCD(Spell) and isKnown(Spell) and (IsHelpfulSpell(Spell) or IsSpellInRange(Spell,"target") == nil or IsSpellInRange(Spell,"target") == 1) then
					return true
				end
				return false
			end
		-- Rotation
	  		if ObjectExists("target") and not UnitIsFriend("target","player") and not UnitIsDeadOrGhost("target") then
	  			local cast 			= CastSpellByName
	  			local php 			= (UnitHealth("player")/UnitHealthMax("player"))*100
	  			local pain 			= UnitPower("player",18)

		  	-- Start Attack
		  		-- actions=auto_attack
		  		-- if canCast("Shear") then
		  		-- 	StartAttack()
		  		-- end
		  	-- Fiery Brand
		  		-- actions+=/fiery_brand,if=buff.demon_spikes.down&buff.metamorphosis.down
		  		if canCast("Fiery Brand") then
		  			if not UnitAura("player","Fiery Brand") and not UnitAura("player","Metamorphosis") then
		  				cast("Fiery Brand","target")
					end
				end
			-- Demon Spikes
				-- actions+=/demon_spikes,if=charges=2|buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down
				if canCast("Demon Spikes") then
					if select(1,GetSpellCharges("Demon Spikes")) == 2 then
						cast("Demon Spikes","player")
					end
				end
			-- Infernal Strike
				-- actions+=/infernal_strike,if=!sigil_placed&!in_flight&remains-travel_time-delay<0.3*duration&(!artifact.fiery_demise.enabled|(max_charges-charges_fractional)*recharge_time<cooldown.fiery_brand.remains+5)&(cooldown.sigil_of_flame.remains>7|charges=2)
				if canCast("Infernal Strike") then
					if select(1,GetSpellCharges("Infernal Strike")) == 2 then
						cast("Infernal Strike","player")
						if IsAoEPending() then
							local X,Y,Z = GetObjectPosition("player")
							ClickPosition(X,Y,Z)
						end
					end
				end
			-- Spirit Bomb
				-- actions+=/spirit_bomb,if=debuff.frailty.down
				if canCast("Spirit Bomb") then
					if not UnitAuras("target","Frailty","player") then
						cast("Spirit Bomb","target")
					end
				end
			-- Soul Carver
				-- actions+=/soul_carver,if=dot.fiery_brand.ticking
				if canCast("Soul Carver") then
					if UnitAuras("target","Fiery Brand","player") ~= nil then
						cast("Soul Carver","target")
					end
				end
			-- Immolation
				-- actions+=/immolation_aura,if=pain<=80
				if canCast("Immolation") then
					if pain <= 80 then
						cast("Immolation","player")
					end
				end
			-- Fel Blade
				-- actions+=/felblade,if=pain<=70
				if canCast("Felblade") then
					if pain <= 70 then
						cast("Felblade","target")
					end
				end
			-- Soul Barrier
				-- actions+=/soul_barrier
				if canCast("Soul Barrier") then
					cast("Soul Barrier","player")
				end
			-- Soul Cleave
				-- actions+=/soul_cleave,if=soul_fragments=5
				if canCast("Soul Cleave") then
					if getAuraStacks("player","Soul Fragments") == 5 then
						cast("Soul Cleave","player")
					end
				end
			-- Metamorphosis
				-- actions+=/metamorphosis,if=buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down&incoming_damage_5s>health.max*0.70
				if canCast("Metamorphosis") then
					if not UnitAuras("player","Demon Spikes") and not UnitAuras("target","Fiery Brand","player") and not UnitAuras("player","Metamorphosis") and php < 30 then
						cast("Metamorphosis","player")
					end
				end
			-- Fel Devastation
				-- actions+=/fel_devastation,if=incoming_damage_5s>health.max*0.70
				if canCast("Fel Devastation") then
					if php < 30 then
						cast("Fel Devastation","player")
					end
				end
			-- Soul Cleave
				-- actions+=/soul_cleave,if=incoming_damage_5s>=health.max*0.70
				if canCast("Soul Cleave") then
					if php < 30 then
						cast("Soul Cleave","target")
					end
				end
			-- Fel Eruption
				-- actions+=/fel_eruption
				if canCast("Fel Eruption") then
					cast("Fel Eruption","player")
				end
			-- Sigil of Flame
				-- actions+=/sigil_of_flame,if=remains-delay<=0.3*duration
				if canCast("Sigil of Flame") then
					if getAuraRemain("target","Sigil of Flame","player") - 1 <= 0.3 * getAuraDuration("target","Sigil of Flame","player") then
						cast("Sigil of Flame","player")
						if IsAoEPending() then
							local X,Y,Z = GetObjectPosition("target")
							ClickPosition(X,Y,Z)
						end
					end
				end
			-- Fracture
				-- actions+=/fracture,if=pain>=80&soul_fragments<4&incoming_damage_4s<=health.max*0.20
				if canCast("Fracture") then
					if pain >= 80 and getAuraStacks("player","Soul Fragments") < 4 and php > 80 then
						cast("Fracture","target")
					end
				end
			-- Soul Cleave
				-- actions+=/soul_cleave,if=pain>=80
				if canCast("Soul Cleave") then
					if pain >= 80 then
						cast("Soul Cleave","target")
					end
				end
			-- Shear
				-- actions+=/shear
				if canCast("Shear") then
					cast("Shear","target")
				end
			end
			self.TimeSinceLastUpdate = self.TimeSinceLastUpdate - devChat_UpdateInterval;
	  	end
	end)	
end)
-- devChat:OnUpdate()
	