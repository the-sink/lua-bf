local bf = {}
local memory = {}
local pointer = 1
local loopIndices = {}

local memoryMax = 29999

local outputObject = { -- TODO
	output = "";
	bytes = {};
}

bf.clearMemory = function()
  for i = 0, memoryMax do
    memory[i] = 0
  end
end

bf.getMemory = function()
  return memory
end

bf.evaluate = function(code)
	local output = ""

	local length = string.len(code)
	local i = 0
	while true do
		i = i + 1
		if i > length then break end
		
		local char = string.sub(code, i, i)

		if char == ">" then pointer = pointer + 1 if pointer > memoryMax then pointer = 0 end
		elseif char == "<" then pointer = pointer - 1 if pointer < 1 then pointer = 1 end
		elseif char == "+" then memory[pointer] = memory[pointer] + 1
		elseif char == "-" then memory[pointer] = memory[pointer] - 1
		elseif char == "." then output = output .. string.char(memory[pointer])
		elseif char == "," then print("waiting on input") memory[pointer] = io.read(1)
		elseif char == "[" then table.insert(loopIndices, i)
		elseif char == "]" then if memory[pointer] ~= 0 then i = loopIndices[#loopIndices]-1 else table.remove(loopIndices, #loopIndices) end
		end
	end
	
	return output
end

bf.clearMemory()

return bf
