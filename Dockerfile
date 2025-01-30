# Use Ubuntu 18.04 as the base image
FROM ubuntu:18.04

# Set environment variable
ENV DEBIAN_FRONTEND=noninteractive

# Add git
RUN apt-get update && apt-get install -y \
    git

# Clone the FlatCAM repository
RUN git clone --depth 1 https://bitbucket.org/jpcgt/flatcam /flatcam

# Set the working directory to /flatcam
WORKDIR /flatcam

# Edit the setup_ubuntu.sh file
RUN sed -i 's/sudo apt-get install libpng-dev /apt-get install -y libpng-dev /' setup_ubuntu.sh
RUN sed -i 's/python-pip /python3-pip /' setup_ubuntu.sh

# Run the setup_ubuntu.sh script
RUN bash setup_ubuntu.sh

# Expose the X11 display port
EXPOSE 6000

# Set the environment variables for X11 forwarding
ENV DISPLAY=:99
ENV QT_X11_NO_MITSHM=1

# Run the FlatCAM application
CMD ["/flatcam/flatcam"]
