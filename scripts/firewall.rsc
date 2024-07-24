/ip firewall filter
add action=accept chain=output comment="Input Section" disabled=yes
add action=accept chain=input comment=vpncltik src-address=10.16.0.0/16
add action=drop chain=input comment="TCP non SYN scan attack input" \
    connection-state=new protocol=tcp tcp-flags=!syn
add action=drop chain=input comment=Fail2ban src-address-list=fail2ban
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid
add action=accept chain=input comment=\
    "Allow Connectivity to firewall for LetsEncrypt" disabled=yes dst-port=80 \
    log=yes log-prefix=LE-Firewall protocol=tcp
add action=accept chain=input comment="defconf: accept ICMP" disabled=yes \
    protocol=icmp
add action=drop chain=input comment="Allow Connectivity to firewall" \
    dst-address=172.16.1.X dst-port=22,8291,8728,8729,80,443 \
    in-interface-list=!LAN log-prefix=RA-Firewall protocol=tcp \
    src-address-list=Admin
add action=accept chain=input comment=\
    "defconf: accept to local loopback (for RouterOS Services)" dst-address=\
    127.0.0.1
add action=accept chain=input comment="Allow Connectivity to firewall" \
    dst-address=172.16.1.X dst-port=22,8291,8728,8729,80,443 \
    in-interface-list=LAN log-prefix=RA-Firewall protocol=tcp \
    src-address-list=Admin
add action=accept chain=input in-interface-list=LAN
add action=accept chain=input comment=Wireguard dst-port=XXXXX log=yes \
    log-prefix=WG protocol=udp
add action=accept chain=input comment=\
    "Allow everything from the Wireguard interface to the router" \
    in-interface=Home
add action=drop chain=input comment="drop dns from wan" connection-state=new \
    dst-port=53 in-interface=sfp-sfpplus1 protocol=tcp
add action=drop chain=input comment="drop dns from wan" connection-state=new \
    dst-port=53 in-interface=sfp-sfpplus1 protocol=udp
add action=drop chain=input comment="drop all else"
add action=accept chain=output comment="Forward Section" disabled=yes
add action=fasttrack-connection chain=forward comment="defconf: fasttrack" \
    connection-state=established,related hw-offload=yes
add action=drop chain=forward comment=Fail2ban src-address-list=fail2ban
add action=drop chain=forward comment="TCP non SYN scan attack forward" \
    connection-state=new protocol=tcp tcp-flags=!syn
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=accept chain=forward comment=\
    "defconf: accept established,related, untracked" connection-state=\
    established,related,untracked
add action=accept chain=forward comment="allow internet traffic" \
    in-interface-list=LAN out-interface-list=WAN
add action=accept chain=forward comment="allow LAN traffic" \
    in-interface-list=LAN out-interface-list=LAN
add action=accept chain=forward comment="allow port forwarding" \
    connection-nat-state=dstnat
add action=accept chain=forward comment="Wireguard to LAN" in-interface=br \
    out-interface-list=WireGuard
add action=accept chain=forward comment=\
    "Allow new connections through router coming in Wireguard interface" \
    connection-state=new in-interface=Home log-prefix=WG
add action=accept chain=forward comment="Wireguard to LAN" in-interface=Home \
    out-interface-list=LAN
add action=accept chain=forward comment="Wireguard to WAN" in-interface=Home \
    out-interface-list=WAN
add action=drop chain=forward connection-nat-state=!dstnat connection-state=\
    new in-interface-list=WAN
add action=drop chain=forward comment="drop all else"
add action=accept chain=output comment="Output Section" disabled=yes
add action=add-src-to-address-list address-list=\
    expected-dst-address-to-my-ISP address-list-timeout=1m chain=output \
    out-interface-list=WAN src-address-type=local
