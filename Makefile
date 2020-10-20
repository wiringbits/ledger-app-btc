#*******************************************************************************
#   Ledger App
#   (c) 2017 Ledger
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#*******************************************************************************

ifeq ($(BOLOS_SDK),)
$(error Environment variable BOLOS_SDK is not set)
endif
include $(BOLOS_SDK)/Makefile.defines

APP_PATH = ""
# All but bitcoin app use dependency onto the bitcoin app/lib
DEFINES_LIB = USE_LIB_BITCOIN
APP_LOAD_PARAMS= --curve secp256k1 $(COMMON_LOAD_PARAMS)

APPVERSION_M=1
APPVERSION_N=5
APPVERSION_P=0
APPVERSION=$(APPVERSION_M).$(APPVERSION_N).$(APPVERSION_P)
APP_LOAD_FLAGS=--appFlags 0xa50 --dep Bitcoin:$(APPVERSION)

# simplify for tests
ifndef COIN
COIN=bitcoin
endif

ifeq ($(COIN),bitcoin_testnet)
# Bitcoin testnet
DEFINES   += BIP44_COIN_TYPE=1 BIP44_COIN_TYPE_2=1 COIN_P2PKH_VERSION=111 COIN_P2SH_VERSION=196 COIN_FAMILY=1 COIN_COINID=\"Bitcoin\" COIN_COINID_HEADER=\"BITCOIN\" COIN_COLOR_HDR=0xFCB653 COIN_COLOR_DB=0xFEDBA9 COIN_COINID_NAME=\"Bitcoin\" COIN_COINID_SHORT=\"TEST\" COIN_NATIVE_SEGWIT_PREFIX=\"tb\" COIN_KIND=COIN_KIND_BITCOIN_TESTNET COIN_FLAGS=FLAG_SEGWIT_CHANGE_SUPPORT
APPNAME ="Bitcoin Test"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),bitcoin)
# Bitcoin mainnet
DEFINES   += BIP44_COIN_TYPE=0 BIP44_COIN_TYPE_2=0 COIN_P2PKH_VERSION=0 COIN_P2SH_VERSION=5 COIN_FAMILY=1 COIN_COINID=\"Bitcoin\" COIN_COINID_HEADER=\"BITCOIN\" COIN_COLOR_HDR=0xFCB653 COIN_COLOR_DB=0xFEDBA9 COIN_COINID_NAME=\"Bitcoin\" COIN_COINID_SHORT=\"BTC\" COIN_NATIVE_SEGWIT_PREFIX=\"bc\" COIN_KIND=COIN_KIND_BITCOIN COIN_FLAGS=FLAG_SEGWIT_CHANGE_SUPPORT
DEFINES_LIB=# we're not using the lib :)
APPNAME ="Bitcoin"
APP_LOAD_PARAMS += --path $(APP_PATH)
#LIB and global pin and
APP_LOAD_FLAGS=--appFlags 0xa50
else ifeq ($(COIN),bitcoin_cash)
# Bitcoin cash
# Initial fork from Bitcoin, public key access is authorized. Signature is different thanks to the forkId
DEFINES   += BIP44_COIN_TYPE=145 BIP44_COIN_TYPE_2=0 COIN_P2PKH_VERSION=0 COIN_P2SH_VERSION=5 COIN_FAMILY=1 COIN_COINID=\"Bitcoin\" COIN_COINID_HEADER=\"BITCOINCASH\" COIN_COLOR_HDR=0x85bb65 COIN_COLOR_DB=0xc2ddb2 COIN_COINID_NAME=\"BitcoinCash\" COIN_COINID_SHORT=\"BCH\" COIN_KIND=COIN_KIND_BITCOIN_CASH COIN_FORKID=0
APPNAME ="Bitcoin Cash"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),bitcoin_gold)
# Bitcoin Gold
# Initial fork from Bitcoin, public key access is authorized. Signature is different thanks to the forkId
DEFINES   += BIP44_COIN_TYPE=156 BIP44_COIN_TYPE_2=0 COIN_P2PKH_VERSION=38 COIN_P2SH_VERSION=23 COIN_FAMILY=1 COIN_COINID=\"Bitcoin\\x20Gold\" COIN_COINID_HEADER=\"BITCOINGOLD\" COIN_COLOR_HDR=0x85bb65 COIN_COLOR_DB=0xc2ddb2 COIN_COINID_NAME=\"BitcoinGold\" COIN_COINID_SHORT=\"BTG\" COIN_KIND=COIN_KIND_BITCOIN_GOLD COIN_FLAGS=FLAG_SEGWIT_CHANGE_SUPPORT COIN_FORKID=79
APPNAME ="Bitcoin Gold"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),litecoin)
# Litecoin
DEFINES   += BIP44_COIN_TYPE=2 BIP44_COIN_TYPE_2=2 COIN_P2PKH_VERSION=48 COIN_P2SH_VERSION=50 COIN_FAMILY=1 COIN_COINID=\"Litecoin\" COIN_COINID_HEADER=\"LITECOIN\" COIN_COLOR_HDR=0xCCCCCC COIN_COLOR_DB=0xE6E6E6 COIN_COINID_NAME=\"Litecoin\" COIN_COINID_SHORT=\"LTC\" COIN_NATIVE_SEGWIT_PREFIX=\"ltc\" COIN_KIND=COIN_KIND_LITECOIN COIN_FLAGS=FLAG_SEGWIT_CHANGE_SUPPORT
APPNAME ="Litecoin"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),dogecoin)
# Doge
DEFINES   += BIP44_COIN_TYPE=3 BIP44_COIN_TYPE_2=3 COIN_P2PKH_VERSION=30 COIN_P2SH_VERSION=22 COIN_FAMILY=1 COIN_COINID=\"Dogecoin\" COIN_COINID_HEADER=\"DOGECOIN\" COIN_COLOR_HDR=0x65D196 COIN_COLOR_DB=0xB2E8CB COIN_COINID_NAME=\"Dogecoin\" COIN_COINID_SHORT=\"DOGE\" COIN_KIND=COIN_KIND_DOGE
APPNAME ="Dogecoin"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),dash)
# Dash
DEFINES   += BIP44_COIN_TYPE=5 BIP44_COIN_TYPE_2=5 COIN_P2PKH_VERSION=76 COIN_P2SH_VERSION=16 COIN_FAMILY=1 COIN_COINID=\"DarkCoin\" COIN_COINID_HEADER=\"DASH\" COIN_COLOR_HDR=0x0E76AA COIN_COLOR_DB=0x87BBD5 COIN_COINID_NAME=\"Dash\" COIN_COINID_SHORT=\"DASH\" COIN_KIND=COIN_KIND_DASH
APPNAME ="Dash"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),zcash)
# Zcash
DEFINES   += BIP44_COIN_TYPE=133 BIP44_COIN_TYPE_2=133 COIN_P2PKH_VERSION=7352 COIN_P2SH_VERSION=7357 COIN_FAMILY=1 COIN_COINID=\"Zcash\" COIN_COINID_HEADER=\"ZCASH\" COIN_COLOR_HDR=0x3790CA COIN_COLOR_DB=0x9BC8E5 COIN_COINID_NAME=\"Zcash\" COIN_COINID_SHORT=\"ZEC\" COIN_KIND=COIN_KIND_ZCASH
# Switch to Heartwood over Sapling
DEFINES   += COIN_CONSENSUS_BRANCH_ID=0xF5B9230B
APPNAME ="Zcash"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),horizen)
# Horizen
DEFINES   += BIP44_COIN_TYPE=121 BIP44_COIN_TYPE_2=121 COIN_P2PKH_VERSION=8329 COIN_P2SH_VERSION=8342 COIN_FAMILY=4 COIN_COINID=\"Horizen\" COIN_COINID_HEADER=\"HORIZEN\" COIN_COLOR_HDR=0xFF4300 COIN_COLOR_DB=0xFF8356 COIN_COINID_NAME=\"Horizen\" COINID=$(COIN) COIN_COINID_SHORT=\"ZEN\" COIN_KIND=COIN_KIND_HORIZEN
APPNAME ="Horizen"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),komodo)
# Komodo
DEFINES   += BIP44_COIN_TYPE=141 BIP44_COIN_TYPE_2=141 COIN_P2PKH_VERSION=60 COIN_P2SH_VERSION=85 COIN_FAMILY=1 COIN_COINID=\"Komodo\" COIN_COINID_HEADER=\"KOMODO\" COIN_COLOR_HDR=0x326464 COIN_COLOR_DB=0x99b2b2 COIN_COINID_NAME=\"Komodo\" COIN_COINID_SHORT=\"KMD\" COIN_KIND=COIN_KIND_KOMODO
APPNAME ="Komodo"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),stratis)
# Stratis
DEFINES   += BIP44_COIN_TYPE=105 BIP44_COIN_TYPE_2=105 COIN_P2PKH_VERSION=63 COIN_P2SH_VERSION=125 COIN_FAMILY=2 COIN_COINID=\"Stratis\" COIN_COINID_HEADER=\"STRATIS\" COIN_COLOR_HDR=0x3790CA COIN_COLOR_DB=0x9BC8E5 COIN_COINID_NAME=\"Stratis\" COIN_COINID_SHORT=\"STRAT\" COIN_KIND=COIN_KIND_STRATIS COIN_FLAGS=FLAG_PEERCOIN_SUPPORT
APPNAME ="Stratis"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),peercoin)
# Peercoin
DEFINES += BIP44_COIN_TYPE=6 BIP44_COIN_TYPE_2=6 COIN_P2PKH_VERSION=55 COIN_P2SH_VERSION=117 COIN_FAMILY=2 COIN_COINID=\"PPCoin\" COIN_COINID_HEADER=\"PEERCOIN\" COIN_COLOR_HDR=0x3790CA COIN_COLOR_DB=0x9BC8E5 COIN_COINID_NAME=\"Peercoin\" COIN_COINID_SHORT=\"PPC\" COIN_KIND=COIN_KIND_PEERCOIN COIN_FLAGS=FLAG_PEERCOIN_UNITS\|FLAG_PEERCOIN_SUPPORT
APPNAME ="Peercoin"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),pivx)
# PivX
# 77 was used in the Chrome apps
DEFINES   += BIP44_COIN_TYPE=119 BIP44_COIN_TYPE_2=77 COIN_P2PKH_VERSION=30 COIN_P2SH_VERSION=13 COIN_FAMILY=1 COIN_COINID=\"DarkNet\" COIN_COINID_HEADER=\"PIVX\" COIN_COLOR_HDR=0x46385D COIN_COLOR_DB=0x9E96AA COIN_COINID_NAME=\"PivX\" COIN_COINID_SHORT=\"PIVX\" COIN_KIND=COIN_KIND_PIVX
APPNAME ="PivX"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),stealth)
# Stealth
DEFINES   += BIP44_COIN_TYPE=125 BIP44_COIN_TYPE_2=125 COIN_P2PKH_VERSION=62 COIN_P2SH_VERSION=85 COIN_FAMILY=4 COIN_COINID=\"Stealth\" COIN_COINID_HEADER=\"STEALTH\" COIN_COLOR_HDR=0x000000 COIN_COLOR_DB=0x808080 COIN_COINID_NAME=\"Stealth\" COIN_COINID_SHORT=\"XST\" COIN_KIND=COIN_KIND_STEALTH COIN_FLAGS=FLAG_PEERCOIN_UNITS\|FLAG_PEERCOIN_SUPPORT
APPNAME ="Stealth"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),viacoin)
# Viacoin
DEFINES   += BIP44_COIN_TYPE=14 BIP44_COIN_TYPE_2=14 COIN_P2PKH_VERSION=71 COIN_P2SH_VERSION=33 COIN_FAMILY=1 COIN_COINID=\"Viacoin\" COIN_COINID_HEADER=\"VIACOIN\" COIN_COLOR_HDR=0x414141 COIN_COLOR_DB=0xA0A0A0 COIN_COINID_NAME=\"Viacoin\" COIN_COINID_SHORT=\"VIA\" COIN_KIND=COIN_KIND_VIACOIN COIN_FLAGS=FLAG_SEGWIT_CHANGE_SUPPORT
APPNAME ="Viacoin"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),vertcoin)
# Vertcoin
# 128 was used in the Chrome apps
DEFINES   += BIP44_COIN_TYPE=28 BIP44_COIN_TYPE_2=128 COIN_P2PKH_VERSION=71 COIN_P2SH_VERSION=5 COIN_FAMILY=1 COIN_COINID=\"Vertcoin\" COIN_COINID_HEADER=\"VERTCOIN\" COIN_COLOR_HDR=0x1B5C2E COIN_COLOR_DB=0x8DAE97 COIN_COINID_NAME=\"Vertcoin\" COIN_COINID_SHORT=\"VTC\" COIN_KIND=COIN_KIND_VERTCOIN COIN_FLAGS=FLAG_SEGWIT_CHANGE_SUPPORT
APPNAME ="Vertcoin"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),digibyte)
DEFINES   += BIP44_COIN_TYPE=20 BIP44_COIN_TYPE_2=20 COIN_P2PKH_VERSION=30 COIN_P2SH_VERSION=63 COIN_FAMILY=1 COIN_COINID=\"DigiByte\" COIN_COINID_HEADER=\"DIGIBYTE\" COIN_COLOR_HDR=0x2864AE COIN_COLOR_DB=0x94B2D7 COIN_COINID_NAME=\"DigiByte\" COIN_COINID_SHORT=\"DGB\" COIN_NATIVE_SEGWIT_PREFIX=\"dgb\" COIN_KIND=COIN_KIND_DIGIBYTE COIN_FLAGS=FLAG_SEGWIT_CHANGE_SUPPORT
APPNAME ="Digibyte"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),qtum)
# Qtum
# Qtum can run significantly different code paths, thus is locked by the OS
# using APP_LOAD_PARAMS instead of BIP44_COIN_TYPE
DEFINES   += BIP44_COIN_TYPE=0 BIP44_COIN_TYPE_2=0 COIN_P2PKH_VERSION=58 COIN_P2SH_VERSION=50 COIN_FAMILY=3 COIN_COINID=\"Qtum\" COIN_COINID_HEADER=\"QTUM\" COIN_COLOR_HDR=0x2E9AD0 COIN_COLOR_DB=0x97CDE8 COIN_COINID_NAME=\"QTUM\" COIN_COINID_SHORT=\"QTUM\" COIN_NATIVE_SEGWIT_PREFIX=\"qc\" COIN_KIND=COIN_KIND_QTUM COIN_FLAGS=FLAG_SEGWIT_CHANGE_SUPPORT
APPNAME ="Qtum"
APP_LOAD_PARAMS += --path "44'/88'" --path "49'/88'" --path "0'/45342'" --path "20698'/3053'/12648430'"
else ifeq ($(COIN),zcoin)
DEFINES   += BIP44_COIN_TYPE=136 BIP44_COIN_TYPE_2=136 COIN_P2PKH_VERSION=82 COIN_P2SH_VERSION=7 COIN_FAMILY=1 COIN_COINID=\"Zcoin\" COIN_COINID_HEADER=\"ZCOIN\" COIN_COLOR_HDR=0x3EAD54 COIN_COLOR_DB=0xA3DCAE COIN_COINID_NAME=\"Zcoin\" COIN_COINID_SHORT=\"ZCOIN\" COIN_KIND=COIN_KIND_ZCOIN
APPNAME ="Zcoin"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),bitcoin_private)
# Bitcoin Private
# Initial fork from Bitcoin, public key access is authorized. Signature is different thanks to the forkId
# Note : might need a third lock on ZClassic
DEFINES   += BIP44_COIN_TYPE=183 BIP44_COIN_TYPE_2=0 COIN_P2PKH_VERSION=4901 COIN_P2SH_VERSION=5039 COIN_FAMILY=1 COIN_COINID=\"BPrivate\" COIN_COINID_HEADER=\"BITCOINPRIVATE\" COIN_COLOR_HDR=0x85bb65 COIN_COLOR_DB=0xc2ddb2 COIN_COINID_NAME=\"BPrivate\" COIN_COINID_SHORT=\"BTCP\" COIN_KIND=COIN_KIND_BITCOIN_PRIVATE COIN_FORKID=42
APPNAME ="Bitcoin Private"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),gamecredits)
# GameCredits
DEFINES   += BIP44_COIN_TYPE=101  BIP44_COIN_TYPE_2=101 COIN_P2PKH_VERSION=38 COIN_P2SH_VERSION=62 COIN_FAMILY=1 COIN_COINID=\"GameCredits\" COIN_COINID_HEADER=\"GAMECREDITS\" COIN_COLOR_HDR=0x98C01F COIN_COLOR_DB=0xA1A2A7 COIN_COINID_NAME=\"GameCredits\" COIN_COINID_SHORT=\"GAME\" COIN_KIND=COIN_KIND_GAMECREDITS COIN_FLAGS=FLAG_SEGWIT_CHANGE_SUPPORT
APPNAME ="GameCredits"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),zclassic)
# ZClassic
DEFINES   += BIP44_COIN_TYPE=147  BIP44_COIN_TYPE_2=147 COIN_P2PKH_VERSION=7352 COIN_P2SH_VERSION=7357 COIN_FAMILY=1 COIN_COINID=\"ZClassic\" COIN_COINID_HEADER=\"ZCLASSIC\" COIN_COLOR_HDR=0xc87035 COIN_COLOR_DB=0xc78457 COIN_COINID_NAME=\"ZClassic\" COIN_COINID_SHORT=\"ZCL\" COIN_KIND=COIN_KIND_ZCLASSIC
APPNAME ="ZClassic"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),xsn)
# XSN mainnet
DEFINES   += BIP44_COIN_TYPE=384  BIP44_COIN_TYPE_2=384 COIN_P2PKH_VERSION=76 COIN_P2SH_VERSION=16 COIN_FAMILY=1 COIN_COINID=\"XSN\" COIN_COINID_HEADER=\"XSN\" COIN_COLOR_HDR=0x2982D1 COIN_COLOR_DB=0x7FB6E6 COIN_COINID_NAME=\"XSN\" COIN_COINID_SHORT=\"XSN\" COIN_NATIVE_SEGWIT_PREFIX=\"xc\" COIN_KIND=COIN_KIND_XSN COIN_FLAGS=FLAG_SEGWIT_CHANGE_SUPPORT
APPNAME ="XSN"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),nix)
# NIX
DEFINES   += BIP44_COIN_TYPE=400  BIP44_COIN_TYPE_2=400 COIN_P2PKH_VERSION=38 COIN_P2SH_VERSION=53 COIN_FAMILY=1 COIN_COINID=\"NIX\" COIN_COINID_HEADER=\"NIX\" COIN_COLOR_HDR=0x1685e8 COIN_COLOR_DB=0xffffff COIN_COINID_NAME=\"NIX\" COIN_COINID_SHORT=\"NIX\" COIN_NATIVE_SEGWIT_PREFIX=\"nix\" COIN_KIND=COIN_KIND_NIX COIN_FLAGS=FLAG_SEGWIT_CHANGE_SUPPORT
APPNAME ="NIX"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),lbry)
# LBRY
DEFINES   += BIP44_COIN_TYPE=140  BIP44_COIN_TYPE_2=140 COIN_P2PKH_VERSION=85 COIN_P2SH_VERSION=122 COIN_FAMILY=1 COIN_COINID=\"LBRY\" COIN_COINID_HEADER=\"LBRY\" COIN_COLOR_HDR=0x38D9A9 COIN_COLOR_DB=0xFEDBA9 COIN_COINID_NAME=\"LBRY\" COIN_COINID_SHORT=\"LBC\" COIN_KIND=COIN_KIND_LBRY
APPNAME ="LBRY"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),resistance)
# Resistance
DEFINES   += BIP44_COIN_TYPE=356  BIP44_COIN_TYPE_2=356 COIN_P2PKH_VERSION=7063 COIN_P2SH_VERSION=7068 COIN_FAMILY=1 COIN_COINID=\"Res\" COIN_COINID_HEADER=\"RES\" COIN_COLOR_HDR=0x3790CA COIN_COLOR_DB=0x9BC8E5 COIN_COINID_NAME=\"Res\" COIN_COINID_SHORT=\"RES\" COIN_KIND=COIN_KIND_RESISTANCE
APPNAME ="Resistance"
APP_LOAD_PARAMS += --path $(APP_PATH)
else ifeq ($(COIN),ravencoin)
# Ravencoin
DEFINES   += BIP44_COIN_TYPE=175  BIP44_COIN_TYPE_2=175 COIN_P2PKH_VERSION=60 COIN_P2SH_VERSION=122 COIN_FAMILY=1 COIN_COINID=\"Ravencoin\" COIN_COINID_HEADER=\"RAVENCOIN\" COIN_COLOR_HDR=0x2E4A80 COIN_COLOR_DB=0x74829E COIN_COINID_NAME=\"Ravencoin\" COIN_COINID_SHORT=\"RVN\" COIN_KIND=COIN_KIND_RAVENCOIN
APPNAME ="Ravencoin"
APP_LOAD_PARAMS += --path $(APP_PATH)
else
ifeq ($(filter clean,$(MAKECMDGOALS)),)
$(error Unsupported COIN - use bitcoin_testnet, bitcoin, bitcoin_cash, bitcoin_gold, litecoin, dogecoin, dash, zcash, horizen, komodo, stratis, peercoin, pivx, viacoin, vertcoin, stealth, digibyte, qtum, bitcoin_private, zcoin, gamecredits, zclassic, xsn, nix, lbry, resistance, ravencoin)
endif
endif

