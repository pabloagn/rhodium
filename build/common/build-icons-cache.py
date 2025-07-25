#!/usr/bin/env python3

import os
import sys
import json
import subprocess
from pathlib import Path
from wcwidth import wcwidth, wcswidth

# --- Constants ---
GROUP = "fuzzel"
KEY = "icons"


# --- Metadata Loading ---
def load_metadata(group: str, key: str) -> dict:
    xdg_data_home = os.getenv("XDG_DATA_HOME", os.path.expanduser("~/.local/share"))
    metadata_path = Path(xdg_data_home) / "rhodium-utils" / "metadata.json"

    if not metadata_path.is_file():
        sys.stderr.write(f"[ERROR] Metadata file not found: {metadata_path}\n")
        sys.exit(1)

    with open(metadata_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    try:
        group_data = data[group]
        entry = group_data[key]
        required_fields = ["name", "title", "prompt"]

        for field in required_fields:
            if (
                field not in entry
                or not isinstance(entry[field], str)
                or not entry[field].strip()
            ):
                raise ValueError(
                    f"Missing or invalid field: '{field}' in {group}/{key}"
                )

        return {
            "APP_NAME": entry["name"],
            "APP_TITLE": entry["title"],
            "PROMPT": entry["prompt"],
        }

    except KeyError:
        sys.stderr.write(f"[ERROR] No metadata entry found for {group}/{key}\n")
        sys.exit(1)
    except ValueError as ve:
        sys.stderr.write(f"[ERROR] {ve}\n")
        sys.exit(1)


# --- Prompt Notification ---
def notify(title: str, message: str):
    subprocess.run(["notify-send", title, message], check=False)


# --- Unicode Padding ---
def pad(text: str, width: int) -> str:
    actual_width = wcswidth(text)
    if actual_width >= width:
        trimmed = ""
        count = 0
        for ch in text:
            w = wcwidth(ch)
            if w < 0:
                continue
            if count + w > width - 1:
                break
            trimmed += ch
            count += w
        return trimmed + "…"
    return text + " " * (width - actual_width)


# --- Dependency Check ---
def check_dependencies(unicode_path: Path, app_title: str):
    if not unicode_path.is_file():
        notify(app_title, f"Unicode JSON not found at {unicode_path}")
        sys.exit(1)


# --- Cache Builder ---
def build_cache(unicode_path: Path, cache_dir: Path):
    with open(unicode_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    flat_lines = []
    block_names = []

    for block, categories in data.items():
        block_names.append(block)
        for category, entries in categories.items():
            for entry in entries:
                symbol = entry["symbol"]
                name = entry["name"]
                formatted = f"{pad(symbol, 4)} {pad(name, 60)} {block} > {category}"
                flat_lines.append(f"{formatted}\t{symbol}")

    cache_dir.mkdir(parents=True, exist_ok=True)

    flat_file = cache_dir / "flat_symbols.cache"
    block_file = cache_dir / "blocks.cache"

    with open(flat_file, "w", encoding="utf-8") as f:
        f.write("\n".join(sorted(flat_lines)))

    with open(block_file, "w", encoding="utf-8") as f:
        f.write("\n".join(sorted(block_names)))


# --- Entrypoint ---
def main():
    meta = load_metadata(GROUP, KEY)

    unicode_path = Path(os.path.expanduser("~/.local/share/icons/icons.json"))
    cache_dir = (
        Path(os.getenv("XDG_CACHE_HOME", os.path.expanduser("~/.cache")))
        / meta["APP_NAME"]
    )

    check_dependencies(unicode_path, meta["APP_TITLE"])
    build_cache(unicode_path, cache_dir)
    notify(meta["APP_TITLE"], "Unicode cache built successfully")


if __name__ == "__main__":
    main()
