/ipv6 firewall address-list
add address=::1/128 comment="defconf: RFC6890 lo" list=bad_ipv6
add address=::ffff:0.0.0.0/96 comment="defconf: RFC6890 IPv4 mapped" list=\
    bad_ipv6
add address=2001::/23 comment="defconf: RFC6890" list=bad_ipv6
add address=2001:db8::/32 comment="defconf: RFC6890 documentation" list=\
    bad_ipv6
add address=2001:10::/28 comment="defconf: RFC6890 orchid" list=bad_ipv6
add address=::/96 comment="defconf: ipv4 compat" list=bad_ipv6
add address=100::/64 comment="defconf: RFC6890 Discard-only" list=\
    not_global_ipv6
add address=2001::/32 comment="defconf: RFC6890 TEREDO" list=not_global_ipv6
add address=2001:2::/48 comment="defconf: RFC6890 Benchmark" list=\
    not_global_ipv6
add address=fc00::/7 comment="defconf: RFC6890 Unique-Local" list=\
    not_global_ipv6
add address=::/128 comment="defconf: unspecified" list=bad_dst_ipv6
add address=::/128 comment="defconf: unspecified" list=bad_src_ipv6
add address=ff00::/8 comment="defconf: multicast" list=bad_src_ipv6
add address=google.com list=NordVPN
add address=gmail.com list=NordVPN
