/system scheduler
add interval=1h name="Failed Login" on-event=Faled_Login_Script policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2024-01-02 start-time=21:00:00
add interval=1h name="Failed Login No User" on-event=\
    Failed_Login_no_User_Exist policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2024-01-02 start-time=21:15:00
