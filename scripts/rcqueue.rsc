# 2024-07-31 12:11:01 by RouterOS 7.14.2
# software id = FS4C-5DUN
#
# model = CCR2004-16G-2S+
# serial number = HF2098MDQN6
/queue tree
add comment="Outbound to WAN " limit-at=250M max-limit=250M name=Outbound-WAN \
    parent=ether1 queue=ethernet-default
add limit-at=20M max-limit=20M name=OB-WAN-QoS1 packet-mark=PM-QoS1 parent=\
    Outbound-WAN priority=1 queue=ethernet-default
add limit-at=9M max-limit=10M name=OB-WAN-QoS2 packet-mark=PM-QoS2 parent=\
    Outbound-WAN priority=2 queue=ethernet-default
add limit-at=1M max-limit=1M name=OB-WAN-QoS3 packet-mark=PM-QoS3 parent=\
    Outbound-WAN priority=3 queue=ethernet-default
add limit-at=5M max-limit=10M name=OB-WAN-QoS4 packet-mark=PM-QoS4 parent=\
    Outbound-WAN priority=4 queue=ethernet-default
add limit-at=150M max-limit=200M name=OB-WAN-default packet-mark=no-mark \
    parent=Outbound-WAN queue=ethernet-default
add comment="Outbound to LAN " name=Outbound-LAN parent=bridge1 queue=\
    ethernet-default
add name=OB-LAN-QoS1 packet-mark=PM-QoS1 parent=Outbound-LAN priority=1 \
    queue=ethernet-default
add name=OB-LAN-QoS2 packet-mark=PM-QoS2 parent=Outbound-LAN priority=2 \
    queue=ethernet-default
add name=OB-LAN-QoS3 packet-mark=PM-QoS3 parent=Outbound-LAN priority=3 \
    queue=ethernet-default
add name=OB-LAN-QoS4 packet-mark=PM-QoS4 parent=Outbound-LAN priority=4 \
    queue=ethernet-default
add name=OB-LAN-default packet-mark=no-mark parent=Outbound-LAN queue=\
    ethernet-default
