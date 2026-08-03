# Use ARG to set the ruby_version, which can be overridden at build time.
ARG ruby_version=3.4.5
FROM ruby:${ruby_version}

# Install all system dependencies, Chromium, and ChromeDriver in a single efficient layer.
# Chromium and its driver come from Debian so they exist for both amd64 and arm64 and are
# always version-matched (chrome-for-testing publishes no linux/arm64 chromedriver).
RUN set -eux; \
    apt-get update && \
    # libvips42 was renamed to libvips42t64 on Debian 13 (trixie); pick whichever exists
    if apt-cache show libvips42t64 >/dev/null 2>&1; then vips_pkg=libvips42t64; else vips_pkg=libvips42; fi && \
    apt-get install -y --no-install-recommends \
        # Essential tools
        gosu \
        curl \
        gnupg \
        unzip \
        # For JS runtime & assets
        jq \
        "${vips_pkg}" \
        # Chromium + matching ChromeDriver (multi-architecture support)
        chromium \
        chromium-driver \
    && \
    \
    # Install Node.js & Yarn
    curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    npm install -g yarn && \
    \
    # Clean up apt caches to reduce image size
    rm -rf /var/lib/apt/lists/*; \
    \
    # Verify gosu and chromedriver work
    gosu nobody true; \
    chromedriver --version

# Add a low-privilege user to the container
RUN adduser app --disabled-password --gecos "" --home /opt/app

# Copy the entrypoint file to the /usr/local/bin directory
COPY bin/entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]
