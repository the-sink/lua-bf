local  bf = {}
local memory = {}
local pointer = 1
local loopIndices = {}

local memoryMax = 29999

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
	local i = 1
	while true do
		if i > length then break end
		local char = string.sub(code, i, i)

		if char == ">" then pointer += 1 if pointer > memoryMax then pointer = 0 end
		elseif char == "<" then pointer -= 1 if pointer < 1 then pointer = 1 end
		elseif char == "+" then memory[pointer] += 1
		elseif char == "-" then memory[pointer] -= 1
		elseif char == "." then output ..= string.char(memory[pointer])
		elseif char == "," then -- TODO
		elseif char == "[" then table.insert(loopIndices, i)
		elseif char == "]" then if memory[pointer] ~= 0 then i = loopIndices[#loopIndices] continue else table.remove(loopIndices, #loopIndices) end
		end

		i += 1
	end
	
	return output
end

bf.clearMemory()

return bf