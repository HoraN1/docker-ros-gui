#!/bin/bash
#
# Author:
#     He Zhanxin <https://github.com/HoraN1>
#
# Description:
#     Initialize ros workspace

# Create catkin workspace
source /opt/ros/kinetic/setup.bash

# Build workspace
cd ~/catkin_ws && catkin_make
source ~/catkin_ws/devel/setup.bash

# Configure .bashrc
echo "# Configure your .bashrc" >> ~/.bashrc
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
