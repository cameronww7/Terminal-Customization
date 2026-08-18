# WSL2 + Fedora Setup Wiki

Reference for setting up WSL2 with Fedora on Windows 11: firmware prerequisite, Windows feature enablement, distro install, and a config/tooling setup ordered to get a working, low-friction daily-driver environment as fast as possible.

Windows-side commands that need an elevated PowerShell window are flagged with the banner below, placed directly above the command. Any PowerShell block without this banner runs fine in a normal, non-elevated window. Linux commands need no separate marker since `sudo` is already visible inline wherever it's actually required.

```
================================
   ADMIN POWERSHELL REQUIRED
================================
```

---

## 1. Verify Hardware Virtualization Support

```powershell
Get-ComputerInfo -Property "HyperVRequirementVirtualizationFirmwareEnabled"
```

If the result above is `False`, reboot into BIOS/UEFI and enable virtualization (Intel: VT-x, AMD: AMD-V), then re-run the check to confirm `True`.

If you already run VirtualBox: current versions coexist fine with WSL2's hypervisor. If an old VM stops starting after step 2, update VirtualBox.

---

## 2. Enable Required Windows Features & Install WSL2

WSL2 depends on two Windows optional features:

- **Windows Subsystem for Linux**
- **Virtual Machine Platform**

You don't need to enable these manually, the install command below turns both on for you. This is just so you know what's happening under the hood.

Three of the commands in this section toggle system-level Windows features or update the WSL kernel package, and need elevation. The rest are plain per-user config and run fine in a normal window. It's still reasonable to just do this whole section in one elevated PowerShell to avoid switching windows, the banners below are there so you know exactly which ones actually require it and which don't.

### Install WSL2 (without a default distro yet)

```
================================
   ADMIN POWERSHELL REQUIRED
================================
```

```powershell
wsl --install --no-distribution
```

This enables both Windows features, installs the WSL2 kernel, and sets WSL2 as the default version. Restart Windows if prompted.

### Confirm the features are actually on

```
================================
   ADMIN POWERSHELL REQUIRED
================================
```

```powershell
Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
```

Both should report `State : Enabled`.

### Explicitly set WSL2 as default

No elevation needed, this is a per-user setting. `wsl --install` sets it already, but confirm it directly so a future distro install doesn't silently land on WSL1:

```powershell
wsl --set-default-version 2
```

### Update to the latest kernel

```
================================
   ADMIN POWERSHELL REQUIRED
================================
```

```powershell
wsl --update
```

Then, back in a normal (non-elevated) window is fine:

```powershell
wsl --version
```

`wsl --version` should print a version block. If it errors, the install above didn't take. Re-run `wsl --install --no-distribution` (elevated) and reboot.

---

## 3. Install Fedora

