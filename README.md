docker-mint-vnc-desktop
=========================

[![Docker Pulls](https://img.shields.io/docker/pulls/pddenhar/docker-mint-vnc-desktop.svg)](https://hub.docker.com/r/pddenhar/docker-mint-vnc-desktop/)
[![Docker Stars](https://img.shields.io/docker/stars/pddenhar/docker-mint-vnc-desktop.svg)](https://hub.docker.com/r/pddenhar/docker-mint-vnc-desktop/)

Docker image to provide HTML5 VNC interface to access to Linux Mint 17.3 MATE desktop environment.

Quick Start
-------------------------

Run the docker image and open port `6080`

```
docker run -it --rm -p 6080:80 pddenhar/docker-mint-vnc-desktop
```

Browse http://127.0.0.1:6080/vnc.html

<img src="https://raw.github.com/fcwu/docker-ubuntu-vnc-desktop/master/screenshots/lxde.png?v1" width=700/>


Connect with VNC Viewer and protect by VNC Password
------------------

Forward VNC service port 5900 to host by

```
docker run -it --rm -p 6080:80 -p 5900:5900 pddenhar/docker-mint-vnc-desktop
```

Now, open the vnc viewer and connect to port 5900. If you would like to protect vnc service by password, set environment variable `VNC_PASSWORD`, for example

```
docker run -it --rm -p 6080:80 -p 5900:5900 -e VNC_PASSWORD=mypassword pddenhar/docker-mint-vnc-desktop
```

A prompt will ask password either in the browser or vnc viewer.


License
==================

See the LICENSE file for details.
