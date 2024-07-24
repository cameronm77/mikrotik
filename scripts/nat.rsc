# NAT Rules.   Change IP and Ports to match needed

/ip firewall nat
add action=masquerade chain=srcnat comment="Default Masq" ipsec-policy=\
    out,none out-interface-list=WAN
add action=src-nat chain=srcnat comment="Wireguard SrcNAT" src-address=\
    10.100.1.X/24 to-addresses=172.16.1.X
add action=dst-nat chain=dstnat comment="Bitwarden NAT" dst-port=XXXX \
    in-interface=sfp-sfpplus1 log=yes log-prefix=vault protocol=tcp \
    to-addresses=172.16.1.X
add action=dst-nat chain=dstnat comment="Certbot - HTTP - hap" disabled=yes \
    dst-port=80 in-interface=sfp-sfpplus1 log=yes log-prefix=certbot \
    protocol=tcp to-addresses=172.16.1.X
add action=dst-nat chain=dstnat comment="DNS Redirect" disabled=yes \
    dst-address=!172.16.1.X dst-port=53 in-interface=!sfp-sfpplus1 protocol=\
    udp src-address=!172.16.1.X to-addresses=172.16.1.X
add action=dst-nat chain=dstnat disabled=yes dst-address=!172.16.1.X \
    dst-port=53 in-interface=!sfp-sfpplus1 protocol=tcp src-address=\
    !172.16.1.X to-addresses=172.16.1.X
add action=masquerade chain=srcnat disabled=yes dst-address=172.16.1.X \
    dst-port=53 protocol=udp src-address=172.16.1.0/24
add action=masquerade chain=srcnat disabled=yes dst-address=172.16.1.X \
    dst-port=53 protocol=tcp src-address=172.16.1.0/24
add action=dst-nat chain=dstnat comment="Nextcloud - HTTPS" disabled=yes \
    dst-port=XXXX in-interface-list=WAN log=yes log-prefix=nc-bw protocol=tcp \
    to-addresses=172.16.1.X to-ports=XXXX
