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

# macOS has none of nmcli/iw/procfs, so it gets its own self-contained branch
# that exits before any of the Linux-only logic below ever runs. Reports the
# SSID instead of a signal percentage: the old `airport -I` utility that
# would give a real RSSI number has been gated behind Location Services
# privacy permissions since Big Sur, which a background prompt script has no
# business prompting for, so this deliberately doesn't try to fight that.
if [ "$(uname -s)" = "Darwin" ]; then
  wired_up_darwin() {
    local iface
    for iface in $(ifconfig -l 2>/dev/null); do
      case "$iface" in
        lo0|utun*|awdl0|llw0|bridge*|ap1|"$WIFI_PORT") continue ;;
      esac
      ifconfig "$iface" 2>/dev/null | grep -q 'status: active' && return 0
    done
    return 1
  }

  # The Wi-Fi hardware port isn't reliably "en0" across every Mac model, so
  # ask networksetup which port is actually the Wi-Fi one instead of guessing.
  WIFI_PORT=$(networksetup -listallhardwareports 2>/dev/null | awk '/Wi-Fi/{getline; print $2}')
  SSID=""
  [ -n "$WIFI_PORT" ] && SSID=$(networksetup -getairportnetwork "$WIFI_PORT" 2>/dev/null | sed -n 's/^Current Wi-Fi Network: //p')

  if [ -n "$SSID" ]; then
    printf '%s %s' "$(wifi_icon)" "$SSID"
  elif wired_up_darwin; then
    printf 'WIRED'
  else
    printf '%s --' "$(wifi_icon)"
  fi
  exit 0
fi

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
