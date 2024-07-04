/ipv6 firewall mangle
add action=mark-connection chain=prerouting disabled=yes dst-address-list=\
    NordVPN new-connection-mark=NordVPN passthrough=yes
