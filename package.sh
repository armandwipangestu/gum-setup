#!/bin/env bash

PACKAGES=(git fzf neofetch awokwok)

gum style \
  --foreground 212 --border-foreground 212 --border double \
  --align center --width 50 --margin "1 2" --padding "2 4" \
  'Gum Setup' 'by: @devnull'

gum format <markdown/packages.md
echo ""
SELECTED_PACKAGES=$(gum choose --no-limit "${PACKAGES[@]}")
echo "# Confirm selected packages" >run/selected_packages.md
for package in $SELECTED_PACKAGES; do
  echo "- \`$package\`" >>run/selected_packages.md
done
gum format <run/selected_packages.md

installPkgs() {
  # shellcheck disable=SC2068
  for package in ${SELECTED_PACKAGES[@]}; do
    if gum spin --spinner moon --title "Installing ${package}" -- sudo apt install -y "$package"; then
      #if [ $? -eq 0 ]; then
      gum log --time rfc822 --structured --level info "Installing success " package "${package}"
      echo -e "$(date '+%d %b %y %H:%M %Z') INFO Installing success package=${package}" >>log/log.txt
    else
      gum log --time rfc822 --structured --level error "Installing failed" package "${package}"
      echo -e "$(date '+%d %b %y %H:%M %Z') ERROR Installing failed package=${package}" >>log/log.txt
    fi
  done
}

gum confirm && echo -e "" && installPkgs || echo -e "\n  not installing packages"
