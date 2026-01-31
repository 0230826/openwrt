include $(TOPDIR)/rules.mk

PKG_NAME:=fake-luci-pro
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_MAINTAINER:=kaka <307127899@qq.com>
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk

define Package/fake-luci-pro
  SECTION:=luci
  CATEGORY:=LuCI
  TITLE:=Fake Luci with Login Record + Simple Admin Page
  DEPENDS:=+uhttpd +luci-base +coreutils +bash +grep  # 新增CGI和基础工具依赖
  PKGARCH:=all
endef

define Package/fake-luci-pro/description
  Replace real Luci login page, record access info, provide simple admin page, hide real Luci.
endef

# 安装规则：将files下的文件复制到对应路径
define Build/Compile
endef

define Package/fake-luci-pro/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/uhttpd $(1)/etc/config/
	$(INSTALL_DIR) $(1)/etc/fake-luci/{log,conf}
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/fake-luci $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/www
	$(CP) ./files/www/* $(1)/www/
	$(INSTALL_DIR) $(1)/www/cgi-bin
	$(INSTALL_BIN) ./files/www/cgi-bin/auth.cgi $(1)/www/cgi-bin/
	# 赋予CGI脚本执行权限（关键）
	chmod +x $(1)/www/cgi-bin/auth.cgi
endef

$(eval $(call BuildPackage,fake-luci-pro))