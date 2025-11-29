## Fantasy Grounds Unity Flatpak Builder

This repository contains the **build tooling and Flatpak manifest** for running the **official Fantasy Grounds Unity client** inside a Flatpak sandbox.  
It **does not contain, bundle, redistribute, or modify** any Fantasy Grounds Unity binaries or assets, other than the Fantasy Grounds application icon.

Instead, the Flatpak:

- Downloads the **official Fantasy Grounds Unity installer** from the Fantasy Grounds / SmiteWorks servers at install time
- Runs that installer inside a Flatpak runtime
- Launches the **unaltered official client** inside that sandbox

You are always running the official upstream client; this project is only a wrapper around it.

---

## Quick install

- **Download the Flatpak bundle**  
  Go to the [Releases page](https://github.com/matjam/fgu-flatpak/releases) and download the latest `com.smiteworks.FantasyGrounds.flatpak` file from the newest release.

- **Install the Flatpak bundle**  
  From a terminal in the directory where you downloaded the file:

  ```bash
  flatpak install --user ./com.smiteworks.FantasyGrounds.flatpak
  ```

- **Run it once from the CLI to accept licensing and run the installer**  
  On first run, the Flatpak will download and execute the official Fantasy Grounds Unity installer inside the sandbox:

  ```bash
  flatpak run com.smiteworks.FantasyGrounds
  ```

  Follow the prompts to accept the Fantasy Grounds license and complete the official installer.

  If you do not do this and try to launch the app, nothing will happen. You need to accept the Fantasy Grounds license.

- **Uninstall if you no longer need it**

  ```bash
  flatpak uninstall --delete-data com.smiteworks.FantasyGrounds
  ```

  That removes the Flatpak and its sandboxed data.  
  If you also want to remove **all** Fantasy Grounds data from your home directory (campaigns, modules, settings), you can delete:

  ```bash
  rm -rf ~/.smiteworks/fgdata
  rm -rf ~/.config/smiteworks
  ```

---

## Legal / Trademark / Copyright

- **Fantasy Grounds**, **Fantasy Grounds Unity**, and all related logos, artwork, and content are **trademarks and/or copyrighted materials of SmiteWorks USA, LLC** and/or their respective owners.
- This project is **not affiliated with, endorsed by, sponsored by, or officially supported by SmiteWorks USA, LLC**.
- This repository provides **only**:
  - A Flatpak manifest
  - A small launcher script
  - Supporting metadata (desktop file, icon, AppStream data)
- All game rulesets, artwork, and the Fantasy Grounds Unity application itself are obtained **directly from the official Fantasy Grounds distribution channels** other than the application icon itself.

By using this project, you acknowledge that:
- You are subject to the **Fantasy Grounds EULA**, terms of service, and any other agreements set by SmiteWorks.
- This project merely **runs the official client in a Flatpak environment** and does not attempt to bypass any licensing, DRM, or usage restrictions.

---

## What this project does

- Provides `com.smiteworks.FantasyGrounds.yml`, a Flatpak manifest using the Freedesktop Platform runtime.
- Includes a launcher script that:
  - Ensures Fantasy Grounds Unity is installed inside the Flatpak sandbox
  - Starts the official Fantasy Grounds Unity client
- Configures persistent directories so your Fantasy Grounds data and configuration live in your home directory as expected.

**Important:**  
This project is strictly a **packaging/build tool**. It exists to make it more convenient to run the official Fantasy Grounds Unity client in a Flatpak sandbox on Linux.

---

## Manually Building the Flatpak locally

You will need:
- `flatpak`
- `flatpak-builder`
- Access to the Freedesktop Platform & SDK (23.08)

Example setup:

```bash
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --user -y flathub org.freedesktop.Platform//23.08 org.freedesktop.Sdk//23.08
```

Then build and bundle:

```bash
flatpak-builder --user \
  --force-clean \
  --repo=repo-dir \
  --install-deps-from=flathub \
  build-dir \
  com.smiteworks.FantasyGrounds.yml

flatpak build-bundle \
  repo-dir \
  com.smiteworks.FantasyGrounds.flatpak \
  com.smiteworks.FantasyGrounds \
  stable
```

You can then install the bundle:

```bash
flatpak install com.smiteworks.FantasyGrounds.flatpak
```

On first run, the Flatpak will download and execute the **official Fantasy Grounds Unity installer** from the Fantasy Grounds website.

---

## Support / Issues

This project only covers:
- The Flatpak packaging
- The launcher script
- The GitHub Actions build setup

If you encounter issues with:
- This Flatpak packaging, build process, or launcher:  
  **Please open an issue in this GitHub repository.**

If you encounter issues with:
- The Fantasy Grounds Unity client itself
- Your account, license, content, or connectivity to Fantasy Grounds services  
Then you should contact **official Fantasy Grounds / SmiteWorks support** or use their official support channels and forums, but note that you are using this launcher. They MAY suggest installing Ubuntu etc instead as that is *their* supported environment.


