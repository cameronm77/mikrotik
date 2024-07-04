/ip firewall mangle
add action=mark-connection chain=prerouting dst-address-list=nordvpn-dst \
    log-prefix=Nord new-connection-mark=NordVPN passthrough=yes
