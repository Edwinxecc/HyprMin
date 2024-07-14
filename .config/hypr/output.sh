#!/bin/bash
# Obtener nombres de las conexiones activas
conexiones_activas=$(xrandr -q | grep ' connected' | awk '{print $1}')

echo "Conexiones activas:"
echo "$conexiones_activas"