APP_LOAD_PARAMS += $(APP_LOAD_FLAGS)
DEFINES += $(DEFINES_LIB)

ifeq ($(TARGET_NAME),TARGET_BLUE)
ICONNAME=icons/blue_app_$(COIN).gif
else
	ifeq ($(TARGET_NAME),TARGET_NANOX)
ICONNAME=icons/nanox_app_$(COIN).gif
	else
ICONNAME=icons/nanos_app_$(COIN).gif
	endif
endif

################
# Default rule #
################
all: default

############
# Platform #
############

DEFINES   += OS_IO_SEPROXYHAL IO_SEPROXYHAL_BUFFER_SIZE_B=300
DEFINES   += HAVE_BAGL HAVE_SPRINTF HAVE_SNPRINTF_FORMAT_U
DEFINES   += HAVE_IO_USB HAVE_L4_USBLIB IO_USB_MAX_ENDPOINTS=4 IO_HID_EP_LENGTH=64 HAVE_USB_APDU
DEFINES   += LEDGER_MAJOR_VERSION=$(APPVERSION_M) LEDGER_MINOR_VERSION=$(APPVERSION_N) LEDGER_PATCH_VERSION=$(APPVERSION_P) TCS_LOADER_PATCH_VERSION=0

# U2F
DEFINES   += HAVE_U2F HAVE_IO_U2F
DEFINES   += U2F_PROXY_MAGIC=\"BTC\"
DEFINES   += USB_SEGMENT_SIZE=64
DEFINES   += BLE_SEGMENT_SIZE=32 #max MTU, min 20

