#!/bin/sh
set -e

APP_ID="com.smiteworks.FantasyGrounds"
INSTALL_URL="https://www.fantasygrounds.com/filelibrary/FGUWebInstall.bin"

# Where FGU actually installs itself (per upstream docs)
FG_HOME="${HOME}/.smiteworks/fantasygrounds"

# Where we cache the installer inside the Flatpak sandbox
APP_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/${APP_ID}"
INSTALLER_PATH="${APP_DATA}/FGUWebInstall.bin"

# User's download dir, if exposed
DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"

mkdir -p "${APP_DATA}"

# 1) If already installed, just run it
if [ -x "${FG_HOME}/FantasyGrounds.x86_64" ]; then
    export GDK_BACKEND=x11
    cd "${FG_HOME}"
    exec ./FantasyGrounds.x86_64 "$@"
fi

echo "Fantasy Grounds is not installed yet. Running web installer..."

# 2) Make sure ~/.smiteworks exists
mkdir -p "${HOME}/.smiteworks"

# 3) Reuse existing installer if the user already downloaded it
if [ -f "${DOWNLOAD_DIR}/FGUWebInstall.bin" ] && [ ! -f "${INSTALLER_PATH}" ]; then
    echo "Found existing FGUWebInstall.bin in ${DOWNLOAD_DIR}, reusing it."
    cp "${DOWNLOAD_DIR}/FGUWebInstall.bin" "${INSTALLER_PATH}"
fi

# 4) Download installer if we still don't have it
if [ ! -f "${INSTALLER_PATH}" ]; then
    echo "Downloading FGUWebInstall.bin from official site..."
    /app/bin/curl -L -o "${INSTALLER_PATH}" "${INSTALL_URL}"
fi

chmod +x "${INSTALLER_PATH}"

# 5) Run the official installer (it will popup its own GUI & EULA)
"${INSTALLER_PATH}"

# 6) Run updater once if present
if [ -x "${FG_HOME}/FantasyGroundsUpdater" ]; then
    echo "Running FantasyGroundsUpdater..."
    cd "${FG_HOME}"
    ./FantasyGroundsUpdater || true
fi

# 7) Finally, launch the main app
if [ -x "${FG_HOME}/FantasyGrounds.x86_64" ]; then
    export GDK_BACKEND=x11
    cd "${FG_HOME}"
    exec ./FantasyGrounds.x86_64 "$@"
fi

echo "Fantasy Grounds appears not to be installed correctly (missing FantasyGrounds.x86_64)."
exit 1

