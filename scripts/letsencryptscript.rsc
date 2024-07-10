       /system script add name="Letsencrypt" owner="admin" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon dont-require-permissions=no run-count=0 source=
       :log info "LetsEncrypt Renewal"
       :local commName ['"sslvpn.thelifeguardstore.com"]
       
       /ip service set disabled=no [find where name="www"]
       :local certName [get [find where common-name=$commName] name]
       
       # set sstp server cert
       /interface sstp-server server set certificate=$certName
       
       
       /ip service set disabled=yes [find where name="www"]
       /ip firewall filter disable [find where comment="LetsEncrypt"]
