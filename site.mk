##	gluon site.mk makefile example

##	GLUON_FEATURES
#		Specify Gluon features/packages to enable;
#		Gluon will automatically enable a set of packages
#		depending on the combination of features listed

#GLUON_FEATURES := \
#	freifunk-berlin-ui \
#	freifunk-berlin-defaults \
#	freifunk-berlin-utils \
#	freifunk-berlin-statistics-collectd \
#	freifunk-berlin-mesh-olsr \
#	freifunk-berlin-owm


##	GLUON_SITE_PACKAGES
#		Specify additional Gluon/OpenWrt packages to include here;
#		A minus sign may be prepended to remove a packages from the
#		selection that would be enabled by default or due to the
#		chosen feature flags

GLUON_SITE_PACKAGES := \
	-hostapd-mini \
	-ppp -ppp-mod-pppoe
#	iwinfo luci-mod-admin-full luci-theme-bootstrap luci-app-ffwizard-berlin luci-mod-freifunk

EXTRA_KERNEL_PACKAGES := \
kmod-usb-acm kmod-usb-net kmod-usb-net-cdc-ether kmod-usb-net-rndis

GLUON_EXTRA_PACKAGES := \
$(EXTRA_KERNEL_PACKAGES) \
alfred \
batctl-default \
collectd collectd-mod-conntrack collectd-mod-cpu collectd-mod-exec collectd-mod-interface \
collectd-mod-irq collectd-mod-iwinfo collectd-mod-load collectd-mod-memory collectd-mod-network \
collectd-mod-olsrd collectd-mod-ping collectd-mod-routeros collectd-mod-rrdtool collectd-mod-snmp \
collectd-mod-uptime collectd-mod-wireless collectd-snmp-templates \
community-profiles \
ethtool \
freifunk-berlin-dhcp-defaults freifunk-berlin-firewall-defaults freifunk-berlin-freifunk-defaults \
freifunk-berlin-lib-guard freifunk-berlin-migration freifunk-berlin-network-defaults \
freifunk-berlin-olsrd-defaults freifunk-berlin-system-defaults freifunk-berlin-statistics-defaults \
freifunk-berlin-tunneldigger freifunk-berlin-uhttpd-defaults freifunk-berlin-uplink-notunnel-files \
freifunk-berlin-uplink-tunnelberlin-tunneldigger \
freifunk-common freifunk-firewall freifunk-gwcheck freifunk-policyrouting \
horst \
iperf ipip \
iptables-mod-conntrack-extra iptables-mod-filter iptables-mod-ipopt \
iwinfo \
libiwinfo-lua libubus-lua libuci-lua libustream-mbedtls \
luci-app-ffwizard-berlin luci-app-firewall luci-app-opkg \
luci-app-olsr luci-app-olsr-services luci-app-olsr-viz \
luci-app-owm luci-app-owm-ant luci-app-owm-cmd luci-app-owm-gui \
luci-app-statistics \
luci-mod-admin-full luci-mod-freifunk-ui \
luci-proto-ipip \
mtr \
olsrd olsrd-mod-arprefresh olsrd-mod-dyn-gw olsrd-mod-dyn-gw-plain olsrd-mod-jsoninfo \
olsrd-mod-nameservice olsrd-mod-netjson olsrd-mod-txtinfo olsrd-mod-watchdog \
om-watchdog px5g-mbedtls \
qos-scripts \
rssileds \
tc tcpdump terminfo tmux \
uhttpd-mod-ubus \
vnstat \
wpad-basic

#PKG_REV = $(strip $(shell \
#			set -- $$(git log -1 --format="%ct %h" --abbrev=7); \
#			secs="$$(($$1 % 86400))"; \
#			yday="$$(date --utc --date="@$$1" "+%y.%j")"; \
#			revision="$$(printf 'git-%s.%05d-%s' "$$yday" "$$secs" "$$2")"; \
#		))
PKG_REV_HASH = $(shell git log -1 --format="%h" --abbrev=7)
PKG_REV_DATE = $(shell date --date=@$$(git log -1 --format="%ct") +%y.%j)

##	DEFAULT_GLUON_RELEASE
#		version string to use for images
#		gluon relies on
#			opkg compare-versions "$1" '>>' "$2"
#		to decide if a version is newer or not.

DEFAULT_GLUON_RELEASE := gluon+exp.git-$(PKG_REV_DATE)-$(PKG_REV_HASH)

# Variables set with ?= can be overwritten from the command line

##	GLUON_RELEASE
#		call make with custom GLUON_RELEASE flag, to use your own release version scheme.
#		e.g.:
#			$ make images GLUON_RELEASE=23.42+5
#		would generate images named like this:
#			gluon-ff%site_code%-23.42+5-%router_model%.bin

GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

# Default priority for updates.
GLUON_PRIORITY ?= 0

# Region code required for some images; supported values: us eu
GLUON_REGION ?= eu

# Languages to include
GLUON_LANGS ?= en de

# Do not build images for deprecated devices
GLUON_DEPRECATED ?= 0

# build broken targets by default, e.g. ar71xx-mikrotik
BROKEN ?= 1

