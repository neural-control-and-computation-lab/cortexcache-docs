#!/usr/bin/env bash
set -euo pipefail
trap 'printf "\nInstallation stopped. See the error above.\n" >&2' ERR
if [[ $EUID -eq 0 ]]; then
    echo 'Run this as your normal desktop user, without sudo. It will request sudo when needed.' >&2
    exit 1
fi
source_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
for name in mount-michaels-projects.sh vlc-mounted-files.py; do
    [[ -f "$source_dir/$name" ]] || { echo "Missing installer file: $name" >&2; exit 1; }
done
. /etc/os-release
[[ "$ID" == ubuntu ]] || { echo 'This installer is intended for Ubuntu Desktop.' >&2; exit 1; }
echo 'Installing VLC, SMB integration, and the Michaels-Projects launcher.'
echo 'Internet access and your Ubuntu administrator password are required.'
sudo apt-get update
sudo apt-get install -y vlc gvfs-backends gvfs-fuse libglib2.0-bin nautilus zenity python3-gi xdg-user-dirs desktop-file-utils
bash "$source_dir/mount-michaels-projects.sh" --install
app_dir="${XDG_DATA_HOME:-$HOME/.local/share}/michaels-projects"
install -m 755 "$source_dir/vlc-mounted-files.py" "$app_dir/vlc-mounted-files.py"
/usr/bin/python3 - "$app_dir" <<'PY'
import datetime, os, pathlib, sys
app_dir=pathlib.Path(sys.argv[1])
applications=app_dir.parent/'applications'
applications.mkdir(parents=True,exist_ok=True)
target=applications/'vlc.desktop'
source=pathlib.Path('/usr/share/applications/vlc.desktop')
if target.exists():
    backup=target.with_name('vlc.desktop.backup-'+datetime.datetime.now().strftime('%Y%m%d-%H%M%S'))
    backup.write_bytes(target.read_bytes())
path=str(app_dir/'vlc-mounted-files.py')
escaped=path.replace('\\','\\\\').replace('"','\\"').replace('`','\\`').replace('$','\\$').replace('%','%%')
lines=source.read_text().splitlines()
in_main=False
replaced=False
for i,line in enumerate(lines):
    if line.startswith('['): in_main=(line=='[Desktop Entry]')
    if in_main and line.startswith('Exec='):
        lines[i]='Exec="'+escaped+'" --started-from-file %U'
        replaced=True
assert replaced, 'Could not locate VLC desktop launch command'
target.write_text('\n'.join(lines)+'\n')
PY
update-desktop-database "${XDG_DATA_HOME:-$HOME/.local/share}/applications"
for type in video/x-msvideo video/vnd.avi video/avi video/mp4 video/x-matroska video/quicktime video/webm; do
    xdg-mime default vlc.desktop "$type"
done
# Start the filesystem bridge now if it is not already mounted.
if [[ -n "${XDG_RUNTIME_DIR:-}" ]] && ! mountpoint -q "$XDG_RUNTIME_DIR/gvfs"; then
    mkdir -p "$XDG_RUNTIME_DIR/gvfs"
    for bridge in /usr/libexec/gvfsd-fuse /usr/lib/gvfs/gvfsd-fuse; do
        if [[ -x "$bridge" ]]; then
            "$bridge" "$XDG_RUNTIME_DIR/gvfs" || echo 'Log out and back in to activate the filesystem bridge.'
            break
        fi
    done
fi
printf '\nInstallation complete. Open Michaels-Projects from Applications or your desktop.\nEnter your York username; YORKU is supplied automatically.\nConnect to the York VPN if required. Double-click videos to play them in VLC.\nIf needed, log out and back in once to activate desktop integration.\n'
