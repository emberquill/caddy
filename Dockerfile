FROM caddy:2.8.0-builder-alpine AS builder

RUN xcaddy build --with github.com/caddy-dns/cloudflare

FROM caddy:2.8.0-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
