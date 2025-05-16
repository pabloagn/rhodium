# assets/fonts/visualize.nix

let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  fontData = import ./fonts.nix;
  fonts = fontData.fonts;
  fontDirs = fontData.fontDirectories;

  # Helper to determine font style from filename
  getFontStyle = filename:
    let
      lowercase = lib.toLower filename;
      isBold = lib.hasInfix "bold" lowercase;
      isItalic = lib.hasInfix "italic" lowercase || lib.hasInfix "oblique" lowercase;
    in {
      weight = if isBold then "bold" else "normal";
      style = if isItalic then "italic" else "normal";
      name = if isBold && isItalic then "Bold Italic"
            else if isBold then "Bold"
            else if isItalic then "Italic"
            else "Regular";
    };

  # Function to generate the CSS for @font-face declaration
  makeFontFaceCSS = fontDir: fontData:
    let
      fontName = fontData.fontName;
      # Sanitize font name for CSS class (remove spaces, etc.)
      cssName = builtins.replaceStrings [" "] ["-"] (lib.toLower fontName);

      # Generate @font-face declarations for each font file
      makeFontFace = fontFile:
        let
          style = getFontStyle fontFile.name;
          format = if lib.hasSuffix ".otf" fontFile.name then "opentype"
                  else if lib.hasSuffix ".ttf" fontFile.name then "truetype"
                  else "opentype";
        in ''
          @font-face {
            font-family: '${fontName}';
            src: url('file://${builtins.toString fontFile.path}') format('${format}');
            font-weight: ${style.weight};
            font-style: ${style.style};
          }
        '';
    in
    ''
      /* Font: ${fontName} */
      ${lib.concatMapStrings makeFontFace fontData.fontFiles}

      .font-${cssName} {
        font-family: '${fontName}', sans-serif;
      }
    '';

  # Get available font styles for a font
  getFontStyles = fontData:
    let
      styleMap = builtins.listToAttrs (map
        (fontFile: {
          name = (getFontStyle fontFile.name).name;
          value = getFontStyle fontFile.name;
        })
        fontData.fontFiles
      );
    in
      builtins.attrNames styleMap;

  # Create a font sample card for display
  makeFontSampleCard = fontDir: fontData:
    let
      fontName = fontData.fontName;
      cssName = builtins.replaceStrings [" "] ["-"] (lib.toLower fontName);
      fontSizes = ["12px" "14px" "16px" "18px" "24px"];

      # Get available styles
      styles = getFontStyles fontData;

      # Create sample text in different sizes
      makeSampleText = fontSize:
        ''
          <div class="font-sample-row">
            <div class="font-size-label">${fontSize}</div>
            <div class="font-sample font-${cssName}" style="font-size: ${fontSize};">
              ABCDEFGHIJKLM abcdefghijklm 0123456789 !@#$%^&*()
            </div>
          </div>
        '';

      # Generate buttons for different font weights/styles
      makeStyleButtons =
        let
          makeStyleButton = styleName:
            let
              style = getFontStyle styleName;
            in ''
              <button class="style-button${if styleName == "Regular" then " active" else ""}"
                      data-style="${style.style}"
                      data-weight="${style.weight}">
                ${styleName}
              </button>
            '';
        in
        ''
          <div class="font-style-buttons">
            ${lib.concatMapStrings makeStyleButton styles}
          </div>
        '';

      # List font files available
      fontFilesList =
        let
          makeFontFileItem = fontFile:
            ''<li>${fontFile.name}</li>'';
        in
        ''
          <div class="font-files">
            <h3>Font Files</h3>
            <ul>
              ${lib.concatMapStrings makeFontFileItem fontData.fontFiles}
            </ul>
          </div>
        '';
    in
    ''
      <div class="font-card" id="font-${cssName}">
        <div class="font-card-header">
          <h2 class="font-title font-${cssName}">${fontName}</h2>
          <div class="font-meta">
            <span class="font-type">${fontData.fontType}</span>
            <span class="font-license">${fontData.fontLicense}</span>
            <span class="font-dir">${fontDir}</span>
          </div>
          ${makeStyleButtons}
        </div>
        <div class="font-samples">
          ${lib.concatMapStrings makeSampleText fontSizes}
        </div>
        <div class="font-code-sample">
          <h3>Code Sample</h3>
          <pre class="font-${cssName}">function example() {
  const message = "Hello, World!";
  console.log(message);
  return message.length;
}</pre>
        </div>
        ${fontFilesList}
      </div>
    '';
