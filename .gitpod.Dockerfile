FROM gitpod/workspace-full

USER gitpod

# Install Zig
RUN wget https://ziglang.org/download/0.8.0/zig-linux-x86_64-0.8.0.tar.xz && \
    tar xf zig-linux-x86_64-0.8.0.tar.xz && \
    sudo mv zig-linux-x86_64-0.8.0 /usr/local/bin
