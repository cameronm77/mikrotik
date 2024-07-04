/ipv6 address
add address=::1 from-pool=Homev6 interface=br
/ipv6 dhcp-client
add add-default-route=yes interface=sfp-sfpplus1 pool-name=Homev6 \
    prefix-hint=::/56 request=prefix
/ipv6 dhcp-server
add address-pool=Homev6 interface=br name=HomeIPv6
