function runRotation()
	if GetSpecializationInfo(GetSpecialization()) == 581 then
		local rotationName = "Sample"
		tableFound = false
		for i = 1, #rotations do
			if rotations[i].name == rotationName then
				tableFound = true
				break
			end
		end
		if not tableFound then
			rotationIndex = #rotations+1
			rotations[rotationIndex] = {name = rotationName}
			-- table.insert(rotations,{name = rotationName})
		end
		if selectedRotation == rotationName then
			print("Selected the Sample!")
		end
	end
end