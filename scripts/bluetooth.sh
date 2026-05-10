# ----------- BLUETOOTH BATTERY (UPOWER) ----------- #
BT_CHARGE=$(upower -i "$BT_DEVICE" 2>/dev/null | awk '/percentage/ {print $2}' | tr -d '%')

if [ -z "$BT_CHARGE" ]; then
    BT_TEXT="🎧 N/A"
else
    if [ "$BT_CHARGE" -ge 80 ]; then ICON=""
    elif [ "$BT_CHARGE" -ge 60 ]; then ICON=""
    elif [ "$BT_CHARGE" -ge 40 ]; then ICON=""
    elif [ "$BT_CHARGE" -ge 20 ]; then ICON=""
    else ICON=""
    fi

    BT_TEXT="🎧 $ICON $BT_CHARGE%"
fi

# ----------- OUTPUT ----------- #
echo "{$BT_TEXT\", \"tooltip\": \"Phone: $PHONE_CHARGE% | BT: $BT_CHARGE%\"}"
