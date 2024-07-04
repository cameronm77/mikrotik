#RAW Firewall Rules for Protection and Invalid packets

/ip firewall raw
add action=drop chain=prerouting comment=\
    "TCP invalid combination of flags attack (7 rules)" protocol=tcp \
    tcp-flags=!fin,!syn,!rst,!ack
add action=drop chain=prerouting protocol=tcp tcp-flags=fin,syn
add action=drop chain=prerouting protocol=tcp tcp-flags=fin,rst
add action=drop chain=prerouting protocol=tcp tcp-flags=fin,!ack
add action=drop chain=prerouting protocol=tcp tcp-flags=fin,urg
add action=drop chain=prerouting protocol=tcp tcp-flags=syn,rst
add action=drop chain=prerouting protocol=tcp tcp-flags=rst,urg
add action=drop chain=prerouting comment="TCP Port 0 attack (2 rules)" \
    protocol=tcp src-port=0
add action=drop chain=prerouting dst-port=0 protocol=tcp
add action=drop chain=prerouting dst-address=!127.0.0.1 port=0 protocol=udp \
    src-address=!127.0.0.1
add action=drop chain=prerouting comment="UDP Port 0 attack (2 rules)" \
    protocol=udp src-port=0
add action=drop chain=prerouting dst-port=0 protocol=udp
add action=drop chain=prerouting comment="SYN fragmented attack" fragment=yes \
    protocol=tcp tcp-flags=syn
add action=drop chain=prerouting comment=\
    "Fragment attack Interface Protection" fragment=yes in-interface-list=\
    fragment_protected_interface
add action=drop chain=prerouting comment="IP option loose-source-routing" \
    ipv4-options=loose-source-routing
add action=drop chain=prerouting comment="IP option strict-source-routing" \
    ipv4-options=strict-source-routing
add action=drop chain=prerouting comment="IP option record-route" \
    ipv4-options=record-route
add action=drop chain=prerouting comment="IP option router-alert" \
    ipv4-options=router-alert
add action=drop chain=prerouting comment="IP option timestamp" ipv4-options=\
    timestamp
add action=drop chain=prerouting comment=\
    "IP options left, except IP Stream used by the IGMP protocol" \
    ipv4-options=any protocol=!igmp
add action=drop chain=prerouting comment="IP Spoofing protection from WAN" \
    in-interface-list=WAN src-address-list=IP_used_on_LAN
add action=drop chain=prerouting comment="IP Spoofing protection from LAN" \
    dst-address=!255.255.255.255 in-interface-list=LAN src-address=!0.0.0.0 \
    src-address-list=!IP_used_on_LAN_WG
add action=accept chain=prerouting protocol=icmp
add action=accept chain=prerouting protocol=igmp
add action=accept chain=prerouting protocol=tcp
add action=accept chain=prerouting protocol=udp
add action=accept chain=prerouting protocol=gre
add action=log chain=prerouting log-prefix="Not TCP protocol" protocol=!tcp
add action=drop chain=prerouting comment="Unused protocol protection" \
    disabled=yes protocol=!tcp
