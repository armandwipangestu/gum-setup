#!/bin/env bash

PACKAGES=(git fzf neofetch awokwok)

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

gum style \
  --foreground 212 --border-foreground 212 --border double \
  --align center --width 50 --margin "1 2" --padding "2 4" \
  'Gum Setup' 'by: @devnull'

gum format <packages.md
echo ""
SELECTED_PACKAGES=$(gum choose --no-limit "${PACKAGES[@]}")
echo "# Confirm selected packages" >selected_packages.md
for package in $SELECTED_PACKAGES; do
  echo "- \`$package\`" >>selected_packages.md
done
gum format <selected_packages.md

installPkgs() {
  # shellcheck disable=SC2068
  for package in ${SELECTED_PACKAGES[@]}; do
    if gum spin --spinner moon --title "Installing ${package}" -- sudo apt install -y "$package"; then
      #if [ $? -eq 0 ]; then
      gum log --time rfc822 --structured --level info "Installing success " package "${package}"
      echo -e "$(date '+%d %b %y %H:%M %Z') INFO Installing success package=${package}" >>log.txt
    else
      gum log --time rfc822 --structured --level error "Installing failed" package "${package}"
      echo -e "$(date '+%d %b %y %H:%M %Z') ERROR Installing failed package=${package}" >>log.txt
    fi
  done
}

#echo "Installing $SELECTED_PACKAGE...
#gum confirm && echo -e "" && pkg i $SELECTED_PACKAGES || echo -e "\n  not installing packages"
gum confirm && echo -e "" && installPkgs || echo -e "\n  not installing packages"
