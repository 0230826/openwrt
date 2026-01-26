# 基础信息（必填）
PKG_NAME:=luci-app-mypackage
PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_MAINTAINER:=0230826 <307127899@qq.com>
PKG_LICENSE:=GPL-3.0

# LuCI 依赖（带网页交互必须加这些）
LUCI_TITLE:=My First OpenWrt LuCI App  # LuCI 界面显示的名称
LUCI_PKGARCH:=all                      # 架构兼容（all 表示全平台适配）
LUCI_DEPENDS:=+luci-base +luci-compat  # 依赖的 LuCI 组件，缺一不可

# 编译指令（固定写法，无需修改）
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/luci.mk
include $(INCLUDE_DIR)/package.mk

# 安装指令：把 luasrc 里的文件复制到 OpenWrt 系统对应路径
define Package/$(PKG_NAME)/install
  $(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
  $(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/mypackage
  $(INSTALL_DATA) ./luasrc/controller/mypackage.lua $(1)/usr/lib/lua/luci/controller/
  $(INSTALL_DATA) ./luasrc/view/mypackage/mypackage.htm $(1)/usr/lib/lua/luci/view/mypackage/
endef

# 构建包
$(eval $(call BuildPackage,$(PKG_NAME)))
# 构建 LuCI 包
$(eval $(call LuCIBuild,$(PKG_NAME)))