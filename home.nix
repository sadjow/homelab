let

  domain = "thewagner.home";

  disable-loki-tests = self: super: {
    grafana-loki = super.grafana-loki.overrideAttrs (oldAttrs: rec {
      doCheck = false;
    });
  };

in

{
  network.description = "${domain} infrastructure";

  ipc = {
    imports = [
      ./hardware/ipc.nix
      ./modules/common.nix
      ./modules/consul.nix
      ./modules/git.nix
      ./modules/mqtt.nix
      ./modules/node-exporter.nix
      ./modules/promtail.nix
      ./modules/traefik.nix

      (
        { config, ... }:
        {
          nixpkgs.overlays = [ disable-loki-tests ];
        }
      )
    ];

  };

  nuc = {
    imports = [
      ./hardware/nuc.nix
      ./modules/common.nix
      ./modules/consul.nix
      ./modules/grafana.nix
      ./modules/loki.nix
      ./modules/node-exporter.nix
      ./modules/prometheus.nix
      ./modules/promtail.nix
      ./modules/remote-builder.nix
    ];
  };

  rp3 = {
    imports = [
      ./hardware/rp3.nix
      ./modules/common.nix
      ./modules/consul.nix
      ./modules/node-exporter.nix
      ./modules/promtail.nix
      ./modules/remote-builder.nix
    ];
  };
}
