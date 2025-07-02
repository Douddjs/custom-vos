FROM ghcr.io/vanilla-os/desktop:main

# Copy all custom files from includes.container to the root filesystem
COPY includes.container/ /

# Run necessary commands
RUN fc-cache -fv && \
    glib-compile-schemas /usr/share/glib-2.0/schemas/ && \
    apt-get update && \
    apt-get install -y snapd gnome-software-plugin-snap && \
    systemctl enable snapd.service && \
    systemctl enable snapd.socket && \
    apt-get clean && \
    rm -rf /tmp/* /var/tmp/* /sources