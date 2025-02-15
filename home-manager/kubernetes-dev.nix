{pkgs, ...}: {
  home.packages = [
    pkgs.cilium-cli
    pkgs.dive
    pkgs.gopls
    pkgs.helm-ls
    pkgs.k9s
    pkgs.kind
    pkgs.kubectl
    pkgs.kubernetes-helm
    pkgs.kyverno-chainsaw
    pkgs.yaml-language-server
  ];
}
