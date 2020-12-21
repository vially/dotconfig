function audiodaemon
    set -l svc $argv[1]
    if [ "$svc" = "pulseaudio" ]
        systemctl --user mask pipewire.service pipewire.socket
        systemctl --user stop pipewire

        systemctl --user unmask pulseaudio.service pulseaudio.socket
        systemctl --user start pulseaudio
    else if [ "$svc" = "pipewire" ]
        systemctl --user mask pulseaudio.service pulseaudio.socket
        systemctl --user stop pulseaudio

        systemctl --user unmask pipewire.service pipewire.socket
        systemctl --user start pipewire
    end
end
