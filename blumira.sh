#!/bin/bash
saveTo=~/github/mikrotik/scripts
now=$(date);
echo "# Generated by autogenscript on $now" > $saveTo/blumira.rsc
echo "/ip firewall address-list" >> $saveTo/blumira.rsc
curl  https://storage.googleapis.com/blumira_block_lists/51ab3aa4_66e9_4d9b_96ce_77ec9efe7393_blumira_ip.txt | awk '{ print "add list=Blumira_Block_List=" $1 "/32 comment=Blumira";}' >> $saveTo/blumira.rsc
