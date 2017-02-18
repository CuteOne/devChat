function isArtifactLearned(artifactId,rank)
	if HasArtifactEquipped() then
        local forceHide;
 
        -- opens (equipped) artifact layout
        if not ArtifactFrame:IsShown() then
            forceHide = true
            SocketInventoryItem(16)
        end
        
        for i, powerID in ipairs(C_ArtifactUI.GetPowers()) do
            local spellID, cost, currentRank, maxRank, bonusRanks, x, y, prereqsMet, isStart, isGoldMedal, isFinal = C_ArtifactUI.GetPowerInfo(powerID)
 			if artifactId == spellID then
 				if rank == nil or rank >= currentRank then return true end
 			end
        end 
        
        if ArtifactFrame:IsShown() and forceHide then
            HideUIPanel(ArtifactFrame)
        end
    end
    return false
end