<h1 align="center">🎹 Spitfire LABS — Linux Installation Guide</h1>

<p align="center">
  A step-by-step guide to installing Spitfire LABS VST on Linux using Wine.<br>
  Tested on <b>Debian 13</b>, <b>Debian 12.11</b>, <b>Devuan</b>, <b>Arch Linux</b>, and <b>Artix Linux</b>.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/DAW-LMMS%201.3.0--alpha-blue" alt="DAW">
  <img src="https://img.shields.io/badge/Wine-10.0%20%7C%2011.1--staging-orange" alt="Wine">
  <img src="https://img.shields.io/badge/Status-Works%20%F0%9F%8E%A8-brightgreen" alt="Status">
</p>

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Step 1 — Install Wine and Dependencies](#step-1--install-wine-and-dependencies)
- [Step 2 — Install Winetricks and Runtime Components](#step-2--install-winetricks-and-runtime-components)
- [Step 3 — Configure Wine and Install WebView2](#step-3--configure-wine-and-install-webview2)
- [Step 4 — Install Graphics Packages](#step-4--install-graphics-packages)
- [Step 5 — Install a DAW](#step-5--install-a-daw)
- [Troubleshooting](#troubleshooting)
- [Sources](#sources)

---

## Prerequisites

| Requirement | Details |
|---|---|
| **OS** | Debian 13 (or 12.11), Arch Linux, or Artix Linux |
| **Wine** | wine-stable 10.0+ or wine-staging 11.1+ |
| **DAW** | LMMS 1.3.0-alpha (VST support required) |
| **GPU** | Any GPU with working Linux drivers |

> [!NOTE]
> wine-staging 11.1+ is recommended as it fixes [#56378](https://bugs.winehq.org/show_bug.cgi?id=56378), which is required for WebView2 compatibility.

---

## Step 1 — Install Wine and Dependencies

### 1.1 Add the WineHQ Repository

**Debian / Ubuntu:**

```bash
sudo mkdir -pm755 /etc/apt/keyrings
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -
```

**Arch / Artix:**

```bash
sudo pacman -S yay
```

### 1.2 Install Wine

```bash
# Update package lists
sudo apt update || sudo pacman -Syu

# Install wine-stable
sudo apt install wine || sudo pacman -S wine
```

<details>
<summary><b>Or install wine-staging (recommended)</b></summary>

**Debian / Ubuntu:**

```bash
sudo apt install --install-recommends winehq-staging
```

**Arch / Artix:**

```bash
sudo pacman -S wine-staging
yay -S wine-staging  # If using AUR
```

</details>

### 1.3 Enable 32-bit Architecture

> [!IMPORTANT]
> Skip this step if you installed wine-staging.

**Debian / Ubuntu** (requires root, not just sudo):

```bash
su
dpkg --add-architecture i386
apt update
apt install wine32:i386
exit
```

**Arch / Artix:**

```bash
sudo pacman -S lib32-wine
```

### 1.4 Install Winbind

Required for WebView2 to avoid admin errors.

```bash
sudo apt install winbind       # Debian / Ubuntu
sudo pacman -S winbind         # Arch / Artix
```

---

## Step 2 — Install Winetricks and Runtime Components

### 2.1 Install Winetricks

```bash
sudo apt install winetricks              # Debian / Ubuntu
sudo pacstall -I winetricks-git          # Debian / Ubuntu (alternative)
sudo pacman -S winetricks                # Arch / Artix
```

> [!TIP]
> If winetricks is not available in your repos, download the `.deb` from [Debian Packages](https://packages.debian.org/trixie/winetricks) and run `sudo apt --fix-broken install` if there are dependency issues.

### 2.2 Install Required Components

```bash
winetricks -q vcrun2019 dotnet472 dotnet48 corefonts gdiplus msxml6 iertutil
```

| Component | Purpose |
|---|---|
| `vcrun2019` | Visual C++ 2019 Redistributable |
| `dotnet472` / `dotnet48` | .NET Framework runtime |
| `corefonts` | Microsoft core fonts |
| `gdiplus` | GDI+ graphics library |
| `msxml6` | MSXML 6.0 parser |
| `iertutil` | Internet Explorer runtime utilities |

---

## Step 3 — Configure Wine and Install WebView2

### 3.1 Set Windows Version

```bash
winecfg
```

In the GUI, set **Windows Version** to **Windows 7**, then click **Apply** → **OK**.

### 3.2 Install WebView2

Download the [WebView2 Evergreen Bootstrapper](https://go.microsoft.com/fwlink/p/?LinkId=2124703) and install it:

```bash
wine ~/Downloads/MicrosoftEdgeWebView2Setup.exe
```

> [!WARNING]
> Do **not** use the standalone installer. It installs version 136.x.x which crashes when launching LABS. Always use the bootstrapper link above.

---

## Step 4 — Install Graphics Packages

Choose **one** of the following based on your GPU:

| Option | Command | Best For |
|---|---|---|
| **Vulkan** (recommended) | `winetricks dxvk` | Modern GPUs (NVIDIA, AMD) |
| **DirectX 10** | `winetricks d3dx10` | Older or Intel GPUs |

To check your graphics capabilities:

```bash
winetricks dxdiag
```

---

## Step 5 — Install a DAW

> [!IMPORTANT]
> Your DAW must support VST plugins through Wine. LMMS is recommended.

**Debian / Ubuntu:**

```bash
sudo apt install lmms                          # Stable (may lack VST support)
sudo pacstall -I lmms-git                      # Alpha (recommended)
```

**Arch / Artix:**

```bash
sudo pacman -S lmms                            # Stable
yay -S lmms-git                                # Alpha (recommended)
```

---

## Troubleshooting

### LABS Doesn't Open or Crashes

1. **Downgrade LABS** — Use the older [LABS.dll](https://github.com/aKqir24/Spitfire-LABS-Installation-Guide-In-Linux/blob/main/LABS.dll.zip):

   ```bash
   curl -O https://github.com/aKqir24/Spitfire-LABS-Installation-Guide-In-Linux/raw/refs/heads/main/LABS.dll.zip
   ```

2. **Try wine-staging** — If using wine-stable, switch to wine-staging (may be less stable).

3. **Check GPU drivers** — Ensure your drivers are up to date and your Wine prefix is clean:

   ```bash
   rm -rf ~/.wine
   wineboot --init
   ```

### Webview Cannot Be Installed even when it is not installed

Just go to `~/.wine/system.reg` of your wine folder, then open it in your IDE and
Search for `Webview`.

You should see lines like these, when you see it remove it and save the file.
This usually happens if you install the `Webview` in win10 or a much latest installer.
```txt

[Software\\Wow6432Node\\Microsoft\\EdgeUpdate\\Clients\\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}] 1785220019
#time=1dd1e5a189fca4e
"location"="C:\\Program Files (x86)\\Microsoft\\EdgeWebView\\Application"
"name"="Microsoft Edge WebView2 Runtime"
"pv"="109.0.1518.140"
"SilentUninstall"="\"C:\\Program Files (x86)\\Microsoft\\EdgeWebView\\Application\\109.0.1518.140\\Installer\\setup.exe\" --force-uninstall --uninstall --msedgewebview --system-level --verbose-logging"

```

---

## Sources

- [Wine + WebView2 — Reddit / Lutris](https://www.reddit.com/r/Lutris/comments/rpomzv/you_do_not_have_the_microsoft_webview2_runtime)
- [Wine + WebView2 — Arch Linux Forums](https://bbs.archlinux.org/viewtopic.php?id=287582)
- [WineHQ Forum — WebView2 Discussion](https://forum.winehq.org/viewtopic.php?t=38443)
