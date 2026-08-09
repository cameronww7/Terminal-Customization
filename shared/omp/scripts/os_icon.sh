#!/usr/bin/env bash
#
# Prints a distro-correct OS icon in that distro's brand color.
#
# We read /etc/os-release directly instead of leaning on Oh My Posh's own
# distro detection, because that detection is unreliable under WSL: WSL sets
# Oh My Posh's distro string from $WSL_DISTRO_NAME, and Fedora's official WSL
# image sets that to something like "FedoraLinux-44" - Oh My Posh only keeps
# the part before the first hyphen, so it sees "fedoralinux", not "fedora",
# and silently falls back to a generic icon instead of the real Fedora one.
# Reading /etc/os-release sidesteps that entirely and works the same whether
# this is running under WSL, in a VM, or on a real non-virtualized install.
ID=""
if [ -f /etc/os-release ]; then
  ID=$(. /etc/os-release 2>/dev/null && echo "$ID")
fi

WSL_PREFIX=""
[ -n "$WSL_DISTRO_NAME" ] && WSL_PREFIX="WSL:"

case "$ID" in
  fedora)
    printf '%s<#3C6EB4></>' "$WSL_PREFIX"      # Fedora blue
    ;;
  kali)
    printf '%s<#557C94></>' "$WSL_PREFIX"      # Kali blue-grey
    ;;
  linuxmint)
    printf '%s<#87CF3A>\U000f08ed</>' "$WSL_PREFIX"  # Mint green
    ;;
  *)
    # Anything else this shared config ends up running on - a generic
    # four-leaf-clover rather than guessing at a brand color.
    printf '%s\U0001F340' "$WSL_PREFIX"
    ;;
esac
