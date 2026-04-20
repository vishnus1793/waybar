#!/bin/bash

DEVICE="68a2145c_51c7_4108_8cd2_881c467f4940"

CHARGE=$(qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$DEVICE/battery org.kde.kdeconnect.device.battery.charge 2>/dev/null)
STATE=$(qdbus-qt5 org.kde.kdeconnect /modules/kdeconnect/devices/$DEVICE/battery org.kde.kdeconnect.device.battery.isCharging 2>/dev/null)

if [ -z "$CHARGE" ]; then
    echo '{"text": "📱 N/A"}'
    exit 0
fi

if [ "$STATE" = "true" ]; then
    STATUS="⚡"
else
    STATUS=""
fi

echo "{\"text\": \"$STATUS $CHARGE%\"}"