#WEBUSB_URL     = www.ledgerwallet.com
#DEFINES       += HAVE_WEBUSB WEBUSB_URL_SIZE_B=$(shell echo -n $(WEBUSB_URL) | wc -c) WEBUSB_URL=$(shell echo -n $(WEBUSB_URL) | sed -e "s/./\\\'\0\\\',/g")
DEFINES   += HAVE_WEBUSB WEBUSB_URL_SIZE_B=0 WEBUSB_URL=""

DEFINES   += UNUSED\(x\)=\(void\)x
DEFINES   += APPVERSION=\"$(APPVERSION)\"

DEFINES += BLAKE_SDK

ifeq ($(TARGET_NAME),TARGET_NANOX)
DEFINES       += HAVE_BLE BLE_COMMAND_TIMEOUT_MS=2000
DEFINES       += HAVE_BLE_APDU # basic ledger apdu transport over BLE

DEFINES       += HAVE_GLO096
DEFINES       += HAVE_BAGL BAGL_WIDTH=128 BAGL_HEIGHT=64
DEFINES       += HAVE_BAGL_ELLIPSIS # long label truncation feature
DEFINES       += HAVE_BAGL_FONT_OPEN_SANS_REGULAR_11PX
DEFINES       += HAVE_BAGL_FONT_OPEN_SANS_EXTRABOLD_11PX
DEFINES       += HAVE_BAGL_FONT_OPEN_SANS_LIGHT_16PX
DEFINES       += HAVE_UX_FLOW
endif

