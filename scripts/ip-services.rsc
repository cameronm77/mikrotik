:local commName ['"YOU_DOMAIN_HERE"]
:local certName [get /certificate [find where common-name=$commName] name]

/ip service
set telnet address=172.16.1.0/24 disabled=yes
set ftp address=172.16.1.0/24 disabled=yes
set www address=10.16.0.0/16
set ssh address=172.16.1.0/24,10.100.1.0/24
set www-ssl address=172.16.1.0/24,10.100.1.0/24 certificate=$certName disabled=no tls-version=only-1.2
set api address=172.16.1.0/24,10.100.1.0/24
set winbox address=172.16.1.0/24,10.100.1.0/24
set api-ssl address=172.16.1.0/24,10.100.1.0/24 certificate=$certName tls-version=only-1.2
