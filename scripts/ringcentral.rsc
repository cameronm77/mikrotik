# 2024-07-31 12:08:28 by RouterOS 7.14.2
# software id = FS4C-5DUN
#
# model = CCR2004-16G-2S+
# serial number = HF2098MDQN6
/ip firewall mangle
add action=passthrough chain=prerouting comment=\
    "===> Process traffic to/from RingCentral apps and RCM PtP <===" \
    disabled=yes
add action=jump chain=prerouting comment=\
    "Check all traffic going TO RingCentral address space." dst-address-list=\
    RingCentral jump-target=MGL-ToRC
add action=jump chain=prerouting comment=\
    "Check all traffic coming FROM RC address space." jump-target=MGL-FromRC \
    src-address-list=RingCentral
add action=jump chain=prerouting comment="Look for RCM PtP Video." dst-port=\
    8850-8869 jump-target=MGL-SetQoS2 protocol=udp
add action=jump chain=MGL-ToRC comment="Classify NEW connections" \
    connection-state=new jump-target=MGL-NewToRC
add action=jump chain=MGL-ToRC comment="Process QoS1" connection-mark=\
    CMK-QoS-1 jump-target=MGL-SetQoS1
add action=jump chain=MGL-ToRC comment="Process QoS2" connection-mark=\
    CMK-QoS-2 jump-target=MGL-SetQoS2
add action=jump chain=MGL-ToRC comment="Process QoS3" connection-mark=\
    CMK-QoS-3 jump-target=MGL-SetQoS3
add action=jump chain=MGL-ToRC comment="Process QoS4" connection-mark=\
    CMK-QoS-4 jump-target=MGL-SetQoS4
add action=jump chain=MGL-FromRC comment="Process QoS1" connection-mark=\
    CMK-QoS-1 jump-target=MGL-SetQoS1
add action=jump chain=MGL-FromRC comment="Process QoS2" connection-mark=\
    CMK-QoS-2 jump-target=MGL-SetQoS2
add action=jump chain=MGL-FromRC comment="Process QoS3" connection-mark=\
    CMK-QoS-3 jump-target=MGL-SetQoS3
add action=jump chain=MGL-FromRC comment="Process QoS4" connection-mark=\
    CMK-QoS-4 jump-target=MGL-SetQoS4
add action=jump chain=MGL-NewToRC comment="Mark RTP traffic" dst-port=\
    20000-64999,8803 jump-target=MGL-MarkQoS1 protocol=udp
add action=return chain=MGL-NewToRC connection-mark=!no-mark
add action=jump chain=MGL-NewToRC comment="Mark Video RT" jump-target=\
    MGL-MarkQoS2 port=8801-8802,8810-8829,10000-19999,3478-3479 protocol=udp
add action=return chain=MGL-NewToRC connection-mark=!no-mark
add action=jump chain=MGL-NewToRC comment="Mark Video RT" jump-target=\
    MGL-MarkQoS2 port=8801-8802 protocol=tcp
add action=return chain=MGL-NewToRC connection-mark=!no-mark
add action=jump chain=MGL-NewToRC comment="Mark SIP control traffic (tcp)" \
    dst-port=5090-5099,8083-8090,1720 jump-target=MGL-MarkQoS3 protocol=tcp
add action=return chain=MGL-NewToRC connection-mark=!no-mark
add action=jump chain=MGL-NewToRC comment="Mark SIP control traffic (udp)" \
    dst-port=5090-5099 jump-target=MGL-MarkQoS3 protocol=udp
add action=return chain=MGL-NewToRC connection-mark=!no-mark
add action=jump chain=MGL-NewToRC comment="Default to QoS4" jump-target=\
    MGL-MarkQoS4
add action=return chain=MGL-NewToRC
add action=passthrough chain=MGL-MarkQoS1 comment=\
    "Mark Connection as EF (QoS-1)"
add action=mark-connection chain=MGL-MarkQoS1 new-connection-mark=CMK-QoS-1 \
    passthrough=yes
add action=return chain=MGL-MarkQoS1
add action=passthrough chain=MGL-MarkQoS2 comment=\
    "Mark Connection as AF41 (QoS-2)"
add action=mark-connection chain=MGL-MarkQoS2 new-connection-mark=CMK-QoS-2 \
    passthrough=yes
add action=return chain=MGL-MarkQoS2
add action=passthrough chain=MGL-MarkQoS3 comment=\
    "Mark Connection as AF31 (QoS-3)"
add action=mark-connection chain=MGL-MarkQoS3 new-connection-mark=CMK-QoS-3 \
    passthrough=yes
add action=return chain=MGL-MarkQoS3
add action=passthrough chain=MGL-MarkQoS4 comment=\
    "Mark Connection as AF21 (QoS-4)"
add action=mark-connection chain=MGL-MarkQoS4 new-connection-mark=CMK-QoS-4 \
    passthrough=yes
add action=return chain=MGL-MarkQoS4
add action=change-dscp chain=MGL-SetQoS1 comment=\
    "Set QoS1's packets DSCP to EF" new-dscp=46 passthrough=yes
add action=set-priority chain=MGL-SetQoS1 new-priority=5 passthrough=yes
add action=mark-packet chain=MGL-SetQoS1 new-packet-mark=PM-QoS1 passthrough=\
    no
add action=change-dscp chain=MGL-SetQoS2 comment=\
    "Set QoS2's packets DSCP to AF41" new-dscp=34 passthrough=yes
add action=set-priority chain=MGL-SetQoS2 new-priority=4 passthrough=yes
add action=mark-packet chain=MGL-SetQoS2 new-packet-mark=PM-QoS2 passthrough=\
    no
add action=change-dscp chain=MGL-SetQoS3 comment=\
    "Set QoS3's packets DSCP to AF31" new-dscp=26 passthrough=yes
add action=set-priority chain=MGL-SetQoS3 new-priority=3 passthrough=yes
add action=mark-packet chain=MGL-SetQoS3 new-packet-mark=PM-QoS3 passthrough=\
    no
add action=change-dscp chain=MGL-SetQoS4 comment=\
    "Set QoS4's packets DSCP to AF21" new-dscp=18 passthrough=yes
add action=set-priority chain=MGL-SetQoS4 new-priority=2 passthrough=yes
add action=mark-packet chain=MGL-SetQoS4 new-packet-mark=PM-QoS4 passthrough=\
    no
