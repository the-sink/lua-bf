local bf = require("brainfuck")
local file = io.open("code.bf", "rb")
local data = file:read("*all")
file:close()

print(bf.evaluate(data))