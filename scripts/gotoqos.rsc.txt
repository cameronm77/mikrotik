/ip firewall address-list
add address=199.36.248.0/22 list=gtc-all
add address=199.87.120.0/22 list=gtc-all
add address=162.250.60.0/22l ist=gtc-all
add address=45.12.196.0/22 list=gtc-all
add address=202.173.24.0/21 list=gtc-all
add address=173.199.0.0/18 list=gtc-all
add address=23.239.224.0/19 list=gtc-all
add address=68.64.0.0/19 list=gtc-all

/ip firewall mangle
add chain=prerouting action=passthrough comment="DFLHD38947qpoinc marker" disabled=yes
add chain=prerouting action=jump comment="Look for GTC PtP Video." jump-target=MGL-SetQoS2 dst-port=8801-8802 protocol=udp place-before=([find where dynamic=no]->0)
add chain=prerouting action=jump comment="Check all traffic coming FROM GTC address space." jump-target=MGL-FromGTC src-address-list=gtc-all place-before=([find where dynamic=no]->0)
add chain=prerouting action=jump comment="Check all traffic going TO GTC address space." dst-address-list=gtc-all jump-target=MGL-ToGTC place-before=([find where dynamic=no]->0)
add chain=prerouting action=passthrough disabled=yes comment="===> Process traffic to/from GTC apps and GTC PtP <===" place-before=([find where dynamic=no]->0)
remove [find comment="DFLHD38947qpoinc marker"]

add chain=MGL-ToGTC action=jump comment="Classify NEW connections" connection-state=new jump-target=MGL-NewToGTC passthrough=yes
add chain=MGL-ToGTC action=jump comment="Process QoS1" connection-mark=CMK-QoS-1 jump-target=MGL-SetQoS1
add chain=MGL-ToGTC action=jump comment="Process QoS2" connection-mark=CMK-QoS-2 jump-target=MGL-SetQoS2
add chain=MGL-ToGTC action=jump comment="Process QoS3" connection-mark=CMK-QoS-3 jump-target=MGL-SetQoS3
add chain=MGL-ToGTC action=jump comment="Process QoS4" connection-mark=CMK-QoS-4  jump-target=MGL-SetQoS4
add chain=MGL-FromGTC action=jump comment="Process QoS1" connection-mark=CMK-QoS-1 jump-target=MGL-SetQoS1
add chain=MGL-FromGTC action=jump comment="Process QoS2" connection-mark=CMK-QoS-2  jump-target=MGL-SetQoS2
add chain=MGL-FromGTC action=jump comment="Process QoS3" connection-mark=CMK-QoS-3 jump-target=MGL-SetQoS3
add chain=MGL-FromGTC action=jump comment="Process QoS4" connection-mark=CMK-QoS-4 jump-target=MGL-SetQoS4
add chain=MGL-NewToGTC action=jump comment="Mark RTP traffic" jump-target=MGL-MarkQoS1 dst-port=45000-49999,8200,1853 protocol=udp
add chain=MGL-NewToGTC action=return connection-mark=!no-mark
add chain=MGL-NewToGTC action=jump comment="Mark Video RT" jump-target=MGL-MarkQoS2 port=8801-8802,3478 protocol=udp
add chain=MGL-NewToGTC action=return connection-mark=!no-mark
add chain=MGL-NewToGTC action=jump comment="Mark Video RT" jump-target=MGL-MarkQoS2 port=8801-8802,3478 protocol=tcp
add chain=MGL-NewToGTC action=return connection-mark=!no-mark
add chain=MGL-NewToGTC action=jump comment="Mark SIP control traffic (tcp)" dst-port=5060-5061,3000-4000,1720 jump-target=MGL-MarkQoS3 protocol=tcp
add chain=MGL-NewToGTC action=return connection-mark=!no-mark
add chain=MGL-NewToGTC action=jump comment="Mark SIP control traffic (udp)" jump-target=MGL-MarkQoS3 dst-port=5060-5061,3000-4000 protocol=udp
add chain=MGL-NewToGTC action=return connection-mark=!no-mark
add chain=MGL-NewToGTC action=jump comment="Default to QoS4" jump-target=MGL-MarkQoS4
add chain=MGL-NewToGTC action=return
add chain=MGL-MarkQoS1 action=passthrough comment="Mark Connection as EF (QoS-1)"
add chain=MGL-MarkQoS1 action=mark-connection new-connection-mark=CMK-QoS-1 passthrough=yes
add chain=MGL-MarkQoS1 action=return
add action=passthrough chain=MGL-MarkQoS2 comment="Mark Connection as AF41 (QoS-2)"
add action=mark-connection chain=MGL-MarkQoS2 new-connection-mark=CMK-QoS-2 passthrough=yes
add chain=MGL-MarkQoS2 action=return
add action=passthrough chain=MGL-MarkQoS3 comment="Mark Connection as AF31 (QoS-3)"
add action=mark-connection chain=MGL-MarkQoS3 new-connection-mark=CMK-QoS-3 passthrough=yes
add chain=MGL-MarkQoS3 action=return
add action=passthrough chain=MGL-MarkQoS4 comment="Mark Connection as AF21 (QoS-4)"
add action=mark-connection chain=MGL-MarkQoS4 new-connection-mark=CMK-QoS-4 passthrough=yes
add chain=MGL-MarkQoS4 action=return
add action=change-dscp chain=MGL-SetQoS1 comment="Set QoS1's packets DSCP to EF" new-dscp=46 passthrough=yes
add action=set-priority chain=MGL-SetQoS1 new-priority=5 passthrough=yes
add action=mark-packet chain=MGL-SetQoS1 new-packet-mark=PM-QoS1 passthrough=no
add action=change-dscp chain=MGL-SetQoS2 comment="Set QoS2's packets DSCP to AF41" new-dscp=34 passthrough=yes
add action=set-priority chain=MGL-SetQoS2 new-priority=4 passthrough=yes
add action=mark-packet chain=MGL-SetQoS2 new-packet-mark=PM-QoS2 passthrough=no
add action=change-dscp chain=MGL-SetQoS3 comment="Set QoS3's packets DSCP to AF31" new-dscp=26 passthrough=yes
add action=set-priority chain=MGL-SetQoS3 new-priority=3 passthrough=yes
add action=mark-packet chain=MGL-SetQoS3 new-packet-mark=PM-QoS3 passthrough=no
add action=change-dscp chain=MGL-SetQoS4 comment="Set QoS4's packets DSCP to AF21" new-dscp=18 passthrough=yes
add action=set-priority chain=MGL-SetQoS4 new-priority=2 passthrough=yes
add action=mark-packet chain=MGL-SetQoS4 new-packet-mark=PM-QoS4 passthrough=no

