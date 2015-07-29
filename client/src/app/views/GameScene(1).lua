--region LoginScene.lua
--Author : ky011
--Date   : 2015/7/15
--此文件由[BabeLua]插件自动生成
local GameObjManager = require "app.gameobj.GameObjManager"
local GameLayer = require "app.gamelayer.GameLayer"
local GameMapController = require "app.gamebg.GameMapController"
local GameScene = class("GameScene", cc.load("mvc").ViewBase)

function GameScene:onCreate()
   self.gamelayer =nil
   self:loginGame()
   self:scheduleUpdate(handler(self, self.update))
end
function GameScene:loginGame()
    self.gamelayer = GameLayer:create()
    self:addChild(self.gamelayer)
    self.gameobjmanager = GameObjManager:create(self,self.gamelayer)

    self.maplayer=GameMapController:create(self.gamelayer,self)
end
function GameScene:get_gameobjmanager( ... )
	return self.gameobjmanager
end
function GameScene:update(dt)
    self.maplayer:update(dt)

end
return GameScene;


--endregion
