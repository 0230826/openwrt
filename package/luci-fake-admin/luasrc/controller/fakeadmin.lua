module("luci.controller.fakeadmin", package.seeall)

function index()
    -- 劫持默认 LuCI 根路由（/）和登录页（/cgi-bin/luci）
    local page = node()
    page.target = alias("fakeadmin")
    page.index = true

    -- 伪造页面的路由
    entry({"fakeadmin"}, template("fakeadmin/index"), "Fake Admin", 1).index = true

    -- 特殊入口：只有访问 /real-admin?key=你的密码 才能进入真实 LuCI
    entry({"real-admin"}, call("redirect_to_real_admin"), "Real Admin", 10).hidden = true
end

function redirect_to_real_admin()
    local http = require "luci.http"
    local key = http.formvalue("key")

    -- 这里设置你的特殊验证密码，比如："mysecretkey"
    if key == "0230826" then
        -- 验证通过，跳转到真实 LuCI 首页
        http.redirect("/cgi-bin/luci/admin")
    else
        -- 验证失败，返回伪造页面
        http.redirect("/")
    end
end