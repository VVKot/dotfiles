{pkgs, ...}: {
  home.packages = with pkgs; [
    cilium-cli
    dive
    gopls
    helm-ls
    k9s
    kind
    kubectl
    krew
    kubernetes-helm
    kyverno-chainsaw
    yaml-language-server
  ];
}
