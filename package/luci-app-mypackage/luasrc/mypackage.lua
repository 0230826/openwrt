module("luci.controller.mypackage", package.seeall)

function index()
    -- 定义菜单：admin 表示后台菜单，mypackage 是菜单名，_("My App") 是显示名称
    entry({"admin", "mypackage"}, alias("admin", "mypackage", "main"), _("My App"), 50).dependent = true
    -- 定义子菜单，对应前端页面
    entry({"admin", "mypackage", "main"}, template("mypackage/mypackage"), _("Main Page"), 10).leaf = true
end