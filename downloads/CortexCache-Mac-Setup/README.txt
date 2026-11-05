CortexCache share setup

Choose Michaels, Ma or Schall when running setup. The same download serves all
three labs. Michaels opens Michaels-Projects. Ma opens Ma-Group and Schall opens
Schall-Group; the server selects your existing user folder. Do not append your
username or %U to the share path. Setup does not grant permissions or create
server folders itself.

Connect the cortex VPN first unless UIT has approved direct access for this
computer. Setup does not connect the VPN or automate Duo. Automatic reconnection
requires both network access and valid credentials. If the VPN connects after
sign-in, reconnect as described below. Close files before disconnecting.

No password is embedded in the scripts, written to a file, or collected by the
website. Only remember credentials on your own trusted computer, subject to your
lab's policy. Shared computers should use separate OS accounts.

Support and manual connection instructions:
https://neural-control-and-computation-lab.github.io/cortexcache-docs/

MAC SETUP
1. Extract the ZIP. Open Terminal, type bash followed by a space, drag
   Setup.command into the Terminal window, and press Return. Do not use sudo.
2. Choose your lab and enter your Passport York username without @yorku.ca.
3. Choose y if you want the launcher to run at Mac sign-in. macOS may ask to
   allow Terminal to control System Events for this Login Item change.
4. Enter your password in the macOS connection dialog, not Terminal. You may
   choose to remember it in Keychain on your personal Mac.

The launcher is in your home folder's Applications directory, named
CortexCache-<share>.app. Open it again whenever you need to reconnect after
connecting the VPN. Login-time failure shows a message; there is no retry loop.
If automatic Login Item creation fails, add that app yourself in System Settings
> General > Login Items (or Login Items & Extensions) > Open at Login.

To uninstall, remove that Login Item and move only that launcher app to Trash.
Eject an active share in Finder. Remove its saved password from macOS Passwords
or Keychain Access if desired. To change the saved username, remove the launcher
and Login Item and rerun setup. The script will not overwrite an existing app.

If macOS or an organization policy blocks the script, use the manual Finder
instructions or ask your IT support; do not disable system security protections.
