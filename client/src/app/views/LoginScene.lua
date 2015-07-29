-- region LoginScene.lua
-- Author : ky011
-- Date   : 2015/7/15
-- 此文件由[BabeLua]插件自动生成
local LoginScene = class("LoginScene", cc.load("mvc").ViewBase)
function LoginScene:onCreate()
    self:loginGame();
end
function LoginScene:loginGame()
    -- local node = (conf[1])
    self.LoginLayer = sg_load_csb("res#csb#ui#MainLayer");

    self.LoginLayer:addTo(self);
    -- strfont_m.png
    --    local sp = display.newSprite("strfont_m");
    --    sp:addTo(self,5):moveTo(display.cx,display.cy);
    local function enterGame(sender,eventType)
         if eventType == TOUCH_EVENT_BEGAN then
             self:getApp():enterScene("GameScene")
         end 
    end
    local Node_servername = sg_get_child_by_name(self.LoginLayer, "Button_shoudongwanwan");
    Node_servername:addTouchEventListener( enterGame ); --view:enterScene("GameScene") end)

end
return LoginScene;


-- endregion
