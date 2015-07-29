local GameObj = class("GameObj")
local ObjIdAcc = 0--游戏对象的id
function GameObj:ctor(  )
	ObjIdAcc = ObjIdAcc +1
	self.objid = ObjIdAcc
	self.zorder = 0 --层级
	self.objnode = nil--显示节点
end
--显示对象函数，要重载
function GameObj:showObj( tlayer )
	-- body
end
function GameObj:remove( ... )
	if self.objnode ~= nil then
		self.objnode:removeFromParent()
		self.objnode=nil
	end
end
return GameObj