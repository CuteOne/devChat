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
		return true
	end
	return false	
end