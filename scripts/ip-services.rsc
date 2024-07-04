/ip service
set telnet address=172.16.1.0/24 disabled=yes
set ftp address=172.16.1.0/24 disabled=yes
set www address=10.16.0.0/16
set ssh address=172.16.1.0/24,10.100.1.0/24
set www-ssl address=172.16.1.0/24,10.100.1.0/24 certificate=\
    letsencrypt-autogen_2023-12-25T21:42:05Z disabled=no tls-version=only-1.2
set api address=172.16.1.0/24,10.100.1.0/24
set winbox address=172.16.1.0/24,10.100.1.0/24
set api-ssl address=172.16.1.0/24,10.100.1.0/24 certificate=\
    letsencrypt-autogen_2023-12-25T21:42:05Z tls-version=only-1.2
