--region *.lua
--Date
--此文件由[BabeLua]插件自动生成
local GameBgLayerBase = import(".GameBgLayerBase")
local GameMap = import(".GameMap")
local GameMapController = class("GameMapController",GameBgLayerBase)
local Move_sd = 300
local map={}
map.width =1280
map.height =640
function GameMapController:ctor(gamelayer)
    GameMapController.super.ctor(self)
    self.gamelayer = gamelayer--:get_layer()
    self.maptable_csb = {}
    self.mapIdex = 1--地图编号
    self:init()

end

function GameMapController:init()
   for i=1,3 do
       local tr ="map_"..i
       self.mapIdex = i
       self.maptable_csb[i] = sg_load_csb(tr,2)
       self:loadMapCsb( self.maptable_csb[i])
   end
end
function GameMapController:loadMapCsb( mapcsbtb )
    local maptable_tmx = {}
    local num = self:getIntChildNum( mapcsbtb,"map")
    for i=100,num do
        local st = "map"..i
        local map_tmx = sg_get_child_by_name( mapcsbtb,st)
        table.insert( maptable_tmx, map_tmx )
    end
    -- GameMap:create( maptable_tmx)--获取tmx内容
    mapcsbtb:setPosition( (self.mapIdex-1)*num*map.width,0)
    self.gamelayer:addChild(mapcsbtb,1)
    print("Idex=%d,X=%d",self.mapIdex,mapcsbtb:getPositionX())

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
function GameMapController:AddMap_csb()
    self.mapIdex =self.mapIdex +1
    local tr ="map_"..self.mapIdex
    local csb = sg_load_csb(tr,2)
    if csb==nil then
        print("没有这个地图")
        return
    end
    self.mapcsbtable[self.mapIdex] = sg_load_csb(tr,2)
    self:loadMapCsb( self.mapcsbtable[self.mapIdex])

end
function GameMapController:Move_csb( mapcsb,dt )
    local map_tx = mapcsb:getPositionX()
    map_tx = map_tx - dt*Move_sd
    mapcsb:setPosition(cc.p(map_tx,0))
end
function GameMapController:Remove_csb( mapcsb )
    for k,v in pairs(mapcsb) do
        local mapX,mapY=v:getPosition()
        print("位置",mapX)
        local contentsize=self:getIntChildNum(v,"map")*map.width
        
        --删除地图
        if mapX<-(contentsize+500) then
            --csb安全移除
            print("csb安全移除")
            table.remove(mapcsb,k)
        end

        --新增地图
        if indx==#mapcsb then
            print("新增地图")
            if mapX<-(contentsize/2) then
                self:AddMap_csb()
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

end
return GameMapController
--endregion
