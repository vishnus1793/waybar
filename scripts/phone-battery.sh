#!/bin/bash

# ----------- CONFIG ----------- #
PHONE_ID="68a2145c_51c7_4108_8cd2_881c467f4940"
BT_DEVICE="/org/freedesktop/UPower/devices/headset_dev_53_58_CA_1D_DC_35"

# ----------- PHONE BATTERY (KDE CONNECT) ----------- #
PHONE_CHARGE=$(qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$PHONE_ID/battery org.kde.kdeconnect.device.battery.charge 2>/dev/null)
PHONE_STATE=$(qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$PHONE_ID/battery org.kde.kdeconnect.device.battery.isCharging 2>/dev/null)

if [ -z "$PHONE_CHARGE" ]; then
    PHONE_TEXT="📱 N-C"
else
    if [ "$PHONE_STATE" = "true" ]; then
        PHONE_TEXT="⚡ $PHONE_CHARGE%"
    else
        PHONE_TEXT=" $PHONE_CHARGE%"
    fi
fi

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
echo "{\"text\": \"$PHONE_TEXT  |  $BT_TEXT\", \"tooltip\": \"Phone: $PHONE_CHARGE% | BT: $BT_CHARGE%\"}"