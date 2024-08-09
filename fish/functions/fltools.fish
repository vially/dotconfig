function fltools --argument-names cmd
    switch $cmd
        case download
            __fltools_download $argv
        case build-libflutter-engine
            __fltools_build_libflutter_engine $argv
        case uninstall-version
            __fltools_uninstall_version $argv
        case '*'
            echo "Unknown fltools sub-command: $cmd"
            return 1
    end
end

function __fltools_download
    # Common artifact names: 'linux-x64-embedder.zip', `artifacts.zip`
    set -l artifact_name 'linux-x64-embedder.zip'
    set -l engine_version (cat ~/.local/share/flutter-sdk/bin/internal/engine.version)
    wget "https://storage.googleapis.com/flutter_infra_release/flutter/$engine_version/linux-x64/$artifact_name"
end

function __fltools_build_libflutter_engine
    set -l flutter_gn_root ~/code/flutter-gn
    set -l flutter_src_dir "$flutter_gn_root/src"
    set -l flutter_src_out_dir "$flutter_gn_root/src/out"
    set -l flutter_src_flutter_dir "$flutter_gn_root/src/flutter"

    set -l engine_version (cat ~/.local/share/flutter-sdk/bin/internal/engine.version)
    set -l flutter_version (flutter --version | head -1 | awk '{ print $2; }')
    set -l flutter_channel (flutter channel | grep '*' | awk '{ print $2 }')

    pushd "$flutter_src_flutter_dir"
    echo "Fetching upstream git changes"
    git fetch upstream --prune
    if test "$flutter_channel" = master
        git checkout "$engine_version"
    else
        git checkout "$flutter_version"
    end
    popd

    pushd "$flutter_gn_root"
    echo "Running 'gclient sync -D'"
    gclient sync -D
    popd

    pushd "$flutter_src_dir"

    echo "Building Flutter for Debug mode"
    ./flutter/tools/gn --runtime-mode=debug --unoptimized
    ninja -C "./out/host_debug_unopt"

    echo "Building Flutter for Release mode"
    ./flutter/tools/gn --runtime-mode=release
    ninja -C "./out/host_release"

    echo "Building Flutter for Profile mode"
    ./flutter/tools/gn --runtime-mode=profile
    ninja -C "./out/host_profile"

    popd

    set src_lib_names 'host_debug_unopt/libflutter_engine.so' 'host_debug_unopt/lib.unstripped/libflutter_engine.so' 'host_profile/libflutter_engine.so' 'host_release/libflutter_engine.so'
    set dst_lib_names "libflutter_engine_debug-$flutter_version.so" "libflutter_engine_debug_unstripped-$flutter_version.so" "libflutter_engine_profile-$flutter_version.so" "libflutter_engine_release-$flutter_version.so"
    set -l dst_dir ~/.cache/flutter-engine-lib

    mkdir -p "$dst_dir"

    echo "Copying engine libs into ~/.cache/flutter-engine-lib"
    for src_lib_name in $src_lib_names
        if set -l index (contains -i -- $src_lib_name $src_lib_names)
            set -l dst "$dst_dir/$dst_lib_names[$index]"
            cp "$flutter_src_out_dir/$src_lib_name" "$dst"

            __fltools_print_success (basename "$dst")
        end
    end

    echo -e "\nCreating engine lib symlinks"
    pushd "$dst_dir"

    for build_mode in debug profile release
        mkdir -p "$dst_dir/by-flutter-version/$flutter_version/$build_mode"
        ln -s "../../../libflutter_engine_$build_mode-$flutter_version.so" "$dst_dir/by-flutter-version/$flutter_version/$build_mode/libflutter_engine.so"
        __fltools_print_success "by-flutter-version/$flutter_version/$build_mode/libflutter_engine.so"

        mkdir -p "$dst_dir/by-engine-version/$engine_version/$build_mode"
        ln -s "../../../libflutter_engine_$build_mode-$flutter_version.so" "$dst_dir/by-engine-version/$engine_version/$build_mode/libflutter_engine.so"
        __fltools_print_success "by-engine-version/$engine_version/$build_mode/libflutter_engine.so"
    end

    popd
end

function __fltools_uninstall_version
    set -l flutter_version $argv[2]
    set -l base_cache_dir ~/.cache/flutter-engine-lib

    pushd "$base_cache_dir"
    set -l engine_version (basename (dirname (dirname (find -type l -ilname "*-$flutter_version*.so" -print -quit))))
    popd

    rm -r "$base_cache_dir/by-engine-version/$engine_version/"{debug,profile,release}
    rmdir "$base_cache_dir/by-engine-version/$engine_version"
    __fltools_print_success "Removed $base_cache_dir/by-engine-version/$engine_version"

    rm -r "$base_cache_dir/by-flutter-version/$flutter_version/"{debug,profile,release}
    rmdir "$base_cache_dir/by-flutter-version/$flutter_version"
    __fltools_print_success "Removed $base_cache_dir/by-engine-version/$flutter_version"

    set lib_names "libflutter_engine_debug-$flutter_version.so" "libflutter_engine_debug_unstripped-$flutter_version.so" "libflutter_engine_profile-$flutter_version.so" "libflutter_engine_release-$flutter_version.so"
    for lib_name in $lib_names
        rm "$base_cache_dir/$lib_name"
        __fltools_print_success "Removed $base_cache_dir/$lib_name"
    end
end

function __fltools_print_success
    set_color green
    echo -n '✓ '
    set_color normal
    echo $argv
end
