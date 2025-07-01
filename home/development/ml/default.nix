{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options = {
    programs.development.ml = {
      enable = mkEnableOption "ML development tools";
    };
  };
  config = mkIf config.programs.development.ml.enable {
    home.packages = with pkgs; [
      # --- AI Agent Frameworks ---
      autogen # Framework for building autonomous AI agents

      # --- Data Versioning ---
      dvc # Git for data, models, and pipelines

      # --- Language Models ---
      llama-cpp # C/C++ implementation of LLaMA model inference
      ollama # Run large language models locally
      text-generation-webui # Web UI to run and fine-tune language models locally

      # --- Model Tools ---
      ggml-tools # Tools for working with GGML quantized models
      huggingface-cli # CLI for downloading and managing Hugging Face models

      # --- NLP Frameworks ---
      haystack # End-to-end framework for building NLP pipelines

      # --- Speech Recognition ---
      whisper-cpp # Low-resource C++ port of OpenAI's Whisper

      # --- UI Interfaces ---
      comfyui # Node-based UI for advanced Stable Diffusion workflows

      # --- Vector Databases ---
      milvus # Open-source vector database for similarity search
      qdrant # Vector database management for semantic search
    ];
  };
}
