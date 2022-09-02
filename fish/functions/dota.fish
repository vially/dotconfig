function dota
    set -l cmd $argv[1]

    pushd ~/.steam/steam/steamapps/common/dota\ 2\ beta/game/bin/linuxsteamrt64/

    if [ "$cmd" = "patch" ]
        # TODO: Create backup files if they don't exist
        rm libSDL2-2.0.so.0
        ln -s /home/vially/code/SDL/build/libSDL2-2.0.so.0 libSDL2-2.0.so.0
    else
        cp libSDL2-2.0.so.0.backup libSDL2-2.0.so.0
    end
    popd
end
