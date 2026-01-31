#!/bin/sh
# 确保输出HTTP头（必须）
echo "Content-type: text/html"
echo ""

# 1. 获取访问者IP和提交的账号密码
CLIENT_IP=$(echo $REMOTE_ADDR)
USERNAME=$(echo $HTTP_USER_AGENT | grep -oP '(?<=username=)[^&]*' || echo "未知")
PASSWORD=$(echo $HTTP_USER_AGENT | grep -oP '(?<=password=)[^&]*' || echo "未知")
# 修复POST参数获取（uhttpd CGI的POST参数在stdin中）
read POST_DATA
USERNAME=$(echo $POST_DATA | awk -F 'username=' '{print $2}' | awk -F '&' '{print $1}')
PASSWORD=$(echo $POST_DATA | awk -F 'password=' '{print $2}')

# 2. 定义日志路径和正确密码（可自行修改）
LOG_FILE="/etc/fake-luci/log/access.log"
CORRECT_USER="admin"
CORRECT_PWD="your_password"  # 替换为你要设置的登录密码

# 3. 记录日志（格式：时间 IP 用户名 密码）
echo "[$(date "+%Y-%m-%d %H:%M:%S")] IP: $CLIENT_IP | USER: $USERNAME | PWD: $PASSWORD" >> $LOG_FILE

# 4. 验证密码
if [ "$USERNAME" = "$CORRECT_USER" ] && [ "$PASSWORD" = "$CORRECT_PWD" ]; then
    # 正确：跳转精简管理页
    echo "<meta http-equiv='refresh' content='0;url=/admin/index.html'>"
else
    # 错误：随机返回404或网络中断页（50%概率）
    RANDOM_NUM=$((RANDOM % 2))
    if [ $RANDOM_NUM -eq 0 ]; then
        # 返回404页
        echo "<meta http-equiv='refresh' content='0;url=/404.html'>"
    else
        # 返回网络中断页
        echo "<meta http-equiv='refresh' content='0;url=/error.html'>"
    fi
fi