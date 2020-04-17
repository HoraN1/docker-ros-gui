#!/bin/bash
#
# Author:
#     He Zhanxin <https://github.com/HoraN1>
#
# Description:
#     Docker run command scripts: docker run ...

# Looking for catkin workspace, if not found, make one.
dir="./catkin_ws/wrc"
if [ ! -d "$dir" ]
then
    mkdir -p catkin_ws/src
fi

docker run --gpus all -it \
    --net=host \
    -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -e TERM=xterm-256color \
    -v $HOME/.Xauthority:/root/.Xauthority \
    -v $PWD/catkin_ws:/home/container/catkin_ws \
    -v $PWD/scripts-container:/home/container
    horasun/ros-gui:test