/queue tree
add comment="Outbound to WAN " limit-at=200M max-limit=200M name=Outbound-WAN parent=ether1 queue=ethernet-default
add limit-at=20M max-limit=20M name=OB-WAN-QoS1 packet-mark=PM-QoS1 parent=Outbound-WAN priority=1 queue=ethernet-default
add limit-at=9M max-limit=10M name=OB-WAN-QoS2 packet-mark=PM-QoS2 parent=Outbound-WAN priority=2 queue=ethernet-default
add limit-at=1M max-limit=1M name=OB-WAN-QoS3 packet-mark=PM-QoS3  parent=Outbound-WAN priority=3 queue=ethernet-default
add limit-at=5M max-limit=10M name=OB-WAN-QoS4 packet-mark=PM-QoS4 parent=Outbound-WAN priority=4 queue=ethernet-default
add limit-at=150M max-limit=200M name=OB-WAN-default packet-mark=no-mark parent=Outbound-WAN queue=ethernet-default
	
add comment="Outbound to LAN " name=Outbound-LAN parent=bridge queue=ethernet-default
add name=OB-LAN-QoS1 packet-mark=PM-QoS1 parent=Outbound-LAN priority=1 queue=ethernet-default
add name=OB-LAN-QoS2 packet-mark=PM-QoS2 parent=Outbound-LAN priority=2 queue=ethernet-default
add name=OB-LAN-QoS3 packet-mark=PM-QoS3 parent=Outbound-LAN priority=3 queue=ethernet-default
add name=OB-LAN-QoS4 packet-mark=PM-QoS4 parent=Outbound-LAN priority=4 queue=ethernet-default
add name=OB-LAN-default packet-mark=no-mark parent=Outbound-LAN queue=ethernet-default

/ip firewall service-port 
set sip disabled=yes
