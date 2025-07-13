{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Common Lisp ---
    sbcl # Common Lisp compiler (Steel Bank Common Lisp)
  ];
}
