--local GameLayer = class("GameLayer")
local GameLayer = class("GameLayer", cc.load("mvc").ViewBase)
function GameLayer:ctor()
	self.layer = cc.Layer:create()
	self:addChild(self.layer)
end
function GameLayer:get_layer()
	return self.layer
end
return GameLayer