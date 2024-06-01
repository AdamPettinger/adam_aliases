# ROS distribution to use
ARG ROS_DISTRO=humble

########################################
# Base Image for ROS Stuff #
########################################
FROM osrf/ros:${ROS_DISTRO}-desktop as base
ENV ROS_DISTRO=${ROS_DISTRO}
SHELL ["/bin/bash", "-c"]

# Set up the entrypoint
COPY ./entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]

#####################
# Development Image #
#####################
FROM base as dev

# Dev container arguments
ARG USERNAME=devuser
ARG UID=1000
ARG GID=${UID}

RUN apt-get update && apt-get install --no-install-recommends -y \
    git \
    python3-vcstool \
    nano \
    iproute2 \
    iputils-ping

# Create new user and home directory
RUN groupadd --gid $GID $USERNAME \
&& useradd --uid ${GID} --gid ${UID} --create-home ${USERNAME} \
&& echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
&& chmod 0440 /etc/sudoers.d/${USERNAME} \
&& mkdir -p /home/${USERNAME} \
&& chown -R ${UID}:${GID} /home/${USERNAME}

# Set the ownership of the workspace to the new user
RUN mkdir -p /smm_ws/src
RUN chown -R ${UID}:${GID} /smm_ws/

# Set the user and source entrypoint in the user's .bashrc file
USER ${USERNAME}
RUN echo "source /entrypoint.sh" >> /home/${USERNAME}/.bashrc

WORKDIR /home/${USERNAME}
RUN git clone --depth 1 https://github.com/AdamPettinger/adam_aliases.git
RUN ./adam_aliases/quiet_install.sh
