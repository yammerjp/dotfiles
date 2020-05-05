#!/bin/bash -e

if ! defaults read org.shiftitapp.ShiftIt leftKeyCode > /dev/null; then
  echo "The variable 'org.shiftitapp.ShiftIt leftKeyCode' is not found"
  echo "This computer may not be installed shiftit"
  exit 1
fi

# 左半分にウィンドウを展開
# Space(shift) + Fn + ←
defaults write org.shiftitapp.ShiftIt leftKeyCode 115
defaults write org.shiftitapp.ShiftIt leftModifiers 8519680
# 画面全体にウィンドウを展開
# Space(shift) + Fn + ↑
defaults write org.shiftitapp.ShiftIt maximizeKeyCode 116
defaults write org.shiftitapp.ShiftIt maximizeModifiers 8519680
# 右半分にウィンドウを展開
# Space(shift) + Fn + →
defaults write org.shiftitapp.ShiftIt rightKeyCode 119
defaults write org.shiftitapp.ShiftIt rightModifiers 8519680

"Finished to set variables of shiftit"