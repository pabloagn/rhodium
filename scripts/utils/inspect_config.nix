# scripts/utils/inspect_config.nix

{ target ? "hosts", maxDepth ? 10 }:

let
  pkgs = import <nixpkgs> {};

  # Configuration paths mapping
  configPaths = {
    hosts = ../../data/hosts/hosts.nix;
    users = ../../data/users/users.nix;
  };

  # Import the configuration
  configData =
    let path = configPaths.${target} or null; in
    if path == null then
      throw "Unknown target: ${target}"
    else
      import path { inherit pkgs; };

  # Safely inspect attributes with depth limit and cycle detection
  inspectWithTypes =
    let
      # Inner recursive function with accumulator for visited paths
      inspect = depth: visited: prefix: value:
        let
          type = builtins.typeOf value;

          # Check if we should stop recursion
          shouldStop =
            depth >= maxDepth ||
            builtins.elem prefix visited;

          # Base case - we've reached max depth, found a cycle, or not an attrset
          baseCase = ["${prefix} = ${type}"];

          # Recursive case for attribute sets
          recurseAttrs =
            let
              # Update visited paths
              newVisited = visited ++ [ prefix ];

              # Process each attribute
              processAttr = name: attrValue:
                let newPrefix = if prefix == "" then name else prefix + "." + name; in
                inspect (depth + 1) newVisited newPrefix attrValue;

              # Map over all attributes and concatenate results
              attrResults = builtins.attrValues (builtins.mapAttrs processAttr value);
            in
            ["${prefix} = ${type}"] ++ builtins.concatLists attrResults;
        in
        if shouldStop then baseCase
        else if type == "set" && builtins.isAttrs value then recurseAttrs
        else baseCase;
    in
    # Start the recursion with empty visited list
    inspect 0 [] "" configData;

  result = builtins.concatStringsSep "\n" inspectWithTypes;
in
result
