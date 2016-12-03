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