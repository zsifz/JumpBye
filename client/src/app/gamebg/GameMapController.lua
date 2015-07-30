--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local GameBgLayerBase = import(".GameBgLayerBase")
local GameMap = import(".GameMap")
local GameMapController = class("GameMapController",GameBgLayerBase)
local Move_sd = GAMESPEED
local map={}
map.width =MAPWIDTH
map.height =MAPHEIGHT
function GameMapController:ctor(gamelayer,gamescene)
    GameMapController.super.ctor(self)
    self.gamelayer = gamelayer--:get_layer()
    self.gamescene = gamescene
    self.csb_TB = {} --csb的table
    self.mapobj_TB = {}--GameMap对象的表
    self.csbcache_TB = {}--csb 缓存表
    self.csb_Idex = 1--拥有多少张地图for csb_TB
    self.csbcache_Idex = 1 --for csbcache_TB
    self:init()

end

function GameMapController:init()
   for i=1,10 do
       local tr ="map_"..i
       local csb= sg_load_csb(tr,2)
       csb:retain()
       if csb~=nil then
            self.csbcache_TB[i] = csb
            -- table.insert( self.csbcache_TB,csb)
       end
   end
   local tr = "map_"..self.csb_Idex
    self.csb_TB[self.csb_Idex] = self.csbcache_TB[ self.csb_Idex]
    self:loadMapCsb( self.csb_TB[self.csb_Idex])
end
function GameMapController:loadMapCsb( mapcsbtb )
    local maptable_tmx = {}
    local num = self:getIntChildNum( mapcsbtb,"map")
    for i=1,num do
        local st = "map_"..i
        local map_tmx = sg_get_child_by_name( mapcsbtb,st)
        table.insert( maptable_tmx, map_tmx )
    end
    local gamemap = GameMap:create( self.gamescene,maptable_tmx)--获取tmx内容
    table.insert( self.mapobj_TB, gamemap )
    if self.csb_Idex==1 then
        mapcsbtb:setPosition( 0,0)
    else
        local csb = self.csb_TB[self.csb_Idex-1]
        mapcsbtb:setPosition(csb:getPositionX()+self:getMapSize(csb),0)
    end
    self.gamelayer:addChild(mapcsbtb,1)

end
function GameMapController:getMapSize( mapthis )
    local contentsize=self:getIntChildNum(mapthis,"map")*map.width
    return contentsize
end
function GameMapController:getIntChildNum(tprent,args)
    if tprent==nil then
        print("getIntChildNum(): tprent is nil")
        return 
    end
    local num=0
    for i=1,100 do
        local key = args.."_"..i
        if sg_get_child_by_name(tprent,key)==nil then
            return num
        else
            num=num+1
        end
    end
end
function GameMapController:Add_csb()
    --test
    if self.csb_Idex==4 then
        print("Add_csb():csb_Idex to high")
    end
    self.csb_Idex =self.csb_Idex +1
    self.csbcache_Idex = self.csbcache_Idex + 1
    -- local tr ="map_"..self.csb_Idex
    if self.csbcache_Idex==11 then
        self.csbcache_Idex =1
    end
    local csb = self.csbcache_TB[ self.csbcache_Idex]--sg_load_csb(tr,2)
    if csb==nil then
        print("Add_csb():not have this csb")
        return
    end
    self.csb_TB[self.csb_Idex] = csb
    self:loadMapCsb( self.csb_TB[self.csb_Idex])

end
function GameMapController:Move_csb( mapcsb,dt )
    local map_tx = mapcsb:getPositionX()
    map_tx = map_tx - dt*Move_sd
    mapcsb:setPosition(cc.p(map_tx,0))
end
function GameMapController:update_csb( mapcsb )
    for k,v in pairs(mapcsb) do
        local mapX,mapY=v:getPosition()
        
        local contentsize=self:getIntChildNum(v,"map")*map.width
        --删除地图
        if mapX<-(contentsize+500) then
            --csb安全移除
            print("csb安全移除")
            v:removeFromParent()
            table.remove(mapcsb,k)
            -- table.remove(self.mapobj_TB,k)
            self.csb_Idex =self.csb_Idex -1
        end

        --新增地图
        local tt =#mapcsb
        if tt<3 then
            if mapcsb[self.csb_Idex]:getPositionX()<-(contentsize/2) then
                print("新增地图")
                self:Add_csb()
            end
        end
    end
end

function GameMapController:update(dt)
    --地图的移动
    for k,v in pairs(self.csb_TB) do
        if v~=nil then
            self:Move_csb(v,dt)
        end
    end
    if #self.csb_TB~=0 then
        self:update_csb( self.csb_TB )
    end
    --GameMap update
    for k,v in pairs(self.mapobj_TB) do
        v:update(dt)
    end
end
return GameMapController
--endregion
