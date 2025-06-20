# 🎹 Install Spitfire LABS with Wine on Linux

Making music on older hardware can be challenging these days—especially with modern tools like Spitfire LABS requiring at least an Intel i5 or AMD Ryzen 5 CPU. Personally, I liked the older versions of LABS, where it didn’t rely on WebView2 for the interface. But things change, and with Microsoft planning to end support for Windows 10, I decided to switch to Linux (Debian 13) and set up LABS using Wine.

> 📝 Tested on: Debian 13 (likely works on Debian 12.11), Arch Linux, and Artix Linux
> 🧪 DAW Used: LMMS (not tested with Ardour or others)

---

## For Debian 13
### ✅ Step 1 – Install Wine and Dependencies

Install `wine-stable` (Wine 10.0 or similar) and required dependencies.

```bash
sudo apt update
sudo apt install wine
```

#### Enable 32-bit architecture and install `wine32`:

(Some actions require root access, not just sudo)

```bash
su  # log in as root
dpkg --add-architecture i386
apt update
apt install wine32:i386
exit
```

#### Install `winbind` (required for WebView2 to avoid admin errors):

```bash
sudo apt install winbind
```

---

### 📦 Step 2 – Install Winetricks, VC++ Redistributable, and .NET

Winetricks may not be included by default on some systems. You can get the official `.deb` package from [Debian Packages](https://packages.debian.org/trixie/winetricks). If there are dependency issues, run:

```bash
sudo apt --fix-broken install
```

Then install Winetricks and required components:

```bash
sudo apt install winetricks
winetricks -q vcrun2015 dotnet472
```

---

### ⚙️ Step 3 – Setup WebView2 and Wine Configuration

#### Set Wine to Windows 7 mode (for WebView2 compatibility):

```bash
winecfg
# In the GUI, set Windows Version to "Windows 7", then Apply and OK.
```

#### Download and install the WebView2 Runtime:

You can get it from the [official Microsoft page](https://developer.microsoft.com/en-us/microsoft-edge/webview2) or use this direct installer link:
[WebView2 Evergreen Installer](https://go.microsoft.com/fwlink/p/?LinkId=2124703)

```bash
wine ~/path/to/MicrosoftEdgeWebView2Setup.exe
```

---

### 🎛️ Step 4 – Install Your DAW (e.g., LMMS)

Make sure your DAW supports VST plugins through Wine. LMMS does.

```bash
sudo apt install lmms
```

---

### 🎨 Step 5 – Install Wine Graphics Packages (for rendering support)

Depending on your setup:

* **DirectX 10**:

  ```bash
  winetricks d3dx10
  ```

* **Vulkan (Recommended)**:

  ```bash
  winetricks dxvk
  ```

* **Optional**: Check your graphics capabilities:

  ```bash
  winetricks dxdiag
  ```

---

## 🧪 Final Step – Launch and Test!

Try running LMMS and loading the LABS VST. If it opens and displays properly, you’re good to go.

---

## ❌ If It Still Doesn't Work:

* You can try downgrading to an older version of LABS link [here](https://github.com/aKqir24/Spitfire-LABS-Installation-Guide-In-Linux/blob/main/LABS.dll.zip).
  ````bash
    # Well Your In Linux So Do This
    curl -0 https://github.com/aKqir24/Spitfire-LABS-Installation-Guide-In-Linux/raw/refs/heads/main/LABS.dll.zip
    # Or Use
    wget https://github.com/aKqir24/Spitfire-LABS-Installation-Guide-In-Linux/raw/refs/heads/main/LABS.dll.zip
  ````
* Try **Wine 9.1** or **Wine-Staging**, but be aware it may be unstable.
* Ensure your GPU drivers are working properly and that your Wine prefix is clean.

---

## 🔄 Notes on Arch / Artix Linux

Still working on a detailed guide for Arch-based distros. Setup is similar, but package names and version handling can differ. Stay tuned!

---
