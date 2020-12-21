function wifi
    sudo networkctl up wlan0
    sleep 5
    sudo networkctl down enp5s0
end
