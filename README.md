# CortexCache connection guide

Interactive, single-page documentation for connecting to the NCC Lab's CortexCache network storage (`Michaels-Group` share) from macOS, Windows and Linux.

- `index.html` — the whole site (no build step, no dependencies)
- `img/` — screenshots used on the page

It consolidates the four Science IT HOWTO documents (VPN client, SMB on Windows / Mac / Linux) into one page with an OS picker, copy buttons, a progress checklist, troubleshooting and an access section.

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

Everything is plain HTML inside `index.html`. Useful anchors:

- Server/share values appear in the "Mount the share" and "Quick reference" cards — search for `cortexcache-data.nas.sci.yorku.ca`.
- OS-specific blocks are `<div class="os-only mac|win|linux">`.
- Troubleshooting entries are `<details>` blocks; add a new one by copying an existing block.
- The access section names Jonathan as the contact; change the `mailto:` link if that changes.

Checklist progress and the OS choice are stored in each visitor's own browser (localStorage); nothing is sent anywhere.
