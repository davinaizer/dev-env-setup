# Description

A simple shell script to help setting up a development environment.

This is still experimental and any issues should be logged on the [issues page](./issues).

# How to use

- Using the terminal, clone this repository into you machine
  - `git clone https://github.com/davinaizer/dev-env-setup.git`
- In the folder, run `bash install.sh`
- Follow the instructions
- Grab yourself a cuppa
- Wait until completed

## What does it do?

The script is split into these stages:

- Install system dependencies
  - Homebrew (Macos Package manager)
- Install Apps Bundle
  - git, gh and nvm, yarn
  - Other applications and tools like vscode, figma, etc (See `Brewfile` for the full list)
- Install Node dependencies
  - Install node 10 and 12
  - Sets node 12 as default
- Create a Workspace folder on user's HOME
- Clone a list of repositories
  - Check `constants.env` file for more info

The script runs a bunch of different actions that can take a while to finish. So, please be patient.
