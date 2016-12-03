function UnitAuras(unit,spellId,source,returnVar)
	if source == nil and UnitAura(unit,spellId) ~= nil then  
		return UnitAura(unit,spellId)
	elseif source == "player" and UnitAura(unit,spellId,"PLAYER HARMFUL") ~= nil then
		return UnitAura(unit,spellId,"PLAYER HARMFUL")
	elseif UnitAura(unit,spellId,"HARMFUL") ~= nil then
		return UnitAura(unit,spellId,"HARMFUL")
	end
	return false 
end
function getAuraDuration(unit,spellId,source)
	if UnitAuras(unit,spellId,source) then
		return select(6,UnitAuras(unit,spellId,source))	* 1
	end
	return 0
end
function getAuraRemain(unit,spellId,source)
	if UnitAuras(unit,spellId,source) then
		local endTime = select(7,UnitAuras(unit,spellId,source))	
		if endTime ~= 0 then
			return endTime - GetTime()
		else
			return 999
		end
	end
	return 0
end
function getAuraRefresh(unit,spellId,source,threshhold)
	local duration = getAuraDuration(unit,spellId,source)
	local remain = getAuraRemain(unit,spellId,source)
	if threshhold == nil then threshhold = 0.3 end
	return remain <= duration * threshhold
end
function getAuraStacks(unit,spellId,source)
	if UnitAuras(unit,spellId,source) then
		return select(4,UnitAuras(unit,spellId,source))
	end
	return 0
end