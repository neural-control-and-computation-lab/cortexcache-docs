#!/bin/bash
# Creates a personal share launcher. Never run with sudo.
set -euo pipefail
if [[ $(uname -s) != Darwin || $EUID == 0 ]]; then
  echo 'Run this on your Mac as your normal user, without sudo.'; exit 1
fi
echo 'Connect the cortex VPN first, unless this computer has approved direct access.'
echo 'Choose your lab: 1) Michaels  2) Ma  3) Schall'
read -r -p 'Lab number: ' lab
case "$lab" in
  1) share=Michaels-Projects ;;
  2) share=Ma-Group ;;
  3) share=Schall-Group ;;
  *) echo 'Choose 1, 2 or 3. Nothing was installed.'; exit 1 ;;
esac
read -r -p 'Passport York username (without @yorku.ca): ' york_user
if [[ ! "$york_user" =~ ^[a-zA-Z0-9][a-zA-Z0-9._-]*$ ]]; then
  echo 'Use only letters, numbers, dots, underscores or hyphens.'; exit 1
fi
app="$HOME/Applications/CortexCache-$share.app"
if [[ -e "$app" ]]; then
  echo "A launcher already exists at $app. Open it to reconnect."
  echo 'To change accounts, remove that launcher and its Login Item, then rerun setup.'
  exit 0
fi
stage=$(mktemp -d)
trap 'rm -rf "$stage"' EXIT
cat > "$stage/mount.applescript" <<EOF
-- No password is stored here. macOS handles authentication and optional Keychain storage.
try
    mount volume "smb://YORKU;$york_user@cortexcache-data.nas.sci.yorku.ca/$share"
on error errorMessage number errorNumber
    if errorNumber is not -128 then
        display dialog "Could not connect to $share. Connect the cortex VPN (unless you have approved direct access), then reopen this app. If access is denied, check your York account and share permission." & return & return & errorMessage buttons {"OK"} default button "OK" with title "CortexCache"
    end if
end try
EOF
/usr/bin/osacompile -o "$stage/launcher.app" "$stage/mount.applescript"
mkdir -p "$HOME/Applications"
mv "$stage/launcher.app" "$app"
echo "Created $app"
read -r -p 'Try connecting automatically at Mac sign-in? [y/N]: ' login
if [[ "$login" == y || "$login" == Y ]]; then
  if ! /usr/bin/osascript - "$app" <<'APPLESCRIPT'
on run argv
    set appPath to item 1 of argv
    tell application "System Events"
        if not (exists login item whose path is appPath) then
            make new login item at end with properties {path:appPath, hidden:false}
        end if
    end tell
end run
APPLESCRIPT
  then
    echo 'Could not add the Login Item. Add the app manually in System Settings > General > Login Items.'
  fi
fi
echo 'Opening the launcher. Enter your password only in the macOS connection dialog.'
echo 'On a trusted personal Mac, you can choose to remember it in your Keychain.'
echo 'If the VPN connects after sign-in, reopen the launcher to retry.'
/usr/bin/open "$app"
