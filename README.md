<main class="max">
        <div style="padding: 50px;" class="medium-space grid">
            <div align="center" class="s12">
              <h1 class="heading medium bold">🎹 Spitfire LABS</h1>
              <h4 class="heading small">Linux Installation Guide (<a class="link" href="https://akqir24.github.io/Spitfire-LABS-Installation-Guide-In-Linux/">Check Out In Website</a>)</h4>
              <p>
                A step-by-step guide to installing Spitfire LABS VST on Linux using Wine.<br>
                Tested on <b>Debian 13</b>, <b>Debian 12.11</b>, <b>Devuan</b>, <b>Arch Linux</b>, and <b>Artix Linux</b>.
              </p>
              <p>
                <img src="https://img.shields.io/badge/DAW-LMMS%201.3.0--alpha-blue" alt="DAW">
                <img src="https://img.shields.io/badge/Wine-10.0%20%7C%2011.1--staging-orange" alt="Wine">
                <img src="https://img.shields.io/badge/Status-Works%20%F0%9F%8E%A8-brightgreen" alt="Status">
              </p>
            </div>
        </div>
      <h3 class="medium bold" id="prerequisites">Prerequisites</h3>
      <div class="space"></div>
      <hr class="divider">
      <div class="space"></div>
      <table class="border center-align stripes surface-container">
        <thead>
            <tr style="background-color: var(--surface-container-high);">
                <th class="bold" style="color: var(--primary);">Requirement</th>
                <th class="bold" style="color: var(--primary);">Details</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="bold">OS</td>
                <td>Debian 13 (or 12.11), Arch Linux, or Artix Linux</td>
            </tr>
            <tr>
                <td class="bold">Wine</td>
                <td>wine-stable 10.0+ or wine-staging 11.1+</td>
            </tr>
            <tr>
                <td class="bold">DAW</td>
                <td>LMMS 1.3.0-alpha (VST support required)</td>
            </tr>
            <tr>
                <td class="bold">GPU</td>
                <td>Any GPU with working Linux drivers</td>
            </tr>
        </tbody>
    </table>
      <blockquote><span class="large bold"><b>NOTE</b></span>
        <br><p>wine-staging 11.1+ is recommended as it fixes <a class="link" href="https://bugs.winehq.org/show_bug.cgi?id=56378">#56378</a>, which is required for WebView2 compatibility.</p>
      </blockquote>
      <div class="space"></div>
      <h3 id="steps" class="heading medium bold">Installation Steps</h3>
      <div class="space"></div>
      <hr class="divider">
      <div class="space"></div>
      <p>Now every thing you should know is setup, you can now let us proceed to the actual steps.</p>
      <div class="space"></div>
      <h4 class="heading small bold" id="install-wine-and-dependencies">1. Install Wine and Dependencies</h4>
      <ul>
        <h5 class="heading small bold">Add the WineHQ Repository</h5>
        <p><b>Debian / Ubuntu:</b></p>
        <pre class="round padding scroll surface-container"><code>sudo mkdir -pm755 /etc/apt/keyrings
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -</code></pre>
        <p><b>Arch / Artix:</b></p>
        <pre class="border round padding scroll"><code>sudo pacman -S yay</code></pre>
        <h5 class="heading small bold">Install Wine</h5>
        <pre class="border round padding scroll"><code>sudo apt update || sudo pacman -Syu      # Update package lists
sudo apt install wine || sudo pacman -S wine        # Install wine-stable</code></pre>
        <details style="border-radius: 16px;" class="small-padding primary">
          <summary>
            <button>
                <span><b>Or install wine-staging (recommended)</b></span>
            </button>
          </summary>
          <div class="small-padding">
            <p><b>Debian / Ubuntu:</b></p>
            <pre class="border round padding scroll"><code>sudo apt install --install-recommends winehq-staging</code></pre>
            <p><b>Arch / Artix:</b></p>
            <pre class="border round padding scroll"><code>sudo pacman -S wine-staging
    yay -S wine-staging  # If using AUR</code></pre>
        </div>
        </details>
      <h5 class="heading small bold">Enable 32-bit Architecture</h5>
      <p><b>Debian / Ubuntu</b> (requires root, not just sudo):</p>
      <pre class="border round padding scroll"><code>su
