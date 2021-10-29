# Description

A simple shell script to help setting up a development environment for MDD projects.

This is still experimental and any issues should be logged on the [issues page](https://github.gamesys.co.uk/davi-naizer/mdd-env-setup/issues).

# How to use

-   Using the terminal, clone this repository into you machine
    -   `git clone https://github.gamesys.co.uk/davi-naizer/mdd-env-setup.git`
-   In the folder, run `bash install.sh`
-   Follow the instructions
-   Grab yourself a cuppa
-   Wait until completed

## What does it do?

The script is split into 5 stages:

-   Install system dependencies
    -   Homebrew (Macos Package manager)
-   Install Apps Bundle
    -   git, gh and nvm
    -   Other applications and tools like vscode, figma, etc (See `Brewfile` for the full list)
-   Install Node dependencies
    -   Install node 10 and 12
    -   Sets node 12 as default
    -   Install gulp, eslint and promo-server (globally)
-   Create workspace folders
    -   Create all necessary folders
    -   Creates the Global Config file (.mddrc.json)
-   Clone most used repositories (CDP and MDD's)
    -   Check `constants.env` file for more info
-   Create API/CONTENT symlink to default venture (jackpotjoy-marketing-content)

The script runs a bunch of different actions that can take a while to finish. So, please be patient.
