# assets/icons/unicode.nix

let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  unicode = import ./unicode.nix;

  # Escape single quotes for use in HTML attributes
  escapeQuote = str: builtins.replaceStrings ["'"] ["\\\""] str;
in
pkgs.writeTextFile {
  name = "unicode-chars";
  text = ''
    <!DOCTYPE html>
    <html>
    <head>
      <title>Unicode Character Library</title>
      <meta charset="UTF-8">
      <style>
        body {
          font-family: sans-serif;
          max-width: 1200px;
          margin: 0 auto;
          padding: 20px;
          line-height: 1.6;
          background-color: #f9f9f9;
        }
        h1 {
          text-align: center;
          margin-bottom: 30px;
          color: #333;
        }
        h2 {
          margin-top: 40px;
          border-bottom: 1px solid #ddd;
          padding-bottom: 10px;
          color: #333;
        }
        .char-grid {
          display: grid;
          grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
          gap: 15px;
          margin-bottom: 30px;
        }
        .char-card {
          display: flex;
          align-items: center;
          padding: 12px;
          border-radius: 6px;
          background-color: white;
          border: 1px solid #eee;
          transition: all 0.2s ease;
          box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .char-card:hover {
          transform: translateY(-2px);
          box-shadow: 0 3px 6px rgba(0,0,0,0.1);
        }
        .char-display {
          font-size: 28px;
          width: 45px;
          height: 45px;
          display: flex;
          align-items: center;
          justify-content: center;
          margin-right: 15px;
          background-color: #f5f5f5;
          border-radius: 4px;
        }
        .char-info {
          flex: 1;
        }
        .char-name {
          font-weight: bold;
          margin-bottom: 5px;
          color: #333;
        }
        .char-code {
          font-family: monospace;
          font-size: 13px;
          color: #666;
          margin-bottom: 5px;
        }
        .button-row {
          display: flex;
          gap: 5px;
        }
        .copy-button {
          font-size: 12px;
          background: #f0f0f0;
          border: 1px solid #ddd;
          padding: 3px 8px;
          border-radius: 3px;
          cursor: pointer;
          transition: background 0.2s;
        }
        .copy-button:hover {
          background: #e0e0e0;
        }
        .category-nav {
          position: sticky;
          top: 10px;
          background-color: white;
          padding: 10px;
          border-radius: 6px;
          box-shadow: 0 2px 5px rgba(0,0,0,0.1);
          margin-bottom: 30px;
          z-index: 100;
        }
        .category-nav h3 {
          margin-top: 0;
          margin-bottom: 10px;
        }
        .category-links {
          display: flex;
          flex-wrap: wrap;
          gap: 10px;
        }
        .category-link {
          background-color: #f0f0f0;
          padding: 5px 10px;
          border-radius: 4px;
          text-decoration: none;
          color: #333;
          font-size: 14px;
          transition: background 0.2s;
        }
        .category-link:hover {
          background-color: #e0e0e0;
        }
        .search-container {
          margin-bottom: 20px;
        }
        #searchInput {
          width: 100%;
          padding: 10px;
          border-radius: 4px;
          border: 1px solid #ddd;
          font-size: 16px;
        }
        .filter-info {
          margin-top: 10px;
          font-size: 14px;
          color: #666;
        }
      </style>
    </head>
    <body>
      <h1>Unicode Character Library</h1>

      <div class="search-container">
        <input type="text" id="searchInput" placeholder="Search for characters..." />
        <div class="filter-info" id="filterInfo"></div>
      </div>

      <div class="category-nav">
        <h3>Categories</h3>
        <div class="category-links">
          ${lib.concatMapStrings (category:
            let
              categoryTitle = lib.toUpper (builtins.substring 0 1 category) + builtins.substring 1 (builtins.stringLength category - 1) category;
            in ''
              <a href="#${category}" class="category-link">${categoryTitle}</a>
            ''
          ) (builtins.attrNames unicode.unicode)}
        </div>
      </div>

      ${lib.concatMapStrings (category:
        let
          categoryAttrs = unicode.unicode.${category};
          categoryTitle = lib.toUpper (builtins.substring 0 1 category) + builtins.substring 1 (builtins.stringLength category - 1) category;
        in ''
          <h2 id="${category}">${categoryTitle}</h2>
          <div class="char-grid" data-category="${category}">
            ${lib.concatMapStrings (name:
              let
                char = categoryAttrs.${name}.char;
                code = categoryAttrs.${name}.code;
              in ''
                <div class="char-card" data-name="${name}" data-char="${escapeQuote char}" data-code="${escapeQuote code}">
                  <div class="char-display">${char}</div>
                  <div class="char-info">
                    <div class="char-name">${name}</div>
                    <div class="char-code">${code}</div>
                    <div class="button-row">
                      <button class="copy-button" data-char="${escapeQuote char}">Copy Char</button>
                      <button class="copy-button" data-code="${escapeQuote code}">Copy Code</button>
                    </div>
                  </div>
                </div>
              ''
            ) (builtins.attrNames categoryAttrs)}
          </div>
        ''
      ) (builtins.attrNames unicode.unicode)}

      <script>
      // Script included directly as text
document.addEventListener("DOMContentLoaded", function() {
  // Functionality for copy buttons
  document.addEventListener("click", function(event) {
    if (event.target.classList.contains("copy-button")) {
      const textToCopy = event.target.getAttribute("data-char") || event.target.getAttribute("data-code");
      navigator.clipboard.writeText(textToCopy).then(() => {
        const originalText = event.target.textContent;
        event.target.textContent = "Copied!";
        setTimeout(() => {
          event.target.textContent = originalText;
        }, 1500);
      });
    }
  });

  // Search functionality
  const searchInput = document.getElementById("searchInput");
  const filterInfo = document.getElementById("filterInfo");
  const charCards = document.querySelectorAll(".char-card");

  searchInput.addEventListener("input", function() {
    const searchTerm = this.value.toLowerCase();
    let visibleCount = 0;
    let totalCount = charCards.length;

    charCards.forEach(card => {
      const name = card.getAttribute("data-name").toLowerCase();
      const code = card.getAttribute("data-code").toLowerCase();
      const char = card.getAttribute("data-char");

      if (name.includes(searchTerm) || code.includes(searchTerm) || char.includes(searchTerm)) {
        card.style.display = "";
        visibleCount++;
      } else {
        card.style.display = "none";
      }
    });

    if (searchTerm) {
      filterInfo.textContent = "Showing " + visibleCount + " of " + totalCount + " characters";
    } else {
      filterInfo.textContent = "";
    }
  });
});
      </script>
    </body>
    </html>
  '';
  destination = "/tmp/unicode.html";
}
