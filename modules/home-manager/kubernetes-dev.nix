{pkgs, ...}: {
  home.packages = with pkgs; [
    cilium-cli
    dive
    gopls
    helm-ls
    k9s
    kind
    krew
    kubectl
    kubernetes-helm
    systemd-lsp
    yaml-language-server
  ];
}