in
pkgs.writeTextFile {
  name = "font-preview";
  text = ''
    <!DOCTYPE html>
    <html>
    <head>
      <title>NixOS Font Library</title>
      <meta charset="UTF-8">
      <style>
        body {
          font-family: system-ui, -apple-system, sans-serif;
          line-height: 1.5;
          margin: 0;
          padding: 20px;
          color: #333;
          background-color: #f9f9f9;
        }

        h1 {
          text-align: center;
          margin-bottom: 40px;
          color: #222;
        }

        /* Font Face Declarations */
        ${lib.concatMapStrings (fontDir: makeFontFaceCSS fontDir fonts.${fontDir}) fontDirs}

        /* Font Cards */
        .font-card {
          background: white;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
          margin-bottom: 40px;
          padding: 30px;
          transition: transform 0.2s ease;
        }

        .font-card:hover {
          transform: translateY(-5px);
          box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .font-card-header {
          margin-bottom: 25px;
          border-bottom: 1px solid #eee;
          padding-bottom: 15px;
        }

        .font-title {
          font-size: 32px;
          margin: 0 0 10px 0;
          font-weight: normal;
        }

        .font-meta {
          display: flex;
          gap: 15px;
          margin-bottom: 15px;
          font-size: 14px;
          color: #666;
        }

        .font-type, .font-license, .font-dir {
          background: #f0f0f0;
          padding: 3px 8px;
          border-radius: 4px;
        }

        .font-style-buttons {
          display: flex;
          gap: 10px;
          margin-top: 15px;
        }

        .style-button {
          background: #f0f0f0;
          border: 1px solid #ddd;
          border-radius: 4px;
          padding: 5px 10px;
          cursor: pointer;
          font-size: 14px;
          transition: all 0.2s;
        }

        .style-button:hover {
          background: #e0e0e0;
        }

        .style-button.active {
          background: #4a6da7;
          color: white;
          border-color: #4a6da7;
        }

        .font-samples {
          margin-bottom: 30px;
        }

        .font-sample-row {
          display: flex;
          margin-bottom: 15px;
          align-items: center;
        }

        .font-size-label {
          width: 50px;
          font-size: 14px;
          color: #666;
          flex-shrink: 0;
        }

        .font-sample {
          flex-grow: 1;
          white-space: nowrap;
          overflow: hidden;
          text-overflow: ellipsis;
        }

        .font-code-sample {
          background: #f5f5f5;
          border-radius: 6px;
          padding: 20px;
          margin-bottom: 20px;
        }

        .font-code-sample h3 {
          margin-top: 0;
          margin-bottom: 15px;
          color: #444;
          font-size: 18px;
        }

        .font-code-sample pre {
          margin: 0;
          font-size: 16px;
          line-height: 1.4;
          overflow-x: auto;
        }

        .font-files {
          background: #f9f9f9;
          border-radius: 6px;
          padding: 20px;
        }

        .font-files h3 {
          margin-top: 0;
          margin-bottom: 15px;
          color: #444;
          font-size: 18px;
        }

        .font-files ul {
          margin: 0;
          padding-left: 20px;
        }

        .font-files li {
          margin-bottom: 5px;
          font-family: monospace;
          font-size: 14px;
        }

        .font-nav {
          position: sticky;
          top: 20px;
          background: white;
          margin-bottom: 30px;
          padding: 15px;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
          z-index: 100;
        }

        .font-nav h2 {
          margin-top: 0;
          margin-bottom: 15px;
          font-size: 20px;
        }

        .font-links {
          display: flex;
          flex-wrap: wrap;
          gap: 10px;
        }

        .font-link {
          padding: 8px 12px;
          background: #f0f0f0;
          border-radius: 4px;
          text-decoration: none;
          color: #333;
          transition: background 0.2s;
        }

        .font-link:hover {
          background: #e0e0e0;
        }

        /* Testing input */
        .test-input-container {
          margin-bottom: 30px;
        }

        .test-input-container h2 {
          margin-bottom: 15px;
        }

        #testInput {
          width: 100%;
          padding: 15px;
          font-size: 16px;
          border: 1px solid #ddd;
          border-radius: 6px;
          margin-bottom: 10px;
        }
      </style>
    </head>
    <body>
      <h1>NixOS Font Library</h1>

      <div class="test-input-container">
        <h2>Test with your own text</h2>
        <input type="text" id="testInput" placeholder="Type some text to preview with all fonts..." value="The quick brown fox jumps over the lazy dog." />
      </div>

      <div class="font-nav">
        <h2>Available Fonts (${toString (builtins.length fontDirs)})</h2>
        <div class="font-links">
          ${lib.concatMapStrings (fontDir:
            let
              fontName = fonts.${fontDir}.fontName;
              cssName = builtins.replaceStrings [" "] ["-"] (lib.toLower fontName);
            in ''
              <a href="#font-${cssName}" class="font-link">${fontName}</a>
            ''
          ) fontDirs}
        </div>
      </div>

      <!-- Font Cards -->
      ${lib.concatMapStrings (fontDir: makeFontSampleCard fontDir fonts.${fontDir}) fontDirs}

      <script>
document.addEventListener('DOMContentLoaded', function() {
  // Style button functionality
  document.querySelectorAll('.style-button').forEach(button => {
    button.addEventListener('click', function() {
      const fontCard = this.closest('.font-card');

      // Update active button
      fontCard.querySelectorAll('.style-button').forEach(btn => {
        btn.classList.remove('active');
      });
      this.classList.add('active');

      // Apply font style
      const style = this.getAttribute('data-style');
      const weight = this.getAttribute('data-weight');

      fontCard.querySelectorAll('.font-sample, pre, .font-title').forEach(el => {
        el.style.fontStyle = style;
        el.style.fontWeight = weight;
      });
    });
  });

  // Custom text input
  const testInput = document.getElementById('testInput');
  testInput.addEventListener('input', function() {
    const text = this.value || 'ABCDEFGHIJKLM abcdefghijklm 0123456789 !@#$%^&*()';
    document.querySelectorAll('.font-sample').forEach(el => {
      el.textContent = text;
    });
  });
});
      </script>
    </body>
    </html>
  '';
  destination = "/tmp/fontpreview.html";
}
