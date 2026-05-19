{ pkgs, pkgs-unstable, llama-cpp, lib, ... }:

{
  virtualisation.podman.enable = true;

  services.llama-cpp = {
    enable = true;

    package = (pkgs.llama-cpp.override {
      cudaSupport = true;
    }).overrideAttrs (old: {
      src     = llama-cpp;
      version = "git-${llama-cpp.shortRev or "unknown"}";

      postPatch = ''
        echo "int LLAMA_BUILD_NUMBER = 9999;"                                         > common/build-info.cpp
        echo "char const *LLAMA_COMMIT = \"${llama-cpp.shortRev or "unknown"}\";"   >> common/build-info.cpp
        echo "char const *LLAMA_COMPILER = \"gcc\";"                                >> common/build-info.cpp
        echo "char const *LLAMA_BUILD_TARGET = \"x86_64\";"                         >> common/build-info.cpp
      '' + (old.postPatch or "");

      cmakeFlags = (old.cmakeFlags or []) ++ [
        "-DCMAKE_CUDA_ARCHITECTURES=120"
        "-DGGML_CUDA_FA_ALL_QUANTS=ON"
      ];
    });

    host  = "127.0.0.1";
    port  = 1337;
    model = "/var/lib/llama-cpp/models/Qwen3.6-35B.gguf";

    extraFlags = [
      "--n-gpu-layers"  "99"
      "--n-cpu-moe"     "25"
      "--flash-attn"    "on"
      "--cache-type-k"  "q8_0"
      "--cache-type-v"  "q8_0"
      "--ctx-size"      "32768"
      "--batch-size"    "2048"
      "--ubatch-size"   "512"
      "--threads"       "14"
      "--no-mmap"
      "--parallel"      "1"
      "--jinja"
    ];
  };

  systemd.services.llama-cpp.wantedBy = lib.mkForce [];

  virtualisation.oci-containers = {
    backend = "podman";
    containers.open-webui = {
      image   = "ghcr.io/open-webui/open-webui:main";
      volumes = [ "open-webui:/app/backend/data" ];
      environment = {
        OLLAMA_API_BASE_URL  = "http://127.0.0.1:1337/v1";
        OPENAI_API_BASE_URL  = "http://127.0.0.1:1337/v1";
        OPENAI_API_KEY       = "dummy";
        WEBUI_AUTH           = "False";
      };
      extraOptions = [ "--network=host" ];
    };
  };
}
