#!/usr/bin/env bash
#
# VPN-lab IP indicator. Rebuild of the old prompt_vpnip() Powerlevel9k
# segment for Oh My Posh, shared by Kali/Mint/Fedora.
#
# Prints the IP address on the tun0 interface (the standard interface name
# OpenVPN and most VPN clients use) if one exists, prints nothing otherwise.
# tun0 only appears once you've actually connected to a VPN - there's
# nothing to configure here, this just reflects whatever's currently up.
#
# Printing nothing (not even a placeholder) is deliberate: oh-my-posh hides a
# segment entirely, diamonds and all, when its rendered text comes out blank,
# so an empty VPN script output means the whole segment disappears from the
# prompt instead of sitting there as a "No-VPN" pill you have to mentally
# filter out every time you're not on a VPN. This is also why the lock icon
# lives here in the script instead of as a fixed prefix in the JSON template:
# a static icon in the template is never blank, so it would always render
# even with an empty IP, defeating the auto-hide entirely.
IP=$(ip -4 addr show tun0 2>/dev/null | awk '/inet /{print $2}' | cut -d/ -f1)
# Deliberately a plain if with no else, not `[[ -n "$IP" ]] && printf ...`:
# the && form makes the whole script exit 1 when there's no VPN, and
# oh-my-posh's cmd template function treats a non-zero exit as an error
# instead of just reading stdout, which broke the segment entirely rather
# than just leaving it blank. An if/fi with no matching branch always exits 0.
if [[ -n "$IP" ]]; then
  printf ' %s' "$IP"
fi
