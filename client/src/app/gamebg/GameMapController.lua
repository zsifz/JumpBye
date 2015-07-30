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
    self.maptable_csb = {}
    self.gamemapobj = {}
    self.mapIdex = 1--拥有多少张地图
    self:init()

end

function GameMapController:init()
   -- for i=1,3 do
   --     local tr ="map_"..i
   --     self.mapIdex = i
   --     self.maptable_csb[i] = sg_load_csb(tr,2)
   --     self:loadMapCsb( self.maptable_csb[i])
   -- end
   local tr = "map_"..self.mapIdex
    self.maptable_csb[self.mapIdex] = sg_load_csb(tr,2)
    self:loadMapCsb( self.maptable_csb[self.mapIdex])
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
    table.insert( self.gamemapobj, gamemap )
    if self.mapIdex==1 then
        mapcsbtb:setPosition( 0,0)
    else
        local csb = self.maptable_csb[self.mapIdex-1]
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
    if self.mapIdex==4 then
        print("mapIdex过多")
    end
    self.mapIdex =self.mapIdex +1
    local tr ="map_"..self.mapIdex
    local csb = sg_load_csb(tr,2)
    if csb==nil then
        print("没有这个地图")
        return
    end
    self.maptable_csb[self.mapIdex] = csb
    self:loadMapCsb( self.maptable_csb[self.mapIdex])

end
function GameMapController:Move_csb( mapcsb,dt )
    local map_tx = mapcsb:getPositionX()
    map_tx = map_tx - dt*Move_sd
    mapcsb:setPosition(cc.p(map_tx,0))
end
function GameMapController:Remove_csb( mapcsb )
    for k,v in pairs(mapcsb) do
        local mapX,mapY=v:getPosition()
        
        local contentsize=self:getIntChildNum(v,"map")*map.width
        --删除地图
        if mapX<-(contentsize+500) then
            --csb安全移除
            print("csb安全移除")
            v:removeFromParent()
            table.remove(mapcsb,k)
            -- table.remove(self.gamemapobj,k)
            self.mapIdex =self.mapIdex -1
        end

        --新增地图
        local tt =#mapcsb
        if tt<3 then
            if mapcsb[self.mapIdex]:getPositionX()<-(contentsize/2) then
                print("新增地图")
                self:Add_csb()
            end
        end
    end
end

function GameMapController:update(dt)
    --地图的移动
    for k,v in pairs(self.maptable_csb) do
        if v~=nil then
            self:Move_csb(v,dt)
        end
    end
    if #self.maptable_csb~=0 then
        self:Remove_csb( self.maptable_csb )
    end
    --GameMap update
    for k,v in pairs(self.gamemapobj) do
        v:update(dt)
    end
end
return GameMapController
--endregion
