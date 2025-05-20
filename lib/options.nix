# lib/options.nix

{ lib, inputs, flakeRootPath, ... }:

# Helper function to generate the options for individual packages
# specs: A list of attribute sets, each with:
#   - name: The name for the option (e.g., "atuin")
#   - description: A short description for the enable option
#   - (optional) default: Boolean, defaults to true if not specified for the enable option
# Returns an attribute set of options
let
  mkIndividualPackageOptions = specs:
    lib.listToAttrs (lib.map
      (spec:
        lib.nameValuePair spec.name {
          enable = lib.mkEnableOption spec.description // { default = spec.default or true; };
        }
      )
      specs);
in
{
  mkIndividualPackageOptions = mkIndividualPackageOptions;
}
