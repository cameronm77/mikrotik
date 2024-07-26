# Download the following lists
curl https://raw.githubusercontent.com/SecOps-Institute/Tor-IP-Addresses/master/tor-exit-nodes.lst -o tor_exits.out -s
curl https://www.spamhaus.org/drop/drop.txt -o spamhaus_drop.out -s
curl https://www.spamhaus.org/drop/edrop.txt -o spamhaus_edrop.out -s
curl https://sslbl.abuse.ch/blacklist/sslipblacklist.txt -o sslbl.out -s
curl https://lists.blocklist.de/lists/all.txt-o blocklist_de.out -s
curl https://cinsscore.com/list/ci-badguys.txt -o cinsarmy.out -s
curl https://feodotracker.abuse.ch/downloads/ipblocklist.txt -o feodo.out -s
curl https://iplists.firehol.org/files/firehol_level1.netset -o firehol_l1.out -s
curl https://iplists.firehol.org/files/firehol_level2.netset -o firehol_l2.out -s

# dshield entires are in /24 
curl https://feeds.dshield.org/block.txt -o dshield.in -s
grep '^[1-9]' dshield.in | awk '{print $1"/24"}' > dshield.out

# add tor_exits
curl https://check.torproject.org/torbulkexitlist -o tor_exits.out -s

# add blumira entries
curl https://storage.googleapis.com/blumira_block_lists/51ab3aa4_66e9_4d9b_96ce_77ec9efe7393_blumira_ip.txt -o blumira.out -s 

# Combine all lists into one big file, explicit remove teams ip, and internal lan ip
cat *.out | grep -Eo '(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\/([0-9]|[1-2][0-9]|3[0-2]))?' | awk '!/\//{$0=$0"/32"}{print}' | sed -E '/^(22[4-9]|23[0-9]|172\.16|52\.113\.194\.132|0\.)/d' | aggregate-prefixes | sed 's/\/32$//' | sed '$a\240.0.0.0/4' > blocklist.txt

# Create array 
cat blocklist.txt | awk '{print ":set newips (newips,\""$0"\")"}' > blocklists.rsc
sed -i '1 i\\:global newips \[\:toarray \"\"\]' blocklists.rsc


