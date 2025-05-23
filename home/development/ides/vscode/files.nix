# home/development/ides/vscode/files.nix

{
  # File encoding and line endings
  "files.encoding" = "utf8";
  "files.eol" = "\n";
  "files.insertFinalNewline" = true;
  "files.trimTrailingWhitespace" = true;

  # File associations
  "files.associations" = {
    "*.jpg" = "binary";
    "*.jpeg" = "binary";
    "*.png" = "binary";
    "*.gif" = "binary";
    "*.ico" = "binary";
    "*.icns" = "binary";
    "*.nix" = "nix";
  };

  # File exclusions for explorer
  "files.exclude" = {
    "**/.git" = true;
    "**/.svn" = true;
    "**/.hg" = true;
    "**/CVS" = true;
    "**/.DS_Store" = true;
    "**/Thumbs.db" = true;
    "**/__pycache__" = true;
    "**/.venv" = true;
    "**/.ruff_cache" = true;
    "**/.mypy_cache" = true;
    "**/.pytest_cache" = true;
    "**/result" = true;
  };

  # Search exclusions
  "search.exclude" = {
    "**/.git" = true;
    "**/.svn" = true;
    "**/.hg" = true;
    "**/CVS" = true;
    "**/.DS_Store" = true;
    "**/Thumbs.db" = true;
    "**/__pycache__" = true;
    "**/.venv" = true;
    "**/.ruff_cache" = true;
    "**/.mypy_cache" = true;
    "**/.pytest_cache" = true;
    "**/result" = true;
  };

  # File watcher exclusions
  "files.watcherExclude" = {
    "**/.git/objects/**" = true;
    "**/.git/subtree-cache/**" = true;
    "**/.hg/store/**" = true;
    "**/__pycache__" = true;
    "**/.pytest_cache" = true;
    "**/.mypy_cache" = true;
    "**/.ruff_cache" = true;
    "**/result" = true;
  };
}
