local GameObj = import(".GameObj")
local Floor = class("Floor",GameObj)
function Floor:ctor( )
	Floor.super.ctor(self)
end
function Floor:showObj( tlayer )
	-- body
end
return Floor