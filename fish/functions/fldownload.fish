function fldownload
    # Common artifact names: 'linux-x64-embedder.zip', `artifacts.zip`
    set -l artifact_name 'linux-x64-embedder.zip'
    wget "https://storage.googleapis.com/flutter_infra_release/flutter/"(cat ~/.local/share/flutter-sdk/bin/internal/engine.version)"/linux-x64/$artifact_name"
end
