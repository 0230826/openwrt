include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-mypackage
PKG_VERSION:=1.0
PKG_RELEASE:=1

# 报错即停，强制开启
PKG_BUILD_FLAGS:=no-mips16
CMAKE_INSTALL:=1
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/luci/luci.mk

# 依赖：必须包含luci-compat（新版LuCI核心）、luci-lib-nixio（系统命令调用）
define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=My First OpenWrt LuCI App (With Form & Command)
  PKGARCH:=all
  LUCI_DEPENDS:=+luci-compat +luci-lib-nixio
endef

define Package/$(PKG_NAME)/description
  A custom LuCI application with form interaction and background command execution.
endef

# 安装路径：将luasrc文件拷贝到OpenWrt系统对应目录
define Package/$(PKG_NAME)/install
  $(INSTALL_DIR) $(1)/usr/lib/lua/luci
  cp -pR ./luasrc/* $(1)/usr/lib/lua/luci/
endef

# 强制报错停止，编译流程控制
$(eval $(call BuildPackage,$(PKG_NAME)))

 