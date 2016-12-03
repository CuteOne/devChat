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