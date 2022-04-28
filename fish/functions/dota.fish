function dota
    set -l cmd $argv[1]

    pushd ~/.steam/steam/steamapps/common/dota\ 2\ beta/game/bin/linuxsteamrt64/
    # TODO: Create backup files if they don't exist
    rm libSDL2-2.0.so.0 libpango-1.0.so libpangoft2-1.0.so

    if [ "$cmd" = "patch" ]
        ln -s /usr/lib/libpangoft2-1.0.so .
        ln -s /usr/lib/libpango-1.0.so .
        ln -s /home/vially/code/SDL/build/libSDL2-2.0d.so.0 libSDL2-2.0.so.0
    else
        cp libpangoft2-1.0.so.backup libpangoft2-1.0.so
        cp libpango-1.0.so.backup libpango-1.0.so
        cp libSDL2-2.0.so.0.backup libSDL2-2.0.so.0
    end
    popd
end
