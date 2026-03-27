let
  categories = {
    infrastructure = "infrastructure";
    monitoring = "monitoring";
    storage = "storage";
    media = "media";
    productivity = "productivity";
    security = "security";
    development = "development";
    external = "external";
  };
in
{
  infrastructure = {
    authelia = {
      profile = "Personal";
      url = "https://auth.rhodium.sh/";
      description = "Authelia";
      categories = [ categories.security ];
    };
    cloudflare-dashboard = {
      profile = "Personal";
      url = "https://dash.cloudflare.com/";
      description = "Cloudflare Dashboard";
      categories = [ categories.external ];
    };
    cloudflare-dns = {
      profile = "Personal";
      url = "https://dns.rhodium.sh/install.html";
      description = "Cloudflare DNS";
      categories = [ categories.infrastructure ];
    };
    drone = {
      profile = "Personal";
      url = "https://drone.rhodium.sh/";
      description = "Drone CI";
      categories = [ categories.development ];
    };
    homepage = {
      profile = "Personal";
      url = "https://dashboard.rhodium.sh/";
      description = "Homepage";
      categories = [ categories.infrastructure ];
    };
    namecheap = {
      profile = "Personal";
      url = "https://www.namecheap.com/myaccount/login/?ReturnUrl=%2fDomains%2fDomainControlPanel%2frhodium.sh%2fdomain%2f";
      description = "Namecheap";
      categories = [ categories.external ];
    };
    tailscale = {
      profile = "Personal";
      url = "https://login.tailscale.com/admin/machines";
      description = "Tailscale";
      categories = [ categories.infrastructure ];
    };
    traefik = {
      profile = "Personal";
      url = "https://traefik.rhodium.sh/dashboard/#/";
      description = "Traefik";
      categories = [ categories.infrastructure ];
    };
    vaultwarden = {
      profile = "Personal";
      url = "https://vault.rhodium.sh/";
      description = "Vaultwarden";
      categories = [ categories.security ];
    };
  };

  monitoring = {
    grafana = {
      profile = "Personal";
      url = "https://grafana.rhodium.sh/?orgId=1&from=now-6h&to=now&timezone=browser&refresh=30s";
      description = "Grafana";
      categories = [ categories.monitoring ];
    };
  };

  storage = {
    backups = {
      profile = "Personal";
      url = "https://backups.rhodium.sh/";
      description = "Backups";
      categories = [ categories.storage ];
    };
    nextcloud = {
      profile = "Personal";
      url = "https://cloud.rhodium.sh/";
      description = "Nextcloud";
      categories = [
        categories.storage
        categories.productivity
      ];
    };
    registry = {
      profile = "Personal";
      url = "https://registry.rhodium.sh/";
      description = "Image Registry";
      categories = [ categories.storage ];
    };
  };

  media = {
    calibre = {
      profile = "Personal";
      url = "https://books.rhodium.sh/";
      description = "Calibre-Web";
      categories = [ categories.media ];
    };
    immich = {
      profile = "Personal";
      url = "https://pictures.rhodium.sh/";
      description = "Immich";
      categories = [ categories.media ];
    };
    navidrome = {
      profile = "Personal";
      url = "https://music.rhodium.sh/";
      description = "Navidrome";
      categories = [ categories.media ];
    };
    plex = {
      profile = "Personal";
      url = "http://192.168.178.141:32400/web/index.html#!/";
      description = "Plex";
      categories = [ categories.media ];
    };
    prowlarr = {
      profile = "Personal";
      url = "https://indexers.rhodium.sh/";
      description = "Prowlarr";
      categories = [ categories.media ];
    };
    qbittorrent = {
      profile = "Personal";
      url = "https://downloads.rhodium.sh/";
      description = "qBittorrent";
      categories = [ categories.media ];
    };
    radarr = {
      profile = "Personal";
      url = "https://films.rhodium.sh/";
      description = "Radarr";
      categories = [ categories.media ];
    };
    sonarr = {
      profile = "Personal";
      url = "https://shows.rhodium.sh/";
      description = "Sonarr";
      categories = [ categories.media ];
    };
  };

  productivity = {
    pastebin = {
      profile = "Personal";
      url = "https://paste.rhodium.sh/";
      description = "PasteBin";
      categories = [ categories.productivity ];
    };
  };

  development = {
    langfuse = {
      profile = "Personal";
      url = "http://192.168.1.117:3000/project/proj-agent-fleet";
      description = "Langfuse";
      categories = [ categories.development ];
    };
    llms = {
      profile = "Personal";
      url = "https://llm.rhodium.sh/";
      description = "LLMs";
      categories = [ categories.development ];
    };
    temporal = {
      profile = "Personal";
      url = "http://192.168.1.117:8088/namespaces/default/workflows";
      description = "Temporal Workflows";
      categories = [ categories.development ];
    };
  };
}
