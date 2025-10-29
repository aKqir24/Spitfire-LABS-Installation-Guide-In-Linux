<h1 align="center">🎹 Install Spitfire LABS with Wine on Linux</h1>

Making music on older hardware can be challenging these days—especially with modern tools like Spitfire LABS requiring at least an Intel i5 or AMD Ryzen 5 CPU. Personally, I liked the older versions of LABS, where it didn’t rely on WebView2 for the interface. But things change, and with Microsoft planning to end support for Windows 10, I decided to switch to Linux (Debian 13) and set up LABS using Wine.

> [!important]
> 📝 **Tested on:** Debian 13 (likely works on Debian 12.11), Arch Linux, and Artix Linux...
> 
> 🧪 **DAW Used:** LMMS (not tested with Ardour or others)
>
> 
___

## ✅ Step 1 – Install Wine and Dependencies

Install `wine-stable` (Wine 10.0 or similar) and required dependencies.

```bash
sudo apt update || sudo pacman -Syu
sudo apt install wine || sudo pacman -S wine
````

* **Enable 32-bit architecture and install `wine32`** (Some actions require root access, not just sudo):

  ```bash
  # Debian / Ubuntu
  su  # log in as root
  dpkg --add-architecture i386
  apt update
  apt install wine32:i386
  exit
  ```

  ```bash
  # Arch / Artix
  sudo pacman -S lib32-wine
  ```

* **Install `winbind`** (required for WebView2 to avoid admin errors):

  ```bash
  # Debian / Ubuntu
  sudo apt install winbind

  # Arch / Artix
  sudo pacman -S winbind
  ```

* **Now Install a DAW**
  Make sure your DAW supports VST plugins through Wine — LMMS does.

  > **NOTE:**
  > *If you're using `lmms`, make sure it uses the **alpha version**, or VST plugins might not be supported in some stable releases. You can use **Pacstall** as an alternative installation method to install the alpha version of `lmms`.*

  ```bash
  # Debian / Ubuntu
  # If it is already in alpha (Which is likely not the case)
  sudo apt install lmms

  # Or use Pacstall to install LMMS
  sudo pacstall -I lmms-git
  ```

  ```bash
  # Arch / Artix
  sudo pacman -S lmms
  # Or install the Git version from AUR (alpha build)
  yay -S lmms-git
  ```

## 📦 Step 2 – Install Winetricks, VC++ Redistributable, .NET, and etc...

To some debian based distros, Winetricks may not be included by default. You can get the official `.deb` package from [Debian Packages](https://packages.debian.org/trixie/winetricks). If there are dependency issues, run:

```bash
# Debian / Ubuntu 
sudo apt --fix-broken install
```

* **Then install Winetricks and required components:**
  ```bash
  # Arch / Artix
  sudo pacman -S winetricks
  ```

  ```bash
  winetricks -q vcrun2015 dotnet472 dotnet48 corefonts gdiplus
  ```
  

### ⚙️ Step 3 – Setup WebView2 and Wine Configuration

* **Set Wine to Windows 7 mode (for WebView2 compatibility):**

  ```bash
  winecfg
  # In the GUI, set Windows Version to "Windows 7", then Apply and OK.
  ```

* **Download and install the WebView2 Runtime:**

  You can get it from the [official Microsoft page](https://developer.microsoft.com/en-us/microsoft-edge/webview2) or use this direct installer link:
  [WebView2 Evergreen Installer](https://go.microsoft.com/fwlink/p/?LinkId=2124703)

  > **WARNING:**
  > *Do not use the standalone installer, cause it will install the 136.x.x version of Webview2 where it will just crash after launching LABS...*

  ```bash
  wine ~/path/to/MicrosoftEdgeWebView2Setup.exe
  ```

## 🎨 Step 4 – Install Wine Graphics Packages (for rendering support)

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

***Then, Try running LMMS and loading the LABS VST. If it opens and displays properly, you’re good to go.***

## ℹ️  More Info

* **❌ If It Still Doesn't Work:**

  * You can try downgrading to an older version of LABS link [here](https://github.com/aKqir24/Spitfire-LABS-Installation-Guide-In-Linux/blob/main/LABS.dll.zip).

  ```bash
    # Well Your In Linux So Do This
    curl -0 https://github.com/aKqir24/Spitfire-LABS-Installation-Guide-In-Linux/raw/refs/heads/main/LABS.dll.zip
    # Or Use
    wget https://github.com/aKqir24/Spitfire-LABS-Installation-Guide-In-Linux/raw/refs/heads/main/LABS.dll.zip
  ```

  * Try **Wine 9.1** or **Wine-Staging**, but be aware it may be unstable.
  * Ensure your GPU drivers are working properly and that your Wine prefix is clean.

* **🔗 Sources:**

  * https://www.reddit.com/r/Lutris/comments/rpomzv/you_do_not_have_the_microsoft_webview2_runtime
  * https://bbs.archlinux.org/viewtopic.php?id=287582
  * https://forum.winehq.org/viewtopic.php?t=38443
