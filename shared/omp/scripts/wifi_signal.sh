#!/usr/bin/env bash
#
# Network-link indicator. Rebuild of the old prompt_zsh_internet_signal()
# Powerlevel9k segment for Oh My Posh, shared by Kali/Mint/Fedora.
#
# Shows wifi signal strength when connected over wifi (via nmcli, falling
# back to iw if nmcli isn't installed), WIRED when connected over ethernet
# instead, or -- when there's no active connection either way.
#
# Replaces the old deprecated iwconfig-based version, which also hardcoded
# a specific NIC name (wlp5s0) - here the interface is detected dynamically
# so it works on any machine.

#  is a generic wifi icon (Font Awesome). Written as a printf escape
# rather than a literal character in the file, since some editors/terminals
# don't render private-use glyphs and can silently mangle them on save.
wifi_icon() { printf ''; }

# True if any real, non-loopback, non-wireless network interface is up -
# i.e. you're plugged in over ethernet. Checked via /sys/class/net directly
# so this works regardless of whether nmcli or iw is installed.
#
# Skips loopback and common virtual interfaces (Docker, libvirt bridges,
# VPN tunnels, WSL's own loopback0) so those don't get mistaken for a real
# wired connection.
wired_up() {
  local dir iface
  for dir in /sys/class/net/*/; do
    iface="$(basename "$dir")"
    case "$iface" in
      lo|loopback*|docker*|veth*|br-*|virbr*|tun*|wg*|vmnet*) continue ;;
    esac
    [ -d "${dir}wireless" ] && continue
    [ "$(cat "${dir}operstate" 2>/dev/null)" = "up" ] && return 0
  done
  return 1
}

if command -v nmcli >/dev/null 2>&1; then
  SIGNAL=$(nmcli -t -f active,signal dev wifi 2>/dev/null | awk -F: '$1=="yes"{print $2; exit}')
  if [ -n "$SIGNAL" ]; then
    printf '%s %s%%' "$(wifi_icon)" "$SIGNAL"
  elif wired_up; then
    printf 'WIRED'
  else
    printf '%s --' "$(wifi_icon)"
  fi
elif command -v iw >/dev/null 2>&1; then
  IFACE=$(iw dev 2>/dev/null | awk '$1=="Interface"{print $2; exit}')
  SIGNAL=""
  [ -n "$IFACE" ] && SIGNAL=$(iw dev "$IFACE" link 2>/dev/null | awk '/signal:/{print $2; exit}')
  if [ -n "$SIGNAL" ]; then
    printf '%s %sdBm' "$(wifi_icon)" "$SIGNAL"
  elif wired_up; then
    printf 'WIRED'
  else
    printf '%s --' "$(wifi_icon)"
  fi
else
  # Neither nmcli nor iw is installed, but we can still tell wired apart
  # from nothing at all by reading /sys/class/net directly.
  if wired_up; then
    printf 'WIRED'
  else
    printf '%s n/a' "$(wifi_icon)"
  fi
fi
