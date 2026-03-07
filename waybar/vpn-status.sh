#!/usr/bin/env sh

MULLVAD_VPN_STATUS=$(mullvad status | tr '[:upper:]' '[:lower:]' | sed 's/://g')
MULLVAD_VPN_SERVER=$(echo "$MULLVAD_VPN_STATUS" | sed '2q;d' | tr -s ' ' | cut -d ' ' -f 3)

if [[ $MULLVAD_VPN_STATUS == *"connecting"* ]]; then
    echo "󱗒 Connecting"
elif [[ $MULLVAD_VPN_STATUS == *"disconnected"* ]]; then
    echo "󰍀 Disconnected"
elif [[ $MULLVAD_VPN_STATUS == *"connected"* ]]; then
    echo "󱚨 $MULLVAD_VPN_SERVER"
elif [[ $MULLVAD_VPN_STATUS == *"blocked"* ]]; then
    echo "󱙲 Blocked"
else
    mullvad status
fi
