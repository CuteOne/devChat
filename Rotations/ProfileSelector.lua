function DemonHunterVengeance()
	runRotation()
	function selectProfile(index)
		for i = 1, #rotations do
			if i == index then
				selectedRotation = rotations[i].name
				break
			end
		end
		return
	end
	-- if selectedRotation == nil then selectedRotation = rotations[1].rotationName end
	-- print(rotations[1].name)
end