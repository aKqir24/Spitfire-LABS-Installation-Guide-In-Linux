<main class="responsive max">

  <h1 class="center-align">🎹 Spitfire LABS — Linux Installation Guide</h1>

  <p class="center-align">
    A step-by-step guide to installing Spitfire LABS VST on Linux using Wine.<br>
    Tested on <b>Debian 13</b>, <b>Debian 12.11</b>, <b>Devuan</b>, <b>Arch Linux</b>, and <b>Artix Linux</b>.
  </p>

  <p class="center-align">
    <img src="https://img.shields.io/badge/DAW-LMMS%201.3.0--alpha-blue" alt="DAW">
    <img src="https://img.shields.io/badge/Wine-10.0%20%7C%2011.1--staging-orange" alt="Wine">
    <img src="https://img.shields.io/badge/Status-Works%20%F0%9F%8E%A8-brightgreen" alt="Status">
  </p>

  <div class="space"></div>
  <hr class="divider">
  <div class="space"></div>

  <article class="border round padding">
    <h2>Table of Contents</h2>
    <ul>
      <li><a href="#prerequisites">Prerequisites</a></li>
      <li><a href="#step-1--install-wine-and-dependencies">Step 1 — Install Wine and Dependencies</a></li>
      <li><a href="#step-2--install-winetricks-and-runtime-components">Step 2 — Install Winetricks and Runtime Components</a></li>
      <li><a href="#step-3--configure-wine-and-install-webview2">Step 3 — Configure Wine and Install WebView2</a></li>
      <li><a href="#step-4--install-graphics-packages">Step 4 — Install Graphics Packages</a></li>
      <li><a href="#step-5--install-a-daw">Step 5 — Install a DAW</a></li>
      <li><a href="#troubleshooting">Troubleshooting</a></li>
      <li><a href="#sources">Sources</a></li>
    </ul>
  </article>

  <div class="space"></div>
  <hr class="divider">
  <div class="space"></div>

  <h2 id="prerequisites">Prerequisites</h2>

  <table class="border stripes">
    <thead>
      <tr>
        <th>Requirement</th>
        <th>Details</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><b>OS</b></td>
        <td>Debian 13 (or 12.11), Arch Linux, or Artix Linux</td>
      </tr>
      <tr>
        <td><b>Wine</b></td>
        <td>wine-stable 10.0+ or wine-staging 11.1+</td>
      </tr>
      <tr>
        <td><b>DAW</b></td>
        <td>LMMS 1.3.0-alpha (VST support required)</td>
      </tr>
      <tr>
        <td><b>GPU</b></td>
        <td>Any GPU with working Linux drivers</td>
      </tr>
    </tbody>
  </table>

  <blockquote class="border round padding">
    <b>NOTE:</b>
    wine-staging 11.1+ is recommended as it fixes
    <a href="https://bugs.winehq.org/show_bug.cgi?id=56378">#56378</a>, which is required for WebView2 compatibility.
  </blockquote>

  <div class="space"></div>
  <hr class="divider">
  <div class="space"></div>

  <h2 id="step-1--install-wine-and-dependencies">Step 1 — Install Wine and Dependencies</h2>

  <h3>1.1 Add the WineHQ Repository</h3>

  <p><b>Debian / Ubuntu:</b></p>

  <pre class="border round padding scroll"><code>sudo mkdir -pm755 /etc/apt/keyrings
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -</code></pre>

  <p><b>Arch / Artix:</b></p>

  <pre class="border round padding scroll"><code>sudo pacman -S yay</code></pre>

  <h3>1.2 Install Wine</h3>

  <pre class="border round padding scroll"><code># Update package lists
sudo apt update || sudo pacman -Syu

# Install wine-stable
sudo apt install wine || sudo pacman -S wine</code></pre>

  <details class="border round padding">
    <summary><b>Or install wine-staging (recommended)</b></summary>
    <div class="space"></div>
    <p><b>Debian / Ubuntu:</b></p>
    <pre class="border round padding scroll"><code>sudo apt install --install-recommends winehq-staging</code></pre>
    <p><b>Arch / Artix:</b></p>
    <pre class="border round padding scroll"><code>sudo pacman -S wine-staging