dpkg --add-architecture i386
apt update
apt install wine32:i386
exit</code></pre>
      <p><b>Arch / Artix:</b></p>
      <pre class="border round padding scroll"><code>sudo pacman -S lib32-wine</code></pre>
      <h5 class="heading small bold">Install Winbind</h5>
      <p>Required for WebView2 to avoid admin errors.</p>
      <pre class="border round padding scroll"><code>sudo apt install winbind       # Debian / Ubuntu
sudo pacman -S winbind         # Arch / Artix</code></pre>
    </ul>
      <div class="space"></div>
      <div class="space"></div>
      <h4 class="heading small bold" id="install-winetricks-and-runtime-components">2. Install Winetricks and Runtime Components</h4>
      <div class="space"></div>
      <ul>
        <h5 class="heading small bold">Install Winetricks</h5>
        <pre class="border round padding scroll"><code>sudo apt install winetricks           # Debian / Ubuntu
sudo pacstall -I winetricks-git       # Debian / Ubuntu (alternative)
sudo pacman -S winetricks             # Arch / Artix</code></pre>
        <blockquote><span class="large bold"><b>TIP</b></span>
          <br><p>If winetricks is not available in your repos, download the <code>.deb</code> from <a class="link" href="https://packages.debian.org/trixie/winetricks">Debian Packages</a> and run
          <code>sudo apt --fix-broken install</code> if there are dependency issues.</p>
        </blockquote>
        <div class="space"></div>
        <h5 class="heading small bold">Install Required Components</h3>
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
      </ul>
      <div class="space"></div>
      <div class="space"></div>
      <h4 class="heading small bold" id="configure-wine-and-install-webview2">3. Configure Wine and Install WebView2</h4>
      <ul>
        <h5 class="heading small bold">Set Windows Version</h5>
        <pre class="border round padding scroll"><code>winecfg</code></pre>
        <p>In the GUI, set <b>Windows Version</b> to <b>Windows 7</b>, then click <b>Apply</b> → <b>OK</b>.</p>
        <h5 class="heading small bold">Install WebView2</h3>
        <p>Download the <a class="link" href="https://go.microsoft.com/fwlink/p/?LinkId=2124703">WebView2 Evergreen Bootstrapper</a> and install it:</p>
        <pre class="border round padding scroll"><code>wine ~/Downloads/MicrosoftEdgeWebView2Setup.exe</code></pre>
        <blockquote><span class="large bold"><b>WARNING</b></span>
            <br><p>Do <b>not</b> use the standalone installer. It installs version 136.x.x which crashes when launching LABS. Always use the bootstrapper link above.
            <code>sudo apt --fix-broken install</code> if there are dependency issues.</p>
        </blockquote>
        <div class="space"></div>
        <div class="space"></div>
      </ul>
        <h4 class="heading small bold" id="install-graphics-packages">4. Install Graphics Packages</h2>
            <ul>
            <p>Choose <b>one</b> of the following based on your GPU:</p>
            <table class="border center-align stripes">
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
            <p>If you are using <code>d3dx10</code> with the mesa driver, You can also force it to use it, you will encounter less crashes since the <code>mesa</code> drivers are maintained.<p/>
            <pre class="border round padding scroll"><code>[ -f ".profile" ] ||  touch .profile
echo "LIBGL_ALWAYS_SOFTWARE=1 __GLX_VENDOR_LIBRARY_NAME=mesa" >> .profile
source .profile </code></pre>
          </ul>
            <div class="space"></div>
            <div class="space"></div>
        <h4 class="heading small bold" id="install-a-daw">5. Install a DAW</h2>
        <ul>
            <blockquote><span class="large bold"><b>IMPORTANT</b></span>
                <br><p>Do <b>not</b> use the standalone installer. It installs version 136.x.x which crashes when launching LABS. Always use the bootstrapper link above.
                <code>sudo apt --fix-broken install</code> if there are dependency issues.</p>
            </blockquote>
            <p><b>Debian / Ubuntu:</b></p>
            <pre class="border round padding scroll"><code>sudo apt install lmms                    # Stable (may lack VST support)
