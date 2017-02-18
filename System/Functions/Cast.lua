function canCast(Spell)
	if IsUsableSpell(Spell) and getSpellCD(Spell) < getLatency() and isKnown(Spell) and (IsHelpfulSpell(Spell) or IsItemInRange(37727,"target") or IsSpellInRange(Spell,"target") == 1) then
		return true
	end
	return false
end
function cast(Spell,Unit,AoEUnit)
	if canCast(Spell) then
		CastSpellByName(Spell,Unit)
		if IsAoEPending() then
			local X,Y,Z = ObjectPosition(AoEUnit)
			ClickPosition(X,Y,Z)
		end
		-- Need a way to check if spell cast succeeded or failed for other reasons, 
		-- profile currently goes to cast but does not seem to fully initialize before moving on, 
		-- however may want to allow this behavior on channeled spells
		return true
	end	
end