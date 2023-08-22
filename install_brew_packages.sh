#!/bin/bash

# Install yq if not already installed
if ! command -v yq &> /dev/null; then
    echo "yq not found. Installing yq..."
    brew install yq
fi

# Function to install Homebrew package
install_package() {
  package="$1"
  echo "Installing $package..."
  brew install "$package"
  echo "$package installed."
}

# Read packages from YAML file and install each one
while IFS= read -r package; do
  install_package "$package"
done < <(yq eval '.packages[]' brew_packages.yml)

# Read casks from YAML file and install each one
while IFS= read -r cask; do
  install_package "$cask"
done < <(yq eval '.casks[]' brew_packages.yml)
