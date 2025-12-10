--+
--| Static

local Class = {}
Class.__index = Class

function Class.new(super: Class?): Class
	local NewClass: Class = {}
	NewClass.__index = NewClass

	if super then
		setmetatable(NewClass, super)
	else
		setmetatable(NewClass, Class)
	end

	function NewClass.new(...)
		local self = {}
		setmetatable(self, NewClass)

		local init = self.init
		if init then
			init(self, ...)
		end

		return self
	end

	return NewClass
end

function Class:instanceof(TargetClass: Class): boolean
	local metatable = getmetatable(self)
	while metatable do
		if metatable == TargetClass then
			return true
		end
		metatable = getmetatable(metatable)
	end
	
	return false
end

--+
--| Export

export type Class = typeof(Class.new())

return {
	Class = Class
}