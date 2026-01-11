# Rhodium - System Resource Limits
#
# Configures resource limits for user processes.
# Required for vmtouch to lock browser binaries in RAM.
{ ... }:
{
  # Increase memory lock limit for vmtouch browser preloading
  # Firefox + Brave = ~500-800MB of binaries to lock
  # Setting to 2GB to be safe (unlimited would also work)
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "memlock";
      value = "2097152"; # 2GB in KB
    }
    {
      domain = "*";
      type = "hard";
      item = "memlock";
      value = "2097152"; # 2GB in KB
    }
  ];
}
