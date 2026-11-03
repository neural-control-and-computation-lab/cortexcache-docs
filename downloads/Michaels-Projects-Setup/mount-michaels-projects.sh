#!/usr/bin/env bash
# Ubuntu desktop SMB connection. No passwords are stored by this script.
set -euo pipefail

if [[ "${1:-}" == '--install' ]]; then
    app_dir="${XDG_DATA_HOME:-$HOME/.local/share}/michaels-projects"
    desktop_dir="$(xdg-user-dir DESKTOP 2>/dev/null || printf '%s/Desktop' "$HOME")"
    mkdir -p "$app_dir" "$desktop_dir" "${XDG_DATA_HOME:-$HOME/.local/share}/applications"
    source_file="$(readlink -f -- "${BASH_SOURCE[0]}")"
    target="$app_dir/mount-michaels-projects.sh"
    if [[ "$source_file" != "$target" ]]; then
        install -m 755 -- "$source_file" "$target"
    fi
    # Desktop Exec quoting differs from shell quoting.
    escaped="${target//\\/\\\\}"
    escaped="${escaped//\"/\\\"}"
    escaped="${escaped//\$/\\\$}"
    escaped="${escaped//\`/\\\`}"
    escaped="${escaped//%/%%}"
    launcher="$desktop_dir/Michaels-Projects.desktop"
    cat > "$launcher" <<DESKTOP
[Desktop Entry]
Version=1.0
Type=Application
Name=Michaels-Projects
Comment=Connect to the York Michaels project folders
Exec="$escaped"
Icon=folder-remote
Terminal=false
Categories=Network;
StartupNotify=false
DESKTOP
    chmod 755 "$launcher"
    cp -- "$launcher" "${XDG_DATA_HOME:-$HOME/.local/share}/applications/Michaels-Projects.desktop"
    gio set "$launcher" metadata::trusted true 2>/dev/null || true
    printf 'Installed: %s\nIf Ubuntu asks, right-click it and choose Allow Launching.\n' "$launcher"
    exit 0
fi

if ! command -v gio >/dev/null 2>&1; then
    printf 'Missing Ubuntu desktop components. Install: sudo apt install libglib2.0-bin gvfs-backends\n' >&2
    exit 1
fi
if ! command -v zenity >/dev/null 2>&1; then
    printf 'Username dialog requires Zenity. Install: sudo apt install zenity\n' >&2
    exit 1
fi
while true; do
    username="$(zenity --entry --title="Connect to Michaels-Projects" \
        --text="Enter your York username (not your email address). Domain: YORKU" \
        --width=440)" || exit 0
    if [[ "$username" =~ ^[A-Za-z0-9][A-Za-z0-9._-]*$ ]]; then
        break
    fi
    zenity --error --text="Enter only your York username, without a domain or email address." || true
done
share="smb://YORKU;${username}@cortexcache-data.nas.sci.yorku.ca/Michaels-Projects"

# Nautilus handles mounting and authentication for an unmounted SMB URI.
# gio open alone can fail before a mount exists.
if command -v nautilus >/dev/null 2>&1; then
    exec nautilus --new-window "$share"
fi
printf 'Ubuntu Files is required. Install: sudo apt install nautilus gvfs-backends\n' >&2
exit 1