yay -S wine-staging  # If using AUR</code></pre>
  </details>

  <h3>1.3 Enable 32-bit Architecture</h3>

  <blockquote class="border round padding">
    <b>IMPORTANT:</b>
    Skip this step if you installed wine-staging.
  </blockquote>

  <p><b>Debian / Ubuntu</b> (requires root, not just sudo):</p>

  <pre class="border round padding scroll"><code>su
dpkg --add-architecture i386
apt update
apt install wine32:i386
exit</code></pre>

  <p><b>Arch / Artix:</b></p>

  <pre class="border round padding scroll"><code>sudo pacman -S lib32-wine</code></pre>

  <h3>1.4 Install Winbind</h3>

  <p>Required for WebView2 to avoid admin errors.</p>

  <pre class="border round padding scroll"><code>sudo apt install winbind       # Debian / Ubuntu
sudo pacman -S winbind         # Arch / Artix</code></pre>

  <div class="space"></div>
  <hr class="divider">
  <div class="space"></div>

  <h2 id="step-2--install-winetricks-and-runtime-components">Step 2 — Install Winetricks and Runtime Components</h2>

  <h3>2.1 Install Winetricks</h3>

  <pre class="border round padding scroll"><code>sudo apt install winetricks              # Debian / Ubuntu
sudo pacstall -I winetricks-git          # Debian / Ubuntu (alternative)
sudo pacman -S winetricks                # Arch / Artix</code></pre>

  <blockquote class="border round padding">
    <b>TIP:</b>
    If winetricks is not available in your repos, download the <code>.deb</code> from
    <a href="https://packages.debian.org/trixie/winetricks">Debian Packages</a> and run
    <code>sudo apt --fix-broken install</code> if there are dependency issues.
  </blockquote>

  <h3>2.2 Install Required Components</h3>

  <pre class="border round padding scroll"><code>winetricks -q vcrun2019 dotnet472 dotnet48 corefonts gdiplus msxml6 iertutil</code></pre>

  <table class="border stripes">
    <thead>
      <tr>
        <th>Component</th>
        <th>Purpose</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>vcrun2019</code></td>
        <td>Visual C++ 2019 Redistributable</td>
      </tr>
      <tr>
        <td><code>dotnet472</code> / <code>dotnet48</code></td>
        <td>.NET Framework runtime</td>
      </tr>
      <tr>
        <td><code>corefonts</code></td>
        <td>Microsoft core fonts</td>
      </tr>
      <tr>
        <td><code>gdiplus</code></td>
        <td>GDI+ graphics library</td>
      </tr>
      <tr>
        <td><code>msxml6</code></td>
        <td>MSXML 6.0 parser</td>
      </tr>
      <tr>
        <td><code>iertutil</code></td>
        <td>Internet Explorer runtime utilities</td>
      </tr>
    </tbody>
  </table>

  <div class="space"></div>
  <hr class="divider">
  <div class="space"></div>

  <h2 id="step-3--configure-wine-and-install-webview2">Step 3 — Configure Wine and Install WebView2</h2>

  <h3>3.1 Set Windows Version</h3>

  <pre class="border round padding scroll"><code>winecfg</code></pre>

  <p>In the GUI, set <b>Windows Version</b> to <b>Windows 7</b>, then click <b>Apply</b> → <b>OK</b>.</p>

  <h3>3.2 Install WebView2</h3>

  <p>Download the <a href="https://go.microsoft.com/fwlink/p/?LinkId=2124703">WebView2 Evergreen Bootstrapper</a> and install it:</p>

  <pre class="border round padding scroll"><code>wine ~/Downloads/MicrosoftEdgeWebView2Setup.exe</code></pre>

  <blockquote class="border round padding">
    <b>WARNING:</b>
    Do <b>not</b> use the standalone installer. It installs version 136.x.x which crashes when launching LABS. Always use the bootstrapper link above.
  </blockquote>

  <div class="space"></div>
  <hr class="divider">
  <div class="space"></div>

  <h2 id="step-4--install-graphics-packages">Step 4 — Install Graphics Packages</h2>

  <p>Choose <b>one</b> of the following based on your GPU:</p>

  <table class="border stripes">
    <thead>
      <tr>
        <th>Option</th>
        <th>Command</th>
        <th>Best For</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><b>Vulkan</b> (recommended)</td>
        <td><code>winetricks dxvk</code></td>
        <td>Modern GPUs (NVIDIA, AMD)</td>
      </tr>
      <tr>
        <td><b>DirectX 10</b></td>
        <td><code>winetricks d3dx10</code></td>
        <td>Older or Intel GPUs</td>
      </tr>
    </tbody>
  </table>

  <p>To check your graphics capabilities:</p>

  <pre class="border round padding scroll"><code>winetricks dxdiag</code></pre>

  <div class="space"></div>
  <hr class="divider">
  <div class="space"></div>

  <h2 id="step-5--install-a-daw">Step 5 — Install a DAW</h2>

  <blockquote class="border round padding">
    <b>IMPORTANT:</b>
    Your DAW must support VST plugins through Wine. LMMS is recommended.
  </blockquote>

  <p><b>Debian / Ubuntu:</b></p>

  <pre class="border round padding scroll"><code>sudo apt install lmms                          # Stable (may lack VST support)
