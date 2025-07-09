{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.scripts;

  # Target scripts dir
  scriptsSourcePath = ../scripts;
  
  # Target folders
  validFolders = [
    "common"
    "docker" 
    "fuzzel"
    "launchers"
    "rdp"
    "rofi"
    "testing"
    "utils"
    "waybar"
  ];
  
  # Read the scripts directory
  scriptsDir = builtins.readDir scriptsSourcePath;
  
  # Validate and filter dirs
  isValidFolder = name: let
    fileType = scriptsDir.${name};
    isDirectory = fileType == "directory";
    isValidName = builtins.elem name validFolders;
  in
    isDirectory && isValidName;
  
  # Get list of valid folder names
  validFolderNames = lib.filter isValidFolder (builtins.attrNames scriptsDir);
  
  # Process each valid folder to find .sh files
  processFolder = folderName: let
    folderPath = scriptsSourcePath + "/${folderName}";
    folderContents = builtins.readDir folderPath;
    
    # Validate individual script files
    isScript = fileName: let
      fileType = folderContents.${fileName};
      isRegularFile = fileType == "regular";
      hasRequiredExtension = lib.hasSuffix ".sh" fileName || lib.hasSuffix ".py" fileName; # NOTE: Python scripts are accepted.
    in
      isRegularFile && hasRequiredExtension;
    
    # Get script files in this folder
    scriptFiles = lib.filter isScript (builtins.attrNames folderContents);
    
    # Create folder/script pairs
    folderScriptPairs = map (scriptFile: {
      folder = folderName;
      script = scriptFile;
      relativePath = "${folderName}/${scriptFile}";
    }) scriptFiles;
  in
    folderScriptPairs;
  
  # Collect all script information from all valid folders
  allScriptInfo = lib.flatten (map processFolder validFolderNames);
  
  # Create symlink for a single script
  mkScriptLink = scriptInfo: let
    sourcePath = "${scriptsSourcePath}/${scriptInfo.relativePath}";
    targetPath = "${config.home.sessionVariables.XDG_BIN_HOME}/${scriptInfo.relativePath}";
  in {
    "${targetPath}" = {
      source = config.lib.file.mkOutOfStoreSymlink sourcePath;
      executable = true;
    };
  };
  
  # Generate all script symlinks
  allScriptLinks = lib.foldl' (acc: scriptInfo: acc // (mkScriptLink scriptInfo)) {} allScriptInfo;

in {
  options.scripts = {
    enable = mkEnableOption "Link individual scripts to local bin path with executable permissions";
  };
  
  config = mkIf cfg.enable {
    home.file = allScriptLinks;
    
    # Ensure bin directory exists
    home.activation.create-script-dirs = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p "${config.home.sessionVariables.XDG_BIN_HOME}"
    '';
  };
}
