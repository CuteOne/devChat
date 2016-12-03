function getLatency()
	local lag = ((select(3,GetNetStats()) + select(4,GetNetStats())) / 1000)
	if lag < .05 then
		lag = .05
	elseif lag > .4 then
		lag = .4
	end
	return lag
end