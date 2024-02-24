# Start from ROS 2 Iron 
FROM ros:iron-ros-base

# Install tools I want everywhere
RUN apt-get update && apt-get install --no-install-recommends -y \
    git \
    python3-vcstool \
    nano \
    iproute2 \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Install these aliases
WORKDIR /root
RUN git clone --depth 1 https://github.com/AdamPettinger/adam_aliases.git
RUN ./adam_aliases/quiet_install.sh

# Source the ROS install in bashrc
RUN echo "source /opt/ros/iron/setup.bash" >> ~/.bashrc