Fedora is an officially published WSL distro (Fedora Project via Microsoft's WSL tar image format), installable directly through the WSL CLI, no third-party image needed.

Check the current release name (this rolls forward as Fedora ships new versions, so don't hardcode a number from memory):

```powershell
wsl --list --online
```

Look for an entry like `FedoraLinux-44`. Install it:

```powershell
wsl --install FedoraLinux-44
```

If the download hangs at 0%:

```powershell
wsl --install --web-download FedoraLinux-44
```

Once the download finishes, `wsl --install` launches straight into Fedora and prompts you to create a UNIX username and password on the spot, there's no separate launch step. That user is added to the `wheel` group (sudo-equivalent) automatically.

If you ever need to relaunch it later (closing the window doesn't uninstall anything):

```powershell
wsl -d FedoraLinux-44
```

### Verify it's running as WSL2

```powershell
wsl --list --verbose
```

Confirm `VERSION` shows `2`. If it shows `1`:

```powershell
wsl --set-version FedoraLinux-44 2
```

### Make it your default distro (optional, if you'll run more than one)

```powershell
wsl --set-default FedoraLinux-44
```

Confirm it took. `wsl --list --verbose` marks the default distro with a `*` next to its name:

```powershell
wsl --list --verbose
```

```
  NAME            STATE           VERSION
* FedoraLinux-44  Stopped         2
  Ubuntu          Stopped         2
```

With this set, running plain `wsl` from PowerShell or Windows Terminal launches Fedora without needing `-d FedoraLinux-44` every time.

---

## 4. Configure for Seamless Windows ↔ Linux Integration

WSL2 runs as a real, lightweight Linux VM sitting next to Windows rather than translating Linux syscalls in place (that was WSL1's approach). That's what makes it fast and genuinely compatible, but it also means Windows and Linux start out as two separate machines: separate network stack, separate DNS resolution, separate PATH, separate clipboard, unless you configure the boundary between them.

Skip this step and you'll hit it constantly: a server running inside Fedora that a Windows browser can't reach, DNS that breaks the moment a VPN connects, `code .` doing nothing because Linux can't see the Windows binary, or `dnf`/`npm` crawling because every file write gets intercepted by antivirus scanning. None of that is inherent to WSL2, it's just what happens when the two sides are left on their defaults.

This step closes that gap across two layers, one file per side of the boundary:

### 4.1 `.wslconfig`: Windows side, controls the WSL2 VM globally

This file lives on the Windows side and configures the WSL2 virtual machine itself, meaning every setting here applies across all distros you run, not just Fedora. It's the layer responsible for how WSL behaves as a network citizen on your machine: whether a service running inside Linux is reachable from Windows, whether DNS keeps working when a VPN connects, and how much of your system's memory the VM is allowed to sit on.

**Where it lives and how to open it:**

The file is `.wslconfig` directly inside your Windows user folder (`C:\Users\YourName\.wslconfig`), not inside any WSL distro. It doesn't exist yet on a fresh setup, you're creating it.

Fastest way, no File Explorer needed:

1. Press `Win + R` to open the Run box.
2. Type exactly:
   ```
   notepad "%USERPROFILE%\.wslconfig"
   ```
3. Press Enter. Notepad will pop up a dialog asking "Do you want to create a new file?", click **Yes**.

If you'd rather navigate there yourself in File Explorer instead: press `Win + R`, type `%USERPROFILE%`, press Enter, this drops you straight into your user folder. Create a new file there named exactly `.wslconfig` (right-click → New → Text Document, then rename it). Make sure File Explorer isn't hiding the extension on you: View menu → check "File name extensions", otherwise you can end up with `.wslconfig.txt` by accident.

Paste the config below into whichever editor you used, then save:

```ini
[wsl2]
# Mirrored networking (Win11 22H2+): WSL shares the same network identity as
# Windows. A server you start inside Fedora is reachable from Windows at
# localhost, and vice versa. No port proxying, no separate WSL IP to track.
networkingMode=mirrored

# Resolves DNS through the Windows resolver, so corporate VPN / split-DNS
# setups work inside WSL the same way they work in Windows.
dnsTunneling=true
firewall=true
autoProxy=true

# Skip the Windows-side swap file; not needed unless you're memory constrained.
swap=0

[experimental]
# Returns idle memory back to Windows instead of holding onto it indefinitely.
autoMemoryReclaim=gradual
# VHDX only grows to the size of data actually written, not pre-allocated.
sparseVhd=true
```

Apply with a full shutdown. This file is not hot-reloaded:

```powershell
wsl --shutdown
```

Relaunch Fedora after.

### 4.2 `/etc/wsl.conf`: Linux side, per-distro behavior

This file lives inside Fedora and controls how that specific distro boots and behaves. Where `.wslconfig` handles the VM as a whole, this handles the day-to-day mechanics of actually using Fedora as a dev environment: whether systemd is available so services behave normally, whether Windows binaries are callable from the Linux shell so `code .` and similar commands work, and how the Windows drives get mounted underneath `/mnt`.

**Where it lives and how to open it:**

This file is on the Linux side, at `/etc/wsl.conf`. It is not a Windows path and won't show up under `C:\`, you have to be inside the Fedora shell to reach it, not a Windows PowerShell/Terminal window. If you're not already in it:

```powershell
wsl -d FedoraLinux-44
```

(or just open Fedora from the Start menu). Once you're at a Fedora prompt (it'll look like `yourname@hostname:~$`, not PowerShell's `PS C:\>`), open the file with `nano`, a terminal text editor:

```bash
sudo nano /etc/wsl.conf
```

It likely doesn't exist yet either, `nano` will just open a blank file, that's expected. Paste the config below in. When you're done editing in `nano`: `Ctrl+O` then `Enter` to save, `Ctrl+X` to exit.

```ini
[boot]
# Runs systemd as PID 1. Fedora's tooling and most of its package ecosystem
# assumes systemd is running, and this isn't optional the way it might be
# on a more minimal distro.
systemd=true

[network]
generateResolvConf = true
generateHosts = true

[interop]
# Lets you call Windows binaries from inside the Linux shell. This is what
# makes `code .` launch Windows-side VS Code from a WSL terminal, and what
# lets `explorer.exe .` or `clip.exe` work.
enabled = true
# Keeping Windows PATH out of Linux PATH avoids shadowing issues (e.g. a
# Windows-side git or python silently taking priority over the Linux one).
appendWindowsPath = false

[user]
default = [REPLEASE WITH Fedora your_username]

[automount]
enabled = true
root = /mnt/
options = "metadata,uid=1000,gid=1000,umask=022,fmask=022,dmask=022"
mountFsTab = true
```

Replace `your_username` with the UNIX username you created in step 3.

`wsl --shutdown` again (from a Windows PowerShell window), relaunch Fedora, then confirm systemd actually took:

```bash
ps -p 1 -o comm=
# should print: systemd
```

---

## 5. Windows Defender Exclusions

Do this now, before installing packages. Defender scanning the WSL virtual disk on every write is what makes `dnf upgrade`, `git clone`, and `npm install` crawl. Excluding it after the fact just means you eat the slow performance during initial setup for no reason.

Find the exact Fedora package folder name (no elevation needed, this just lists a folder in your own profile):

```powershell
Get-ChildItem "$env:LOCALAPPDATA\Packages" | Where-Object { $_.Name -match "Fedora" }
```

Add these to Windows Security → Virus & Threat Protection → Manage Settings → Exclusions. This is a GUI step, not a shell command, but Windows Security will prompt you for admin approval (UAC) the first time you open the exclusions panel:

- `%USERPROFILE%\AppData\Local\Packages\<the Fedora folder from above>\LocalState\ext4.vhdx`
- `%USERPROFILE%\.vscode-server`

---

## 6. Base Package Installation

Fedora uses `dnf`, not `apt`.

```bash
sudo dnf upgrade -y
sudo dnf install -y @development-tools git curl wget unzip tar \
    dnf-plugins-core \
    python3 python3-pip \
    nodejs npm \
    zsh tmux neovim htop
```

`git`, `curl`, and `nodejs`/`npm` here aren't arbitrary. They're what the next few steps (VS Code Remote, Claude Code, git-based workflows) depend on.

---

## 7. Filesystem Convention

Before you start cloning things: keep project directories inside the Linux filesystem (e.g. `~/projects/`), not under `/mnt/c/...`. Files under `/mnt/c` are accessed through a translation layer and are noticeably slower for anything metadata-heavy: `git status`, `npm install`, file-watch-heavy tooling. Since VS Code Remote-WSL edits files directly on the Linux side (next step), there's no real reason to keep anything under `/mnt/c` once you're set up.

```bash
mkdir -p ~/projects
```

---

## 8. VS Code Remote-WSL

This is the primary way you'll be working, so get it right.

On the **Windows** side, install the extension:

- `ms-vscode-remote.remote-wsl`

From inside your Fedora terminal, in a project directory:

```bash
cd ~/projects/some-project
code .
```

This launches Windows-side VS Code but runs the actual VS Code Server inside Fedora: file access, terminal, and any language tooling all run on the Linux side. Install language/tooling extensions (Python, ESLint, etc.) *from inside* that remote window, extensions installed in a normal Windows-side VS Code window don't carry over to the WSL remote session.

### Increase the file watcher limit

Large repos routinely blow past Linux's default inotify watch limit, which shows up in VS Code as `ENOSPC: System limit for number of file watchers reached`. Fix it once:

```bash
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

---

## 9. Claude Code CLI

Native installer, no Node dependency, runs inside the Fedora shell:

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Don't run this with `sudo`. It installs into your home directory (`~/.local/bin`) by design, and running as root will install it somewhere your normal user can't reach or update.

If `claude` isn't found after install, your shell's PATH is missing `~/.local/bin`:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Verify:

```bash
claude --version
```

Fedora also has a native `dnf` repo for this if you'd rather it live in your normal package-manager update flow instead of self-updating in the background. Worth it if you specifically want `dnf upgrade` to be the one place you check for updates, otherwise the native installer above is simpler and is what most people should default to.

---

## 10. Git Identity & SSH Key

You'll want this set up before you're pushing scripts or tooling anywhere.

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main
git config --global core.autocrlf input
```

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```

Add the printed public key to GitHub/GitLab under SSH keys.

---

## 11. Docker

Why bother: it gives you an isolated, reproducible place to build and run things without leaving state on your host system or fighting dependency conflicts between projects.

Preferred approach: **Docker Desktop for Windows** with the WSL2 backend, rather than a Docker daemon installed directly inside Fedora:

1. Install Docker Desktop on Windows, with "Use WSL 2 instead of Hyper-V" checked during setup.
2. Docker Desktop → Settings → Resources → WSL Integration → enable integration for your Fedora distro.
3. From inside Fedora:

```bash
docker version
docker run --rm hello-world
```

If you specifically want a native daemon running inside WSL instead (no Docker Desktop):

```bash
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
```

(Requires `systemd=true` from step 4.2, since it's managed as a systemd service.) Log out and back into the distro for the group change to apply.

---

## 12. Flatpak (optional, skip unless you need it)

Flatpak isn't in the base Fedora WSL image. It's for running Linux GUI apps through WSLg. If your workflow is terminal + VS Code Remote, you likely don't need this at all, only install it if you specifically want a GUI Linux application running inside WSL.

```bash
sudo dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

---

## 13. Other Things Worth Knowing

- **Windows Terminal** ships by default on Windows 11 and is the better place to run your Fedora sessions than the legacy console host: tabs, better copy/paste behavior, GPU-accelerated rendering. If you want a Nerd Font for a nicer prompt (Starship, Oh My Zsh, etc.), install one (e.g. `winget install DEVCOM.JetBrainsMonoNerdFont`) and set it in the Fedora profile under Windows Terminal settings.
- **Clipboard**: basic copy/paste between Windows and the Fedora terminal works out of the box through WSL interop. If you use Neovim/Vim and want the `+`/`*` registers to reach the Windows clipboard specifically, you'll still need a small bridge like `win32yank`. Plain terminal copy/paste doesn't need it.
- **Raw sockets / packet-level tools**: WSL2 runs a real Linux kernel (not a syscall-translation layer like WSL1), so tools that need raw socket access, like `nmap`, `tcpdump`, and `scapy`, work natively without the workarounds WSL1 required.

---

## 14. Troubleshooting

| Symptom | Fix |
|---|---|
| `wsl --install` prints help text instead of installing | You're likely on an older Windows build. Confirm with `wsl --list --online`, then explicitly `wsl --install -d FedoraLinux-44` |
| Install hangs at 0% | `wsl --install --web-download -d FedoraLinux-44` |
| `wsl --status` shows a kernel mismatch | `wsl --update` then `wsl --shutdown` |
| DNS broken / VPN conflicts inside WSL | Confirm `networkingMode=mirrored` and `dnsTunneling=true` in `.wslconfig`, then `wsl --shutdown` |
| `systemctl` says "System has not been booted with systemd" | `systemd=true` isn't set or didn't take. Check `/etc/wsl.conf`, then `wsl --shutdown` and relaunch |
| Docker daemon unreachable | If using Docker Desktop: confirm WSL integration is toggled on for the Fedora distro in Docker Desktop settings |
| `dnf` fails on network calls | Check `generateResolvConf=true` in `wsl.conf`; `cat /etc/resolv.conf` inside the distro to confirm a nameserver is present |
| VS Code: `ENOSPC` file watcher error | Apply the `fs.inotify.max_user_watches` fix in step 8 |
| GUI app / WSLg won't launch | `wsl --update`, update GPU drivers on the Windows host, check `echo $DISPLAY` returns something inside the distro |

---

## 15. Quick Reference

```powershell
wsl --list --online                 # see installable distros
wsl --list --verbose                # see installed distros and their WSL version
wsl --install FedoraLinux-44        # install a specific distro
wsl -d FedoraLinux-44               # launch a specific distro
wsl --set-default FedoraLinux-44    # make it the default `wsl` target
wsl --shutdown                      # full VM shutdown, needed after .wslconfig/wsl.conf edits
wsl --update                        # update the WSL2 kernel
wsl --unregister FedoraLinux-44     # nuke the distro entirely (destructive)
```
