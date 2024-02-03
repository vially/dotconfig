function fltools --argument-names cmd
    switch $cmd
        case download
            __fltools_download $argv
    end
end

function __fltools_download
    # Common artifact names: 'linux-x64-embedder.zip', `artifacts.zip`
    set -l artifact_name 'linux-x64-embedder.zip'
    set -l engine_version (cat ~/.local/share/flutter-sdk/bin/internal/engine.version)
    wget "https://storage.googleapis.com/flutter_infra_release/flutter/$engine_version/linux-x64/$artifact_name"
end
