docker build -t linuxm3 .
docker run -it --rm -p 5900:5900 -p 6080:6080 linuxm3
