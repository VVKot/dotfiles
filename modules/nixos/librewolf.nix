args @ {pkgs, ...}: {
  programs.librewolf = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "Default";
        isDefault = true;
        extensions = {
          force = true;
          # https://gitlab.com/rycee/nur-expressions/-/blob/master/pkgs/firefox-addons/generated-firefox-addons.nix
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            consent-o-matic
            flagfox
            keepassxc-browser
            languagetool
            privacy-badger
            sponsorblock
            tranquility-1
            ublock-origin
          ];
        };
        search = {
          force = true;
          default = "google";

          order = [
            "ddg"
            "youtube"
            "NixOS Options"
            "Nix Packages"
            "Sourcegraph"
            "google"
          ];

          engines = {
            "bing".metaData.hidden = true;
            "amazondotcom-us".metaData.hidden = true;

            "youtube" = {
              icon = "https://youtube.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@yt"];
              urls = [
                {
                  template = "https://www.youtube.com/results";
                  params = [
                    {
                      name = "search_query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "Nix Packages" = {
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "NixOS Options" = {
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };

            "Sourcegraph" = {
              icon = "https://sourcegraph.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@so"];

              urls = [
                {
                  template = "https://sourcegraph.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };
            "imdb" = {
              icon = "https://www.imdb.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@imdb"];

              urls = [
                {
                  template = "https://www.imdb.com/find";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };
          };
        };
      };
    };

    settings = {
      "devtools.policy.disabled" = true;

      "webgl.disabled" = false;
      "gfx.webrender.all" = true;
      "media.ffmpeg.vaapi.enabled" = true;
      "media.ffmpeg.dmabuf-textures.enabled" = true;
      "widget.wayland-dmabuf-vaapi.enabled" = true;
      "layers.acceleration.force-enabled" = true;

      "privacy.clearOnShutdown.cookies" = false;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;

      "dom.push.enabled" = false;
      "dom.push.connection.enabled" = false;
      "dom.battery.enabled" = false;

      "extensions.autoDisableScopes" = 0;
      "extensions.update.enabled" = false;
      # for home-manager
      "extensions.webextensions.ExtensionStorageIDB.enabled" = false;
    };
  };

  programs.browserpass = {
    enable = true;
    browsers = ["librewolf"];
  };

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";
    BROWSER = "${pkgs.librewolf}/bin/librewolf";
  };
}
