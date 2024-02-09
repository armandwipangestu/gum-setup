#!/bin/env bash

function spin() {
  gum spin --spinner $1 --title "Animation $1" -- sleep 3s
}

spin line
spin dot
spin minidot
spin jump
spin pulse
spin points
spin globe
spin moon
spin monkey
spin meter
spin hamburger
