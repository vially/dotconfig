function fltools --argument-names cmd
    switch $cmd
        case download
            __fltools_download $argv
        case build-libflutter-engine
            __fltools_build_libflutter_engine $argv
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
    set -l engine_version (cat ~/.local/share/flutter-sdk/bin/internal/engine.version)
    set -l flutter_version (flutter --version | head -1 | awk '{ print $2; }')
    set -l src_dir ~/code/flutter-gn/src/out
    set -l dst_dir ~/.local/share/flutter-embedder-libs/"$flutter_version"

    mkdir -p "$dst_dir"

    set src_lib_names 'host_debug_unopt/libflutter_engine.so' 'host_debug_unopt/lib.unstripped/libflutter_engine.so' 'host_profile/libflutter_engine.so' 'host_release/libflutter_engine.so'
    set dst_lib_names 'libflutter_engine_debug.so' 'libflutter_engine_debug_unstripped.so' 'libflutter_engine_profile.so' 'libflutter_engine_release.so'

    echo "Copying engine libs into ~/.local/share/flutter-embedder-libs/$flutter_version"
    for src_lib_name in $src_lib_names
        if set -l index (contains -i -- $src_lib_name $src_lib_names)
            set -l dst "$dst_dir/$dst_lib_names[$index]"
            cp "$src_dir/$src_lib_name" "$dst"

            __fltools_print_success (basename "$dst")
        end
    end
end

function __fltools_print_success
    set_color green
    echo -n '✓ '
    set_color normal
    echo $argv
end
