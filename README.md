# flatcam_docker
Easily run FlatCAM in a Docker container and display it locally on your screen!


It's simple!
Grab the Dockerfile from this repo, build the container and launch!

`git clone https://github.com/jake5253/flatcam_docker
cd flatcam_docker
docker build -t flatcam .
docker run -it --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --volume="$HOME/Documents:/workspace:rw" flatcam`

NOTE: You might need to enable X11Forwarding.  Add `X11Forwarding yes` to your /etc/ssh/sshd_config. Be aware of any and all security implications this may raise!
