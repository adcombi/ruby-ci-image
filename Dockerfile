ARG ruby_version=3.4.12
FROM ruby:${ruby_version}

# Install common CI dependencies. Debian's Chromium and ChromeDriver packages
# are version-matched and available on both amd64 and arm64.
RUN set -eux; \
    apt-get update; \
    if apt-cache show libvips42t64 >/dev/null 2>&1; then vips_pkg=libvips42t64; else vips_pkg=libvips42; fi; \
    apt-get install -y --no-install-recommends \
        gosu \
        curl \
        gnupg \
        unzip \
        jq \
        "${vips_pkg}" \
        chromium \
        chromium-driver; \
    curl -sL https://deb.nodesource.com/setup_22.x | bash -; \
    apt-get install -y --no-install-recommends nodejs; \
    npm install -g yarn; \
    rm -rf /var/lib/apt/lists/*; \
    gosu nobody true; \
    chromedriver --version

RUN adduser app --disabled-password --gecos "" --home /opt/app

COPY bin/entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