sudo pacstall -I lmms-git                # Alpha (recommended)</code></pre>
            <p><b>Arch / Artix:</b></p>
            <pre class="border round padding scroll"><code>sudo pacman -S lmms                      # Stable
yay -S lmms-git                          # Alpha (recommended)</code></pre>
        </ul>
        <div class="space"></div>
        <div class="space"></div>
      <h3 class="heading medium bold" id="troubleshooting">Troubleshooting</h2>
      <div class="space"></div>
      <hr class="divider">
      <div class="space"></div>
      <h4 id="labs-crashes" class="heading small bold">LABS Doesn't Open or it Crashes</h3>
      <ol>
        <li>
            <b>Downgrade LABS</b>: Use the older
            <a class="link" href="https://github.com/aKqir24/Spitfire-LABS-Installation-Guide-In-Linux/blob/main/LABS.dll.zip">LABS.dll</a>:
            <pre class="border round padding scroll"><code>curl -O https://github.com/aKqir24/Spitfire-LABS-Installation-Guide-In-Linux/raw/refs/heads/main/LABS.dll.zip</code></pre>
        </li>
        <li>
            <b>Try wine-staging</b>: If using wine-stable, switch to wine-staging (may be less stable).
        </li>
        <li>
            <b>Check GPU drivers</b>: Ensure your drivers are up to date and your Wine prefix is clean:
            <pre class="border round padding scroll"><code>rm -rf ~/.wine
wineboot --init</code></pre>
        </li>
        <li>
            <b>Properly setup dotnet:</b>
            Run <code>winecfg</code> and go to libraries, then add <code>concrt140</code> in the new override for library.
        </ol>
    <div class="space"></div>
      <h4 id="webview-cannot-install" class="heading small bold">Webview Cannot Be Installed even when it is not installed</h3>
      <p>Just go to <code>~/.wine/system.reg</code> of your wine folder, then open it in your IDE and Search for <code>Webview</code>.</p>
      <p>You should see lines like these, when you see it remove it and save the file.
            This usually happens if you install the <code>Webview</code> in win10 or a much latest installer.</p>
      <pre class="border round padding scroll"><code>[Software\\Wow6432Node\\Microsoft\\EdgeUpdate\\Clients\\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}] 1785220019
    #time=1dd1e5a189fca4e
    "location"="C:\\Program Files (x86)\\Microsoft\\EdgeWebView\\Application"
    "name"="Microsoft Edge WebView2 Runtime"
    "pv"="109.0.1518.140"
    "SilentUninstall"="\"C:\\Program Files (x86)\\Microsoft\\EdgeWebView\\Application\\109.0.1518.140\\Installer\\setup.exe\" --force-uninstall --uninstall --msedgewebview --system-level --verbose-logging"</code></pre>
        </ul>
      </ol>
      <h3 class="heading medium bold" id="sources">Sources</h2>
      <div class="space"></div>
      <hr class="divider">
      <div class="space"></div>
      <ul>
        <li><a class="link" href="https://www.reddit.com/r/Lutris/comments/rpomzv/you_do_not_have_the_microsoft_webview2_runtime">Wine + WebView2 — Reddit / Lutris</a></li>
        <li><a class="link" href="https://bbs.archlinux.org/viewtopic.php?id=287582">Wine + WebView2 — Arch Linux Forums</a></li>
        <li><a class="link" href="https://appdb.winehq.org/objectManager.php?sClass=version&iId=42586#notes">WineHQ Forum — Clip Studio Paint 4 menus turn black when clicked</a></li>
        <li><a class="link" href="https://forum.winehq.org/viewtopic.php?t=38443">WineHQ Forum — WebView2 Discussion</a></li>
      </ul>
</main>
