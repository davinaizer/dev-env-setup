#!/bin/bash
# author: Davi Naizer
# created: 2021-10-18
# updated: 2021-10-29

# SCRIPT USAGE
# LOCALLY
# $ bash install.sh

# LOAD CONSTANTS FILE
source constants.env

# UTILS FUNCTIONS
function cecho() {
    RED="\033[0;31m"
    GREEN="\033[0;32m"
    YELLOW="\033[1;33m"
    CYAN="\033[1;36m"
    NC="\033[0m" # No Color

    printf "${!1}${2} ${NC}\n"
}

function abort() {
    printf "%s\n" "$@"
    exit 1
}

function promptContinue() {
    cecho "GREEN" "Do you want to continue (Y/n)?"
    read answer
    if [ "$answer" != "${answer#[Nn]}" ]; then
        abort "Operation aborted!"
    fi
}

function checkOS() {
    OS="$(uname)"
    if [[ "${OS}" == "Linux" ]]; then
        OS_IS_LINUX=1
    elif [[ "${OS}" != "Darwin" ]]; then
        abort "This script is only supported on macOS and Linux."
    fi
}

# MAIN FUNCTIONS
function welcomeMessage() {
    echo
    cecho "YELLOW" "Welcome to the Dev Env Setup Script v${SCRIPT_VERSION}"
    echo
    echo "This script will create a workspace folder in your HOME directory and install a selection of applications and respositories."
    echo "It will take a while to complete, so go grab youself a coffee in the meantime."
    echo
    echo "The WORKSPACE folder will be created in the following location:"
    cecho "CYAN" $WORKSPACE_PATH
    echo

    promptContinue
}

function installSystemDeps() {
    echo
    cecho "GREEN" "Installing XCode command line tools..."
    xcode-select --install

    cecho "GREEN" "Installing Homebrew (Package manager)..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function installAppsBundle() {
    echo
    cecho "GREEN" "Installing apps bundle (Brewfile)..."
    brew bundle --verbose
    brew cleanup
}

function installNodeDeps() {
    echo
    cecho "GREEN" "Installing NodeJS..."

    # source nvm script
    source $(brew --prefix nvm)/nvm.sh

    # install nodejs
    nvm install 12
    nvm alias default 12

    echo
    cecho "GREEN" "Installing NPM Global packages..."
    npm install -g eslint npm-check yarn
}

function createWorkspaceFolders() {
    echo
    cecho "GREEN" "Creating Workspace and Subfolders..."

    for dir in "${WORKSPACE_SUBFOLDERS[@]}"; do
        SUBFOLDER_PATH=${WORKSPACE_PATH}/${dir}
        echo "Creating folder @ ${SUBFOLDER_PATH}"
        [[ ! -d "$SUBFOLDER_PATH" ]] && mkdir -p "${SUBFOLDER_PATH}"
    done
}

function cloneRepos() {
    echo
    cecho "GREEN" "Cloning GitHub repositories..."
    for repo in "${GIT_REPO_LIST[@]}"; do
        REPO_REMOTE_PATH="${GIT_REPO_URL}/${repo}"
        REPO_LOCAL_PATH="${WORKSPACE_PATH}/github/${repo}"
        cecho "CYAN" "Cloning project: ${repo}"
        git clone $REPO_REMOTE_PATH $REPO_LOCAL_PATH
        echo
    done
}

function macosCustomSettings() {
    # Show Library folder
    chflags nohidden ~/Library
    # Show path bar
    defaults write com.apple.finder ShowPathbar -bool true
    # Show status bar
    defaults write com.apple.finder ShowStatusBar -bool true

    # Add macOS Dock Dividers
    for i in {1..4}; do
        defaults write com.apple.dock persistent-apps -array-add '{tile-type="spacer-tile";}'
    done

    # Add macOS Dock Dividers - right side of the dock
    defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

    # sets dock's height
    defaults write com.apple.dock tilesize -integer 24

    # restart Dock
    killall Dock
}

function init() {
    welcomeMessage

    # START TIMER
    startTime=$SECONDS

    # INSTALL DEPENDENCIES
    installSystemDeps
    installAppsBundle
    macosCustomSettings
    installNodeDeps

    # CREATE WORKSPACE AND CLONE REPOS
    createWorkspaceFolders
    cloneRepos

    # END TIMER
    duration=$((SECONDS - startTime))
    cecho "GREEN" "Installation completed in ${duration} seconds."
}

# RUN SCRIPT
init