# Enabling debug PRINTF
DEBUG:= 0
ifneq ($(DEBUG),0)
        ifeq ($(TARGET_NAME),TARGET_NANOX)
                DEFINES   += HAVE_PRINTF PRINTF=mcu_usb_printf
        else
                DEFINES   += HAVE_PRINTF PRINTF=screen_printf
        endif
else
        DEFINES   += PRINTF\(...\)=
endif



##############
# Compiler #
##############
ifneq ($(BOLOS_ENV),)
$(info BOLOS_ENV=$(BOLOS_ENV))
CLANGPATH := $(BOLOS_ENV)/clang-arm-fropi/bin/
GCCPATH := $(BOLOS_ENV)/gcc-arm-none-eabi-5_3-2016q1/bin/
else
$(info BOLOS_ENV is not set: falling back to CLANGPATH and GCCPATH)
endif
ifeq ($(CLANGPATH),)
$(info CLANGPATH is not set: clang will be used from PATH)
endif
ifeq ($(GCCPATH),)
$(info GCCPATH is not set: arm-none-eabi-* will be used from PATH)
endif

CC       := $(CLANGPATH)clang

#CFLAGS   += -O0
CFLAGS   += -O3 -Os
CFLAGS   += -I/usr/include/
AS     := $(GCCPATH)arm-none-eabi-gcc

