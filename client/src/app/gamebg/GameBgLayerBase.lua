--region *.lua
--Date
--此文件由[BabeLua]插件自动生成


local GameBgLayerBase = class("GameBgLayerBase")
function GameBgLayerBase:ctor()
    self.layer  = cc.Layer:create()

end
function GameBgLayerBase:getLayer( )
	return self.layer
end
function GameBgLayerBase:showToScene( tparent ,zOrder)
	tparent:addChild( self.layer, zOrder)
end
function GameBgLayerBase:addToLayer(child,zOrder,rags)
   self.layer:addChild(child,zOrder,rags)
--   rags = rags or 1
--   if rags~=1 then
--    child:setPosition(rags.width,rags.height)
--   end
end
return GameBgLayerBase
--endregion
