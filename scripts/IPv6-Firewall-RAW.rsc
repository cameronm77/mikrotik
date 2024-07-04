/ipv6 firewall raw
add action=accept chain=prerouting comment=\
    "defconf: enable for transparent firewall" disabled=yes
add action=accept chain=prerouting comment="defconf: RFC4291, section 2.7.1" \
    dst-address=ff02::1:ff00:0/104 icmp-options=135:0-255 protocol=icmpv6 \
    src-address=::/128
add action=drop chain=prerouting comment="defconf: drop bogon IP's" \
    src-address-list=bad_ipv6
add action=drop chain=prerouting comment="defconf: drop bogon IP's" \
    dst-address-list=bad_ipv6
add action=drop chain=prerouting comment=\
    "defconf: drop packets with bad SRC ipv6" src-address-list=bad_src_ipv6
add action=drop chain=prerouting comment=\
    "defconf: drop packets with bad dst ipv6" dst-address-list=bad_dst_ipv6
add action=drop chain=prerouting comment="defconf: drop non global from WAN" \
    in-interface-list=WAN src-address-list=not_global_ipv6
add action=jump chain=prerouting comment="defconf: jump to ICMPv6 chain" \
    disabled=yes jump-target=icmp6 protocol=icmpv6
add action=accept chain=prerouting comment=\
    "defconf: accept local multicast scope" dst-address=ff02::/16
add action=drop chain=prerouting comment=\
    "defconf: drop other multicast destinations" dst-address=ff00::/8
add action=accept chain=prerouting comment=\
    "defconf: accept everything else from WAN" in-interface-list=WAN
add action=accept chain=prerouting comment=\
    "defconf: accept everything else from LAN" in-interface-list=LAN
add action=drop chain=prerouting comment="defconf: drop the rest"