LD       := $(GCCPATH)arm-none-eabi-gcc
LDFLAGS  += -O3 -Os
LDLIBS   += -lm -lgcc -lc

# import rules to compile glyphs(/pone)
include $(BOLOS_SDK)/Makefile.glyphs

### variables processed by the common makefile.rules of the SDK to grab source files and include dirs
APP_SOURCE_PATH  += src
SDK_SOURCE_PATH  += lib_stusb lib_stusb_impl lib_u2f qrcode

ifeq ($(TARGET_NAME),TARGET_NANOX)
SDK_SOURCE_PATH  += lib_blewbxx lib_blewbxx_impl
SDK_SOURCE_PATH  += lib_ux
endif

# If the SDK supports Flow for Nano S, build for it

ifeq ($(TARGET_NAME),TARGET_NANOS)

	ifneq "$(wildcard $(BOLOS_SDK)/lib_ux/src/ux_flow_engine.c)" ""
		SDK_SOURCE_PATH  += lib_ux
		DEFINES		       += HAVE_UX_FLOW
	endif

endif

load: all
	python -m ledgerblue.loadApp $(APP_LOAD_PARAMS)

delete:
	python -m ledgerblue.deleteApp $(COMMON_DELETE_PARAMS)

# import generic rules from the sdk
include $(BOLOS_SDK)/Makefile.rules

#add dependency on custom makefile filename
dep/%.d: %.c Makefile


# Temporary restriction until we a Resistance Nano X icon
ifeq ($(TARGET_NAME),TARGET_NANOX)

listvariants:
	@echo VARIANTS COIN bitcoin_testnet bitcoin bitcoin_cash bitcoin_gold litecoin dogecoin dash zcash horizen komodo stratis peercoin pivx viacoin vertcoin stealth digibyte qtum bitcoin_private zcoin gamecredits zclassic xsn nix lbry ravencoin

else

listvariants:
	@echo VARIANTS COIN bitcoin_testnet bitcoin bitcoin_cash bitcoin_gold litecoin dogecoin dash zcash horizen komodo stratis peercoin pivx viacoin vertcoin stealth digibyte qtum bitcoin_private zcoin gamecredits zclassic xsn nix lbry ravencoin resistance

endif
