#!/usr/bin/env bash

# This script will configure a Dell machine.
#
# Before running this script, you must install the Dell Command | Configure
# utility by following the installation guide provided at:
# https://www.dell.com/support/home/en-vg/product-support/product/command-configure/docs

# Valid options: Optimized, Cool, Quiet, UltraPerformance
cctk --ThermalManagement=UltraPerformance

# Valid options: Enabled, Disabled
cctk --FanCtrlOvrd=Enabled
cctk --FrontFan=Enabled

# Valid options: Auto, High, Medium, MedHigh, MedLow, Low
cctk --FanSpeed=Auto

# Valid options: integers in the [0, 100] range
cctk --FanSpeedLvl=100

# Valid options: FullSpeed, NoiseReduce
cctk --SysFanSpeed=FullSpeed

# Valid options: Standard, Express, PrimAcUse, Adaptive, Custom:$RANGE
cctk --PrimaryBattChargeCfg=Custom:70-80

# Valid options: Enabled, Disabled
cctk --FnLock=Disabled
cctk --FnLockMode=Disabled

# Valid options: 5s, 10s, 15s, 30s, 1m, 5m, 15m, Never
cctk --KbdBacklightTimeoutAc=5m
cctk --KbdBacklightTimeoutBatt=5m

# Valid options: Disabled, Bright, Auto, Dim
cctk ----KeyboardIllumination=Auto
