/ip firewall nat
add action=masquerade chain=srcnat comment="Default Masq" ipsec-policy=\
    out,none out-interface-list=WAN
add action=src-nat chain=srcnat comment="Wireguard SrcNAT" src-address=\
    10.100.1.0/24 to-addresses=172.16.1.1
add action=dst-nat chain=dstnat comment="Bitwarden NAT" dst-port=4434 \
    in-interface=sfp-sfpplus1 log=yes log-prefix=vault protocol=tcp \
    to-addresses=172.16.1.4
add action=dst-nat chain=dstnat comment="Certbot - HTTP" disabled=yes \
    dst-port=80 in-interface=sfp-sfpplus1 log=yes log-prefix=certbot \
    protocol=tcp to-addresses=172.16.1.80
add action=dst-nat chain=dstnat comment="Certbot - HTTP - hap" disabled=yes \
    dst-port=80 in-interface=sfp-sfpplus1 log=yes log-prefix=certbot \
    protocol=tcp to-addresses=172.16.1.4
add action=dst-nat chain=dstnat comment="DNS Redirect" disabled=yes \
    dst-address=!172.16.1.9 dst-port=53 in-interface=!sfp-sfpplus1 protocol=\
    udp src-address=!172.16.1.9 to-addresses=172.16.1.9
add action=dst-nat chain=dstnat disabled=yes dst-address=!172.16.1.9 \
    dst-port=53 in-interface=!sfp-sfpplus1 protocol=tcp src-address=\
    !172.16.1.9 to-addresses=172.16.1.9
add action=masquerade chain=srcnat disabled=yes dst-address=172.16.1.9 \
    dst-port=53 protocol=udp src-address=172.16.1.0/24
add action=masquerade chain=srcnat disabled=yes dst-address=172.16.1.9 \
    dst-port=53 protocol=tcp src-address=172.16.1.0/24
add action=dst-nat chain=dstnat comment="Nextcloud - HTTPS" disabled=yes \
    dst-port=443 in-interface-list=WAN log=yes log-prefix=nc-bw protocol=tcp \
    to-addresses=172.16.1.4 to-ports=443
