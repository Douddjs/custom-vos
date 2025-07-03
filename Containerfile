FROM ghcr.io/vanilla-os/desktop:main

# Copy all custom files from includes.container to the root filesystem
COPY includes.container/ /

# Update font cache and compile schemas
RUN fc-cache -fv && \
    glib-compile-schemas /usr/share/glib-2.0/schemas/

# Cleanup
RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    rm -rf /sources