sudo pacstall -I lmms-git                      # Alpha (recommended)</code></pre>

  <p><b>Arch / Artix:</b></p>

  <pre class="border round padding scroll"><code>sudo pacman -S lmms                            # Stable
yay -S lmms-git                                # Alpha (recommended)</code></pre>

  <div class="space"></div>
  <hr class="divider">
  <div class="space"></div>

  <h2 id="troubleshooting">Troubleshooting</h2>

  <h3>LABS Doesn't Open or Crashes</h3>

  <ol>
    <li>
      <b>Downgrade LABS</b> — Use the older
      <a href="https://github.com/aKqir24/Spitfire-LABS-Installation-Guide-In-Linux/blob/main/LABS.dll.zip">LABS.dll</a>:
      <pre class="border round padding scroll"><code>curl -O https://github.com/aKqir24/Spitfire-LABS-Installation-Guide-In-Linux/raw/refs/heads/main/LABS.dll.zip</code></pre>
    </li>
    <li>
      <b>Try wine-staging</b> — If using wine-stable, switch to wine-staging (may be less stable).
    </li>
    <li>
      <b>Check GPU drivers</b> — Ensure your drivers are up to date and your Wine prefix is clean:
      <pre class="border round padding scroll"><code>rm -rf ~/.wine
wineboot --init</code></pre>
    </li>
  </ol>

  <h3>Webview Cannot Be Installed even when it is not installed</h3>

  <p>Just go to <code>~/.wine/system.reg</code> of your wine folder, then open it in your IDE and
  Search for <code>Webview</code>.</p>

  <p>You should see lines like these, when you see it remove it and save the file.
  This usually happens if you install the <code>Webview</code> in win10 or a much latest installer.</p>

  <pre class="border round padding scroll"><code>[Software\\Wow6432Node\\Microsoft\\EdgeUpdate\\Clients\\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}] 1785220019
#time=1dd1e5a189fca4e
"location"="C:\\Program Files (x86)\\Microsoft\\EdgeWebView\\Application"
"name"="Microsoft Edge WebView2 Runtime"
"pv"="109.0.1518.140"
"SilentUninstall"="\"C:\\Program Files (x86)\\Microsoft\\EdgeWebView\\Application\\109.0.1518.140\\Installer\\setup.exe\" --force-uninstall --uninstall --msedgewebview --system-level --verbose-logging"</code></pre>

  <div class="space"></div>
  <hr class="divider">
  <div class="space"></div>

  <h2 id="sources">Sources</h2>

  <ul>
    <li><a href="https://www.reddit.com/r/Lutris/comments/rpomzv/you_do_not_have_the_microsoft_webview2_runtime">Wine + WebView2 — Reddit / Lutris</a></li>
    <li><a href="https://bbs.archlinux.org/viewtopic.php?id=287582">Wine + WebView2 — Arch Linux Forums</a></li>
    <li><a href="https://forum.winehq.org/viewtopic.php?t=38443">WineHQ Forum — WebView2 Discussion</a></li>
  </ul>

</main>
