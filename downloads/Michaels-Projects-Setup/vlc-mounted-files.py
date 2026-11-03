#!/usr/bin/python3
"""Open authenticated SMB mounts in the Ubuntu-packaged VLC player."""
import os
import sys
from gi.repository import Gio
arguments = []
for argument in sys.argv[1:]:
    if argument.lower().startswith('smb://'):
        path = Gio.File.new_for_uri(argument).get_path()
        if path and os.path.isfile(path):
            argument = path
    arguments.append(argument)
os.execv('/usr/bin/vlc', ['/usr/bin/vlc', *arguments])
