{lib}: metadata:
lib.mapAttrs
(
  top: group:
    lib.mapAttrs
    (
      sub: val:
        val
        // {
          name = "${top}-${sub}";
          prompt = "${val.prompt}: ";
        }
    )
    group
)
metadata
