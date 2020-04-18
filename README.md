# Docker-ROS with GUI enabled guide

## A repository to build an image with GUI enabled. 

This is a docker image built on nvidia/cudagl-ubuntu16.04 with ros-kinetic-full. For now, it only works with nvidia gpu based host machine.

## Basic setup: Docker, Nvidia-docker, course content

To start with, make sure you installed docker. Installation instructions can be found at [install docker](https://docs.docker.com/engine/install/). 

Then, install nvidia-docker such that docker run command recognizes `--gpus all` tag. You can find out more at [NVIDIA/nvidia-docker](https://github.com/NVIDIA/nvidia-docker).

Below are instructions on how to use this repository:

## For those who are not familiar Docker

### 1. Get the latest image

Pull the latest image from Docker Hub

```
docker pull horasun/ros-gui:latest
``` 

And inside your working directory, clone this repository, There are some template bash scripts to reduce bash command complexity. 

```
git clone https://github.com/HoraN1/docker-gui-ros.git
```

### 2. Run the image to start a container

For enabling GUI application the docker run command will be very long. As you cloned this repository, the bash script `docker-run.sh` will help you. Run command shown below inside your **host machine terminal**. You can change the container name by adding the tag `--name=<CUSTOM_NAME>` inside `docker-run.sh`.

```
# Run in host
bash ./docker-run.sh
```

After this command, you will see a directory called `catkin_ws` is made in the current directory on your host machine, within it is a subdirectory called `src`, which is your working directory by default. You can customize this by editing `docker-run.sh`. For more information regarding ROS file system, take a look at [ros-tutorials](http://wiki.ros.org/ROS/Tutorials).

### 3. Dependencies

You should run the command to install your project dependencies inside the **docker container terminal**. Then run the `initialize-workspace.sh` to build the workspace. But remember to update your `apt` in the container. For example:

```
# Run in container
sudo apt-get update
rosdep install --from-paths src --ignore-src --rosdistro=kinetic -y
```

### 4. Build workspace

For now, the container is running, and your local working directory `./catkin_ws` is volumed to the container `~/catkin_ws`. Running command shown below in your **container terminal**.

```
# Run in container
bash ~/scripts/initialize-workspace.sh
source ~/.bashrc
```

This script will initialize your workspace and build it. You will find two new directories founded under your local `catkin_ws` called `build` and `devel`. It will also configure you `.bashrc` to source `devel/setup.bash` every time you start a new terminal.

### 5. Build a new image

At any point, if you want to save some changes inside the container, you can commit the container to a new image and you can start from that new image after removing the unwanted containers. Using `docker ps -a` to list all containers and commit the one you worked on.

```
# Run in host
docker ps -a
docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
```

## For those who are familiar with Docker

If you are familiar with docker, you can just pull the latest image and based on it, build your own Dockerfile, but you may not change the username in the container. If you find a solution or any other issues, please contact me :smile:.

Or you can clone this repository and modify the Dockerfile to meet your needs.

## To test if the X-server is forwarding
In the docker container, run:
```
bash ~/scripts/test-gui.sh
```
