local devChat_EventFrame = CreateFrame("Frame")
devChat_EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
devChat_EventFrame:SetScript("OnEvent",
function(self, event, ...)
	local updateRate = math.random(0.22,0.32)
	local timer = 0
	local function onUpdate(self,elapsed)
	    timer = timer + elapsed
	    if timer >= updateRate then			
		-- Call Roation
			DemonHunterVengeance()
	        timer = 0
	    end
	end
 
	local devChat = CreateFrame("frame")
	devChat:SetScript("OnUpdate", onUpdate)
end)

	