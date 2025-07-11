{pkgs, ...}: {
  home.packages = with pkgs; [
    awscli2 # Main AWS Cli
    awslogs # Better AWS CloudWatch Logs
  ];
}
