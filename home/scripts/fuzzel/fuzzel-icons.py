#!/usr/bin/env python3
import os
import sys
import json
import subprocess
from pathlib import Path
from wcwidth import wcwidth, wcswidth

# --- Configuration ---
APP_NAME = "rhodium-unicode"
APP_TITLE = "Rhodium's Unicode Collection"
PROMPT = "β: "

# Padding config (affects display)
SYMBOL_PADDING = 4
NAME_PADDING = 60
CATEGORY_PADDING = 30

# Paths
UNICODE_JSON_FILE = os.path.expanduser("~/.local/share/icons/icons.json")
CACHE_DIR = os.path.join(
    os.getenv("XDG_CACHE_HOME", os.path.expanduser("~/.cache")), APP_NAME
)
CACHE_FILE_FLAT = os.path.join(CACHE_DIR, "flat_symbols.cache")
CACHE_FILE_BLOCKS = os.path.join(CACHE_DIR, "blocks.cache")


def notify(title, message):
    subprocess.run(["notify-send", title, message], check=False)


# def pad(text, width):
#     return text[: width - 1] + "…" if len(text) > width else text.ljust(width)

def pad(text, width):
    actual_width = wcswidth(text)
    if actual_width >= width:
        # Truncate while respecting Unicode width
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

def check_dependencies():
    if not Path(UNICODE_JSON_FILE).is_file():
        notify(APP_TITLE, f"Unicode JSON not found at {UNICODE_JSON_FILE}")
        sys.exit(1)


def build_cache():
    os.makedirs(CACHE_DIR, exist_ok=True)
    with open(UNICODE_JSON_FILE, "r", encoding="utf-8") as f:
        data = json.load(f)

    flat_lines = []
    block_names = []

    for block, categories in data.items():
        block_names.append(block)
        for category, entries in categories.items():
            for entry in entries:
                symbol = entry["symbol"]
                name = entry["name"]
                formatted = f"{pad(symbol, SYMBOL_PADDING)} {pad(name, NAME_PADDING)} {block} > {category}"
                flat_lines.append(f"{formatted}\t{symbol}")

    with open(CACHE_FILE_FLAT, "w", encoding="utf-8") as f:
        f.write("\n".join(sorted(flat_lines)))

    with open(CACHE_FILE_BLOCKS, "w", encoding="utf-8") as f:
        f.write("\n".join(sorted(block_names)))


def show_category_view(block):
    with open(UNICODE_JSON_FILE, "r", encoding="utf-8") as f:
        data = json.load(f)

    entries = []
    if block not in data:
        notify(APP_TITLE, f"Block not found: {block}")
        return

    for category, symbols in data[block].items():
        for entry in symbols:
            symbol = entry["symbol"]
            name = entry["name"]
            label = (
                f"{pad(symbol, SYMBOL_PADDING)} {pad(name, NAME_PADDING)} {category}"
            )
            entries.append(f"{label}\t{symbol}")

    menu = "\n".join(line.split("\t")[0] for line in entries)
    result = (
        subprocess.run(
            ["fuzzel", "--dmenu", "--prompt", f"Symbol ({block}): ", "-w", "100"],
            input=menu.encode(),
            capture_output=True,
        )
        .stdout.decode()
        .strip()
    )

    for line in entries:
        label, sym = line.split("\t")
        if label == result:
            subprocess.run(["wl-copy"], input=sym.encode())
            notify(APP_TITLE, f"Symbol copied to clipboard: {sym}")
            break


def browse_by_category():
    if not Path(CACHE_FILE_BLOCKS).is_file():
        build_cache()

    with open(CACHE_FILE_BLOCKS, "r", encoding="utf-8") as f:
        blocks = f.read()

    selected = (
        subprocess.run(
            ["fuzzel", "--dmenu", "--prompt", "Block: "],
            input=blocks.encode(),
            capture_output=True,
        )
        .stdout.decode()
        .strip()
    )

    if selected:
        show_category_view(selected)


def show_flattened_view():
    if not Path(CACHE_FILE_FLAT).is_file():
        build_cache()

    with open(CACHE_FILE_FLAT, "r", encoding="utf-8") as f:
        lines = f.readlines()

    menu = "".join(line.split("\t")[0] + "\n" for line in lines)
    selected = (
        subprocess.run(
            ["fuzzel", "--dmenu", "--prompt", "Symbol: ", "-w", "100"],
            input=menu.encode(),
            capture_output=True,
        )
        .stdout.decode()
        .strip()
    )

    for line in lines:
        label, symbol = line.strip().split("\t")
        if label == selected:
            subprocess.run(["wl-copy"], input=symbol.encode())
            notify(APP_TITLE, f"Symbol copied to clipboard: {symbol}")
            break


def main():
    check_dependencies()

    menu = "⊹ By Category\n⊹ Flattened View"
    selected = (
        subprocess.run(
            ["fuzzel", "--dmenu", "--prompt", PROMPT, "-l", "2"],
            input=menu.encode(),
            capture_output=True,
        )
        .stdout.decode()
        .strip()
    )

    if selected == "⊹ By Category":
        browse_by_category()
    elif selected == "⊹ Flattened View":
        show_flattened_view()
    elif selected:
        notify(APP_TITLE, f"Invalid option selected: {selected}")


if __name__ == "__main__":
    main()
