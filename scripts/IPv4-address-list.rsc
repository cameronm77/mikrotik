/ip firewall address-list
add address=172.16.X.X/24 comment=Servers list=Admin
add address=10.100.1.0/24 comment=Wireguard list=Admin
add address=127.0.0.0/8 list=unexpected-src-address-hitting-ISP
add address=169.254.0.0/16 list=unexpected-src-address-hitting-ISP
add address=192.0.0.0/24 list=unexpected-src-address-hitting-ISP
add address=192.0.2.0/24 list=unexpected-src-address-hitting-ISP
add address=192.88.99.0/24 list=unexpected-src-address-hitting-ISP
add address=198.18.0.0/15 list=unexpected-src-address-hitting-ISP
add address=198.51.100.0/24 list=unexpected-src-address-hitting-ISP
add address=203.0.113.0/24 list=unexpected-src-address-hitting-ISP
add address=233.252.0.0/24 list=unexpected-src-address-hitting-ISP
add address=240.0.0.0/5 list=unexpected-src-address-hitting-ISP
add address=248.0.0.0/6 list=unexpected-src-address-hitting-ISP
add address=252.0.0.0/7 list=unexpected-src-address-hitting-ISP
add address=254.0.0.0/8 list=unexpected-src-address-hitting-ISP
add address=172.16.X.X/24 comment="Current network" list=\
    expected-address-from-LAN
add address=224.0.0.0/4 comment=Multicast list=expected-address-from-LAN
add address=255.255.255.255 comment=Local list=expected-address-from-LAN
add address=8.8.8.8 comment=Google list="DNS Servers"
add address=8.8.4.4 comment=Google list="DNS Servers"
add address=4.2.2.1 comment="Level 3" list="DNS Servers"
add address=4.2.2.2 comment="Level 3" list="DNS Servers"
add address=208.67.222.222 comment=OpenDNS list="DNS Servers"
add address=208.67.220.220 comment=OpenDNS list="DNS Servers"
add address=1.1.1.1 comment=Cloudflare list="DNS Servers"
add address=1.0.0.1 comment=Cloudflare list="DNS Servers"
add address=1.1.1.2 comment=Cloudflare list="DNS Servers"
add address=1.0.0.2 comment=Cloudflare list="DNS Servers"
add address=1.1.1.3 comment=Cloudflare list="DNS Servers"
add address=1.0.0.3 comment=Cloudflare list="DNS Servers"
add address=4.2.2.3 comment="Level 3" list="DNS Servers"
add address=4.2.2.4 comment="Level 3" list="DNS Servers"
add address=4.2.2.5 comment="Level 3" list="DNS Servers"
add address=4.2.2.6 comment="Level 3" list="DNS Servers"
add address=45.90.28.225 comment=NextDNS list="DNS Servers"
add address=45.90.30.225 comment=NextDNS list="DNS Servers"
add address=948953.dns.nextdns.io comment=NextDNS list="DNS Servers"
add address=188.94.192.215 comment=FlastStart list="DNS Servers"
add address=45.76.84.187 comment=FlastStart list="DNS Servers"
add address=www.crackle.com list="Video Streaming Services"
add address=www.youtube.com list="Video Streaming Services"
add address=www.hbomax.com list="Video Streaming Services"
add address=www.disneyplus.com list="Video Streaming Services"
add address=www.hulu.com list="Video Streaming Services"
add address=plus.espn.com list="Video Streaming Services"
add address=www.sling.com list="Video Streaming Services"
add address=www.fubo.tv list="Video Streaming Services"
add address=www.netflix.com list="Video Streaming Services"
add address=www.vimeo.com list="Video Streaming Services"
add address=www.vidlii.com list="Video Streaming Services"
add address=www.veoh.com list="Video Streaming Services"
add address=d.tube list="Video Streaming Services"
add address=www.twitch.tv list="Video Streaming Services"
add address=www.dailymotion.com list="Video Streaming Services"
add address=www.metacafe.com list="Video Streaming Services"
add address=www.bitchute.com list="Video Streaming Services"
add address=www.liveleak.com list="Video Streaming Services"
add address=www.cbs.com list="Video Streaming Services"
add address=acorn.tv list="Video Streaming Services"
add address=pluto.tv list="Video Streaming Services"
add address=www.shudder.com list="Video Streaming Services"
add address=tv.apple.com list="Video Streaming Services"
add address=quibi.com list="Video Streaming Services"
add address=www.peacocktv.com list="Video Streaming Services"
add address=www.showtime.com list="Video Streaming Services"
add address=www.pureflix.com list="Video Streaming Services"
add address=www.hmnow.com list="Video Streaming Services"
add address=www.fandor.com list="Video Streaming Services"
add address=mubi.com list="Video Streaming Services"
add address=www.popcornflix.com list="Video Streaming Services"
add address=www.contv.com list="Video Streaming Services"
add address=classiccinemaonline.com list="Video Streaming Services"
add address=tubitv.com list="Video Streaming Services"
add address=10.100.X.0/24 list="Network Tunnels"
add address=172.17.X.0/24 list=Admin
add address=172.16.X.0/24 list=Admin
add address=172.16.X.X list=Sonos
add address=172.16.X.X list=Sonos
add address=172.16.X.X list=Sonos
add address=172.16.X.X list=Sonos
add address=172.16.X.0/24 list=fragment_protected_IP
add address=172.16.X.0/24 list=IP_used_on_LAN
add address=10.10.X.0/24 list=fragment_protected_IP
add address=10.X.X.0/24 list=IP_used_on_LAN_WG
add address=172.16.X.0/24 list=IP_used_on_LAN_WG
add address=192.168.X.X/24 list=IP_used_on_LAN
add address=192.168.X.X/24 list=IP_used_on_LAN_WG
add address=9.9.9.9 comment=Quad9 list="DNS Servers"
