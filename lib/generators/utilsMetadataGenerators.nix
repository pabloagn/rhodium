{lib}: metadata:
lib.mapAttrs
(
  top: group:
    lib.mapAttrs
    (
      sub: val:
        val
        // {
          name = "rh-${top}-${sub}"; # NOTE: We use the rh- prefix for increased discoverability
          prompt = "${val.prompt}: ";
        }
    )
    group
)
metadata
