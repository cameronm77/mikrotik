/system script
add dont-require-permissions=no name=Faled_Login_Script owner=cmilani policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/\
    log\r\
    \n:global failmsg  \"login failure for user \"\r\
    \n:global frommsg  \" from \"\r\
    \n:global viamsg   \" via \"\r\
    \n:global listfail \"list_failed_attempt\"\r\
    \n:foreach rlog in=[find where message~\"((25[0-5]|(2[0-4]|[01]\\\?[0-9]\\\
    \?)[0-9])\\\\.){3}(25[0-5]|(2[0-4]|[01]\\\?[0-9]\\\?)[0-9])\"] do={\r\
    \n    :local rmess [get \$rlog message]\r\
    \n    :if ((\$rmess~\$failmsg) and (\$rmess~\$frommsg) and (\$rmess~\$viam\
    sg)) do={\r\
    \n         :local userinside [:pick \$rmess ([:find \$rmess \$failmsg -1] \
    + [:len \$failmsg]) [:find \$rmess \$frommsg -1]]\r\
    \n         :local ipinside [:pick \$rmess ([:find \$rmess \$frommsg -1] + \
    [:len \$frommsg]) [:find \$rmess \$viamsg -1]]\r\
    \n         :local intinside [:pick \$rmess ([:find \$rmess \$viamsg -1] + \
    [:len \$viamsg]) [:len \$rmess]]\r\
    \n         /ip firewall address-list\r\
    \n         :if ([:len [find where list=\$listfail and address=\$ipinside]]\
    \_= 0) do={\r\
    \n             add list=\$listfail address=\$ipinside comment=\"\$rmess\"\
    \r\
    \n         }\r\
    \n    }\r\
    \n}"
add dont-require-permissions=no name=Failed_Login_no_User_Exist owner=cmilani \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    source="/log\r\
    \n:global failmsg  \"login failure for user \"\r\
    \n:global frommsg  \" from \"\r\
    \n:global viamsg   \" via \"\r\
    \n:global listfail \"list_failed_attempt\"\r\
    \n:foreach rlog in=[find where message~\"((25[0-5]|(2[0-4]|[01]\\\?[0-9]\\\
    \?)[0-9])\\\\.){3}(25[0-5]|(2[0-4]|[01]\\\?[0-9]\\\?)[0-9])\"] do={\r\
    \n    :local rmess [get \$rlog message]\r\
    \n    :if ((\$rmess~\$failmsg) and (\$rmess~\$frommsg) and (\$rmess~\$viam\
    sg)) do={\r\
    \n         :local userinside [:pick \$rmess ([:find \$rmess \$failmsg -1] \
    + [:len \$failmsg]) [:find \$rmess \$frommsg -1]]\r\
    \n         :local ipinside [:pick \$rmess ([:find \$rmess \$frommsg -1] + \
    [:len \$frommsg]) [:find \$rmess \$viamsg -1]]\r\
    \n         :local intinside [:pick \$rmess ([:find \$rmess \$viamsg -1] + \
    [:len \$viamsg]) [:len \$rmess]]\r\
    \n         :if ([:len [/user find where name=\$userinside]] = 0) do={\r\
    \n             /ip firewall address-list\r\
    \n             :if ([:len [find where list=\$listfail and address=\$ipinsi\
    de]] = 0) do={\r\
    \n                 add list=\$listfail address=\$ipinside comment=\"\$rmes\
    s\"\r\
    \n             }\r\
    \n         }\r\
    \n    }\r\
    \n}"
