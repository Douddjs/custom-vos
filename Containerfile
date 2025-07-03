FROM ghcr.io/vanilla-os/desktop:main

# Copy all custom files from includes.container to the root filesystem
COPY includes.container/ /

# Unlock lpkg and update package lists
RUN lpkg --unlock && lpkg update

# Install Snapd and Snap Store using lpkg
RUN lpkg install -y snapd gnome-software-plugin-snap

# Install DaVinci Resolve common dependencies using lpkg
RUN lpkg install -y \
    fakeroot \
    xorriso \
    libxcb-composite0 \
    libxcb-cursor0 \
    libxcb-damage0 \
    libxcb-dpms0 \
    libxcb-dri2-0 \
    libxcb-dri3-0 \
    libxcb-ewmh2 \
    libxcb-glx0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-record0 \
    libxcb-render0 \
    libxcb-res0 \
    libxcb-screensaver0 \
    libxcb-shape0 \
    libxcb-shm0 \
    libxcb-sync1 \
    libxcb-util1 \
    libxcb-xf86dri0 \
    libxcb-xfixes0 \
    libxcb-xinerama0 \
    libxcb-xinput0 \
    libxcb-xkb1 \
    libxcb-xtest0 \
    libxcb-xv0 \
    libxcb-xvmc0

# Update font cache and compile schemas
RUN fc-cache -fv && \
    glib-compile-schemas /usr/share/glib-2.0/schemas/

# Enable snapd services
RUN systemctl enable snapd.service && \
    systemctl enable snapd.socket

# Make DaVinci Resolve helper script executable (if it exists)
RUN if [ -f /usr/local/bin/prepare-davinci-resolve ]; then \
    chmod +x /usr/local/bin/prepare-davinci-resolve; \
    fi

# Cleanup
RUN lpkg autoremove -y && \
    lpkg clean && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    rm -rf /sources
