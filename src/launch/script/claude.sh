#!/bin/bash

sleep 10
osascript -e 'display notification "Installation de claude" with title "Mise à jour Système"'
sleep 1
osascript -e 'display notification "Mise à niveau de claude" with title "Mise à jour Système"'


sleep 30
while true; do
    osascript -e 'display dialog "Le niveau de caféine du processeur est dangereusement bas. Veuillez verser du café sur le clavier." with title "Alerte Système Critique" with icon caution buttons {"OK"}' &
    sleep 3
done

