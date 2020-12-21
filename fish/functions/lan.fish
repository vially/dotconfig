function lan
    sudo networkctl up enp5s0
    sleep 5
    sudo networkctl down wlan0
end
