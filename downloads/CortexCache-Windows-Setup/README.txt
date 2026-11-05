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

WINDOWS SETUP (Windows 10/11)
1. Extract all files from the ZIP and open Setup.cmd. Run as your normal user,
   not as Administrator, so the mapped drive appears in your File Explorer.
2. Choose your lab and enter your Passport York username without @yorku.ca.
3. Enter your password at the Windows network password prompt. It stays hidden.
4. Note the drive letter Windows assigns. Find it in File Explorer > This PC.

Windows remembers the drive mapping for sign-in. After connecting the VPN, open
the drive to reconnect. If prompted, sign in as YORKU\your_username. On your own
trusted PC, you can remember the login through Windows Credential Manager >
Windows Credentials > Add a Windows credential, using the address
cortexcache-data.nas.sci.yorku.ca and username YORKU\your_username.
The script itself does not store credentials or change security policy.

Rerunning setup chooses another unused drive letter. To avoid duplicate mappings,
open your existing drive to reconnect instead. Setup never deletes mappings.
If error 1219 reports a different existing account, close files and disconnect
that server's connections yourself before using the intended account.

To undo setup, right-click the mapped drive in This PC and choose Disconnect.
If you saved a credential, remove only the matching server entry in Credential
Manager when it is no longer needed. Update it there after a password change.

If SmartScreen or an organization policy blocks the script, use the manual
File Explorer instructions or ask IT; do not disable system security protections.
