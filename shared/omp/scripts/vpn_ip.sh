#!/usr/bin/env bash
#
# VPN-lab IP indicator. Rebuild of the old prompt_vpnip() Powerlevel9k
# segment for Oh My Posh, shared by Kali/Mint/Fedora.
#
# Prints the IP address on the tun0 interface (the standard interface name
# OpenVPN and most VPN clients use) if one exists, or "No-VPN" if it doesn't.
# tun0 only appears once you've actually connected to a VPN - there's
# nothing to configure here, this just reflects whatever's currently up.
IP=$(ip -4 addr show tun0 2>/dev/null | awk '/inet /{print $2}' | cut -d/ -f1)
if [[ -n "$IP" ]]; then
  printf '%s' "$IP"
else
  printf 'No-VPN'
fi
