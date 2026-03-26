{ pkgs, pkgs-unstable, ... }:
{
  home.packages =
    (with pkgs; [
      # --- AI Coding Agents ---
      codex # OpenAI's lightweight coding agent CLI
      gemini-cli # Google's Gemini CLI agent
      aider-chat # AI pair programming in terminal
      goose-cli # Open-source extensible AI agent by Block
    ])
    ++ (with pkgs-unstable; [
      # --- AI Coding Agents (Unstable) ---
      claude-code # Anthropic's CLI for Claude
      claude-monitor # Monitor for Claude Code sessions
    ]);
}
