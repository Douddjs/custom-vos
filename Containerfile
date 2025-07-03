FROM ghcr.io/vanilla-os/desktop:main

# Copy all custom files from includes.container to the root filesystem
COPY includes.container/ /

# Update font cache and compile schemas
RUN fc-cache -fv && \
    glib-compile-schemas /usr/share/glib-2.0/schemas/
