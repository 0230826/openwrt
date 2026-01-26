module("luci.controller.mypackage", package.seeall)

function index()
    -- 页面访问路径：http://路由器IP/cgi-bin/luci/admin/mypackage
    entry({"admin", "mypackage"}, template("mypackage/mypackage"), _("My Custom App"), 10).dependent = true
    -- 命令执行接口：接收POST请求，处理表单参数
    entry({"admin", "mypackage", "do_command"}, post("action_do_command"), nil).leaf = true
end

-- 核心：执行后台命令 + 返回结果
function action_do_command()
    local fs = require "nixio.fs"
    local util = require "nixio.util"
    local http = require "luci.http"
    local uci = require "luci.model.uci".cursor()

    -- 接收前端表单参数（name="cmd_param"）
    local cmd_param = http.formvalue("cmd_param") or "default_param"
    
    -- 待执行的后台命令（示例：打印参数 + 查看系统负载，可自定义）
    -- 注意：使用双引号包裹参数，防止空格截断；可替换为任意shell命令/脚本
    local cmd = string.format('echo "Received Param: %s" && uptime', cmd_param)
    
    -- 执行命令并获取输出结果
    local cmd_result = util.exec(cmd) or "Command execution failed!"

    -- 返回结果到前端页面
    http.prepare_content("text/plain")
    http.write(cmd_result)
end