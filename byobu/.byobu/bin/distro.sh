#!/bin/bash
DISTRO=$(awk -F '="' '{ if ($1 == "NAME") print substr($2,1,1)}' /etc/*-release)
VERSION=$(awk -F '=' '{ if ($1 == "VERSION_ID") print substr($2,1,3)}' /etc/*-release | tr -d '"')
LOGO1=$DISTRO$VERSION
color c W; printf "%s" "$LOGO1"; color -; printf " "

