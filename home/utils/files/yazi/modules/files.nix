{ pkgs }:
{
  "yazi/plugins/markdown.sh" = import ../plugins/markdown-preview.nix { inherit pkgs; };

  # Custom glow style for markdown preview - matching kanso theme
  "glow/kanso.json".text = builtins.toJSON {
    document = {
      block_prefix = "\n";
      block_suffix = "\n";
      color = "#C5C9C7";
      margin = 2;
    };
    block_quote = {
      indent = 1;
      indent_token = "│ ";
      color = "#6B7E84";
    };
    paragraph = { };
    list = {
      level_indent = 2;
    };
    heading = {
      block_suffix = "\n";
      color = "#C5C9C7";
      bold = true;
    };
    h1 = {
      prefix = "# ";
      color = "#C5C9C7";
      bold = true;
    };
    h2 = {
      prefix = "## ";
      color = "#C5C9C7";
      bold = true;
    };
    h3 = {
      prefix = "### ";
      color = "#A4A7A4";
      bold = true;
    };
    h4 = {
      prefix = "#### ";
      color = "#A4A7A4";
    };
    h5 = {
      prefix = "##### ";
      color = "#8EA4A2";
    };
    h6 = {
      prefix = "###### ";
      color = "#6B7E84";
      bold = false;
    };
    text = { };
    strikethrough = {
      crossed_out = true;
    };
    emph = {
      italic = true;
      color = "#8EA4A2";
    };
    strong = {
      bold = true;
      color = "#C5C9C7";
    };
    hr = {
      color = "#22262D";
      format = "\n────────\n";
    };
    item = {
      block_prefix = "• ";
    };
    enumeration = {
      block_prefix = ". ";
    };
    task = {
      ticked = "[✓] ";
      unticked = "[ ] ";
    };
    link = {
      color = "#8BA4B0";
      underline = true;
    };
    link_text = {
      color = "#7AA89F";
      bold = true;
    };
    image = {
      color = "#938AA9";
      underline = true;
    };
    image_text = {
      color = "#6B7E84";
      format = "Image: {{.text}} →";
    };
    code = {
      prefix = " ";
      suffix = " ";
      color = "#87A987";
      background_color = "#0f1316";
    };
    code_block = {
      color = "#C5C9C7";
      margin = 2;
      chroma = {
        text = {
          color = "#C5C9C7";
        };
        error = {
          color = "#C5C9C7";
          background_color = "#E46876";
        };
        comment = {
          color = "#6B7E84";
        };
        comment_preproc = {
          color = "#7AA89F";
        };
        keyword = {
          color = "#938AA9";
        };
        keyword_reserved = {
          color = "#938AA9";
        };
        keyword_namespace = {
          color = "#938AA9";
        };
        keyword_type = {
          color = "#8BA4B0";
        };
        operator = {
          color = "#C5C9C7";
        };
        punctuation = {
          color = "#A4A7A4";
        };
        name = {
          color = "#C5C9C7";
        };
        name_builtin = {
          color = "#7AA89F";
        };
        name_tag = {
          color = "#8BA4B0";
        };
        name_attribute = {
          color = "#E6C384";
        };
        name_class = {
          color = "#E6C384";
        };
        name_constant = {
          color = "#B98D7B";
        };
        name_decorator = {
          color = "#E6C384";
        };
        name_exception = {
          color = "#E46876";
        };
        name_function = {
          color = "#8BA4B0";
        };
        name_other = {
          color = "#C5C9C7";
        };
        literal = {
          color = "#B98D7B";
        };
        literal_number = {
          color = "#B98D7B";
        };
        literal_date = {
          color = "#B98D7B";
        };
        literal_string = {
          color = "#87A987";
        };
        literal_string_escape = {
          color = "#7AA89F";
        };
        generic_deleted = {
          color = "#E46876";
        };
        generic_emph = {
          italic = true;
        };
        generic_inserted = {
          color = "#87A987";
        };
        generic_strong = {
          bold = true;
        };
        generic_subheading = {
          color = "#8BA4B0";
        };
      };
    };
    table = {
      center_separator = "┼";
      column_separator = "│";
      row_separator = "─";
    };
    definition_list = { };
    definition_term = { };
    definition_description = {
      block_prefix = "\n";
    };
    html_block = { };
    html_span = { };
  };
}
