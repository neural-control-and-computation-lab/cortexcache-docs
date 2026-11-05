# CortexCache connection guide

Interactive, single-page documentation for connecting to the Michaels, Ma and Schall labs' CortexCache network storage (`Michaels-Projects`, `Ma-Group`, and `Schall-Group`) from macOS, Windows and Linux.

- `index.html` — the whole site (no build step, no dependencies)
- `reference.html` — detailed setup, connection management, error recovery and transfer guidance
- `img/` — screenshots used on the page

It consolidates the four Science IT HOWTO documents (VPN client, SMB on Windows / Mac / Linux) into one page with lab and OS selectors, copy buttons, troubleshooting and access instructions.

## Publishing on GitHub Pages

One-time setup, from inside this folder:

```bash
git init
git add .
git commit -m "CortexCache connection guide"
git branch -M main
git remote add origin git@github.com:<your-account>/cortexcache-docs.git
git push -u origin main
```

Then on GitHub: **Settings → Pages → Build and deployment → Source: "Deploy from a branch"**, branch `main`, folder `/ (root)`, Save. After a minute the site is live at

```
https://<your-account>.github.io/cortexcache-docs/
```

To update the guide later, edit `index.html`, commit, and push — Pages redeploys automatically.

## Editing

The page is a three-step onboarding guide: get access, connect the cortex VPN, then open the selected lab share. Lab and operating-system selectors show only relevant instructions. Troubleshooting and screenshots stay collapsed until requested.

Lab share mappings and OS-specific content are in `index.html`. Elements use `data-lab="michaels|other"` and `data-os="win|mac|linux"`. Selected lab and OS are stored only in the visitor's localStorage. Access email links prefill a request with empty username and supervisor fields; the site collects no credentials.

## Mac and Windows setup

`downloads/CortexCache-Mac-Setup/` and `downloads/CortexCache-Windows-Setup/`
contain readable installers and README instructions. Their matching ZIPs are
published downloads. Both prompt for a lab and support all three public shares.
Mac creates a per-user AppleScript launcher with optional Login Item registration.
Windows uses `net use` with a free drive letter and persistent mapping, without
saving passwords. Credential storage is left to the OS and the user. Neither
installer connects the VPN, changes server ACLs, or appends a username to Ma or
Schall share paths. Rebuild ZIPs after source changes, preserving the executable
bit on Setup.command and CRLF line endings on Setup.cmd. Do not run installers
as part of site validation; doing so changes the local user's configuration.

## Ubuntu installer

`downloads/Michaels-Projects-Setup.zip` includes the online dependency/VLC installer, share launcher and direct-server video integration. Source files are in the adjacent `Michaels-Projects-Setup/` directory.

## Public-site maintenance

This is public documentation. Keep credentials, real user lists, research data, management-console addresses and private handoff notes out of both the site and repository. Review screenshots and ZIP contents before publishing. The downloads contain readable source code and delegate password entry to the operating system.

Both HTML pages use a hash-based Content Security Policy and a no-referrer policy. After changing an inline script or stylesheet, regenerate its SHA-256 CSP hash before publishing; otherwise browsers will block it. The site uses no third-party scripts, analytics, credential forms or background network requests. Lab/OS preferences are stored locally in the browser. GitHub hosting can retain normal request logs.

Removed assets remain recoverable in Git history; deleting a file from the current site is not secret revocation. If credentials are ever published, revoke them and assess repository history separately.
