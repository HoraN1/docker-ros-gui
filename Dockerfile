FROM nvidia/cudagl:10.1-base-ubuntu16.04 
LABEL maintainer="He Zhanxin" \
      version="2.0"
    
# Install tools required
RUN apt-get update && apt-get install -y --no-install-recommends\
    apt-utils build-essential \
    software-properties-common \
    ipython python-dev python-numpy python-pip python-scipy \
    git vim wget curl lsb-release mlocate sudo && \
    rm -rf /var/lib/apt/lists/* 

# Install ROS, source from http://wiki.ros.org/kinetic/Installation/Ubuntu 
# Setup your sources.list and keys
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
# Update and install
    apt-get update && apt-get install -y ros-kinetic-desktop-full \
    python-rosdep python-rosinstall python-rosinstall-generator python-wstool && \
    rm -rf /var/lib/apt/lists/* 

#
# Install extra package here.
#

# User and permissions
ARG user=container
ARG group=container
ENV HOME=/home/${user}
RUN export uid=1000 gid=1000 && \
    mkdir -p /etc/sudoers.d && \
    groupadd -g ${gid} ${group} && \
    useradd -d ${HOME} -u ${uid} -g ${gid} -m -s /bin/bash ${user} && \
    echo "${user} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/sudoers_${user} && \
    sudo usermod -a -G video ${user}
USER ${user}
WORKDIR ${HOME}/catkin_ws/src

# Initialize rosdep
RUN sudo chown -R $user:$group ${HOME}/catkin_ws && \
    sudo rosdep init && \
    rosdep update

COPY scripts-container ${HOME}
CMD bash
