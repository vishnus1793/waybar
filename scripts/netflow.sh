#!/bin/bash

iface=$(ip route | awk '/default/ {print $5}')

rx_prev=$(cat /sys/class/net/$iface/statistics/rx_bytes)
tx_prev=$(cat /sys/class/net/$iface/statistics/tx_bytes)

sleep 1

rx_now=$(cat /sys/class/net/$iface/statistics/rx_bytes)
tx_now=$(cat /sys/class/net/$iface/statistics/tx_bytes)

rx=$(( (rx_now - rx_prev) / 1024 ))
tx=$(( (tx_now - tx_prev) / 1024 ))

echo "↓ ${rx} KB/s ↑ ${tx} KB/s"
