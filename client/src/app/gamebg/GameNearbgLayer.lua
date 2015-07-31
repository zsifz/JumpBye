--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local GameBgLayerBase = import(".GameBgLayerBase")
local GameNearbgLayer = class("GameNearbgLayer",GameBgLayerBase)
function GameNearbgLayer:ctor( )
	GameNearbgLayer.super:ctor(self)
	self:init()
end
function GameNearbgLayer:init(  )
	-- body
	local nearbg=CreateSprite("aaaa_5")
	nearbg:setAnchorPoint(0,0)
	nearbg:setPosition(0,0)
	self.layer:addChild(nearbg,1)
end
return GameNearbgLayer

--endregion
