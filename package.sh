#!/bin/env bash

PACKAGES=(git fzf neofetch)

#echo "Choose a package to install:"
#echo "NOTE: Use space to select and"
#SELECTED_PACKAGE=$(gum choose --no-limit "${PACKAGES[@]}")
#echo "# Selected Packages" > selected_packages.md
#for package in "${SELECTED_PACKAGE[@]}"; do
#  echo "- $package" >> selected_packages.md
#done
#gum format < selected_packages.md
#echo "Installing $SELECTED_PACKAGE..."
#gum confirm && pkg i $SELECTED_PACKAGE || echo "not installing package"
# Anda dapat menambahkan perintah instalasi paket di sini

#echo "Choose packages to install:"
#IFS=, read -ra SELECTED_PACKAGES <<< "$(gum choose --no-limit "${PACKAGES[@]}" | tr -d '\n' | sed 's/ /\\ /g')"
#echo "Installing ${SELECTED_PACKAGES[*]}..."
#pkg i $SELECTED_PACKAGES
# Anda dapat menambahkan perintah instalasi paket di sini

#echo "Choose packages to install:"
#IFS=" " read -ra SELECTED_PACKAGES <<< "$(gum choose --no-limit "${PACKAGES[@]}")"

gum format < packages.md
echo ""
SELECTED_PACKAGES=$(gum choose --no-limit "${PACKAGES[@]}")
echo "# Selected Packages" > selected_packages.md
for package in $SELECTED_PACKAGES; do
  echo "- \`$package\`" >> selected_packages.md
done
gum format < selected_packages.md
#echo "Installing $SELECTED_PACKAGE...
gum confirm && echo -e "" && pkg i $SELECTED_PACKAGES || echo -e "\n  not installing packages"
