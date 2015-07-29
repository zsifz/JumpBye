require("app.tbfunction")
local MyApp = class("MyApp", cc.load("mvc").AppBase)

function MyApp:onCreate()
    cc.Director:getInstance():setAnimationInterval(1.0 / 60)

    --math.randomseed(os.time)

end

return MyApp
