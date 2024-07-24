:global questions { 
    {   text="What is name of device?"; 
        defval="";
        validate="str" 
        min=0;
        max=16;
        key="name"
    };
    {   text="What is IPv4 of LAN"; 
        defval="172.16.1.0/24"; 
        validate="ip"
        key="lanip"
    };
    {   text="What is IPv4 of WAN if Static"; 
        defval="$[:rndnum from=1 to=254].$[:rndnum from=0 to=255].$[:rndnum from=0 to=255].$[:rndnum from=0 to=255]"; 
        validate="ip"
        key="wanip"
    }
}
