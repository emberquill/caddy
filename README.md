# Caddy with Cloudflare DNS

Very simple docker image that builds [Caddy](https://github.com/caddyserver/caddy) with the [Cloudflare DNS](https://github.com/caddy-dns/cloudflare) plugin so Caddy can handle Cloudflare DNS-01 challenges. I run multiple instances of Caddy across several servers, and I figured having to rebuild it locally on every update was silly. So I put it in the GitHub Container Registry.

## Usage

Just set an environment variable containing a Cloudflare API token with `Zone.Zone` and `Zone.DNS` permissions for your domain. Here is an example docker-compose with the values that would be different from an ordinary caddy setup:

```yaml
services:
    caddy:
        image: ghcr.io/emberquill/caddy:latest
        environment:
            CLOUDFLARE_API_TOKEN: <CLOUDFLARE API TOKEN>
(Truncated)
```

Then in your Caddyfile, add tls blocks to whichever domains need them as shown in the [example](https://github.com/caddy-dns/cloudflare#config-examples) in the Cloudflare plugin repo, using the environment variable you previously configured:

```
your.domain.name:443 {
    reverse_proxy some_container:80

    tls {
        dns cloudflare {env.CLOUDFLARE_API_TOKEN}
    }
}
```
